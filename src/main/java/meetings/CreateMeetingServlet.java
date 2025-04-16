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

        try {
            // Get and parse form values
            String politicianIdStr = request.getParameter("politicianId");
            String slotsStr = request.getParameter("slots");

            if (politicianIdStr == null || politicianIdStr.trim().isEmpty() ||
                    slotsStr == null || slotsStr.trim().isEmpty()) {
                response.getWriter().println("Politician ID and Slots are required.");
                return;
            }

            int politicianId = Integer.parseInt(politicianIdStr.trim());
            int slots = Integer.parseInt(slotsStr.trim());

            // Get and validate other fields
            String topic = request.getParameter("topic");
            String description = request.getParameter("description");

            Date date = Date.valueOf(request.getParameter("date"));

            // Handle time (HTML gives HH:mm, Java needs HH:mm:ss)
            String timeStr = request.getParameter("time");
            if (timeStr != null && timeStr.length() == 5) {
                timeStr += ":00";
            }
            Time time = Time.valueOf(timeStr);

            String typeofthemeeting = request.getParameter("typeofthemeeting");
            String host = request.getParameter("host");
            String platform = request.getParameter("platform");
            Date deadlinetoregister = Date.valueOf(request.getParameter("deadlinetoregister"));


            System.out.println("=== Retrieved Form Values ===");
            System.out.println("Politician ID: " + politicianId);
            System.out.println("Topic: " + topic);
            System.out.println("Description: " + description);
            System.out.println("Date: " + date);
            System.out.println("Time: " + time);
            System.out.println("Type of Meeting: " + typeofthemeeting);
            System.out.println("Host: " + host);
            System.out.println("Platform: " + platform);
            System.out.println("Deadline to Register: " + deadlinetoregister);
            System.out.println("Slots: " + slots);
            System.out.println("==============================");
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
            meeting.setAvailableSlots(slots); // initially same as total slots


            // Insert into database
            MeetingController controller = new MeetingController();
            boolean success = controller.insertMeeting(meeting);

            // Response
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            if (success) {
                response.getWriter().write("Meeting created successfully.");
            } else {
                response.getWriter().write("Failed to create meeting.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}