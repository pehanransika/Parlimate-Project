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
            // Retrieve politician ID from session
            HttpSession session = request.getSession();
            Integer politician_id = (Integer) session.getAttribute("politician_id");

            // Set a default value for politician ID if not found in session
            if (politician_id == null) {
                politician_id = 1; // Default ID if no session-based politician ID is found
            }

            // Retrieve form data
            String topic = request.getParameter("topic");
            String purposeofmeeting = request.getParameter("purposeofmeeting");
            String opponentname = request.getParameter("opponentname");
            String partyaffiliation = request.getParameter("partyaffiliation");
            String discussionformat = request.getParameter("discussionformat");
            String preferredhost = request.getParameter("preferredhost");
            String proposaldateString = request.getParameter("proposaldate");
            String proposaltimeString = request.getParameter("proposaltime");
            String estimatedduration = request.getParameter("estimatedduration");

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
                    discussionformat, preferredhost, proposaldate, proposaltime, estimatedduration
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
