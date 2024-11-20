package UserPackage;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class UserController {
    public static int insertUser(String email, String password, String userType) {
        boolean isSuccess = false;

        // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String createdAt = currentDateTime.format(formatter);

        String sql = "INSERT INTO users (email, password, user_type, created_at) VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters in the PreparedStatement
            statement.setString(1, email);
            statement.setString(2, password);
            statement.setString(3, userType);
            statement.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Set current timestamp

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

        return -1; // Return -1 if insertion fails (indicating an error)
    }


    //Login Validate
    public static List<UserModel> loginValidate(String email, String password) {

        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, email);
            stmt.setString(2, password); // Consider hashing this before storing

            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("user_id");
                    String gmail = rs.getString("email");
                    String pass = rs.getString("password");
                    String userType = rs.getString("user_type");
                    String createdAt = rs.getString("created_at");

                    UserModel user = new UserModel(id, gmail, pass, userType, createdAt);
                    users.add(user);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return users;
    }

    public static List<UserModel> UserProfile(int id) {
        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE user_id = '"+id+"'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {



            // Execute the query and process the ResultSet
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int userid = rs.getInt("user_id");
                    String gmail = rs.getString("email");
                    String pass = rs.getString("password");
                    String userType = rs.getString("user_type");
                    String createdAt = rs.getString("created_at");

                    UserModel user = new UserModel(id, gmail, pass, userType, createdAt);
                    users.add(user);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return users;
    }

    public static boolean updateUser(int userId, String email, String password) {

        boolean isSuccess = false;
        // Database connection and SQL query
        String sql = "UPDATE users SET email = ?, password = ? WHERE user_id = ?";

        // Code for executing the query would go here, e.g., using a PreparedStatement
        // Example:
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setInt(4, userId);

            int rowsUpdated = pstmt.executeUpdate();
             isSuccess= rowsUpdated > 0;

        } catch (SQLException e) {
            System.err.println("Error inserting data into users table: " + e.getMessage());
        }

        return isSuccess;
    }
    public static boolean deleteUser(int userId) {
        boolean isSuccess = false;
        String sql = "DELETE FROM users WHERE user_id = ?"; // SQL query to delete user by user ID

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

