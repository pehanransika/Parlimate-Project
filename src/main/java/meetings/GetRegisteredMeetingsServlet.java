package meetings;

import UserPackage.UserModel;
import UserPackage.PoliticianController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/GetRegisteredMeetingsServlet")
public class GetRegisteredMeetingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("No session or user found");
            response.sendRedirect("login.jsp");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("user");
        int userId = user.getUserId();
        System.out.println("[DEBUG] Fetched userId from session: " + userId);

        try {
            // Fetch registered meetings
            MeetingController controller = new MeetingController();
            List<MeetingModel> registeredMeetings = controller.fetchUserRegisteredMeetings(request);
            System.out.println("[DEBUG] Number of registered meetings fetched: " + registeredMeetings.size());

            PoliticianController politicianController = new PoliticianController();

            // Enhance meeting list with politician names
            List<MeetingModel> enhancedMeetings = registeredMeetings.stream().map(meeting -> {
                String politicianName = politicianController.getPoliticianNameById(meeting.getPoliticianId());
                meeting.setPoliticianName(politicianName);
                return meeting;
            }).collect(Collectors.toList());

            // Set the enhanced list as a request attribute
            request.setAttribute("registeredMeetings", enhancedMeetings);

            // Forward to the dedicated JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DiscussionRoom/discussion-room-registered.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not fetch registered meetings.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}