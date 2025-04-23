package surveys;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class ResponseController {
    public boolean createResponse(ResponseModel response) {
        String checkSql = "SELECT COUNT(*) FROM response WHERE survey_id = ? AND question_id = ? AND user_id = ?";
        String updateSql = "UPDATE response SET answer_id = ? WHERE survey_id = ? AND question_id = ? AND user_id = ?";
        String insertSql = "INSERT INTO response (survey_id, question_id, answer_id, user_id) VALUES (?, ?, ?, ?)";
        String voteUpdateSql = "UPDATE answer SET number_of_votes = (SELECT COUNT(*) FROM response WHERE response.answer_id = answer.answer_id) WHERE answer.question_id = ?";
        boolean success = false;
        try (Connection conn = DBConnection.getConnection()) {
            // Check if a response already exists
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, response.getSurveyId());
                checkStmt.setInt(2, response.getQuestionId());
                checkStmt.setInt(3, response.getUserId());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // Response exists, update it
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, response.getAnswerId());
                            updateStmt.setInt(2, response.getSurveyId());
                            updateStmt.setInt(3, response.getQuestionId());
                            updateStmt.setInt(4, response.getUserId());
                            int rowsUpdated = updateStmt.executeUpdate();
                            success = rowsUpdated > 0;
                        }
                    } else {
                        // Response does not exist, insert a new one
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, response.getSurveyId());
                            insertStmt.setInt(2, response.getQuestionId());
                            insertStmt.setInt(3, response.getAnswerId());
                            insertStmt.setInt(4, response.getUserId());
                            int rowsInserted = insertStmt.executeUpdate();
                            success = rowsInserted > 0;
                        }
                    }
                }
            }
            if (success) {
                // Update vote counts for all answers related to the question
                try (PreparedStatement voteUpdateStmt = conn.prepareStatement(voteUpdateSql)) {
                    voteUpdateStmt.setInt(1, response.getQuestionId());
                    voteUpdateStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return success;
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

    public int getTotalVotesForSurvey(int surveyId) {
        String sql = "SELECT COUNT(DISTINCT user_id) FROM response WHERE survey_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, surveyId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
