package meetings;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetAllMeetingUserServlet")
public class GetAllMeetingUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            System.out.println("Trying to get all meetings for user");
            List<MeetingModel> allMeetingsUser = MeetingController.getAllMeetings();

            // Set the list as a request attribute
            request.setAttribute("allMeetingsUser", allMeetingsUser);

            // Forward to meetings.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DiscussionRoom/discussion-room.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to retrieve user meetings. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
