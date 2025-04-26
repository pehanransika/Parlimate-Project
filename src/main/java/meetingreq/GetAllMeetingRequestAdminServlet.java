package meetingreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import UserPackage.PoliticianController;

@WebServlet("/GetAllMeetingRequestAdminServlet")
public class GetAllMeetingRequestAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all meeting requests from MeetingRequestController
            System.out.println("This is a debug message");
            List<MeetingRequestModel> allMeetingRequestsAdmin = MeetingRequestController.getAllMeetingRequests();
            int totalCount = allMeetingRequestsAdmin.size();

            // Create a map to store meeting request IDs and corresponding politician names
            Map<Integer, String> politicianNames = new HashMap<>();

            // Fetch politician name for each meeting request
            for (MeetingRequestModel meetingRequest : allMeetingRequestsAdmin) {
                int politicianId = meetingRequest.getPolitician_id();
                String politicianName = PoliticianController.getPoliticianName(politicianId);
                politicianNames.put(meetingRequest.getMeetingrequestid(), politicianName);
            }

            // Set the lists and map as request attributes
            request.setAttribute("allMeetingRequestsAdmin", allMeetingRequestsAdmin);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("politicianNames", politicianNames); // Add politician names map to request

            // Forward to requestsDetail.jsp
            System.out.println("This is a debug message");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/meetingManagement/meetingManagement.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve meeting requests or politician names. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delegate POST requests to GET method
        doGet(request, response);
    }
}