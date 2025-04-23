package meetings;

import UserPackage.UserModel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MeetingController {

    public MeetingController() {}

    public boolean insertMeeting(MeetingModel meeting, int meetingrequestid) {
        String insertQuery = "INSERT INTO meetings (politicianId, topic, description, date, time, typeofthemeeting, host, platform, deadlinetoregister, slots, availableslots) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateRequestStatusQuery = "UPDATE meetingrequest SET status = ? WHERE meetingrequestid = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {

            // Set values for the insert statement
            ps.setInt(1, meeting.getPoliticianId());
            ps.setString(2, meeting.getTopic());
            ps.setString(3, meeting.getDescription());
            ps.setDate(4, meeting.getDate());
            ps.setTime(5, meeting.getTime());
            ps.setString(6, meeting.getTypeofthemeeting());
            ps.setString(7, meeting.getHost());
            ps.setString(8, meeting.getPlatform());
            ps.setDate(9, meeting.getDeadlinetoregister());
            ps.setInt(10, meeting.getSlots());
            ps.setInt(11, meeting.getSlots());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                // Update meetingrequest status to false
                try (PreparedStatement updatePs = connection.prepareStatement(updateRequestStatusQuery)) {
                    updatePs.setBoolean(1, false);
                    updatePs.setInt(2, meetingrequestid);
                    updatePs.executeUpdate();
                }
                return true;
            } else {
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean deleteMeeting(int meetingId) {
        String query = "DELETE FROM meetings WHERE meetingid = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meetingId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateMeeting(MeetingModel meeting) {
        String query = "UPDATE meetings SET politicianId = ?, topic = ?, description = ?, date = ?, time = ?, typeofthemeeting = ?, host = ?, platform = ?, deadlinetoregister = ?, slots = ?, availableslots = ? WHERE meetingId = ?";

        try (Connection connection = DBConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, meeting.getPoliticianId());
            ps.setString(2, meeting.getTopic());
            ps.setString(3, meeting.getDescription());
            ps.setDate(4, meeting.getDate());
            ps.setTime(5, meeting.getTime());
            ps.setString(6, meeting.getTypeofthemeeting());
            ps.setString(7, meeting.getHost());
            ps.setString(8, meeting.getPlatform());
            ps.setDate(9, meeting.getDeadlinetoregister());
            ps.setInt(10, meeting.getSlots());
            ps.setInt(11, meeting.getAvailableSlots());
            ps.setInt(12, meeting.getMeetingId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<MeetingModel> getAllMeetings() {
        String query = "SELECT  * FROM meetings ORDER BY CASE WHEN availableslots >0 THEN 0 ELSE 1 END, CASE WHEN date >= CURRENT_DATE THEN 0 ELSE 1 END, date ASC;";
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
                meeting.setSlots(rs.getInt("slots"));
                meeting.setAvailableSlots(rs.getInt("availableslots"));
                meetings.add(meeting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return meetings;
    }

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
                meeting.setSlots(rs.getInt("slots"));
                meeting.setAvailableSlots(rs.getInt("availableslots"));
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
                meeting.setSlots(rs.getInt("slots"));
                meeting.setAvailableSlots(rs.getInt("availableslots"));
                todaysMeetings.add(meeting);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return todaysMeetings;
    }

    public ArrayList<MeetingModel> fetchUserRegisteredMeetings(HttpServletRequest request) {
        ArrayList<MeetingModel> registeredMeetings = new ArrayList<>();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("[DEBUG] No session or user found.");
            return registeredMeetings;
        }

        UserModel user = (UserModel) session.getAttribute("user");
        int userId = user.getUserId();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT m.* FROM meetings m " +
                    "JOIN meetingusers mu ON m.meetingId = mu.meetingId " +
                    "WHERE mu.userId = ? ORDER BY CASE WHEN date >= CURRENT_DATE THEN 0 ELSE 1 END, date ASC;";

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
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
                        meeting.setSlots(rs.getInt("slots"));
                        meeting.setAvailableSlots(rs.getInt("availableslots"));
                        registeredMeetings.add(meeting);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return registeredMeetings;
    }

}
