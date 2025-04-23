package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteUserFromUMServlet")
public class DeleteUserFromUMServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("userId");
        int convertedId = Integer.parseInt(idParam);

        System.out.println(convertedId);
        boolean isDeleted = UserController.deleteUser(convertedId);
        System.out.println(isDeleted);

        if(isDeleted) {
            System.out.println("Deleted User from UM");
            response.getWriter().write("Success");
        } else {
            response.getWriter().write("Error");
        }

    }
}
