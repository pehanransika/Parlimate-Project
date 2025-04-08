package support;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupportController {

    // Method to save a new support message
    public static boolean saveSupportMessage(String name, String email, String message) throws SQLException {
        // SQL query to insert a new support message into the database
        String query = "INSERT INTO support (name, email, message) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set values in the prepared statement
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, message);

            // Execute the insert statement and check if any rows were affected
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();  // Log the error for debugging
            throw e;  // Rethrow the exception to be handled by the servlet
        }
    }

    // Method to retrieve all support messages
    public static List<SupportModel> getAllSupportMessages() {
        ArrayList<SupportModel> supportMessages = new ArrayList<>();

        // SQL query to fetch all support messages from the database
        String query = "SELECT name, email, message FROM support ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String message = rs.getString("message");

                    // Create a SupportModel object and add it to the list
                    SupportModel supportMessage = new SupportModel(name, email, message);
                    supportMessages.add(supportMessage);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Return the list of support messages (could be empty if no result)
        return supportMessages;
    }

    // Method to get a support message by its ID
    public static SupportModel getSupportMessageById(int id) {
        SupportModel supportMessage = null;

        // SQL query to retrieve a support message by its ID
        String query = "SELECT name, email, message FROM support WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the query
            stmt.setInt(1, id);

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Retrieve data from the result set
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String message = rs.getString("message");

                    // Create a SupportModel object
                    supportMessage = new SupportModel(name, email, message);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Return the support message (could be null if no result)
        return supportMessage;
    }

    // Method to delete a support message by its ID
    public static boolean deleteSupportMessage(int id) {
        boolean isDeleted = false;

        // SQL query to delete a support message by its ID
        String query = "DELETE FROM support WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the query
            stmt.setInt(1, id);

            // Execute the delete statement and check if any rows were deleted
            int rowsDeleted = stmt.executeUpdate();
            isDeleted = rowsDeleted > 0; // True if at least one row was deleted

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }

    // Method to update a support message by its ID
    public static boolean updateSupportMessage(int id, String name, String email, String message) {
        String query = "UPDATE support SET name = ?, email = ?, message = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, message);
            stmt.setInt(4, id); // Set the id

            // Execute the update statement and return true if rows are updated
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            // Log detailed exception message
            System.err.println("Error updating support message: " + e.getMessage());
            e.printStackTrace();
            return false; // Return false if an exception occurs
        }
    }
}