package meetings;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JoinMeetingController {
    public static boolean addUserToMeeting(String meetingId, String userId, String email) throws SQLException {
        String insertQuery = "INSERT INTO meetingusers (meetingid, userid, email) VALUES (?, ?, ?)";
        String checkQuery = "SELECT COUNT(*) FROM meetingusers WHERE meetingid = ? AND userid = ?";
        String updateSlotsQuery = "UPDATE meetings SET availableslots = availableslots - 1 WHERE meetingid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, Integer.parseInt(meetingId));
            checkStmt.setInt(2, Integer.parseInt(userId));
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                return false;  // Already registered
            }

            // Insert the user
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, Integer.parseInt(meetingId));
                insertStmt.setInt(2, Integer.parseInt(userId));
                insertStmt.setString(3, email);
                insertStmt.executeUpdate();

                // Update available slots only if insert succeeds
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSlotsQuery)) {
                    updateStmt.setInt(1, Integer.parseInt(meetingId));
                    updateStmt.executeUpdate();
                }

                return true;
            }
        }
    }

    public static boolean addUserToWishlist(String meetingId, String userId, String email) throws SQLException {
        // Assuming you have a method for DB connection and executing the SQL query
        String query = "INSERT INTO meetingwishlist (meetingid, userid, email) VALUES (?, ?, ?)";

        // Check if the user is already registered for the meeting
        String checkQuery = "SELECT COUNT(*) FROM meetingwishlist WHERE meetingid = ? AND userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(checkQuery)) {

            stmt.setInt(1, Integer.parseInt(meetingId));
            stmt.setInt(2, Integer.parseInt(userId));
            ResultSet rs = stmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // If user is already in the meeting
                return false;  // Indicating failure due to duplicate
            }

            // If no duplicate, proceed to insert the user into the meeting
            try (PreparedStatement insertStmt = conn.prepareStatement(query)) {
                insertStmt.setInt(1, Integer.parseInt(meetingId));
                insertStmt.setInt(2, Integer.parseInt(userId));
                insertStmt.setString(3, email);
                insertStmt.executeUpdate();
                return true;  // Successfully inserted
            }
        }
    }
    public static boolean withdrawRegistration(String meetingId, String userId) {
        String deleteQuery = "DELETE FROM meetingusers WHERE meetingId = ? AND userId = ?";
        String updateSlotsQuery = "UPDATE meetings SET availableSlots = availableSlots + 1 WHERE meetingId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {

            // Set parameters for delete query
            deleteStmt.setInt(1, Integer.parseInt(meetingId));
            deleteStmt.setInt(2, Integer.parseInt(userId));

            int rowsAffected = deleteStmt.executeUpdate();

            if (rowsAffected > 0) {
                // Registration was deleted successfully, now update availableSlots
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSlotsQuery)) {
                    updateStmt.setInt(1, Integer.parseInt(meetingId));
                    updateStmt.executeUpdate();
                }
                return true;
            } else {
                return false; // No rows deleted
            }

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }


    public static List<RegisteredUserModel> getRegisteredUsers(int meetingId) {
        String query = "SELECT userid, email FROM meetingusers WHERE meetingid = ?";
        List<RegisteredUserModel> users = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, meetingId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int userId = rs.getInt("userid");
                    String email = rs.getString("email");

                    RegisteredUserModel user = new RegisteredUserModel(userId, email, meetingId);
                    users.add(user);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // You can log this instead
        }

        return users;
    }

}


