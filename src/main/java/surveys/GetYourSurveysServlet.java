package surveys;

import UserPackage.UserModel;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/GetYourSurveysServlet")
public class GetYourSurveysServlet  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch user votes for this question and
        // Fetch user votes for this question and
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        // Get the user object from session
        UserModel user = (UserModel) session.getAttribute("user");

        // Extract the userId
        int userId = user.getUserId();
        // Create an instance of your controller
        surveyController controller = new surveyController(userId);

        // Retrieve all surveys with questions and answers
        List<SurveyModel> surveys = controller.getSurveysOfUser(userId) ;

        // Add the list of surveys as a request attribute so that it can be accessed in surveys.jsp
        request.setAttribute("surveys", surveys);



        // Forward the request to surveys.jsp for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("yourSurveys.jsp");
        dispatcher.forward(request, response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        doGet(request,response);
    }
}
