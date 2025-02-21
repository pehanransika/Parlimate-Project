package Suerveyreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

@WebServlet("/UpdateSurveyRequestServlet")
@MultipartConfig
public class UpdateSurveyRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and validate survey request ID
            String surveyRequestIdParam = request.getParameter("suerveyrequestid");
            System.out.println("Survey Request ID received: " + surveyRequestIdParam);

            if (surveyRequestIdParam == null || surveyRequestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Survey Request ID is missing.");
            }

            int suerveyrequestid = Integer.parseInt(surveyRequestIdParam);

            // Retrieve other form parameters
            String useridParam = request.getParameter("userid");

            String questiontype = request.getParameter("questiontype");
            String questiontext = request.getParameter("questiontext");
            String requesttimeParam = request.getParameter("requesttime");

            // Validate mandatory fields

            // Parse user ID
            Integer userid = null;
            if (useridParam != null && !useridParam.trim().isEmpty()) {
                userid = Integer.parseInt(useridParam);
            }

            // Parse request time
            Timestamp requesttime = null;
            if (requesttimeParam != null && !requesttimeParam.trim().isEmpty()) {
                try {
                    LocalDateTime dateTime = LocalDateTime.parse(requesttimeParam);
                    requesttime = Timestamp.valueOf(dateTime);
                } catch (DateTimeParseException e) {
                    throw new IllegalArgumentException("Invalid request time format.");
                }
            }

            // Call the controller method to update the survey request
            boolean isUpdated = SurveyRequestController.updateSurveyRequest(
                    suerveyrequestid, userid,  questiontype, questiontext, requesttime);

            if (isUpdated) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Survey Request Updated Successfully'); window.location.href='GetAllSurveyRequestsServlet';</script>");
            } else {
                request.setAttribute("error", "Failed to update the survey request.");
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('" + e.getMessage() + "'); window.history.back();</script>");
        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An unexpected error occurred. Please try again.'); window.location.href='wrong.jsp';</script>");
        }
    }
}