package surveys;

import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetUserSurveysServlet")
public class GetUserSurveysServlet  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create an instance of your controller
        surveyController controller = new surveyController();

        // Retrieve all surveys with questions and answers
        List<SurveyModel> surveys = controller.getAllSurveysWithQuestionsAndAnswers();

        // Add the list of surveys as a request attribute so that it can be accessed in surveys.jsp
        request.setAttribute("surveys", surveys);



        // Forward the request to surveys.jsp for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("userSurveys.jsp");
        dispatcher.forward(request, response);

   }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        doGet(request,response);
    }
}
