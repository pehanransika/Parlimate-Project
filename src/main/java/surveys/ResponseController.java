package surveys;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class ResponseController {
    public boolean createResponse(ResponseModel response) {
        String sql = "INSERT INTO response (survey_id, question_id, answer_id, user_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, response.getSurveyId());
            stmt.setInt(2, response.getQuestionId());
            stmt.setInt(3, response.getAnswerId());
            stmt.setInt(4, response.getUserId());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Method to update an existing response (e.g., changing the selected answer)
    public boolean updateResponse(ResponseModel response) {
        String sql = "UPDATE response SET answer_id = ? WHERE response_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, response.getAnswerId());
            stmt.setInt(2, response.getResponseId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    public int getAnswerVotes(int answerId) {
        String query = "SELECT COUNT(*) FROM response WHERE answer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, answerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the count of responses for this answer
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if no votes found or in case of an error
    }

    public int getQuestionFullVotes(int questionId) {
        String query = "SELECT COUNT(*) FROM response WHERE question_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, questionId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the total count of responses for this question
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if no votes found or in case of an error
    }

    public int getSurveyFullVotes(int surveyId) {
        String query = "SELECT COUNT(*) FROM response WHERE survey_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, surveyId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the total count of responses for the survey
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if no votes found or in case of an error
    }


}
