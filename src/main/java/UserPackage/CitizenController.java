package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CitizenController {

    private static Connection conn = null;
    private static PreparedStatement pst = null;
    private static ResultSet rs = null;


    public static boolean insertCitizen(int userId, String name, String address, String phoneNumber, String district) {
        String insertQuery = "INSERT INTO citizen (user_id, name, address, phone_number, district) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(insertQuery)) {

            statement.setInt(1, userId);
            statement.setString(2, name);
            statement.setString(3, address);
            statement.setString(4, phoneNumber);
            statement.setString(5, district);
            // Use image_url here

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;  // Returns true if insertion is successful
        } catch (SQLException e) {
            System.err.println("Error inserting data into citizen table: " + e.getMessage());
        }
        return false;
    }

    public CitizenModel getUserById(int userId) {
        CitizenModel citizen = null;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM Citizens WHERE userId = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                citizen = new CitizenModel(
                        rs.getInt("citizenId"),
                        rs.getInt("userId"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getString("name"),
                        rs.getString("district"),
                        rs.getString("province")
                );
            }
//            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return citizen;
    }

    public static List<CitizenModel> CitizenProfile(int id) {
        List<CitizenModel> citizens = new ArrayList<>();
        String sql = "SELECT * FROM citizen WHERE user_id = '" + id + "'";
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
                    String district = rs.getString("district");
                    String province = rs.getString("province");

                    CitizenModel citizen = new CitizenModel(citizenid, userid, address, phoneNumber, name, district, province);
                    citizens.add(citizen);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return citizens;
    }

    public static boolean updateCitizen(int userId, String name, String address, String phoneNumber, String district) {
        String updateQuery = "UPDATE citizen SET name = ?, address = ?, phone_number = ?, district = ? WHERE user_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setString(1, name);
            statement.setString(2, address);
            statement.setString(3, phoneNumber);
            statement.setString(4, district);

            statement.setInt(5, userId);  // Set the user_id for WHERE clause
            System.out.println("Update Citizen: " +statement.executeUpdate());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;  // Returns true if the update is successful
        } catch (SQLException e) {
            System.err.println("Error updating data in citizen table: " + e.getMessage());
        }
        return false;
    }

    public static boolean updateCitizenUser(int userId, String name, String district, String province) {
        boolean isSuccessful = true;
        String sql = "Update citizen set name=? , district=?, province=? where user_id=? ";

        try {
            conn = DBConnection.getConnection();
            pst = conn.prepareStatement(sql);

            System.out.println("Executing update query for user: " + userId);
            System.out.println("[DEBUG] New name: " + name);
            System.out.println("[DEBUG] New district: " + district);
            System.out.println("[DEBUG] New province: " + province);

            pst.setString(1, name);
            pst.setString(2, district);
            pst.setString(3, province);
            pst.setInt(4, userId);

            int rowsUpdated = pst.executeUpdate();

            isSuccessful = rowsUpdated > 0;

        } catch (Exception e) {
            System.err.println("Error updating data in citizen table: " + e.getMessage());
            e.printStackTrace();
        }

        return isSuccessful;
    }

    public static boolean deleteCitizen(int userId) {
        String sql = "DELETE FROM citizen WHERE user_id = ?"; // Ensure table and column names match the database schema
        try (Connection conn = DBConnection.getConnection(); // Auto-close resources
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the parameter for user_id
            pstmt.setInt(1, userId);

            // Execute the query and get rows affected
            int rowsAffected = pstmt.executeUpdate();

            // Log and return the result
            if (rowsAffected > 0) {
                System.out.println("Citizen with user_id " + userId + " deleted successfully.");
                return true; // Deletion was successful
            } else {
                System.out.println("No citizen found with user_id " + userId + ".");
                return false; // No matching record found
            }

        } catch (SQLException e) {
            // Log the exception with more context
            System.err.println("Error deleting citizen with user_id " + userId + ": " + e.getMessage());
        }

        return false; // Default return if something goes wrong
    }


}