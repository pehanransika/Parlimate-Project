package fundreq;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApproveController {
    // Get all approved requests
    public static List<ApproveModel> getAllApprovedRequests() {
        List<ApproveModel> approvedRequests = new ArrayList<>();
        String sql = "SELECT * FROM approved_requests ORDER BY approval_date DESC";

        try (Connection conn = DBConnection.getConnection();
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
                        rs.getString("attachment_url"),
                        rs.getString("photos"),
                        rs.getTimestamp("approval_date"),
                        rs.getString("name")
                );
                approvedRequests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching approved requests: " + e.getMessage());
            e.printStackTrace();
        }
        return approvedRequests;
    }

    // Get single approved request by ID
    public static ApproveModel getApprovedRequestById(int requestId) {
        String sql = "SELECT * FROM approved_requests WHERE requestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ApproveModel(
                            rs.getInt("requestid"),  // Fixed from request_id to requestid
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            rs.getTimestamp("approval_date"),
                            rs.getString("name")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching request by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Approve a fundraising request - MAIN FIX APPLIED HERE
    public static boolean approveFundraisingRequest(int requestId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Get the request to be approved along with user name
            String selectSql = "SELECT fr.*, " +
                    "COALESCE(p.name, c.name) AS name " +
                    "FROM fundraisingrequests fr " +
                    "LEFT JOIN politician p ON fr.userid = p.user_id AND fr.userid IN (SELECT user_id FROM politician) " +
                    "LEFT JOIN citizen c ON fr.userid = c.user_id AND fr.userid IN (SELECT user_id FROM citizen) " +
                    "WHERE fr.requestid = ?";

            ApproveModel requestToApprove;
            String requesterName = null;

            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, requestId);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (!rs.next()) {
                        System.err.println("No request found with ID: " + requestId);
                        return false;
                    }

                    requesterName = rs.getString("name");
                    if (requesterName == null) {
                        requesterName = "Anonymous"; // Default value if name is null
                    }

                    requestToApprove = new ApproveModel(
                            rs.getInt("requestid"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            new Timestamp(System.currentTimeMillis()),
                            requesterName
                    );
                }
            }

            // 2. Insert into approved_requests
            String insertSql = "INSERT INTO approved_requests " +
                    "(requestid, title, description, contact_no, category, " +
                    "targetamount, attachment_url, photos, approval_date, name) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, requestToApprove.getRequestId());
                insertStmt.setString(2, requestToApprove.getTitle());
                insertStmt.setString(3, requestToApprove.getDescription());
                insertStmt.setString(4, requestToApprove.getContact_no());
                insertStmt.setString(5, requestToApprove.getCategory());
                insertStmt.setDouble(6, requestToApprove.getTargetamount());
                insertStmt.setString(7, requestToApprove.getAttachmentUrl());
                insertStmt.setString(8, requestToApprove.getPhotos());
                insertStmt.setTimestamp(9, requestToApprove.getApprovalDate());
                insertStmt.setString(10, requestToApprove.getName());

                if (insertStmt.executeUpdate() == 0) {
                    conn.rollback();
                    System.err.println("Failed to insert into approved_requests");
                    return false;
                }
            }


            // 3. Delete from original table
            String deleteSql = "DELETE FROM fundraisingrequests WHERE requestid = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, requestId);
                if (deleteStmt.executeUpdate() == 0) {
                    conn.rollback();
                    System.err.println("Failed to delete from fundraisingrequests");
                    return false;
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Error approving request: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("Rollback failed: " + ex.getMessage());
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    // Update an approved request
    public static boolean updateApprovedRequest(ApproveModel request) {
        String sql = "UPDATE approved_requests SET " +
                "title = ?, description = ?, contact_no = ?, category = ?, " +
                "targetamount = ?, attachment_url = ?, photos = ?, name = ? " +
                "WHERE requestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, request.getTitle());
            stmt.setString(2, request.getDescription());
            stmt.setString(3, request.getContact_no());
            stmt.setString(4, request.getCategory());
            stmt.setDouble(5, request.getTargetamount());
            stmt.setString(6, request.getAttachmentUrl());
            stmt.setString(7, request.getPhotos());
            stmt.setString(8, request.getName());
            stmt.setInt(9, request.getRequestId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating request: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Delete an approved request
    public static boolean deleteApprovedRequest(int requestid) {
        String sql = "DELETE FROM approved_requests WHERE requestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, requestid);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting request: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public static List<ApproveModel> getApprovedFundraisersByUser(int userId) {
        List<ApproveModel> approvedRequests = new ArrayList<>();
        String sql = "SELECT ar.* FROM approved_requests ar " +
                "JOIN fundraisingrequests fr ON ar.requestid = fr.requestid " +
                "WHERE fr.userid = ? " +
                "ORDER BY ar.approval_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ApproveModel request = new ApproveModel(
                            rs.getInt("requestid"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("contact_no"),
                            rs.getString("category"),
                            rs.getDouble("targetamount"),
                            rs.getString("attachment_url"),
                            rs.getString("photos"),
                            rs.getTimestamp("approval_date"),
                            rs.getString("name")
                    );
                    approvedRequests.add(request);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user's approved requests: " + e.getMessage());
            e.printStackTrace();
        }
        return approvedRequests;
    }
    // Helper method to load JDBC driver (call this once at application startup)
    public static void initialize() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found");
            e.printStackTrace();
        }
    }
}