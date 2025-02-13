package UserPackage;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class UserController {
    public static boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count > 0, email exists
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }
    public static int insertUser(String email, String hashedPassword, String userType) {

        boolean isSuccess = false;
        if (isEmailExists(email)) {
            return -2; // Indicate duplicate email
        }

        // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String createdAt = currentDateTime.format(formatter);

        String sql = "INSERT INTO users (email, password, user_type, created_at) VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set parameters in the PreparedStatement
            statement.setString(1, email);
            statement.setString(2, hashedPassword);
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

        String sql = "SELECT * FROM users WHERE email = ?";



        // Hash the input password before checking
        String hashedPassword = passwordHashing.hashPassword(password);

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);


            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String storedHash = rs.getString("password"); // Password stored in DB

                    // Compare hashed password instead of re-hashing
                    if (passwordHashing.checkPassword(password, storedHash)) {
                        int id = rs.getInt("user_id");
                        String gmail = rs.getString("email");
                        String userType = rs.getString("user_type");
                        String createdAt = rs.getString("created_at");

                        UserModel user = new UserModel(id, gmail, storedHash, userType, createdAt);
                        users.add(user);
                    }

            stmt.setString(2, hashedPassword); // ✅ Now comparing hashed passwords

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

        // SQL query to update the user
        String sql = "UPDATE users SET email = ?, password = ? WHERE user_id = ?";

        // Debugging log: Show parameters before executing
        System.out.println("Attempting to update user: userId=" + userId + ", email=" + email);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Validate parameters before updating
            if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
                System.err.println("Validation failed: email or password is empty.");
                return false;
            }

            // Set parameters for the PreparedStatement
            pstmt.setString(1, email);   // Email
            pstmt.setString(2, password); // Password
            pstmt.setInt(3, userId);    // User ID

            // Execute the update query
            int rowsUpdated = pstmt.executeUpdate();
            isSuccess = rowsUpdated > 0;

            // Log success or failure
            if (isSuccess) {
                System.out.println("User with userId=" + userId + " updated successfully.");
            } else {
                System.err.println("Update failed: No rows affected for userId=" + userId);
            }

        } catch (SQLException e) {
            // Log detailed SQL error
            System.err.println("SQL error while updating user: " + e.getMessage());
        }

        return isSuccess;
    }


    public static boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId); // Bind the user ID
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("User with user_id " + userId + " deleted successfully.");
                return true; // Return true if the deletion was successful
            } else {
                System.out.println("No user found with user_id " + userId + ".");
                return false; // Return false if no rows were deleted
            }

        } catch (SQLException e) {
            System.err.println("Error deleting user from users table: " + e.getMessage());
            return false;
        }
    }



}

