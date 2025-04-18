package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/PoliticianListServlet")
public class PoliticianListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Servlet reached!");
        try {
            List<PoliticianModel> politicians = PoliticianController.getPoliticianList();

            System.out.println("Politicians found: " + politicians.size());
            request.setAttribute("politicians", politicians);
            System.out.println("Attribute set!");
            RequestDispatcher dis = request.getRequestDispatcher(request.getContextPath() + "/Profile/profile.jsp");
            dis.forward(request, response);

            System.out.println("Servlet called! Politicians count: " + politicians.size());
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}