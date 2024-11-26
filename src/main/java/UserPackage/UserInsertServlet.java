package UserPackage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/UserNewInsertServlet")

public class UserInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

         String email = req.getParameter("email");
        System.out.println("hii");
         String password = req.getParameter("Password");

         String userType = req.getParameter("userType");
         int userid ;
         boolean isType = false;
         userid = UserController.insertUser(email, password, userType);

        if (userid > 0){
            if(userType.equals("Citizen")) {

             String name = req.getParameter("name");
             String address = req.getParameter("address");
             String phoneNumber = req.getParameter("phoneNumber");
             String profile = req.getParameter("district");
             String img_url = req.getParameter("img_url");

              isType = CitizenController.insertCitizen(userid,name,address,phoneNumber,profile,img_url);


           }else if(userType.equals("Politician")) {
             String name = req.getParameter("name");
             String address = req.getParameter("address");
             String phoneNumber = req.getParameter("phoneNumber");
             String profileImgUrl = req.getParameter("img_url");

             isType = PoliticianController.insertPolitician(userid,name,address,phoneNumber,profileImgUrl);

           }else if(userType.equals("Political-Party")) {
             String name = req.getParameter("partyName");
             String address = req.getParameter("partyAddress");
             String phoneNumber = req.getParameter("partyPhoneNumber");
             String logoImg = req.getParameter("logoImg");
             int noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));

             isType = PoliticalPartyController.insertPoliticalParty(userid,name,phoneNumber,address,logoImg,noOfMembers);

           }else{
             //do nothing
           }
        }

        if(isType  ) {
            String alertMessage = "Registered Successfully";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='Home.jsp';");
            resp.getWriter().println("</script>");



        }else{
             RequestDispatcher dis2 = req.getRequestDispatcher("index.jsp");
             dis2.forward(req, resp);
         }
    }
}
