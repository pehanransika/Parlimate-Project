package Suerveyreq;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SurveyRequestController {

    // Method to check if a user exists in the database
    public static boolean isUserExists(int userid) throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE userid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userid);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking user existence: " + e.getMessage());
            throw e;
        }
    }

    // Method to create a new survey request
    public static boolean createSurveyRequest(int userid, String questionText, String answer01,
                                              String answer02, String answer03, String answer04, Timestamp requestTime) throws SQLException {
        String insertQuery = "INSERT INTO survey_requests (userid, questiontext, answer01, answer02, answer03, answer04, requesttime) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

            stmt.setInt(1, userid);
            stmt.setString(2, questionText);
            stmt.setString(3, answer01);
            stmt.setString(4, answer02);
            stmt.setString(5, answer03);
            stmt.setString(6, answer04);
            stmt.setTimestamp(7, requestTime);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error creating survey request: " + e.getMessage());
            throw e;
        }
    }

    // Retrieve all survey requests
    public static List<SurveyRequestModel> getAllSurveyRequests() throws SQLException {
        List<  SurveyRequestModel> requests = new ArrayList<>();
        String query = "SELECT suerveyrequestid, userid, questiontext, answer01, answer02, answer03, answer04, requesttime FROM survey_requests";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SurveyRequestModel request = new SurveyRequestModel(
                        rs.getInt("suerveyrequestid"),
                        rs.getInt("userid"),
                        rs.getString("questiontext"),
                        rs.getString("answer01"),
                        rs.getString("answer02"),
                        rs.getString("answer03"),
                        rs.getString("answer04"),
                        rs.getTimestamp("requesttime").toLocalDateTime()
                );
                requests.add(request);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving all survey requests: " + e.getMessage());
            throw e;
        }
        return requests;
    }

    // Retrieve a single survey request by ID
    public static SurveyRequestModel getSurveyRequestById(int suerveyrequestid) throws SQLException {
        String query = "SELECT userid, questiontext, answer01, answer02, answer03, answer04, requesttime FROM survey_requests WHERE surveyrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, suerveyrequestid);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new SurveyRequestModel(
                             suerveyrequestid,
                            rs.getInt("userid"),
                            rs.getString("questiontext"),
                            rs.getString("answer01"),
                            rs.getString("answer02"),
                            rs.getString("answer03"),
                            rs.getString("answer04"),
                            rs.getTimestamp("requesttime").toLocalDateTime()
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving survey request: " + e.getMessage());
            throw e;
        }
        return null;
    }

    // Update a survey request
    public static boolean updateSurveyRequest(int surveyrequestid, int userid, String questionText, String answer01,
                                              String answer02, String answer03, String answer04, Timestamp requestTime) throws SQLException {
        String query = "UPDATE survey_requests SET userid = ?, questiontext = ?, answer01 = ?, answer02 = ?, answer03 = ?, answer04 = ?, requesttime = ? WHERE surveyrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userid);
            stmt.setString(2, questionText);
            stmt.setString(3, answer01);
            stmt.setString(4, answer02);
            stmt.setString(5, answer03);
            stmt.setString(6, answer04);
            stmt.setTimestamp(7, requestTime);
            stmt.setInt(8, surveyrequestid);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating survey request: " + e.getMessage());
            throw e;
        }
    }

    // Delete a survey request
    public static boolean deleteSurveyRequest(int suerveyrequestid) throws SQLException {
        System.out.println("Attempting to delete survey request with ID: " + suerveyrequestid); // Debugging log

        String query = "DELETE FROM survey_requests WHERE suerveyrequestid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, suerveyrequestid);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Log result

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting survey request: " + e.getMessage());
            throw e;
        }
    }

}
