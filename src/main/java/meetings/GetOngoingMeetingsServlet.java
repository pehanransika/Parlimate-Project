package meetings;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetOngoingMeetingsServlet")
public class GetOngoingMeetingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("Fetching today's (ongoing) meetings...");
            List<MeetingModel> ongoingMeetings = MeetingController.getTodaysMeetings();

            request.setAttribute("ongoingMeetings", ongoingMeetings);

            // You can either forward to a dedicated JSP, or reuse the existing one
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DiscussionRoom/discussion-room-ongoing.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not fetch ongoing meetings.");
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
