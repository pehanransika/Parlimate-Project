package meetingreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        try {
            // Retrieve and validate request ID
            String meetingrequestIdParam = request.getParameter("meetingrequestid");
            System.out.println("Request ID received: " + meetingrequestIdParam);

            if (meetingrequestIdParam == null || meetingrequestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing.");
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

            int participantcount = 0;
            if (participantcountStr != null && !participantcountStr.isEmpty()) {
                try {
                    participantcount = Integer.parseInt(participantcountStr);
                } catch (NumberFormatException e) {
                    // handle invalid input if needed
                    e.printStackTrace();
                }
            }

            // Validate mandatory fields
            if (topic == null || topic.trim().isEmpty() ||
                    purposeofmeeting == null || purposeofmeeting.trim().isEmpty() ||
                    proposaldateString == null || proposaldateString.trim().isEmpty() ||
                    proposaltimeString == null || proposaltimeString.trim().isEmpty()) {
                throw new IllegalArgumentException("Required fields are missing.");
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
                    discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration ,participantcount);

            if (isUpdated) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Meeting Request Updated Successfully'); window.location.href='GetAllMeetingRequestServlet';</script>");
            } else {
                request.setAttribute("error", "Failed to update the meeting request.");
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
