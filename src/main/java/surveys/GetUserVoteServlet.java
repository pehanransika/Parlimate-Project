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

@WebServlet("/getUserVote")
public class GetUserVoteServlet extends HttpServlet {
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
            int questionId = Integer.parseInt(request.getParameter("question_id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));

            Integer answerId = getUserVoteForQuestion(questionId, userId);

            Gson gson = new Gson();
            out.print(gson.toJson(answerId));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Invalid parameters\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
        }
    }

    private Integer getUserVoteForQuestion(int questionId, int userId) {
        String query = "SELECT answer_id FROM response WHERE question_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, questionId);
            stmt.setInt(2, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("answer_id");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch user vote: " + e.getMessage());
        }
        return null; // No vote found
    }
}
