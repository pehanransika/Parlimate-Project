package meetingreq;

import com.ann.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class MeetingRequestController {

    // Check if the politician exists in the database
    public static boolean isPoliticianExists(int politicianid) throws SQLException {
        String query = "SELECT COUNT(*) FROM politician WHERE politician_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, politicianid);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Create a new meeting request
    public static boolean createMeetingRequest(int politician_id, String topic, String purposeofmeeting, String opponentname,
                                               String partyaffiliation, String discussionformat, String preferredhost,
                                               LocalDate proposaldate, LocalTime proposaltime, String estimatedduration) throws SQLException {
        if (!isPoliticianExists(politician_id)) {
            throw new SQLException("Politician ID does not exist.");
        }

        String query = "INSERT INTO meetingrequest (politician_id, topic, purposeofmeeting, opponentname, partyaffiliation, " +
                "discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, politician_id);
            stmt.setString(2, topic);
            stmt.setString(3, purposeofmeeting);
            stmt.setString(4, opponentname);
            stmt.setString(5, partyaffiliation);
            stmt.setString(6, discussionformat);
            stmt.setString(7, preferredhost);
            stmt.setDate(8, Date.valueOf(proposaldate)); // Use LocalDate for proposaldate
            stmt.setTime(9, Time.valueOf(proposaltime)); // Use LocalTime for proposaltime
            stmt.setString(10, estimatedduration);

            return stmt.executeUpdate() > 0; // Returns true if a row was inserted
        }
    }

    // Retrieve all meeting requests
    public static List<MeetingRequestModel> getAllMeetingRequests() throws SQLException {
        List<MeetingRequestModel> requests = new ArrayList<>();
        String query = "SELECT meetingrequestid, politician_id, topic, purposeofmeeting, opponentname, partyaffiliation, " +
                "discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration FROM meetingrequest";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int meetingrequestid = rs.getInt("meetingrequestid");
                int politician_id = rs.getInt("politician_id");
                String topic = rs.getString("topic");
                String purposeofmeeting = rs.getString("purposeofmeeting");
                String opponentname = rs.getString("opponentname");
                String partyaffiliation = rs.getString("partyaffiliation");
                String discussionformat = rs.getString("discussionformat");
                String preferredhost = rs.getString("preferredhost");
                LocalDate proposaldate = rs.getDate("proposaldate").toLocalDate();
                LocalTime proposaltime = rs.getTime("proposaltime").toLocalTime();
                String estimatedduration = rs.getString("estimatedduration");

                MeetingRequestModel request = new MeetingRequestModel(
                        meetingrequestid, topic,politician_id, purposeofmeeting, proposaldate, proposaltime,opponentname,partyaffiliation,discussionformat, preferredhost,estimatedduration
                );
                requests.add(request);
            }
        }

        return requests;
    }
    public static MeetingRequestModel getMeetingRequestById(int meetingrequestid) throws SQLException {
        String query = "SELECT topic, purposeofmeeting, opponentname, partyaffiliation, " +
                "discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration " +
                "FROM meetingrequest WHERE meetingrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, meetingrequestid);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    int politician_id = rs.getInt("politician_id");
                    String topic = rs.getString("topic");
                    String purposeofmeeting = rs.getString("purposeofmeeting");
                    String opponentname = rs.getString("opponentname");
                    String partyaffiliation = rs.getString("partyaffiliation");
                    String discussionformat = rs.getString("discussionformat");
                    String preferredhost = rs.getString("preferredhost");
                    LocalDate proposaldate = rs.getDate("proposaldate").toLocalDate();
                    LocalTime proposaltime = rs.getTime("proposaltime").toLocalTime();
                    String estimatedduration = rs.getString("estimatedduration");

                    // Return the model with the fetched data
                    return new MeetingRequestModel(meetingrequestid, topic,politician_id, purposeofmeeting, proposaldate, proposaltime,opponentname,partyaffiliation,discussionformat, preferredhost,estimatedduration);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving meeting request: " + e.getMessage());
            throw e;  // Rethrow the exception after logging it
        }
        return null;
    }
    public static boolean updateMeetingRequest(int meetingrequestid, String topic, String purposeofmeeting,
                                               String opponentname, String partyaffiliation, String discussionformat,
                                               String preferredhost, LocalDate proposaldate, LocalTime proposaltime,
                                               String estimatedduration) throws SQLException {
        String query = "UPDATE meetingrequest SET topic = ?, purposeofmeeting = ?, opponentname = ?, " +
                "partyaffiliation = ?, discussionformat = ?, preferredhost = ?, proposaldate = ?, " +
                "proposaltime = ?, estimatedduration = ? WHERE meetingrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Input validation (basic example)
            if (topic == null || topic.trim().isEmpty() || purposeofmeeting == null || purposeofmeeting.trim().isEmpty()) {
                throw new IllegalArgumentException("Topic and purpose of meeting cannot be null or empty.");
            }

            // Log input parameters for debugging
            System.out.println("Updating meeting request with ID: " + meetingrequestid);
            System.out.println("Parameters: " + topic + ", " + purposeofmeeting + ", " + opponentname + ", "
                    + partyaffiliation + ", " + discussionformat + ", " + preferredhost + ", "
                    + proposaldate + ", " + proposaltime + ", " + estimatedduration);

            // Set parameters in the correct order
            stmt.setString(1, topic);
            stmt.setString(2, purposeofmeeting);
            stmt.setString(3, opponentname);
            stmt.setString(4, partyaffiliation);
            stmt.setString(5, discussionformat);
            stmt.setString(6, preferredhost);
            stmt.setDate(7, proposaldate != null ? Date.valueOf(proposaldate) : null);
            stmt.setTime(8, proposaltime != null ? Time.valueOf(proposaltime) : null);
            stmt.setString(9, estimatedduration);
            stmt.setInt(10, meetingrequestid);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);

            return rowsUpdated > 0; // Returns true if at least one row was updated
        } catch (SQLException e) {
            System.err.println("Error updating meeting request: " + e.getMessage());
            throw e; // Rethrow the exception after logging it
        }
    }


    public static boolean deleteMeetingRequest(int requestId) throws SQLException {
        String query = "DELETE FROM meetingrequest WHERE meetingrequestid = ?";
        try (Connection conn = fundreq.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting meeting request: " + e.getMessage());
            throw e;
        }
    }



}
