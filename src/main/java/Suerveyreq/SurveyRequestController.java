


package Suerveyreq;

import java.sql.*;
import java.time.LocalDateTime;
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
    public static boolean createSurveyRequest(int userid, String questionType, String questionText, Timestamp requestTime) throws SQLException {
        String insertQuery = "INSERT INTO survey_requests (userid, questiontype, questiontext, requesttime) VALUES ( ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

            stmt.setInt(1, userid);

            stmt.setString(2, questionType);
            stmt.setString(3, questionText);
            stmt.setTimestamp(4, requestTime);

            int rowsInserted = stmt.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error creating survey request: " + e.getMessage());
            throw e;
        }
    }
    // Retrieve all survey requests
    public static List<SuerveyRequestModel> getAllSurveyRequests() throws SQLException {
        List<SuerveyRequestModel> requests = new ArrayList<>();
        String query = "SELECT surveyrequestid, userid, questiontype, questiontext, requesttime " +
                "FROM survey_requests"; // Correct column name here

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int surveyRequestId = rs.getInt("surveyrequestid");  // Ensure correct column name
                int userId = rs.getInt("userid");

                String questionType = rs.getString("questiontype");
                String questionText = rs.getString("questiontext");
                Timestamp requestTime = rs.getTimestamp("requesttime");

                // Create a SuerveyRequestModel object
                SuerveyRequestModel request = new SuerveyRequestModel(
                        surveyRequestId, userId, questionType, questionText, requestTime.toLocalDateTime()
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
    public static SuerveyRequestModel getSurveyRequestById(int surveyrequestid) throws SQLException {
        String query = "SELECT userid, questiontype, questiontext, requesttime " +
                "FROM survey_requests WHERE surveyrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, surveyrequestid);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    int userid = rs.getInt("userid");

                    String questiontype = rs.getString("questiontype");
                    String questiontext = rs.getString("questiontext");
                    Timestamp requesttime = rs.getTimestamp("requesttime");

                    // Return the model with the fetched data
                    return new SuerveyRequestModel(surveyrequestid, userid,  questiontype, questiontext, requesttime.toLocalDateTime());
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving survey request: " + e.getMessage());
            throw e;
        }

        return null;
    }

    // Update a survey request
    public static boolean updateSurveyRequest(int surveyrequestid, Integer userid, String questiontype,
                                              String questiontext, Timestamp requesttime) throws SQLException {
        String query = "UPDATE survey_requests SET userid = ?, questiontype = ?, questiontext = ?, " +
                "requesttime = ? WHERE surveyrequestid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Input validation (basic example)


            // Log input parameters for debugging
            System.out.println("Updating survey request with ID: " + surveyrequestid);
            System.out.println("Parameters: " + userid +  ", " + questiontype + ", " + questiontext + ", "
                    + requesttime);

            // Set parameters in the correct order
            stmt.setObject(1, userid);

            stmt.setString(2, questiontype);
            stmt.setString(3, questiontext);
            stmt.setTimestamp(4, requesttime);
            stmt.setInt(5, surveyrequestid);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);

            return rowsUpdated > 0; // Returns true if at least one row was updated
        } catch (SQLException e) {
            System.err.println("Error updating survey request: " + e.getMessage());
            throw e;
        }
    }

    // Delete a survey request
    public static boolean deleteSurveyRequest(int surveyrequestid) throws SQLException {
        String query = "DELETE FROM survey_requests WHERE surveyrequestid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, surveyrequestid);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting survey request: " + e.getMessage());
            throw e;
        }
    }
}
