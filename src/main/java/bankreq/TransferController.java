package bankreq;

import java.lang.invoke.LambdaMetafactory;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
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

    // Method to create a new fundraising request
    public static boolean createBankTransfer(
            int user_id,
            int fundraiser_id,
            String bank_name,
            String account_holder_name,
            String account_number,
            String branch,
            BigDecimal amount,
            String currency,
            String receipt_image_path,
            String reference_code,
            Timestamp transfer_date

    ) throws SQLException {
        // Validate required fields at controller level too
        if (isEmpty(bank_name) || isEmpty(account_holder_name) || isEmpty(account_number) || isEmpty(branch)||isEmpty(reference_code)||
                amount == null || isEmpty(currency) || isEmpty(receipt_image_path)) {
            throw new IllegalArgumentException("Missing required fields");
        }

        String query = "INSERT INTO bank_transfers (user_id, fundraiser_id, bank_name, account_holder_name,account_number,branch, " +
                "amount, currency,receipt_image_path,reference_code, transfer_date ) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set all parameters in correct order
            stmt.setInt(1, user_id);
            stmt.setInt(2, fundraiser_id);
            stmt.setString(3, bank_name);
            stmt.setString(4, account_holder_name);
            stmt.setString(5, account_number);
            stmt.setString(6, account_number);
            stmt.setBigDecimal(7, amount);
            stmt.setString(8, currency);
            stmt.setString(9, receipt_image_path);
            stmt.setString(10, reference_code);
            stmt.setTimestamp(11, transfer_date);


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
        String query = "SELECT transfer_id, user_id,fundraiser_id, bank_name, account_holder_name,account_number ,amount,currency,receipt_image_path, reference_code, transfer_date FROM bank_transfers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int transferId = rs.getInt("transfer_id");
                int userId = rs.getInt("user_id");
                int fundraserId = rs.getInt("fundraiser_id");
                String bank_name = rs.getString("bank_name");
                String account_holder_name = rs.getString("account_holder_name");
                String account_number = rs.getString("account_number");
                BigDecimal amount = rs.getBigDecimal("amount");
                String currency = rs.getString("currency");
                String receipt_image_path = rs.getString("receipt_image_path");

                Timestamp transfer_date = rs.getTimestamp("transfer_date");


             TransferModel request = new TransferModel(transferId, userId, fundraserId,bank_name,account_holder_name,account_number,amount,currency,receipt_image_path,transfer_date);
                requests.add(request);
            }
        }
        return requests;
    }


    // Method to retrieve a single fundraising request by ID
    public static TransferModel  getBankTransferById(int transferId) throws SQLException {
        String query = "SELECT transfer_id, user_id,fundraiser_id, bank_name, account_holder_name,account_number ,amount,currency,receipt_image_path, reference_code, transfer_date FROM bank_transfers WHERE transfer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, transferId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    int userId = rs.getInt("user_id");
                    int fundraserId = rs.getInt("fundraiser_id");
                    String bank_name = rs.getString("bank_name");
                    String account_holder_name = rs.getString("account_holder_name");
                    String account_number = rs.getString("account_number");
                    BigDecimal amount = rs.getBigDecimal("amount");
                    String currency = rs.getString("currency");
                    String receipt_image_path = rs.getString("receipt_image_path");

                    Timestamp transfer_date = rs.getTimestamp("transfer_date");

                    return new  TransferModel(transferId, userId, fundraserId,bank_name,account_holder_name,account_number,amount,currency,receipt_image_path,transfer_date);

                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving fundraising request: " + e.getMessage());
            throw e;  // Rethrow the exception after logging it
        }
        return null;
    }



    // Method to delete a fundraising request
    public static boolean deleteTransfers(int transferId) throws SQLException {
        String query = "DELETE FROM bank_transfers WHERE transfer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, transferId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting fundraising request: " + e.getMessage());
            throw e;
        }
    }


}

