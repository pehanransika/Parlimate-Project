package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/PoliticianDetailsServlet")
public class PoliticianDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("Inside doGet PoliticianDetailsServlet");
            int userId = Integer.parseInt(request.getParameter("userId"));

            PoliticianController politicianController = new PoliticianController();
            PoliticianModel politicianDetails = politicianController.getUserById(userId);

            if (politicianDetails != null) {
                request.setAttribute("politicianDetails", politicianDetails);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/DiscussionRoom/discussion-room.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("error", "Politician not found.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid request.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
