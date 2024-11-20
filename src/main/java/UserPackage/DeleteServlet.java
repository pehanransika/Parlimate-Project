package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteServlet")

public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          int id = Integer.parseInt(req.getParameter("id"));
          String userType = req.getParameter("userType");
          boolean isUserDelete = false;
          boolean isTypeDelete = false;
          isUserDelete = UserController.deleteUser(id);

        if(userType.equals("Citizen")) {

            isTypeDelete = CitizenController.deleteCitizen(id);

        }else if(userType.equals("Politician")) {

            isTypeDelete = PoliticianController.deletePolitician(id);

        }else if(userType.equals("Political Party")) {

            isTypeDelete = PoliticalPartyController.deletePoliticalParty(id);

        }else {

        }

          if(isUserDelete &&  isTypeDelete){
              String alert = "Account deleted successfully";
              resp.getWriter().println("<script>alert('" + alert + "');"+"window.location.href='login.jsp'</script>");
          }else{
              List<UserModel> userDetails = UserController.UserProfile(id);
              req.setAttribute("userDetails", userDetails);
              RequestDispatcher rd = req.getRequestDispatcher("wrong.jsp");
              rd.forward(req, resp);
          }

    }
}
