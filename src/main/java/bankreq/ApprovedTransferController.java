package bankreq;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApprovedTransferController {

    public static boolean approveTransferRequest(int transferId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1. Verify transfer exists
            String selectSql = "SELECT * FROM bank_transfers WHERE transfer_id = ?";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                selectStmt.setInt(1, transferId);
                ResultSet rs = selectStmt.executeQuery();

                if (!rs.next()) {
                    System.err.println("No transfer found with ID: " + transferId);
                    return false;
                }
            }

            // 2. Insert into approved_transfers
            String insertSql = "INSERT INTO approved_transfers " +
                    "(transfer_id, user_id, fundraiser_id, bank_name, account_holder_name, " +
                    "account_number, branch, amount, currency, receipt_image_path, " +
                    "reference_code, transfer_date, verified_at) " +
                    "SELECT transfer_id, user_id, fundraiser_id, bank_name, account_holder_name, " +
                    "account_number, branch, amount, currency, receipt_image_path, " +
                    "reference_code, transfer_date, NOW() " +
                    "FROM bank_transfers WHERE transfer_id = ?";

            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setInt(1, transferId);
                int rowsInserted = insertStmt.executeUpdate();
                if (rowsInserted == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // Removed the status update since the column doesn't exist
            // You might want to add deletion of the original record instead:
            String deleteSql = "DELETE FROM bank_transfers WHERE transfer_id = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, transferId);
                int rowsDeleted = deleteStmt.executeUpdate();
                if (rowsDeleted == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
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
                    System.err.println("Failed to close connection: " + e.getMessage());
                }
            }
        }
    }

    public static List<ApprovedTransferModel> getAllApprovedTransfers() {
        List<ApprovedTransferModel> approvedTransfers = new ArrayList<>();
        String sql = "SELECT * FROM approved_transfers ORDER BY verified_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ApprovedTransferModel transfer = new ApprovedTransferModel(
                        rs.getInt("transfer_id"),
                        rs.getInt("user_id"),
                        rs.getInt("fundraiser_id"),
                        rs.getString("bank_name"),
                        rs.getString("account_holder_name"),
                        rs.getString("account_number"),
                        rs.getString("branch"),
                        rs.getBigDecimal("amount"),
                        rs.getString("currency"),
                        rs.getString("receipt_image_path"),
                        rs.getString("reference_code"),
                        rs.getTimestamp("transfer_date"),
                        rs.getInt("verified_by"),
                        rs.getTimestamp("verified_at")
                );
                approvedTransfers.add(transfer);
            }
        } catch (SQLException e) {
            System.err.println("Database error while fetching approved transfers: " + e.getMessage());
        }
        return approvedTransfers;
    }
}
