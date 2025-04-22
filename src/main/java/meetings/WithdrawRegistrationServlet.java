package meetings;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/WithdrawRegistrationServlet")
public class WithdrawRegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters from the POST request
        String meetingId = request.getParameter("meetingId");
        String userId = request.getParameter("userId");

        // Validate input
        if (meetingId == null || userId == null || meetingId.isEmpty() || userId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            // Call controller method to handle withdrawal
            boolean success = JoinMeetingController.withdrawRegistration(meetingId, userId);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Withdrawal successful");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to withdraw registration");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error occurred");
        }
    }
}
