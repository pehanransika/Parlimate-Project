package admin;

import UserPackage.DBConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class AdminController {

    // Insert Admin
    public static int insertAdmin(String name, String email, String password, String phonenumber, String role) {
        // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp createdAt = Timestamp.valueOf(currentDateTime); // Convert to Timestamp

        String sql = "INSERT INTO admins (name, email, password, phonenumber, role, createdat) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters in the PreparedStatement
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, password);
            statement.setString(4, phonenumber);
            statement.setString(5, role);
            statement.setTimestamp(6, createdAt); // Set Timestamp for the createdat column

            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();

            // Retrieve the generated user ID
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Return the generated user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in registration: " + e.getMessage());
        }

        return -1; // Return -1 if insertion fails
    }

    // Login Validate
    public static List<AdminModel> loginValidate(String email, String password) {
        List<AdminModel> admins = new ArrayList<>();
        String sql = "SELECT * FROM admins WHERE email = ? AND password = ?"; // Ensure 'admins' table exists

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password); // Consider hashing this before storing

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int userid = rs.getInt("userid");
                    String name = rs.getString("name");
                    String phoneNumber = rs.getString("phoneNumber");
                    String role = rs.getString("role");
                    String createdat = rs.getString("createdat");

                    AdminModel admin = new AdminModel(userid, name, email, password, phoneNumber, role,createdat);
                    admins.add(admin);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from admins table: " + e.getMessage());
        }

        return admins;
    }


    // Get Admin Profile by User ID
   /* public static List<AdminModel> adminProfile(int userId) {
        List<AdminModel> admins = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String password = rs.getString("password");
                    String phoneNumber = rs.getString("phoneNumber");
                    String role = rs.getString("role");
                    String createdAt = rs.getString("created_at");

                    AdminModel admin = new AdminModel(userId, name, email, password, phoneNumber, role, createdAt);
                    admins.add(admin);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return admins;
    }
*/
    // Update Admin
    public static boolean updateAdmin(int userId, String name, String email, String phoneNumber, String password, String role) {
        // Validate inputs
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phoneNumber == null || phoneNumber.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
            System.err.println("Validation failed: All fields (name, email, phoneNumber, password, role) are required.");
            return false;
        }

        String sql = "UPDATE users SET name = ?, email = ?, phoneNumber = ?, password = ?, role = ? WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set parameters for the PreparedStatement
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phoneNumber);
            pstmt.setString(4, password);
            pstmt.setString(5, role);
            pstmt.setInt(6, userId);

            // Execute the update query
            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Admin with userId=" + userId + " updated successfully.");
                return true;
            } else {
                System.err.println("Update failed: No admin found with userId=" + userId);
            }

        } catch (SQLException e) {
            System.err.println("SQL error while updating admin: " + e.getMessage());
        }

        return false;
    }

    // Delete Admin
    public static boolean deleteAdmin(int userId) {
        String sql = "DELETE FROM users WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId); // Bind the user ID
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Admin with userid=" + userId + " deleted successfully.");
                return true;
            } else {
                System.out.println("No admin found with userid=" + userId + ".");
            }

        } catch (SQLException e) {
            System.err.println("Error deleting admin from users table: " + e.getMessage());
        }

        return false;
    }


}
