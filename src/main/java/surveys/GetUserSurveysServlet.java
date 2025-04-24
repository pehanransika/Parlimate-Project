package surveys;

import UserPackage.UserModel;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GetUserSurveysServlet")
public class GetUserSurveysServlet  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch user votes for this question and
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        // Get the user object from session
        UserModel user = (UserModel) session.getAttribute("user");

        // Extract the userId
        int userid = user.getUserId();
        // Create an instance of your controller
        surveyController controller = new surveyController(userid);
        List<SurveyModel> surveys = new ArrayList<>();
        String surveyIdParam = request.getParameter("surveyId");
        if (surveyIdParam != null && !surveyIdParam.trim().isEmpty()) {
            // Case 1: Specific survey requested
            int surveyId = Integer.parseInt(surveyIdParam);
            SurveyModel survey = controller.getSurveyById(surveyId);
            surveys.add(survey);
        } else {
            // Case 2: No surveyId, fetch all user surveys
                surveys = controller.getAllSurveysOfUsers();
        }

        // Add the list of surveys as a request attribute so that it can be accessed in surveys.jsp
        request.setAttribute("surveys", surveys);

        String jspPath;
        if ("admin".equals(user.getUserType()) || "moderator".equals(user.getUserType())) {
            jspPath = "/admin/SurveyManagement/UserSurveys.jsp";
        } else {
            jspPath = "/Surveys/userSurveys.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        dispatcher.forward(request, response);

   }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        doGet(request,response);
    }
}
