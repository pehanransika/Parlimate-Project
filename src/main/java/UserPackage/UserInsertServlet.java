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
        String password = req.getParameter("Password");
        String userType = req.getParameter("userType");

        // Hash the password
        String hashedPassword = passwordHashing.hashPassword(password);
        if (hashedPassword == null) {
            String alertMessage = "Error while processing the password. Please try again.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
            return;
        }

        int userId;
        boolean isType = false;

        // Insert user into the database
        userId = UserController.insertUser(email, hashedPassword, userType);
        if (userId == -2) { // Duplicate email
            String alertMessage = "Duplicate email entered. Please use a different email.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
            return;
        }

        // Process user type-specific logic
        if (userId > 0) {
            if ("Citizen".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String profile = req.getParameter("district");
                String imgUrl = req.getParameter("img_url");

                isType = CitizenController.insertCitizen(userId, name, address, phoneNumber, profile, imgUrl);
            } else if ("Politician".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String profileImgUrl = req.getParameter("img_url");

                isType = PoliticianController.insertPolitician(userId, name, address, phoneNumber, profileImgUrl);
            } else if ("Political-Party".equals(userType)) {
                String name = req.getParameter("partyName");
                String address = req.getParameter("partyAddress");
                String phoneNumber = req.getParameter("partyPhoneNumber");
                String logoImg = req.getParameter("logoImg");
                int noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));

                isType = PoliticalPartyController.insertPoliticalParty(userId, name, phoneNumber, address, logoImg, noOfMembers);
            }
        }

        // Handle success or failure
        if (isType) {
            String alertMessage = "Registered Successfully";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
        } else {
            RequestDispatcher dis2 = req.getRequestDispatcher("index.jsp");
            dis2.forward(req, resp);
        }
    }
}
