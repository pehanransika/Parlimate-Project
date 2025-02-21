package Suerveyreq;

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
            String questionText = request.getParameter("questiontext");
            String userIdStr = request.getParameter("userid");
            String answer01 = request.getParameter("answer01");
            String answer02 = request.getParameter("answer02");
            String answer03 = request.getParameter("answer03");
            String answer04 = request.getParameter("answer04");

            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            // Get the current timestamp for the survey request
            Timestamp requestTime = new Timestamp(System.currentTimeMillis());

            // Debugging logs
            System.out.println("User ID: " + userId);
            System.out.println("Question Text: " + questionText);
            System.out.println("Answer 01: " + answer01);
            System.out.println("Answer 02: " + answer02);
            System.out.println("Answer 03: " + answer03);
            System.out.println("Answer 04: " + answer04);
            System.out.println("Request Time: " + requestTime);

            // Call the controller to create a survey request
            boolean isTrue = SurveyRequestController.createSurveyRequest(userId, questionText, answer01, answer02, answer03, answer04, requestTime);

            if (isTrue) {
                // If successful, show alert and redirect to GetListServlet
                String alertMessage = "Survey Request published successfully.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllSurveyRequestServlet';</script>");
            } else {
                // If not successful, forward to the error page
                request.setAttribute("error", "Failed to publish survey request.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            request.setAttribute("error", "Invalid input or database error. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Surveys/wrong.jsp");
            dispatcher.forward(request, response);
        }
    }
}
