package meetingreq;

import UserPackage.UserModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

@WebServlet("/UpdateNewMeetingRequestServlet")
@MultipartConfig
public class UpdateMeetingRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Declare userId outside try-catch for accessibility in catch blocks
        int userId = -1;

        try {
            // Check session and user
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                System.out.println("DEBUG: No valid session or user found");
                response.sendRedirect("../index.jsp");
                return;
            }

            // Retrieve userId from session
            UserModel user = (UserModel) session.getAttribute("user");
            userId = user.getUserId();
            System.out.println("DEBUG: Retrieved userId from session: " + userId);

            // Retrieve and validate request ID
            String meetingrequestIdParam = request.getParameter("meetingrequestid");
            System.out.println("Request ID received: " + meetingrequestIdParam);

            if (meetingrequestIdParam == null || meetingrequestIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Request ID is missing or invalid.");
            }

            int meetingrequestid = Integer.parseInt(meetingrequestIdParam);

            // Retrieve other form parameters
            String topic = request.getParameter("topic");
            String purposeofmeeting = request.getParameter("purposeofmeeting");
            String opponentname = request.getParameter("opponentname");
            String partyaffiliation = request.getParameter("partyaffiliation");
            String discussionformat = request.getParameter("discussionformat");
            String preferredhost = request.getParameter("preferredhost");
            String proposaldateString = request.getParameter("proposaldate");
            String proposaltimeString = request.getParameter("proposaltime");
            String estimatedduration = request.getParameter("estimatedduration");
            String participantcountStr = request.getParameter("participantcount");

            // Parse participant count
            int participantcount = 0;
            if (participantcountStr != null && !participantcountStr.isEmpty()) {
                try {
                    participantcount = Integer.parseInt(participantcountStr);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Invalid participant count format.");
                }
            }

            // Validate mandatory fields
            if (topic == null || topic.trim().isEmpty() ||
                    purposeofmeeting == null || purposeofmeeting.trim().isEmpty() ||
                    proposaldateString == null || proposaldateString.trim().isEmpty() ||
                    proposaltimeString == null || proposaltimeString.trim().isEmpty()) {
                throw new IllegalArgumentException("Required fields are missing (topic, purpose, date, or time).");
            }

            // Parse date and time
            LocalDate proposaldate;
            LocalTime proposaltime;
            try {
                proposaldate = LocalDate.parse(proposaldateString);
                proposaltime = LocalTime.parse(proposaltimeString);
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException("Invalid date or time format.");
            }

            // Call the controller method to update the meeting request
            boolean isUpdated = MeetingRequestController.updateMeetingRequest(
                    meetingrequestid, topic, purposeofmeeting, opponentname, partyaffiliation,
                    discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration, participantcount);

            // Set userId as a request attribute for safety
            request.setAttribute("userId", userId);

            if (isUpdated) {
                // Set success message
                request.setAttribute("message", "Meeting Request Updated Successfully");
            } else {
                // Set failure message
                request.setAttribute("error", "Failed to update the meeting request.");
            }

            // Forward to GetMyMeetingRequests with userId parameter
            RequestDispatcher dispatcher = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId);
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("Invalid Request ID: " + e.getMessage());
            request.setAttribute("error", "Invalid request ID format.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId);
            dispatcher.forward(request, response);
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid input: " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId);
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.err.println("Error during request update: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId);
            dispatcher.forward(request, response);
        }
    }
}