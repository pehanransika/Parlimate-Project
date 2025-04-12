package fundreq;

import fundreq.DBConnection;
import fundreq.RejectedRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RejectedRequestController {

    // Method to add a new rejected request
    public static boolean rejectAndDeleteRequest(RejectedRequest rejectedRequest) throws SQLException {
        // Validate input first
        if (rejectedRequest.getReasonForReject() == null ||
                rejectedRequest.getReasonForReject().trim().isEmpty()) {
            throw new IllegalArgumentException("Rejection reason cannot be null or empty");
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Add to rejected_requests table
            String insertQuery = "INSERT INTO rejected_requests (request_id, reason_for_reject, rejection_date) " +
                    "VALUES (?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, rejectedRequest.getRequestId());
                insertStmt.setString(2, rejectedRequest.getReasonForReject());
                insertStmt.setTimestamp(3, rejectedRequest.getRejectionDate());

                int rowsInserted = insertStmt.executeUpdate();
                if (rowsInserted <= 0) {
                    conn.rollback();
                    return false;
                }
            }

            // 2. Delete from fundraisingrequests table
            String deleteQuery = "DELETE FROM fundraisingrequests WHERE requestid = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {
                deleteStmt.setInt(1, rejectedRequest.getRequestId());

                int rowsDeleted = deleteStmt.executeUpdate();
                if (rowsDeleted <= 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit(); // Commit transaction if both operations succeed
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // Rollback on error
            }
            System.err.println("Error in rejectAndDeleteRequest: " + e.getMessage());
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
        String query = "SELECT rejection_id, request_id, reason_for_reject, rejection_date " +
                "FROM rejected_requests";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                RejectedRequest request = new RejectedRequest();
                request.setRejectionId(rs.getInt("rejection_id"));
                request.setRequestId(rs.getInt("request_id"));
                request.setReasonForReject(rs.getString("reason_for_reject"));
                request.setRejectionDate(rs.getTimestamp("rejection_date"));

                rejectedRequests.add(request);
            }
        }
        return rejectedRequests;
    }

    // Method to get rejected request by ID
    public static RejectedRequest getRejectedRequestById(int rejectionId) throws SQLException {
        String query = "SELECT rejection_id, request_id, reason_for_reject, rejection_date " +
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
        String query = "SELECT rejection_id, request_id, reason_for_reject, rejection_date " +
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

    // Helper method to reject a funding request

}