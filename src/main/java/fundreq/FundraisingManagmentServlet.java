package fundreq;

import UserPackage.UserController;
import UserPackage.UserModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/FundraisingManagmentServlet")

public class FundraisingManagmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all users from the database
        List<UserModel> allFunraises = UserController.getAllUsers();

        // Debugging: Print users before setting the attribute
        System.out.println("Retrieved Users: " + allFunraises);

        // Attach users to request object
        request.setAttribute("allFunraises", allFunraises);
        RequestDispatcher dispatcher = request.getRequestDispatcher("fundraisingManagement.jsp");
        dispatcher.forward(request, response);

    }
}

