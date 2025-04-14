package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/profileNewServlet")
public class profileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the user, citizen, and politician data from the session
        UserModel user = (UserModel) req.getSession().getAttribute("user");
        CitizenModel citizen = (CitizenModel) req.getSession().getAttribute("citizen");
        PoliticianModel politician = (PoliticianModel) req.getSession().getAttribute("politician");

        // If none of the session attributes are set, redirect to login page
        if (user == null && citizen == null && politician == null) {
            resp.sendRedirect("index.jsp");
            return;
        }

        // Set session attributes if available (don't overwrite if already set)
        if (user != null) {
            req.getSession().setAttribute("user", user);
        }
        if (citizen != null) {
            req.getSession().setAttribute("citizen", citizen);
        }

        // Politician profile: If a politician is found in the session, retrieve their profile


        if (politician != null) {
            req.getSession().setAttribute("politician",politician);
        }



        // Forward to the profile.jsp page
        req.getRequestDispatcher("Profile/profile.jsp").forward(req, resp);
    }
}
