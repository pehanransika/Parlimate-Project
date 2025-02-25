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
        List<UserModel> allUsers = UserController.getAllUsers();

        // Debugging: Print users before setting the attribute
        System.out.println("Retrieved Users: " + allUsers);

        // Attach users to request object
        request.setAttribute("allUsers", allUsers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/userManagment/userManagment.jsp");
        dispatcher.forward(request, response);

    }
}

