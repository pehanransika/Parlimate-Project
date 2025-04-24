package surveys;

import java.sql.*;

public class PercentageController {
    public static double getPercentageForAnswer(int answerId) {
        double percentage = 0.0;

        String query = "SELECT percentage FROM percentage WHERE answer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, answerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                percentage = rs.getDouble("percentage");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return percentage;
    }

    public void calculateAndStorePercentages() {
        String totalResponsesQuery = "SELECT question_id, COUNT(*) as total FROM response GROUP BY question_id";
        String answerCountQuery = "SELECT answer_id, question_id, COUNT(*) as count FROM response GROUP BY answer_id, question_id";
        String insertPercentageQuery = "INSERT INTO percentage (answer_id, percentage) VALUES (?, ?) " +
                "ON CONFLICT (answer_id) DO UPDATE SET percentage = EXCLUDED.percentage";

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement totalStmt = conn.prepareStatement(totalResponsesQuery);
            ResultSet totalRs = totalStmt.executeQuery();

            // Store total responses per question in a map
            java.util.Map<Integer, Integer> totalMap = new java.util.HashMap<>();
            while (totalRs.next()) {
                totalMap.put(totalRs.getInt("question_id"), totalRs.getInt("total"));
            }

            // Now count responses per answer
            PreparedStatement answerStmt = conn.prepareStatement(answerCountQuery);
            ResultSet answerRs = answerStmt.executeQuery();

            while (answerRs.next()) {
                int answerId = answerRs.getInt("answer_id");
                int questionId = answerRs.getInt("question_id");
                int answerCount = answerRs.getInt("count");

                int total = totalMap.getOrDefault(questionId, 0);

                if (total > 0) {
                    double percentage = (answerCount * 100.0) / total;

                    // Store or update in percentage table
                    PreparedStatement insertStmt = conn.prepareStatement(insertPercentageQuery);
                    insertStmt.setInt(1, answerId);
                    insertStmt.setDouble(2, percentage);
                    insertStmt.executeUpdate();
                    insertStmt.close();
                }
            }

            answerStmt.close();
            totalStmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
