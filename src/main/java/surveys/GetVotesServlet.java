package surveys;

import com.google.gson.Gson;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getVotes")
public class GetVotesServlet extends HttpServlet {
    private ResponseController responseController;

    @Override
    public void init() {
        responseController = new ResponseController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Get the question_id from the request
            int questionId = Integer.parseInt(request.getParameter("question_id"));

            // Fetch vote counts for the question
            List<Integer> voteCounts = getVoteCountsForQuestion(questionId);

            // Convert to JSON and send response
            Gson gson = new Gson();
            out.print(gson.toJson(voteCounts));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Invalid question_id\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }

    // Method to fetch vote counts for a question
    private List<Integer> getVoteCountsForQuestion(int questionId) {
        List<Integer> voteCounts = new ArrayList<>();

        // First, get all answer IDs for this question (ordered by answer_id to maintain consistency)
        String query = "SELECT answer_id FROM answer WHERE question_id = ? ORDER BY answer_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, questionId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int answerId = rs.getInt("answer_id");
                    // Use ResponseController to get the vote count for this answer
                    int voteCount = responseController.getAnswerVotes(answerId);
                    voteCounts.add(voteCount);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch vote counts: " + e.getMessage());
        }

        return voteCounts;
    }
}