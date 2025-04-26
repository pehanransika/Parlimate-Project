package meetingreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import UserPackage.UserModel;

@WebServlet("/CreateMeetingRequestServlet")
public class CreateMeetingRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("DEBUG: Starting CreateMeetingRequestServlet doPost");

            // Check session and user
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                System.out.println("DEBUG: No valid session or user found");
                response.sendRedirect("../index.jsp");
                return;
            }

            // Retrieve userId from session
            UserModel user = (UserModel) session.getAttribute("user");
            int userId = user.getUserId();
            System.out.println("DEBUG: Retrieved userId from session: " + userId);

            // Retrieve form data
            String politicianIdStr = request.getParameter("politicianid");
            String topic = request.getParameter("topic");
            String purposeofmeeting = request.getParameter("purposeofmeeting");
            String opponentname = request.getParameter("opponentname");
            String partyaffiliation = request.getParameter("partyaffiliation");
            String discussionformat = request.getParameter("discussionformat");
            String preferredhost = request.getParameter("preferredhost");
            String proposaldateString = request.getParameter("proposaldate");
            String proposaltimeString = request.getParameter("proposaltime");
            String estimatedduration = request.getParameter("estimatedduration");
            String participantcountStr = request.getParameter("participantCount");

            // Debug logging of all parameters
            System.out.println("DEBUG: politicianIdStr: " + politicianIdStr);
            System.out.println("DEBUG: topic: " + topic);
            System.out.println("DEBUG: purposeofmeeting: " + purposeofmeeting);
            System.out.println("DEBUG: opponentname: " + opponentname);
            System.out.println("DEBUG: partyaffiliation: " + partyaffiliation);
            System.out.println("DEBUG: discussionformat: " + discussionformat);
            System.out.println("DEBUG: preferredhost: " + preferredhost);
            System.out.println("DEBUG: proposaldateString: " + proposaldateString);
            System.out.println("DEBUG: proposaltimeString: " + proposaltimeString);
            System.out.println("DEBUG: estimatedduration: " + estimatedduration);
            System.out.println("DEBUG: participantcountStr: " + participantcountStr);

            // Validate politicianId
            int politician_id;
            if (politicianIdStr == null || politicianIdStr.trim().isEmpty()) {
                System.out.println("DEBUG: politicianId is null or empty");
                throw new IllegalArgumentException("Politician ID is required");
            }
            try {
                politician_id = Integer.parseInt(politicianIdStr);
                if (politician_id <= 0) {
                    System.out.println("DEBUG: Invalid politicianId: " + politician_id);
                    throw new IllegalArgumentException("Invalid Politician ID");
                }
            } catch (NumberFormatException e) {
                System.out.println("DEBUG: Failed to parse politicianId: " + politicianIdStr);
                throw new IllegalArgumentException("Invalid Politician ID format");
            }

            // Parse participant count
            int participantcount = 0;
            if (participantcountStr != null && !participantcountStr.isEmpty()) {
                try {
                    participantcount = Integer.parseInt(participantcountStr);
                    System.out.println("DEBUG: Parsed participantcount: " + participantcount);
                } catch (NumberFormatException e) {
                    System.out.println("DEBUG: Invalid participant count format: " + participantcountStr);
                    throw new IllegalArgumentException("Invalid participant count format");
                }
            }

            // Validate required fields
            if (topic == null || topic.trim().isEmpty() ||
                    purposeofmeeting == null || purposeofmeeting.trim().isEmpty() ||
                    proposaldateString == null || proposaldateString.trim().isEmpty() ||
                    proposaltimeString == null || proposaltimeString.trim().isEmpty() ||
                    estimatedduration == null || estimatedduration.trim().isEmpty()) {
                System.out.println("DEBUG: Missing required parameters");
                throw new IllegalArgumentException("Missing required parameters: topic, purpose, date, time, or duration");
            }

            // Parse proposalDate and proposalTime
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalDate proposaldate;
            LocalTime proposaltime;
            try {
                proposaldate = LocalDate.parse(proposaldateString, dateFormatter);
                proposaltime = LocalTime.parse(proposaltimeString, timeFormatter);
                System.out.println("DEBUG: Parsed proposaldate: " + proposaldate);
                System.out.println("DEBUG: Parsed proposaltime: " + proposaltime);
            } catch (Exception e) {
                System.out.println("DEBUG: Failed to parse date/time: " + e.getMessage());
                throw new IllegalArgumentException("Invalid date or time format");
            }

            // Call the controller to create the meeting request
            System.out.println("DEBUG: Calling MeetingRequestController.createMeetingRequest");
            boolean isTrue = MeetingRequestController.createMeetingRequest(
                    politician_id, topic, purposeofmeeting, opponentname, partyaffiliation,
                    discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration, participantcount
            );

            if (isTrue) {
                System.out.println("DEBUG: Meeting request created successfully");
                // On success, dispatch to GetMyMeetingRequests with userId parameter
                request.setAttribute("userId", userId); // Optional: Set as attribute for additional safety
                RequestDispatcher dis = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId); // Use userId instead of userid
                dis.forward(request, response);

            } else {
                System.out.println("DEBUG: Failed to create meeting request");
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish request.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
                dis.forward(request, response);
            }

        } catch (NumberFormatException e) {
            System.out.println("DEBUG: NumberFormatException: " + e.getMessage());
            String alertMessage = "Invalid numeric input. Please check your inputs.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        } catch (SQLException e) {
            System.out.println("DEBUG: SQLException: " + e.getMessage());
            String alertMessage = "Database error occurred. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        } catch (IllegalArgumentException e) {
            System.out.println("DEBUG: IllegalArgumentException: " + e.getMessage());
            String alertMessage = e.getMessage();
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        } catch (Exception e) {
            System.out.println("DEBUG: Unexpected error: " + e.getMessage());
            String alertMessage = "An unexpected error occurred. Please try again later.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        }
    }
}