package Suerveyreq;

import Suerveyreq.SurveyRequestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/CreateSurveyRequestServlet")
public class CreateSurveyRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int defaultUserId = 2; // Default user ID if not provided

            // Retrieve form data
            String title = request.getParameter("title");
            String questionType = request.getParameter("questiontype");
            String questionText = request.getParameter("questiontext");
            String userIdStr = request.getParameter("userid");

            // Parse user ID or use the default
            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            // Get the current timestamp for the survey request
            Timestamp requestTime = new Timestamp(System.currentTimeMillis());

            // Call the controller to create a survey request
            boolean isTrue = SurveyRequestController.createSurveyRequest(userId, title, questionType, questionText, requestTime);

            if (isTrue) {
                // If successful, show alert and redirect to GetListServlet
                String alertMessage = "Survey Request published successfully.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetListServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish survey request.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
            dispatcher.forward(request, response);
        }
    }
}

