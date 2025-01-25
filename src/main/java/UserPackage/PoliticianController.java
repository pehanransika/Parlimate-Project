package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PoliticianController {

    // Method to insert a new politician record without political party ID
    public static boolean insertPolitician(int userId, String name, String address, String phoneNumber, String profileImgUrl) {
        // SQL query to insert politician record
        String insertPoliticianSQL = "INSERT INTO politician (user_id, name, address, phone_number, profile_img_url) VALUES (?, ?, ?, ?, ?);";

        // Try-with-resources to manage database connection and statement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement insertPoliticianStmt = conn.prepareStatement(insertPoliticianSQL)) {

            // Set the values for the PreparedStatement
            insertPoliticianStmt.setInt(1, userId);           // Set the user ID
            insertPoliticianStmt.setString(2, name);          // Set the name
            insertPoliticianStmt.setString(3, address);       // Set the address
            insertPoliticianStmt.setString(4, phoneNumber);   // Set the phone number
            insertPoliticianStmt.setString(5, profileImgUrl); // Set the profile image URL

            // Execute the update and return true if the insertion was successful
            int rowsInserted = insertPoliticianStmt.executeUpdate();
            return rowsInserted > 0; // Return true if the politician was inserted, otherwise false

        } catch (SQLException e) {
            // Print the error message if an exception occurs
            System.err.println("Error inserting politician: " + e.getMessage());
            return false;
        }
    }
    public static List<PoliticianModel> PoliticianProfile(int id) {
        List<PoliticianModel> politicians = new ArrayList<>();

        String sql = "SELECT * FROM politician WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Use PreparedStatement to safely set the user_id parameter
            stmt.setInt(1, id);

        String sql = "SELECT * FROM politician WHERE user_id = '" + id + "'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    int politicianId = rs.getInt("politician_id");
                    int userId = rs.getInt("user_id");

                    int citizenid = rs.getInt("politician_id");
                    int userid = rs.getInt("user_id");

                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    int politicalPartyId = rs.getInt("political_party_id");

                    String profileImageUrl = rs.getString("profile_img_url");

                    // Create a PoliticianModel object and add it to the list
                    PoliticianModel politician = new PoliticianModel(userId, politicianId, name, address, phoneNumber, politicalPartyId, profileImageUrl);

                    String ProfileImageUrl = rs.getString("profile_image_url");

                    PoliticianModel politician = new PoliticianModel(citizenid, userid, name, address, phoneNumber, politicalPartyId, ProfileImageUrl);

                    politicians.add(politician);
                }
            }


            System.err.println("Error retrieving data from politician table: " + e.getMessage());
        }

        return politicians;
    }


            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return politicians;

    }


    public static boolean updatePolitician(int userId, String name, String address, String phoneNumber, String profileImgUrl) {
        // SQL query to update politician record
        String updatePoliticianSQL = "UPDATE politician SET name = ?, address = ?, phone_number = ?, profile_img_url = ? WHERE user_id = ?";

        // Try-with-resources to manage database connection and statement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement updatePoliticianStmt = conn.prepareStatement(updatePoliticianSQL)) {

            // Set the values for the PreparedStatement
            updatePoliticianStmt.setString(1, name);           // Set the name
            updatePoliticianStmt.setString(2, address);        // Set the address
            updatePoliticianStmt.setString(3, phoneNumber);    // Set the phone number
            updatePoliticianStmt.setString(4, profileImgUrl);  // Set the profile image URL
            updatePoliticianStmt.setInt(5, userId);            // Set the user ID for the WHERE clause

            // Execute the update and return true if the update was successful
            int rowsUpdated = updatePoliticianStmt.executeUpdate();
            return rowsUpdated > 0; // Return true if the politician was updated, otherwise false

        } catch (SQLException e) {
            // Print the error message if an exception occurs
            System.err.println("Error updating politician: " + e.getMessage());
            return false;
        }
    }

    public static boolean deletePolitician(int userId) {
        String sql = "DELETE FROM politician WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            System.err.println("Error deleting politician: " + e.getMessage());
        }
        return false;
    }

}

