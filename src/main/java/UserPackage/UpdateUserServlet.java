package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateNewUserServlet")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the current session
        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Redirect to login page if session user is null
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Fetch user data
        req.setAttribute("user", user);
        int userId = user.getUserId();
        String userType = req.getParameter("userType");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Update user in the main 'users' table
        boolean isUserUpdated = UserController.updateUser(userId, email, password);
        boolean isTypeUpdated = false;

        // Update details based on user type
        if (userId > 0) {
            switch (userType) {
                case "Citizen": {
                    String name = req.getParameter("name");
                    String address = req.getParameter("address");
                    String phoneNumber = req.getParameter("phoneNumber");
                    String district = req.getParameter("district");


                    isTypeUpdated = CitizenController.updateCitizen(userId, name, address, phoneNumber, district);
                    break;
                }
                case "Politician": {
                    String name = req.getParameter("name");
                    String address = req.getParameter("address");
                    String phoneNumber = req.getParameter("phoneNumber");


                    isTypeUpdated = PoliticianController.updatePolitician(userId, name, address, phoneNumber);
                    break;
                }
                case "Political Party": {
                    String name = req.getParameter("name");
                    String address = req.getParameter("address");
                    String phoneNumber = req.getParameter("phoneNumber");
                    String logoImg = req.getParameter("logoImg");

                    int noOfMembers = 0;
                    try {
                        noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid number of members. Defaulting to 0.");
                    }

                    isTypeUpdated = PoliticalPartyController.updatePoliticalParty(userId, name, phoneNumber, address, logoImg, noOfMembers);
                    break;
                }
                default:
                    System.err.println("Unknown user type: " + userType);
            }
        }

        // Check update status and respond
        if (isUserUpdated && isTypeUpdated) {
            resp.getWriter().println("<script>alert('Updated Successfully'); window.location.href='login.jsp';</script>");
        } else {
            req.setAttribute("errorMessage", "Failed to update user information. Please try again.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("updateprofile.jsp");
            dispatcher.forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Redirect to the update page
        resp.sendRedirect("updateprofile.jsp");
    }
}