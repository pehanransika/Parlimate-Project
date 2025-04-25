package UserPackage;

import java.sql.*;
import java.time.LocalDate;
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
        if (isEmailExists(email)) {
            return -2; // Indicate duplicate email
        }

        String sql = "INSERT INTO users (email, password, user_type, created_at) VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, email);
            statement.setString(2, hashedPassword);
            statement.setString(3, userType);
            statement.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Current timestamp

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Return generated user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in registration: " + e.getMessage());
        }

        return -1; // Indicate failure
    }
    public static List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String userType = rs.getString("user_type");
                String created_at = rs.getString("created_at");

                UserModel user = new UserModel(userId, email, "", userType, created_at);
                users.add(user);
            }

            // Debugging: Print user list size
            System.out.println("Users found: " + users.size());

        } catch (SQLException e) {
            System.err.println("Error fetching users: " + e.getMessage());
        }

        return users;
    }
    public UserModel getUserById(int userId) {
        UserModel user = null;
        String query = "SELECT * FROM users WHERE user_id = ?"; // Fixed column name

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Corrected constructor usage
                    user = new UserModel(
                            rs.getInt("user_id"),
                            rs.getString("email"),
                            "", // Password should not be exposed
                            rs.getString("user_type"),
                            rs.getString("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
        }

        return user;
    }

    // Login Validation
    public static List<UserModel> loginValidate(String email, String password) {
        List<UserModel> users = new ArrayList<>();

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String storedHash = rs.getString("password"); // Password stored in DB

                    // Compare hashed password
                    if (passwordHashing.checkPassword(password, storedHash)) {
                        int id = rs.getInt("user_id");
                        String gmail = rs.getString("email");
                        String userType = rs.getString("user_type");
                        String created_at = rs.getString("created_at");

                        UserModel user = new UserModel(id, gmail, storedHash, userType, created_at);
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving data from users table: " + e.getMessage());
        }

        return users;
    }

    // Fetch User Profile
    public static List<UserModel> UserProfile(int id) {
        List<UserModel> users = new ArrayList<>();
        // Directly insert the ID into the SQL query
        String sql = "SELECT * FROM users WHERE user_id = " + id;

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String userType = rs.getString("user_type");
                String created_at = rs.getString("created_at");
                System.out.println("DB Record: ID=" + userId + ", Email=" + email + ", CreatedAt=" + created_at); // Debugging

                UserModel user = new UserModel(userId, email, password, userType, created_at);
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user profile: " + e.getMessage());
        }

        return users;
    }


    public static boolean updateUser(int userId, String email, String password) {
        boolean isSuccess = false;

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.err.println("Validation failed: email or password is empty.");
            return false;
        }

        String hashedPassword = passwordHashing.hashPassword(password);

        String sql = "UPDATE users SET email = ?, password = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            pstmt.setString(2, hashedPassword); // Store hashed password
            pstmt.setInt(3, userId);

            int rowsUpdated = pstmt.executeUpdate();
            isSuccess = rowsUpdated > 0;

            if (isSuccess) {
                System.out.println("User with userId=" + userId + " updated successfully.");
            } else {
                System.err.println("Update failed: No rows affected for userId=" + userId);
            }

        } catch (SQLException e) {
            System.err.println("SQL error while updating user: " + e.getMessage());
        }

        return isSuccess;
    }

    public static boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId); // Bind user ID
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("User with user_id " + userId + " deleted successfully.");
                return true;
            } else {
                System.out.println("No user found with user_id " + userId + ".");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error deleting user from users table: " + e.getMessage());
            return false;
        }
    }

    public static int getCount() {
        String query = "SELECT COUNT(*) FROM users";
        try (Connection connection = meetings.DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<Integer> getUserRegistrationsLast5Days() {
        List<Integer> registrations = new ArrayList<>();
        String query = "SELECT DATE(created_at) AS signup_date, COUNT(*) AS count " +
                "FROM users " +
                "WHERE created_at >= ? AND created_at < ? " +
                "GROUP BY DATE(created_at) " +
                "ORDER BY signup_date DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            // Set date range: from 5 days ago to tomorrow
            LocalDate today = LocalDate.now();
            LocalDate fiveDaysAgo = today.minusDays(5);
            ps.setDate(1, java.sql.Date.valueOf(fiveDaysAgo));
            ps.setDate(2, java.sql.Date.valueOf(today.plusDays(1)));

            ResultSet rs = ps.executeQuery();

            // Initialize counts for the last 5 days (most recent to oldest)
            for (int i = 0; i < 5; i++) {
                registrations.add(0); // Default to 0 for each day
            }

            // Populate counts from query results
            while (rs.next()) {
                LocalDate signupDate = rs.getDate("signup_date").toLocalDate();
                int count = rs.getInt("count");
                // Calculate days ago (0 = today, 1 = yesterday, etc.)
                long daysAgo = java.time.temporal.ChronoUnit.DAYS.between(signupDate, today);
                if (daysAgo >= 0 && daysAgo < 5) {
                    registrations.set((int) daysAgo, count);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Return list of zeros on error
            return new ArrayList<>(List.of(0, 0, 0, 0, 0));
        }

        return registrations;
    }

}
