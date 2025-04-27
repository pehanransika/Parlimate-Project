package meetings;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/JoinMeetingServlet")
public class JoinMeetingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the request
        String meetingId = request.getParameter("meetingId");
        String userId = request.getParameter("userId");
        String email = request.getParameter("email");

        // For testing purposes
        System.out.println("Received: " + meetingId + ", " + userId + ", " + email);

        // Get the session
        HttpSession session = request.getSession();

        try {
            // Call method to insert into DB (this will depend on your DB connection setup)
            boolean success = JoinMeetingController.addUserToMeeting(meetingId, userId, email);

            if (success) {
                // Set success notification in session
                session.setAttribute("notification", "Successfully registered for the meeting!");
            } else {
                // Set error notification for duplicate registration
                session.setAttribute("notification", "You have already registered for this meeting.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Set error notification for database issues
            session.setAttribute("notification", "An error occurred while processing your request.");
        }

        // Redirect to GetAllMeetingUserServlet
        response.sendRedirect(request.getContextPath() + "/DiscussionRoom/GetAllMeetingUserServlet");
    }
}