package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetUserCountServlet")
public class GetUserCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try{
            int userCount = UserController.getCount();
            request.setAttribute("userCount", userCount);
            request.getRequestDispatcher("GetUserCountServlet").forward(request, response);

        }
        catch(Exception e){

        }
    }

}
