package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
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
              if(usertype.equals("Citizen")) {

                  List<CitizenModel> Citizens = CitizenController.CitizenProfile(userid);
                  req.getSession().setAttribute("citizen", Citizens.get(0));
                  CitizenModel citizen = (CitizenModel)  req.getSession().getAttribute("citizen");
                  req.setAttribute("citizen", citizen);

              }else if(usertype.equals("Politician")) {

                  List<PoliticianModel> Politicians = PoliticianController.PoliticianProfile(userid);
                  req.getSession().setAttribute("politician", Politicians.get(0));
                  PoliticianModel politician = (PoliticianModel)  req.getSession().getAttribute("politician");
                  req.setAttribute("politician", politician);

              }else if(usertype.equals("Political Party")) {

                  List<PoliticalPartyModel> PoliticalPartys = PoliticalPartyController.PoliticalPartyProfile(userid);
                  req.getSession().setAttribute("political party", PoliticalPartys.get(0));
                  PoliticalPartyModel politicalParty = (PoliticalPartyModel)  req.getSession().getAttribute("political party");
                  req.setAttribute("political party", politicalParty);

              }else {

              }
              req.getRequestDispatcher("profile.jsp").forward(req,resp);

          }else{
              //Handle case where user id is not log in
              resp.sendRedirect("login.jsp");
          }
    }
}
