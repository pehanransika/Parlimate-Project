package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PoliticalPartyController {
    public static boolean insertPoliticalParty(int user_id, String name, String phoneNumber, String address, String logoImg, int noOfMembers) {
        
        String insertQuery = "INSERT INTO politicalparty (user_id, name, phone_number, address, logo_img, no_of_members) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(insertQuery)) {

            statement.setInt(1, user_id);
            statement.setString(2, name);
            statement.setString(3, phoneNumber);
            statement.setString(4, address);
            statement.setString(5, logoImg);
            statement.setInt(6, noOfMembers);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error inserting data into political party table: " + e.getMessage());
        }
        return false;
    }

    public static List<PoliticalPartyModel> PoliticalPartyProfile(int id) {
        List<PoliticalPartyModel> politicalPartys = new ArrayList<>();
        String sql = "SELECT * FROM politicalparty WHERE user_id = '" + id + "'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int politicalPartyId = rs.getInt("political_party_id");
                    int userid = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String phoneNumber = rs.getString("phone_number");
                    String address = rs.getString("address");
                    String logoImg = rs.getString("logo_img");
                    int noOfMembers = rs.getInt("no_of_members");

                    PoliticalPartyModel politicalParty = new PoliticalPartyModel(politicalPartyId, userid, name,  phoneNumber,address, logoImg, noOfMembers);
                    politicalPartys.add(politicalParty);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return politicalPartys;

    }

    public static boolean updatePoliticalParty(int user_id, String name, String phoneNumber, String address, String logoImg, int noOfMembers) {
        String updateQuery = "UPDATE politicalparty SET name = ?, phone_number = ?, address = ?, logo_img = ?, no_of_members = ? WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setString(1, name);          // Set the name
            statement.setString(2, phoneNumber);   // Set the phone number
            statement.setString(3, address);       // Set the address
            statement.setString(4, logoImg);       // Set the logo image URL
            statement.setInt(5, noOfMembers);      // Set the number of members
            statement.setInt(6, user_id);          // Set the user ID for the WHERE clause

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;  // Return true if the update was successful

        } catch (SQLException e) {
            System.err.println("Error updating data in political party table: " + e.getMessage());
        }
        return false;
    }

    public static boolean deletePoliticalParty(int userId) {
        boolean isSuccess = false;
        String sql = "DELETE FROM politicalparty WHERE user_id = ?"; // Ensure column and table names are correct

        // Try-with-resources to ensure connection and statement are closed
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the user ID parameter for the prepared statement
            pstmt.setInt(1, userId);

            // Execute the delete operation
            int rowsDeleted = pstmt.executeUpdate();

            // Check if deletion was successful
            if (rowsDeleted > 0) {
                System.out.println("Political Party with user_id " + userId + " deleted successfully.");
                isSuccess = true;  // Deletion was successful
            } else {
                System.out.println("No Political Party found with user_id " + userId + ".");
                isSuccess = false; // No matching record found
            }

        } catch (SQLException e) {
            // Log the error with the exception message and userId for debugging
            System.err.println("Error deleting Political Party with user_id " + userId + ": " + e.getMessage());
        }

        return isSuccess;
    }

}
