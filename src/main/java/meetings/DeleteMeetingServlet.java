package meetings;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteMeetingServlet")
public class DeleteMeetingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int meetingId = Integer.parseInt(request.getParameter("meetingId"));
            MeetingController controller = new MeetingController();
            controller.deleteMeeting(meetingId);

            // Redirect or forward to a confirmation or list page
            response.sendRedirect("/GetAllMeetingServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

