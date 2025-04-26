package meetingreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RejectMeetingServlet")
public class RejectMeetingRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("DEBUG: Entering RejectMeetingRequestServlet.doPost");
        try {
            // Extract parameters from the request
            String meetingRequestIdStr = request.getParameter("meetingrequestid");
            String rejectReason = request.getParameter("rejectreason");
            System.out.println("DEBUG: meetingRequestIdStr = " + meetingRequestIdStr);
            System.out.println("DEBUG: rejectReason = " + rejectReason);

            // Validate parameters
            if (meetingRequestIdStr == null || rejectReason == null || meetingRequestIdStr.trim().isEmpty()) {
                System.out.println("DEBUG: Validation failed - missing or empty parameters");
                // Handle missing parameters
                request.setAttribute("errorMessage", "Meeting Request ID and reject reason are required.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Parse meetingrequestid to int
            int meetingRequestId;
            try {
                meetingRequestId = Integer.parseInt(meetingRequestIdStr);
                System.out.println("DEBUG: Parsed meetingRequestId = " + meetingRequestId);
            } catch (NumberFormatException e) {
                System.out.println("DEBUG: NumberFormatException - Invalid meetingRequestId format: " + meetingRequestIdStr);
                // Handle invalid meetingrequestid format
                request.setAttribute("errorMessage", "Invalid Meeting Request ID format.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Call the controller method to reject the meeting request
            System.out.println("DEBUG: Calling MeetingRequestController.rejectMeetingRequest");
            MeetingRequestController.rejectMeetingRequest(meetingRequestId, rejectReason);
            System.out.println("DEBUG: Meeting request rejected successfully");

            // Set success message and redirect to the meeting requests page
            request.getSession().setAttribute("successMessage", "Meeting request rejected successfully.");
            System.out.println("DEBUG: Redirecting to /GetAllMeetingRequestAdminServlet");
            response.sendRedirect(request.getContextPath() + "/GetAllMeetingRequestAdminServlet");

        } catch (Exception e) {
            System.out.println("DEBUG: Exception caught: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for detailed debugging
            // Handle any unexpected errors
            request.setAttribute("errorMessage", "An error occurred while rejecting the meeting request: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
        System.out.println("DEBUG: Exiting RejectMeetingRequestServlet.doPost");
    }
}