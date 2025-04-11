package meetings;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JoinMeetingController {
    public static boolean addUserToMeeting(String meetingId, String userId, String email) throws SQLException {
        // Assuming you have a method for DB connection and executing the SQL query
        String query = "INSERT INTO meetingusers (meetingid, userid, email) VALUES (?, ?, ?)";

        // Check if the user is already registered for the meeting
        String checkQuery = "SELECT COUNT(*) FROM meetingusers WHERE meetingid = ? AND userid = ?";

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
}

