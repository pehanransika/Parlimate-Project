package Suerveyreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteSurveyRequestServlet")
public class DeleteSurveyRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the survey request ID from the request parameter
            String surveyRequestIdParam = request.getParameter("surveyRequestId");



            System.out.println("Received surveyRequestId: " + surveyRequestIdParam);

            // Validate the survey request ID
            if (surveyRequestIdParam == null || surveyRequestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Survey request ID is missing or invalid.");
            }

            // Parse the survey request ID to an integer
            int surveyRequestId = Integer.parseInt(surveyRequestIdParam);

            // Attempt to delete the survey request
            boolean isDeleted = SurveyRequestController.deleteSurveyRequest(surveyRequestId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Survey Request Deleted Successfully'); window.location.href='GetAllSurveyRequestServlet';</script>");
            } else {
                // Handle case where the survey request is not found or already deleted
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Survey request not found or already deleted.'); window.location.href='GetAllSurveyRequestServlet';</script>");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Survey Request ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid survey request ID format.'); window.location.href='GetAllSurveyRequestServlet';</script>");
        } catch (Exception e) {
            System.err.println("Error during survey request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again later.'); window.location.href='GetAllSurveyRequestsServlet';</script>");
        }
    }
}
