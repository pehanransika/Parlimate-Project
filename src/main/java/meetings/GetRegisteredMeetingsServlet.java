package meetings;

import UserPackage.UserModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

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
        int userId = user.getUserId(); // ✅ Correct way to get the ID
        System.out.println("[DEBUG] Fetched userId from session: " + userId);


        try {
            // Call the correct method in the controller to fetch registered meetings
            MeetingController controller = new MeetingController();
            List<MeetingModel> registeredMeetings = controller.fetchUserRegisteredMeetings(request);
            System.out.println("[DEBUG] Number of registered meetings fetched: " + registeredMeetings.size());

            request.setAttribute("registeredMeetings", registeredMeetings);
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
