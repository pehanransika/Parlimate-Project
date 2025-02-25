package Suerveyreq;

import fundreq.RequestController;
import fundreq.RequestModel;

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
            // Fetch all fundraising requests from FundraisingRequestController
            List<SurveyRequestModel> allSurveyRequests = SurveyRequestController.getAllSurveyRequests();
            System.out.println(allSurveyRequests.size());

            // Set the list as a request attribute
            request.setAttribute("allSurveyRequests", allSurveyRequests);
            System.out.println(allSurveyRequests.size());
            // Forward to requestsDetail.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/surveyrequestDetails.jsp");


            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve fundraising requests. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delegate POST requests to GET method
        doGet(request, response);
    }
}