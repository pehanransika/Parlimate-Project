package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.FileStore;
import java.util.List;

@WebServlet("/UpdateNewUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        UserModel user = (UserModel) req.getSession().getAttribute("user");
        req.setAttribute("user", user);
        int userid = user.getUserId();
        String userType = req.getParameter("userType");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean isUserUpdated;
        boolean isTypeUpdated = false;
        isUserUpdated = UserController.updateUser(userid,email, password);

        if (userid > 0){
            if(userType.equals("Citizen")) {

                String name = req.getParameter("email");
                String address = req.getParameter("password");
                String phoneNumber = req.getParameter("userType");
                String profile = req.getParameter("profile");
                String img_url = req.getParameter("img_url");

                isTypeUpdated = CitizenController.updateCitizen(userid,name,address,phoneNumber,profile,img_url);

            }else if(userType.equals("Politician")) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String profileImgUrl = req.getParameter("profile");

                isTypeUpdated = PoliticianController.insertPolitician(userid,name,address,phoneNumber,profileImgUrl);

            }else if(userType.equals("Political Party")) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String logoImg = req.getParameter("logoImg");
                int noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));

                isTypeUpdated = PoliticalPartyController.insertPoliticalParty(userid,name,phoneNumber,address,logoImg,noOfMembers);

            }else{
                //do nothing
            }
        }
        if(isUserUpdated && isTypeUpdated ) {
            String alertMessage = "Updated Successfully";
            resp.getWriter().println("<script>alert('"+alertMessage+"');</script>;window.location.href='login.jsp';</script>");
        }else{
            RequestDispatcher dis2 = req.getRequestDispatcher("update.jsp");
            dis2.forward(req, resp);
        }


    }
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }


}
