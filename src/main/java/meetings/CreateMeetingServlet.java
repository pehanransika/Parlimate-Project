package meetings;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/CreateMeetingServlet")
public class CreateMeetingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("DEBUG: Entering CreateMeetingServlet doPost");

        try {
            // Log all received parameters
            System.out.println("DEBUG: Received Parameters:");
            request.getParameterMap().forEach((key, value) ->
                    System.out.println("  " + key + ": " + String.join(",", value))
            );

            // Get and parse form values
            String meetingRequestIdStr = request.getParameter("meetingrequestid");
            String politicianIdStr = request.getParameter("politicianId");
            String slotsStr = request.getParameter("slots");
            System.out.println("DEBUG: meetingRequestIdStr: " + meetingRequestIdStr);
            System.out.println("DEBUG: politicianIdStr: " + politicianIdStr);
            System.out.println("DEBUG: slotsStr: " + slotsStr);

            if (meetingRequestIdStr == null || meetingRequestIdStr.trim().isEmpty() ||
                    politicianIdStr == null || politicianIdStr.trim().isEmpty() ||
                    slotsStr == null || slotsStr.trim().isEmpty()) {
                System.out.println("DEBUG: Validation failed - Missing required fields");
                response.getWriter().println("Meeting Request ID, Politician ID, and Slots are required.");
                return;
            }

            int meetingRequestId = Integer.parseInt(meetingRequestIdStr.trim());
            int politicianId = Integer.parseInt(politicianIdStr.trim());
            int slots = Integer.parseInt(slotsStr.trim());
            System.out.println("DEBUG: Parsed IDs - meetingRequestId: " + meetingRequestId + ", politicianId: " + politicianId + ", slots: " + slots);

            // Get and validate other fields
            String topic = request.getParameter("topic");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String typeofthemeeting = request.getParameter("typeofthemeeting");
            String host = request.getParameter("host");
            String platform = request.getParameter("platform");
            String deadlineStr = request.getParameter("deadlinetoregister");

            System.out.println("DEBUG: Other Parameters:");
            System.out.println("  topic: " + topic);
            System.out.println("  description: " + description);
            System.out.println("  date: " + dateStr);
            System.out.println("  time: " + timeStr);
            System.out.println("  typeofthemeeting: " + typeofthemeeting);
            System.out.println("  host: " + host);
            System.out.println("  platform: " + platform);
            System.out.println("  deadlinetoregister: " + deadlineStr);

            // Validate non-null fields
            if (topic == null || description == null || dateStr == null || timeStr == null ||
                    typeofthemeeting == null || host == null || platform == null || deadlineStr == null) {
                System.out.println("DEBUG: Validation failed - One or more fields are null");
                response.getWriter().println("All fields are required.");
                return;
            }

            Date date = Date.valueOf(dateStr);

            // Handle time (HTML gives HH:mm, Java needs HH:mm:ss)
            if (timeStr.length() == 5) {
                timeStr += ":00";
            }
            Time time = Time.valueOf(timeStr);
            Date deadlinetoregister = Date.valueOf(deadlineStr);

            System.out.println("DEBUG: Parsed Dates and Time:");
            System.out.println("  date: " + date);
            System.out.println("  time: " + time);
            System.out.println("  deadlinetoregister: " + deadlinetoregister);

            // Create MeetingModel object
            MeetingModel meeting = new MeetingModel();
            meeting.setPoliticianId(politicianId);
            meeting.setTopic(topic);
            meeting.setDescription(description);
            meeting.setDate(date);
            meeting.setTime(time);
            meeting.setTypeofthemeeting(typeofthemeeting);
            meeting.setHost(host);
            meeting.setPlatform(platform);
            meeting.setDeadlinetoregister(deadlinetoregister);
            meeting.setSlots(slots);
            meeting.setAvailableSlots(slots);

            System.out.println("DEBUG: MeetingModel created successfully");

            // Call MeetingController
            System.out.println("DEBUG: Instantiating MeetingController");
            MeetingController controller = new MeetingController();
            System.out.println("DEBUG: Calling insertMeeting");
            boolean success = controller.insertMeeting(meeting, meetingRequestId);
            System.out.println("DEBUG: insertMeeting returned: " + success);

            // Response
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            if (success) {
                String contextPath = request.getContextPath();
                System.out.println("DEBUG: Redirecting to: " + contextPath + "/GetAllMeetingServlet");
                response.sendRedirect(contextPath + "/GetAllMeetingServlet");
            } else {
                System.out.println("DEBUG: Failed to create meeting");
                response.getWriter().write("Failed to create meeting.");
            }

        } catch (NumberFormatException e) {
            System.out.println("DEBUG: NumberFormatException occurred: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("Error: Invalid number format in input.");
        } catch (IllegalArgumentException e) {
            System.out.println("DEBUG: IllegalArgumentException occurred: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("Error: Invalid date or time format.");
        } catch (Exception e) {
            System.out.println("DEBUG: Unexpected error occurred: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}