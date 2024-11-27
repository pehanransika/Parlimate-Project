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

                if (usertype.equals("Citizen")) {
                    List<CitizenModel> citizens = CitizenController.CitizenProfile(userid);
                    userProfile = citizens.get(0);
                } else if (usertype.equals("Politician")) {
                    List<PoliticianModel> politicians = PoliticianController.PoliticianProfile(userid);
                    userProfile = politicians.get(0);
                } else if (usertype.equals("Political Party")) {
                    List<PoliticalPartyModel> politicalParties = PoliticalPartyController.PoliticalPartyProfile(userid);
                    userProfile = politicalParties.get(0);
                }

                // Store the user profile in session
                req.getSession().setAttribute("userProfile", userProfile);

                // Redirect to Home.jsp
                resp.sendRedirect("Home.jsp");

            } else {
                // Handle failed login
                String alertMessage = "Login failed, please try again";
                resp.getWriter().println("<script>alert('" + alertMessage + "');window.location.href='index.jsp'</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
