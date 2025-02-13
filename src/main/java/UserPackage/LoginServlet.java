package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            // Validate login credentials
            List<UserModel> userlogin = UserController.loginValidate(email, password);

            if (userlogin != null && !userlogin.isEmpty()) {
                UserModel user = userlogin.get(0);

                // Store user in session
                req.getSession().setAttribute("user", user);

                // Determine user profile based on user type and store in session
                String usertype = user.getUserType();
                int userid = user.getUserId();
                Object userProfile = null;
                String redirectUrl = "GetPostListServlet"; // Default redirect

                switch (usertype) {
                    case "Citizen":
                        List<CitizenModel> citizens = CitizenController.CitizenProfile(userid);
                        if (!citizens.isEmpty()) userProfile = citizens.get(0);
                        break;
                    case "Politician":
                        List<PoliticianModel> politicians = PoliticianController.PoliticianProfile(userid);
                        if (!politicians.isEmpty()) userProfile = politicians.get(0);
                        break;
                    case "Political Party":
                        List<PoliticalPartyModel> politicalParties = PoliticalPartyController.PoliticalPartyProfile(userid);
                        if (!politicalParties.isEmpty()) userProfile = politicalParties.get(0);
                        break;
                    case "admin":
                    case "moderator":
                        List<AdminModel> admins = AdminController.AdminProfile(userid);
                        if (!admins.isEmpty()) userProfile = admins.get(0);
                        redirectUrl = "admin/Home/index.jsp";
                        break;
                }

                // Store the user profile in session
                req.getSession().setAttribute("userProfile", userProfile);

                // Redirect to the appropriate page
                resp.sendRedirect(redirectUrl);
            } else {
                // Handle failed login properly
                resp.getWriter().println("<script>alert('Login failed, please try again'); window.location.href='index.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("index.jsp"); // Redirect to login page on error
        }
    }
}
