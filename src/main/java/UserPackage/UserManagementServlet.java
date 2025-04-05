package UserPackage;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserManagementServlet")

public class UserManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all users from the database
        List<UserModel> getallUsers = UserController.getAllUsers();

        // Debugging: Print users before setting the attribute
        System.out.println("Retrieved Users: " + getallUsers);

        // Attach users to request object
        request.setAttribute("getallUsers", getallUsers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/userManagement/userManagement.jsp");
        dispatcher.forward(request, response);

    }
}

