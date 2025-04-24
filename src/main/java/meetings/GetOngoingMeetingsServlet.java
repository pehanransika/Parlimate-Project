package meetings;

import UserPackage.PoliticianController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/GetOngoingMeetingsServlet")
public class GetOngoingMeetingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("Fetching today's (ongoing) meetings...");
            List<MeetingModel> ongoingMeetings = MeetingController.getTodaysMeetings();
            PoliticianController politicianController = new PoliticianController();

            // Enhance meeting list with politician names
            List<MeetingModel> enhancedMeetings = ongoingMeetings.stream().map(meeting -> {
                String politicianName = politicianController.getPoliticianNameById(meeting.getPoliticianId());
                meeting.setPoliticianName(politicianName);
                return meeting;
            }).collect(Collectors.toList());

            // Set the enhanced list as a request attribute
            request.setAttribute("ongoingMeetings", enhancedMeetings);

            // Forward to the dedicated JSP
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