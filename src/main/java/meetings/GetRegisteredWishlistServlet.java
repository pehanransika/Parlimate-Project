package meetings;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetRegisteredWishlistServlet")
public class GetRegisteredWishlistServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int meetingId = Integer.parseInt(request.getParameter("meetingId"));
        System.out.println(meetingId);
        // Fetch email list based on meetingId from database (your logic here)
        List<RegisteredUserModel> registeredWishlistUsers = JoinMeetingController.getregisteredWishlistUsers(meetingId);

        request.setAttribute("registeredWishlistUsers", registeredWishlistUsers);
        request.setAttribute("meetingId", meetingId);// Optional: if you want to show it

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/meetingManagement/registeredWishlistUsers.jsp");
        dispatcher.forward(request, response);
    }
}
