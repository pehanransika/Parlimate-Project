package Suerveyreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetAllSurveyRequestServlet")
public class GetAllSurveyRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all survey requests
            List<SurveyRequestModel> allSurveyRequests = SurveyRequestController.getAllSurveyRequests();

            // Set the list as a request attribute
            request.setAttribute("allSurveyRequests", allSurveyRequests);

            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/surveyrequestDetails.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to retrieve survey requests.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}