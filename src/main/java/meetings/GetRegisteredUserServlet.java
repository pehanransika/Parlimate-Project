package meetings;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/GetRegisteredUserServlet")
public class GetRegisteredUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int meetingId = Integer.parseInt(request.getParameter("meetingId"));
        System.out.println(meetingId);
        // Fetch email list based on meetingId from database (your logic here)
        List<RegisteredUserModel> registeredUsers = JoinMeetingController.getRegisteredUsers(meetingId);

        request.setAttribute("registeredUsers", registeredUsers);
        request.setAttribute("meetingId", meetingId);// Optional: if you want to show it

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/meetingManagement/registeredUsers.jsp");
        dispatcher.forward(request, response);
    }
}
