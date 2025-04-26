package meetingreq;

import UserPackage.UserModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteNewMeetingRequestServlet")
public class DeleteMeetingRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Declare userId outside try-catch to make it accessible in catch blocks
        int userId = -1; // Default value in case session/user is invalid

        try {
            // Retrieve the request ID from the request parameter
            String meetingrequestIdParam = request.getParameter("meetingrequestid"); // Use requestId to match form
            System.out.println("Received meetingrequestid: " + meetingrequestIdParam);

            // Check session and user
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                System.out.println("DEBUG: No valid session or user found");
                response.sendRedirect("../index.jsp");
                return;
            }

            // Retrieve userId from session
            UserModel user = (UserModel) session.getAttribute("user");
            userId = user.getUserId(); // Assign to userId
            System.out.println("DEBUG: Retrieved userId from session: " + userId);

            // Validate the request ID
            if (meetingrequestIdParam == null || meetingrequestIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Request ID is missing or invalid.");
            }

            // Parse to integer
            int meetingrequestid = Integer.parseInt(meetingrequestIdParam);

            // Attempt deletion
            boolean isDeleted = MeetingRequestController.deleteMeetingRequest(meetingrequestid);

            // Set userId as a request attribute for safety
            request.setAttribute("userId", userId);

            if (isDeleted) {
                // Set success message
                request.setAttribute("message", "Request Deleted Successfully");
            } else {
                // Set failure message
                request.setAttribute("error", "Request not found or already deleted.");
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
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("GetMyMeetingRequests?userId=" + userId);
            dispatcher.forward(request, response);
        }
    }
}