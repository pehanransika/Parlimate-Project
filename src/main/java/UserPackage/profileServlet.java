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

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         processRequest(req,resp);
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req,resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          UserModel user = (UserModel) req.getSession().getAttribute("user");
          if(user != null) {
              //forward user data to profile
              req.setAttribute("user", user);
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

// Store the user profile in session and request under a single attribute
              req.getSession().setAttribute("userinfo", userProfile);
              req.setAttribute("userinfo", userProfile);

              req.getRequestDispatcher("Home.jsp").forward(req,resp);


          }else{
              //Handle case where user id is not log in
              resp.sendRedirect("index.jsp");
          }
    }
}
