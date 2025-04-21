package fundreq;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RejectedRequestController {

    // Method to add a new rejected request
    public static boolean rejectAndDeleteRequest(RejectedRequest rejectedRequest) throws SQLException {
        // Validate input
        if (rejectedRequest == null || rejectedRequest.getReasonForReject() == null
                || rejectedRequest.getReasonForReject().trim().isEmpty()) {
            throw new IllegalArgumentException("Rejection reason cannot be null or empty");
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Debug logging
            System.out.println("Attempting to reject request ID: " + rejectedRequest.getRequestId());

            // 1. First INSERT into rejected_requests
            String insertSQL = "INSERT INTO rejected_requests (request_id, reason_for_reject, rejection_date,title,user_id) " +
                    "VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {
                insertStmt.setInt(1, rejectedRequest.getRequestId());
                insertStmt.setString(2, rejectedRequest.getReasonForReject());
                insertStmt.setTimestamp(3, rejectedRequest.getRejectionDate());
                insertStmt.setString(4, rejectedRequest.getTitle());
                insertStmt.setInt(5,rejectedRequest.getUserId());
                


                int insertedRows = insertStmt.executeUpdate();
                if (insertedRows != 1) {
                    conn.rollback();
                    throw new SQLException("Failed to insert into rejected_requests (no rows affected)");
                }
                System.out.println("Successfully inserted into rejected_requests");
            }

            // 2. Update the status column in fundraisingrequests to 'DELETED'
            String updateSQL = "UPDATE fundraisingrequests SET status = 'DELETED' WHERE requestid = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                updateStmt.setInt(1, rejectedRequest.getRequestId());

                int updatedRows = updateStmt.executeUpdate();
                if (updatedRows != 1) {
                    conn.rollback();
                    throw new SQLException("Failed to update status in fundraisingrequests (no rows affected)");
                }
                System.out.println("Successfully updated status in fundraisingrequests");
            }

            // If we get here, both operations succeeded
            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Transaction failed: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transaction rolled back");
                } catch (SQLException ex) {
                    System.err.println("Rollback failed: " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }
    // Method to get all rejected requests
    public static List<RejectedRequest> getAllRejectedRequests() throws SQLException {
        List<RejectedRequest> rejectedRequests = new ArrayList<>();
        String query = "SELECT r.rejection_id, r.request_id, r.reason_for_reject, r.rejection_date,r.user_id " +
                "f.title " +
                "FROM rejected_requests r " +
                "LEFT JOIN fundraisingrequests f ON r.request_id = f.requestid";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                RejectedRequest request = new RejectedRequest();
                request.setRejectionId(rs.getInt("rejection_id"));
                request.setRequestId(rs.getInt("request_id"));
                request.setReasonForReject(rs.getString("reason_for_reject"));
                request.setRejectionDate(rs.getTimestamp("rejection_date"));
                request.setTitle(rs.getString("title"));  // Set the title from joined table
                request.setUserId(rs.getInt("user_id"));

                rejectedRequests.add(request);
            }
        }
        return rejectedRequests;
    }
    // Method to get rejected request by ID
    public static RejectedRequest getRejectedRequestById(int rejectionId) throws SQLException {
        String query = "SELECT rejection_id, request_id, reason_for_reject, rejection_date ,title,user_id" +
                "FROM rejected_requests WHERE rejection_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, rejectionId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    RejectedRequest request = new RejectedRequest();
                    request.setRejectionId(rs.getInt("rejection_id"));
                    request.setRequestId(rs.getInt("request_id"));
                    request.setReasonForReject(rs.getString("reason_for_reject"));
                    request.setRejectionDate(rs.getTimestamp("rejection_date"));
                    request.setTitle(rs.getString("title"));
                    request.setUserId(rs.getInt("user_id"));
                    return request;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving rejected request: " + e.getMessage());
            throw e;
        }
        return null;
    }

    // Method to get rejected requests by original request ID
    public static List<RejectedRequest> getRejectedRequestsByRequestId(int requestId) throws SQLException {
        List<RejectedRequest> rejectedRequests = new ArrayList<>();
        String query = "SELECT rejection_id, request_id, reason_for_reject, rejection_date,title,user_id " +
                "FROM rejected_requests WHERE request_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RejectedRequest request = new RejectedRequest();
                    request.setRejectionId(rs.getInt("rejection_id"));
                    request.setRequestId(rs.getInt("request_id"));
                    request.setReasonForReject(rs.getString("reason_for_reject"));
                    request.setRejectionDate(rs.getTimestamp("rejection_date"));
                    request.setTitle(rs.getString("title"));
                    request.setUserId(rs.getInt("user_id"));

                    rejectedRequests.add(request);
                }
            }
        }
        return rejectedRequests;
    }

    // Method to update a rejected request
    public static boolean updateRejectedRequest(RejectedRequest rejectedRequest) throws SQLException {
        String query = "UPDATE rejected_requests SET reason_for_reject = ? " +
                "WHERE rejection_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, rejectedRequest.getReasonForReject());
            stmt.setInt(2, rejectedRequest.getRejectionId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating rejected request: " + e.getMessage());
            throw e;
        }
    }

    // Method to delete a rejected request
    public static boolean deleteRejectedRequest(int rejectionId) throws SQLException {
        String query = "DELETE FROM rejected_requests WHERE rejection_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, rejectionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting rejected request: " + e.getMessage());
            throw e;
        }
    }
    public static List<RejectedRequest> getAllRejectedRequestsByUserId(int userId) throws SQLException {
        List<RejectedRequest> rejectedRequests = new ArrayList<>();
        String query = "SELECT r.rejection_id, r.request_id, r.reason_for_reject, r.rejection_date, f.title,r.user_id " +
                "FROM rejected_requests r " +
                "LEFT JOIN fundraisingrequests f ON r.request_id = f.requestid " +
                "WHERE r.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);


            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    rejectedRequests.add(new RejectedRequest(
                            rs.getInt("user_id"),
                            rs.getInt("rejection_id"),
                            rs.getInt("request_id"),
                            rs.getString("reason_for_reject"),
                            rs.getTimestamp("rejection_date"),
                            rs.getString("title")

                    ));
                }
            }
        }

        return rejectedRequests;
    }

}