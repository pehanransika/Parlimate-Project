package meetingreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteNewMeetingRequestServlet")
public class DeleteMeetingRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the request ID from the request parameter
            String meetingrequestIdParam = request.getParameter("meetingrequestid"); // Use requestId to match form

            System.out.println("Received requestId: " + meetingrequestIdParam);

            // Validate the request ID
            if (meetingrequestIdParam == null || meetingrequestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing or invalid.");
            }

            // Parse to integer
            int meetingrequestid = Integer.parseInt(meetingrequestIdParam);

            // Attempt deletion
            boolean isDeleted = MeetingRequestController.deleteMeetingRequest(meetingrequestid);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request Deleted Successfully'); window.location.href='GetAllMeetingRequestServlet';</script>");
            } else {
                // If the request is not found
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request not found or already deleted.'); window.location.href='GetAllMeetingRequestServlet';</script>");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Request ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid request ID format.'); window.location.href='GetAllMeetingRequestServlet';</script>");
        } catch (Exception e) {
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again later.'); window.location.href='GetAllRequestsServlet';</script>");
        }
    }
}


