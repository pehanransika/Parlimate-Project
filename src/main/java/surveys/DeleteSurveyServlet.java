package surveys;

import UserPackage.UserModel;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteSurveyServlet")
public class DeleteSurveyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch user votes for this question and
            HttpSession session = request.getSession(false);
            // Get the user object from session
            UserModel user = (UserModel) session.getAttribute("user");
            // Extract the userId
            int userid = user.getUserId();
            // Create an instance of your controller
            surveyController surveyController = new surveyController(userid);
            int surveyId = Integer.parseInt(request.getParameter("surveyId"));
            boolean success = surveyController.deleteSurvey(surveyId);
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Survey deleted successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to delete survey");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid survey ID");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error deleting survey: " + e.getMessage());
        }
    }
}