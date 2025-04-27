package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UserNewInsertServlet")
public class UserInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("Password");
        String userType = req.getParameter("userType");
        String enteredOtp = req.getParameter("otp");

        HttpSession session = req.getSession();
        Object generatedOtpObj = session.getAttribute("otp");

        // ✅ First check OTP
        if (generatedOtpObj == null || !enteredOtp.equals(generatedOtpObj.toString())) {
            String alertMessage = "Invalid or expired OTP. Please try again.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("history.back();"); // 👈 Go back without refreshing the page
            resp.getWriter().println("</script>");
            return;
        }

        // ✅ If OTP is correct, continue registration
        String hashedPassword = passwordHashing.hashPassword(password);
        if (hashedPassword == null) {
            String alertMessage = "Error while processing the password. Please try again.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("history.back();"); // 👈 Go back without refreshing the page
            resp.getWriter().println("</script>");

            return;
        }

        int userId;
        boolean isType = false;

        userId = UserController.insertUser(email, hashedPassword, userType);
        if (userId == -2) { // Duplicate email
            String alertMessage = "Duplicate email entered. Please use a different email.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("history.back();"); // 👈 Go back without refreshing the page
            resp.getWriter().println("</script>");

            return;
        }

        if (userId > 0) {
            if ("Citizen".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String district = req.getParameter("district");

                isType = CitizenController.insertCitizen(userId, name, address, phoneNumber, district);

            } else if ("Politician".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");

                isType = PoliticianController.insertPolitician(userId, name, address, phoneNumber);

            } else if ("Political-Party".equals(userType)) {
                String name = req.getParameter("partyName");
                String address = req.getParameter("partyAddress");
                String phoneNumber = req.getParameter("partyPhoneNumber");
                String logoImg = req.getParameter("logoImg");
                int noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));

                isType = PoliticalPartyController.insertPoliticalParty(userId, name, phoneNumber, address, logoImg, noOfMembers);
            }
        }

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
