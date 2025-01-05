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
<<<<<<< HEAD
=======
        System.out.println("hii");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
         String password = req.getParameter("Password");

         String userType = req.getParameter("userType");
         int userid ;
         boolean isType = false;
         userid = UserController.insertUser(email, password, userType);
<<<<<<< HEAD
        if (userid == -2) { // Duplicate email
            String alertMessage = "Duplicate email entered. Please use a different email.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.history.back();"); // Redirect back to the previous page
            resp.getWriter().println("</script>");
            return;
        }
=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

        if (userid > 0){
            if(userType.equals("Citizen")) {

             String name = req.getParameter("name");
             String address = req.getParameter("address");
             String phoneNumber = req.getParameter("phoneNumber");
<<<<<<< HEAD
             String profile = req.getParameter("district");
=======
             String profile = req.getParameter("profile");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
             String img_url = req.getParameter("img_url");

              isType = CitizenController.insertCitizen(userid,name,address,phoneNumber,profile,img_url);


           }else if(userType.equals("Politician")) {
             String name = req.getParameter("name");
             String address = req.getParameter("address");
             String phoneNumber = req.getParameter("phoneNumber");
<<<<<<< HEAD
             String profileImgUrl = req.getParameter("img_url");

             isType = PoliticianController.insertPolitician(userid,name,address,phoneNumber,profileImgUrl);

           }else if(userType.equals("Political-Party")) {
             String name = req.getParameter("partyName");
             String address = req.getParameter("partyAddress");
             String phoneNumber = req.getParameter("partyPhoneNumber");
=======
             String profileImgUrl = req.getParameter("profile");

             isType = PoliticianController.insertPolitician(userid,name,address,phoneNumber,profileImgUrl);

           }else if(userType.equals("Political Party")) {
             String name = req.getParameter("name");
             String address = req.getParameter("address");
             String phoneNumber = req.getParameter("phoneNumber");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
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
<<<<<<< HEAD
            resp.getWriter().println("window.location.href='index.jsp';");
=======
            resp.getWriter().println("window.location.href='login.jsp';");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
            resp.getWriter().println("</script>");



        }else{
<<<<<<< HEAD
             RequestDispatcher dis2 = req.getRequestDispatcher("index.jsp");
=======
             RequestDispatcher dis2 = req.getRequestDispatcher("wrong.jsp");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
             dis2.forward(req, resp);
         }
    }
}
