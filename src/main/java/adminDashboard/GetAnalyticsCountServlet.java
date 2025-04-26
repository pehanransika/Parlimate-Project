package adminDashboard;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import UserPackage.PoliticalPartyController;
import UserPackage.PoliticianController;
import UserPackage.UserController;
import meetings.MeetingController;
import fundreq.ApproveController;
import surveys.surveyController;
import UserPackage.CitizenController;
import post.PostController;

import java.io.IOException;
import java.util.List;

@WebServlet("/GetAnalyticsCountServlet")
public class GetAnalyticsCountServlet extends HttpServlet {
    private UserController userController;
    private MeetingController meetingController;
    private ApproveController fundraiserController;
    private surveyController surveyController;
    private PoliticianController politicianController;
    private PoliticalPartyController politicalPartyController;
    private CitizenController citizenController;
    private PostController postController;

    @Override
    public void init() throws ServletException {
        // Initialize controllers (could use dependency injection in a real app)
//        userController = new UserController();
//        meetingController = new MeetingController();
//        fundraiserController = new ApproveController();
//        //surveyController = new surveyController();
//        politicianController = new PoliticianController();
//        politicalPartyController = new PoliticalPartyController();
//        citizenController = new CitizenController();
//        postController = new PostController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check for valid session (similar to JSP)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "http://localhost:8080/Parlimate");
            return;
        }

        try {
            // Fetch counts from controllers
            int userCount = UserController.getCount();
            int meetingCount = MeetingController.getCount();
            int politicianCount = PoliticianController.getCount();
            int politicalPartyCount = PoliticalPartyController.getCount();
            int citizenCount = CitizenController.getCount();
            int postCount = PostController.getCount();
            List<Integer> userRegistrations = UserController.getUserRegistrationsLast5Days();

            int day1Registrations = userRegistrations.size() > 0 ? userRegistrations.get(0) : 0;
            int day2Registrations = userRegistrations.size() > 1 ? userRegistrations.get(1) : 0;
            int day3Registrations = userRegistrations.size() > 2 ? userRegistrations.get(2) : 0;
            int day4Registrations = userRegistrations.size() > 3 ? userRegistrations.get(3) : 0;
            int day5Registrations = userRegistrations.size() > 4 ? userRegistrations.get(4) : 0;

            //int fundraiserCount = ApproveController.getCount();
            //int surveyCount = surveyController.getCount();

            System.out.println("userRegistrations: " + userRegistrations);
            // Set counts as request attributes
            request.setAttribute("userCount", userCount);
            request.setAttribute("meetingCount", meetingCount);
            request.setAttribute("politicianCount", politicianCount);
            request.setAttribute("citizenCount", citizenCount);
            request.setAttribute("postCount", postCount);
            request.setAttribute("politicalPartyCount", politicalPartyCount);
            request.setAttribute("userRegistrations", userRegistrations);
            request.setAttribute("day1Registrations", day1Registrations);
            request.setAttribute("day2Registrations", day2Registrations);
            request.setAttribute("day3Registrations", day3Registrations);
            request.setAttribute("day4Registrations", day4Registrations);
            request.setAttribute("day5Registrations", day5Registrations);


            //request.setAttribute("activeFundraiserCount", activeFundraiserCount);
            //request.setAttribute("completedSurveyCount", completedSurveyCount);

            // Log for debugging
            System.out.println("Analytics counts fetched: users=" + userCount + ", meetings=" + meetingCount + ", ...");

            // Forward to the dashboard JSP
            request.getRequestDispatcher("/admin/Home/index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Optionally set error attributes or redirect to an error page
            request.setAttribute("errorMessage", "Failed to load analytics data");
            request.getRequestDispatcher("/admin/Home/index.jsp").forward(request, response);
        }
    }
}