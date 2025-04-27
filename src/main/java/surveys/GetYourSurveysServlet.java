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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("user");


        int userId = user.getUserId();

        surveyController controller = new surveyController(userId);


        List<SurveyModel> surveys = controller.getSurveysOfUser(userId) ;


        request.setAttribute("surveys", surveys);




        RequestDispatcher dispatcher = request.getRequestDispatcher("yourSurveys.jsp");
        dispatcher.forward(request, response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        doGet(request,response);
    }
}
