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

@WebServlet("/searchSurveyServlet")
public class SearchSurveyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }


        UserModel user = (UserModel) session.getAttribute("user");


        int userId = user.getUserId();


        String searchQuery = request.getParameter("searchQuery");
        String platform = request.getParameter("platform");


        surveyController controller = new surveyController(userId);

        List<SurveyModel> surveys;

        // Determine which search method to use based on platform
        if ("parlimate".equals(platform)) {

            surveys = controller.searchParlimateSurveys(searchQuery);
            request.setAttribute("surveys", surveys);

            // Forward to the search results JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/surveys.jsp");
            dispatcher.forward(request, response);
        } else if("users".equals(platform)){

            surveys = controller.searchSurveys(searchQuery);
            request.setAttribute("surveys", surveys);

            // Forward to the search results JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/userSurveys.jsp");
            dispatcher.forward(request, response);
        }else{

            surveys = controller. searchSurveysByUser(userId,searchQuery);
            request.setAttribute("surveys", surveys);

            // Forward to the search results JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/yourSurveys.jsp");
            dispatcher.forward(request, response);
        }

    }
}
