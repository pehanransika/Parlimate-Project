package meetings;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddToWishlistServlet")
public class AddToWishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the request
        String meetingId = request.getParameter("meetingId");
        String userId = request.getParameter("userId");
        String email = request.getParameter("email");

        // For testing purposes
        System.out.println("Received: " + meetingId + ", " + userId + ", " + email);

        // Assuming you have a method to insert data into the meeting_users table
        try {
            // Call method to insert into DB (this will depend on your DB connection setup)
            boolean success = JoinMeetingController.addUserToWishlist(meetingId, userId, email);

            if (success) {
                // If insertion is successful, send a success response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"success\"}");
            } else {
                // If insertion fails due to duplicate key, return a custom error message
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"error\", \"message\":\"You have already registered for this meeting.\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"An error occurred while processing your request.\"}");
        }
    }
}
