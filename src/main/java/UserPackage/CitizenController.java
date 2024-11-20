package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CitizenController {
        public static boolean insertCitizen(int userId, String name, String address, String phoneNumber, String profile, String imageUrl) {
            String insertQuery = "INSERT INTO citizen (user_id, name, address, phone_number, profile, image_url) VALUES (?, ?, ?, ?, ?, ?)";
            try (Connection connection = DBConnection.getConnection();
                 PreparedStatement statement = connection.prepareStatement(insertQuery)) {

                statement.setInt(1, userId);
                statement.setString(2, name);
                statement.setString(3, address);
                statement.setString(4, phoneNumber);
                statement.setString(5, profile);
                statement.setString(6, imageUrl);  // Use image_url here

                int rowsInserted = statement.executeUpdate();
                return rowsInserted > 0;  // Returns true if insertion is successful
            } catch (SQLException e) {
                System.err.println("Error inserting data into citizen table: " + e.getMessage());
            }
            return false;
        }

    public static List<CitizenModel> CitizenProfile(int id) {
        List<CitizenModel> citizens = new ArrayList<>();
        String sql = "SELECT * FROM citizen WHERE user_id = '"+id+"'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {



            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int citizenid = rs.getInt("citizen_id");
                    int userid = rs.getInt("user_id");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    String name = rs.getString("name");
                    String profile = rs.getString("profile");
                    String imageUrl = rs.getString("image_url");

                    CitizenModel citizen = new CitizenModel(citizenid,userid,address,phoneNumber,name,profile,imageUrl);
                    citizens.add(citizen);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return citizens;
    }

    public static boolean updateCitizen(int userId, String name, String address, String phoneNumber, String profile, String imageUrl) {
        String updateQuery = "UPDATE citizen SET name = ?, address = ?, phone_number = ?, profile = ?, image_url = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setString(1, name);
            statement.setString(2, address);
            statement.setString(3, phoneNumber);
            statement.setString(4, profile);
            statement.setString(5, imageUrl);
            statement.setInt(6, userId);  // Set the user_id for WHERE clause

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;  // Returns true if the update is successful
        } catch (SQLException e) {
            System.err.println("Error updating data in citizen table: " + e.getMessage());
        }
        return false;
    }

    public static boolean deleteCitizen(int userId) {
        boolean isSuccess = false;
        String sql = "DELETE FROM citizen WHERE user_id = ?"; // SQL query to delete user by user ID

        // Try-with-resources to ensure connection and statement are closed
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the user ID parameter for the prepared statement
            pstmt.setInt(1, userId);

            // Execute the delete operation
            int rowsDeleted = pstmt.executeUpdate();
            isSuccess = rowsDeleted > 0;  // Return true if deletion was successful

        } catch (SQLException e) {
            System.err.println("Error deleting user from users table: " + e.getMessage());
        }

        return isSuccess;
    }

}

