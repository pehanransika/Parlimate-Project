package fundreq;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static fundreq.DBConnection.getConnection;

public class ApproveController {

    // Get all approved fundraising requests
    public static List<ApproveModel> getAllApprovedRequests() {
        List<ApproveModel> requests = new ArrayList<>();
        String sql = "SELECT ar.*, COALESCE(ft.total_amount_lkr, 0) AS total_lkr " +
                "FROM approved_requests ar " +
                "LEFT JOIN fundraiser_totals_lkr ft ON ar.requestid = ft.requestid " +
                "ORDER BY ar.approval_date DESC";


        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ApproveModel request = new ApproveModel(
                        rs.getInt("requestid"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("contact_no"),
                        rs.getString("category"),
                        rs.getDouble("targetamount"),
                        rs.getString("status"),
                        rs.getString("attachment_url"),
                        rs.getString("photos"),
                        rs.getTimestamp("approval_date"),
                        rs.getString("name"),
                        rs.getInt("userid")
                );
                request.setTotalLkr(rs.getDouble("total_lkr"));
                requests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching approved requests: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    // Get single approved request by ID
    public static ApproveModel getApprovedRequestById(int requestId) {
        String sql = "SELECT * FROM approved_requests WHERE requestid = ?";
        ApproveModel approvedRequest = null;

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    approvedRequest = new ApproveModel(
                            rs.getInt("requestid"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("status"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            rs.getTimestamp("approval_date"),
                            rs.getString("name"),
                            rs.getInt("userid")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error in getApprovedRequestById: " + e.getMessage());
            e.printStackTrace();
        }

        return approvedRequest;
    }

    // Approve a fundraising request
    public static boolean approveFundraisingRequest(int requestId) {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // 1. Get request details
            ApproveModel request = getRequestDetails(conn, requestId);
            if (request == null) {
                return false;
            }

            // 2. Insert into approved_requests
            if (!insertApprovedRequest(conn, request)) {
                conn.rollback();
                return false;
            }

            // 3. Delete from original table
            if (!deleteOriginalRequest(conn, requestId)) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Error approving request: " + e.getMessage());
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) {}
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {}
            }
        }
    }

    private static ApproveModel getRequestDetails(Connection conn, int requestId) throws SQLException {
        String sql = "SELECT fr.*, COALESCE(p.name, c.name) AS name " +
                "FROM fundraisingrequests fr " +
                "LEFT JOIN politician p ON fr.userid = p.user_id " +
                "LEFT JOIN citizen c ON fr.userid = c.user_id " +
                "WHERE fr.requestid = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ApproveModel(
                            rs.getInt("requestid"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("status"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            new Timestamp(System.currentTimeMillis()),
                            rs.getString("name"),
                            rs.getInt("userid")
                    );
                }
            }
        }
        return null;
    }

    private static boolean insertApprovedRequest(Connection conn, ApproveModel request) throws SQLException {
        // Set the status to "APPROVED" before inserting the request
        request.setStatus("APPROVED");

        String sql = "INSERT INTO approved_requests " +
                "(requestid, title, description, contact_no, category, " +
                "targetamount, attachment_url, photos, approval_date, status, name, userid) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, request.getRequestId());
            stmt.setString(2, request.getTitle());
            stmt.setString(3, request.getDescription());
            stmt.setString(4, request.getContact_no());
            stmt.setString(5, request.getCategory());
            stmt.setDouble(6, request.getTargetamount());
            stmt.setString(7, request.getAttachmentUrl());
            stmt.setString(8, request.getPhotos());
            stmt.setTimestamp(9, request.getApprovalDate());
            stmt.setString(10, request.getStatus());  // This will now be "APPROVED"
            stmt.setString(11, request.getName());
            stmt.setInt(12, request.getUserid());

            return stmt.executeUpdate() > 0;
        }
    }


    private static boolean deleteOriginalRequest(Connection conn, int requestId) throws SQLException {
        String sql = "DELETE FROM fundraisingrequests WHERE requestid = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Update an approved request
    public static boolean updateApprovedRequest(ApproveModel request) {
        String sql = "UPDATE approved_requests SET " +
                "title = ?, description = ?, contact_no = ?, category = ?, " +
                "targetamount = ?, attachment_url = ?, photos = ?, status = ?, name = ? " +
                "WHERE requestid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, request.getTitle());
            stmt.setString(2, request.getDescription());
            stmt.setString(3, request.getContact_no());
            stmt.setString(4, request.getCategory());
            stmt.setDouble(5, request.getTargetamount());
            stmt.setString(6, request.getAttachmentUrl());
            stmt.setString(7, request.getPhotos());
            stmt.setString(8, request.getStatus());
            stmt.setString(9, request.getName());
            stmt.setInt(10, request.getRequestId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating request: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete an approved request
    public static boolean deleteApprovedRequest(int requestId) {
        String sql = "DELETE FROM approved_requests WHERE requestid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting request: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Hold an approved request
    public static boolean holdApprovedRequest(int requestId) {
        String sql = "UPDATE approved_requests SET status = 'HOLD' WHERE requestid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestId);
            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated by hold: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error holding request: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get approved fundraisers by user ID
    public static List<ApproveModel> getApprovedFundraisersByUser(int userid) {
        List<ApproveModel> requests = new ArrayList<>();
        String sql = "SELECT * FROM approved_requests ar " +
                "WHERE userid = ?" +
                " ORDER BY ar.approval_date DESC";


        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userid);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(new ApproveModel(
                            rs.getInt("requestid"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("status"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            rs.getTimestamp("approval_date"),
                            rs.getString("name"),
                            rs.getInt("userid")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user requests: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }
    public static boolean restorerequest(int requestId) throws SQLException{
        String query="UPDATE approved_requests SET status='APPROVED' WHERE requestid=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error restoring fundraising request: " + e.getMessage());
            throw e;
        }

    }

    // Custom exception class
    public static String getRequesterEmail(int requestId) throws EmailRetrievalException {
        String sql = "SELECT u.email FROM users u " +
                "JOIN approved_requests ar ON u.user_id = ar.userid " +
                "WHERE ar.requestid = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("email"); // Fixed here: directly return the email value
                }
                throw new EmailRetrievalException("No requester found for fundraising request ID: " + requestId);
            }

        } catch (SQLException e) {
            throw new EmailRetrievalException("Database error while retrieving requester email", e);
        }
    }

    // Custom exception class
    public static class EmailRetrievalException extends Exception {
        public EmailRetrievalException(String message) {
            super(message);
        }
        public EmailRetrievalException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}