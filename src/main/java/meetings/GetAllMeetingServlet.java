package meetings;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetAllMeetingServlet")
public class GetAllMeetingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all meetings from MeetingController
            System.out.println("Trying to get all meetings");

            List<MeetingModel> allMeetings = MeetingController.getAllMeetings();
            int totalCount = allMeetings.size();

            // Set the list as a request attribute
            request.setAttribute("allMeetings", allMeetings);
            request.setAttribute("totalCount", totalCount);

            // Forward to meetings.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/meetingManagement/scheduledMeeting.jsp");
            System.out.println(dispatcher);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve meetings. Please try again later.");
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
