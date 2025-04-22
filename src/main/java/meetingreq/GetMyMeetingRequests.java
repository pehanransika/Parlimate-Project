package meetingreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class GetMyMeetingRequests extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Step 1: Get userId from request
            String userIdParam = request.getParameter("userId");
            int userId = Integer.parseInt(userIdParam);

            System.out.println("User ID"+userId);

            // Step 2: Query to get politicianId based on userId directly in the servlet
            String query = "SELECT politician_id FROM politician WHERE user_id = ?";
            int politicianId = -1; // Default value in case of failure

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setInt(1, userId); // Set the userId in the query

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        politicianId = rs.getInt("politician_id");
                        System.out.println("politician id" + politicianId);// Retrieve politicianId from result
                    } else {
                        throw new SQLException("Politician not found for user ID: " + userId);
                    }
                }
            }

            // Step 3: Fetch meeting requests for this politician
            List<MeetingRequestModel> myMeetingRequests = MeetingRequestController.getMyMeetingRequests(politicianId);

            // Step 4: Set the list of meeting requests as a request attribute
            request.setAttribute("myMeetingRequests", myMeetingRequests);

            // Step 5: Forward to JSP to display the data
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DiscussionRoom/meetingrequestDetail.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to retrieve meeting requests. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
