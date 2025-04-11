package meetings;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MeetingController {

    // Constructor to initialize the database connection
    public MeetingController() {}

    // Insert a new meeting into the database
    public boolean insertMeeting(MeetingModel meeting) {
        String query = "INSERT INTO meetings (politicianId,topic, description, date, time, typeofthemeeting, host, platform, deadlinetoregister) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meeting.getPoliticianId());
            ps.setString(3, meeting.getTopic());
            ps.setString(4, meeting.getDescription());
            ps.setDate(5, meeting.getDate());
            ps.setTime(6, meeting.getTime());
            ps.setString(7, meeting.getTypeofthemeeting());
            ps.setString(8, meeting.getHost());
            ps.setString(9, meeting.getPlatform());
            ps.setDate(10, meeting.getDeadlinetoregister());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a meeting from the database
    public boolean deleteMeeting(int meetingId) {
        String query = "DELETE FROM meetings WHERE meetingId = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meetingId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update an existing meeting in the database
    public boolean updateMeeting(MeetingModel meeting) {
        String query = "UPDATE meetings SET politicianId = ?, topic = ?, description = ?, date = ?, time = ?, typeofthemeeting = ?, host = ?, platform = ?, deadlinetoregister = ? WHERE meetingId = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meeting.getPoliticianId());
            ps.setString(3, meeting.getTopic());
            ps.setString(4, meeting.getDescription());
            ps.setDate(5, meeting.getDate());
            ps.setTime(6, meeting.getTime());
            ps.setString(7, meeting.getTypeofthemeeting());
            ps.setString(8, meeting.getHost());
            ps.setString(9, meeting.getPlatform());
            ps.setDate(10, meeting.getDeadlinetoregister());
            ps.setInt(11, meeting.getMeetingId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Select all meetings from the database
    public static List<MeetingModel> getAllMeetings() {
        String query = "SELECT * FROM meetings";
        List<MeetingModel> meetings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection(); Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                MeetingModel meeting = new MeetingModel();
                meeting.setMeetingId(rs.getInt("meetingId"));
                meeting.setPoliticianId(rs.getInt("politicianId"));
                meeting.setTopic(rs.getString("topic"));
                meeting.setDescription(rs.getString("description"));
                meeting.setDate(rs.getDate("date"));
                meeting.setTime(rs.getTime("time"));
                meeting.setTypeofthemeeting(rs.getString("typeofthemeeting"));
                meeting.setHost(rs.getString("host"));
                meeting.setPlatform(rs.getString("platform"));
                meeting.setDeadlinetoregister(rs.getDate("deadlinetoregister"));
                meetings.add(meeting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return meetings;
    }

    // Select a specific meeting by meetingId
    public MeetingModel getMeetingById(int meetingId) {
        String query = "SELECT * FROM meetings WHERE meetingId = ?";
        MeetingModel meeting = null;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meetingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                meeting = new MeetingModel();
                meeting.setMeetingId(rs.getInt("meetingId"));
                meeting.setPoliticianId(rs.getInt("politicianId"));
                meeting.setTopic(rs.getString("topic"));
                meeting.setDescription(rs.getString("description"));
                meeting.setDate(rs.getDate("date"));
                meeting.setTime(rs.getTime("time"));
                meeting.setTypeofthemeeting(rs.getString("typeofthemeeting"));
                meeting.setHost(rs.getString("host"));
                meeting.setPlatform(rs.getString("platform"));
                meeting.setDeadlinetoregister(rs.getDate("deadlinetoregister"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return meeting;
    }
    public static List<MeetingModel> getTodaysMeetings() {
        String query = "SELECT * FROM meetings WHERE date = CURRENT_DATE";
        List<MeetingModel> todaysMeetings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                MeetingModel meeting = new MeetingModel();
                meeting.setMeetingId(rs.getInt("meetingId"));
                meeting.setPoliticianId(rs.getInt("politicianId"));
                meeting.setTopic(rs.getString("topic"));
                meeting.setDescription(rs.getString("description"));
                meeting.setDate(rs.getDate("date"));
                meeting.setTime(rs.getTime("time"));
                meeting.setTypeofthemeeting(rs.getString("typeofthemeeting"));
                meeting.setHost(rs.getString("host"));
                meeting.setPlatform(rs.getString("platform"));
                meeting.setDeadlinetoregister(rs.getDate("deadlinetoregister"));

                todaysMeetings.add(meeting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return todaysMeetings;
    }
}

