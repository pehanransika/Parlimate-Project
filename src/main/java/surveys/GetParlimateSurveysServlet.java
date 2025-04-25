package surveys;

import UserPackage.UserModel;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetParlimateSurveysServlet")
public class GetParlimateSurveysServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if session exists and user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // Get the user object from session
        UserModel user = (UserModel) session.getAttribute("user");

        // Extract the userId
        int userId = user.getUserId();

        // Create an instance of the controller
        surveyController controller = new surveyController(userId);

        // Retrieve all surveys with questions and answers
        List<SurveyModel> surveys;
        if ("admin".equals(user.getUserType()) || "moderator".equals(user.getUserType())) {
            surveys = controller.getAllSurveysByModeratorsAndAdmins();
            request.setAttribute("surveys", surveys);
            // Forward to admin/moderator JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/SurveyManagement/ParlimateSurveys.jsp");
            dispatcher.forward(request, response);
        } else {
            // For regular users, use a different method if needed or the same one
            surveys = controller.getAllSurveysByModeratorsAndAdmins(); // Adjust if regular users need different data
            request.setAttribute("surveys", surveys);
            // Forward to regular user JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/surveys.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}