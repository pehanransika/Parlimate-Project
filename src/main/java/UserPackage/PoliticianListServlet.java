package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/load-politicians") // Use a unique URL, NOT profile.jsp
public class PoliticianListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<PoliticianModel> politicians = PoliticianController.getPoliticianList();
            System.out.println("Politicians found: " + politicians.size());
            request.setAttribute("politicians", politicians);

            // Forward to the actual JSP
//            request.getRequestDispatcher("/Profile/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}