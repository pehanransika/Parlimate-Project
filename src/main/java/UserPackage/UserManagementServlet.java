package UserPackage;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "UserManagementServlet", urlPatterns = "/user-management")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("UserManagementServlet is called!"); // Debugging

        // Fetch all users from the database
        List<UserModel> allUsers = UserController.getAllUsers();

        System.out.println("Users retrieved: " + allUsers.size()); // Debugging

        // Attach users to request object
        request.setAttribute("allUsers", allUsers);

        // Forward to JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/userManagment/userManagment.jsp");
        dispatcher.forward(request, response);
    }
}
