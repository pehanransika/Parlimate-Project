package bankreq;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransferController {

    // Method to check if a user exists
    public static boolean isUserExists(int userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0; // If count > 0, user exists
            }
        } catch (SQLException e) {
            System.err.println("Error checking user existence: " + e.getMessage());
            throw e;
        }
    }

    // Method to create a new bank transfer
    public static boolean createBankTransfer(
            int user_id,
            int fundraiser_id,
            BigDecimal amount,
            String currency,
            String receipt_image_path,
            Timestamp transfer_date
    ) throws SQLException {
        if (amount == null || isEmpty(currency) || isEmpty(receipt_image_path)) {
            throw new IllegalArgumentException("Missing required fields");
        }

        String query = "INSERT INTO bank_transfers (user_id, fundraiser_id, amount, currency, receipt_image_path, transfer_date) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, user_id);
            stmt.setInt(2, fundraiser_id);
            stmt.setBigDecimal(3, amount);
            stmt.setString(4, currency);
            stmt.setString(5, receipt_image_path);
            stmt.setTimestamp(6, transfer_date);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    private static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Method to retrieve all fundraising requests
    public static List<TransferModel> getAllTransferRequest() throws SQLException {
        List<TransferModel> requests = new ArrayList<>();
        String query = "SELECT transfer_id, user_id, fundraiser_id, amount, currency, receipt_image_path, transfer_date " +
                "FROM bank_transfers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int transferId = rs.getInt("transfer_id");
                int userId = rs.getInt("user_id");
                int fundraserId = rs.getInt("fundraiser_id");

                BigDecimal amount = rs.getBigDecimal("amount");
                String currency = rs.getString("currency");
                String receipt_image_path = rs.getString("receipt_image_path");

                Timestamp transfer_date = rs.getTimestamp("transfer_date");

                TransferModel request = new TransferModel(transferId, userId, fundraserId, amount, currency, receipt_image_path, transfer_date);
                requests.add(request);
            }
        }
        return requests;
    }

    // Method to retrieve a single fundraising request by ID
    public static TransferModel getBankTransferById(int transferId) throws SQLException {
        String query = "SELECT transfer_id, user_id, fundraiser_id, amount, currency, receipt_image_path, transfer_date " +
                "FROM bank_transfers WHERE transfer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, transferId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    int fundraserId = rs.getInt("fundraiser_id");

                    BigDecimal amount = rs.getBigDecimal("amount");
                    String currency = rs.getString("currency");
                    String receipt_image_path = rs.getString("receipt_image_path");

                    Timestamp transfer_date = rs.getTimestamp("transfer_date");

                    return new TransferModel(transferId, userId, fundraserId, amount, currency, receipt_image_path, transfer_date);
                }
            }
        }
        return null;
    }

    // Method to delete a transfer request
    public static boolean deleteTransfers(int transferId) throws SQLException {
        String query = "DELETE FROM bank_transfers WHERE transfer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, transferId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        }
    }
}