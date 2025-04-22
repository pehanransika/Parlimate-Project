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

@WebServlet("/CreateNewMeetingRequestServlet")
public class CreateMeetingRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            int defaultPoliticianId = 1;
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
            System.out.println(estimatedduration);
            String participantcountStr = request.getParameter("participantCount");

            int participantcount = 0;
            if (participantcountStr != null && !participantcountStr.isEmpty()) {
                try {
                    participantcount = Integer.parseInt(participantcountStr);
                } catch (NumberFormatException e) {
                    // handle invalid input if needed
                    e.printStackTrace();
                }
            }

            int politician_id= (politicianIdStr != null && !politicianIdStr.isEmpty())
                    ? Integer.parseInt(politicianIdStr)
                    : defaultPoliticianId;
            // Validate required fields
            if (topic == null || purposeofmeeting == null || opponentname == null || partyaffiliation == null ||
                    proposaldateString == null || proposaltimeString == null || estimatedduration == null) {
                throw new IllegalArgumentException("Missing required parameters.");
            }

            // Parse proposalDate and proposalTime
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalDate proposaldate = LocalDate.parse(proposaldateString, dateFormatter);
            LocalTime proposaltime = LocalTime.parse(proposaltimeString, timeFormatter);

            // Call the controller to create the meeting request
            boolean isTrue = MeetingRequestController.createMeetingRequest(
                    politician_id, topic, purposeofmeeting, opponentname, partyaffiliation,
                    discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration,participantcount
            );

            if (isTrue) {
                // If successful, show alert and redirect to GetAllMeetingRequestServlet
                String alertMessage = "Request Published Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllMeetingRequestServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish request.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
                dis.forward(request, response);
            }

        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        } catch (IllegalArgumentException e) {
            // Catch missing parameter exceptions
            String alertMessage = e.getMessage();
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        } catch (Exception e) {
            // Catch unexpected errors
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            RequestDispatcher dis = request.getRequestDispatcher("error.jsp");
            dis.forward(request, response);
        }
    }
}
