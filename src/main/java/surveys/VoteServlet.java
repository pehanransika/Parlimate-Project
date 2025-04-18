package surveys;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.google.gson.Gson;

@WebServlet("/vote")
public class VoteServlet extends HttpServlet {
    private ResponseController responseController = new ResponseController();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String json = request.getReader().lines().reduce("", (acc, line) -> acc + line);
        Gson gson = new Gson();
        VoteData voteData = gson.fromJson(json, VoteData.class);

        ResponseModel responseModel = new ResponseModel();
        responseModel.setSurveyId(voteData.survey_id);
        responseModel.setQuestionId(voteData.question_id);
        responseModel.setAnswerId(voteData.answer_id);
        responseModel.setUserId(voteData.user_id);

        boolean success = responseController.createResponse(responseModel);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private static class VoteData {
        int survey_id;
        int question_id;
        int answer_id;
        int user_id;
    }
}