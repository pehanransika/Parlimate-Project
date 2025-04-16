package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserDetailsServlet")
public class UserDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");

        if (userIdParam == null || userIdParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"User ID is missing\"}");
            return;
        }


        try {
            int userId = Integer.parseInt(userIdParam);
            UserController userController = new UserController();
            UserModel user = userController.getUserById(userId);

            if (user != null) {
                String additionalDetails = "";

                // Fetch additional details based on user type
                switch (user.getUserType().toLowerCase()) {
                    case "politician":
                        PoliticianController politicianController = new PoliticianController();
                        PoliticianModel politician = politicianController.getUserById(userId);
                        if (politician != null) {
                            additionalDetails = ", \"name\": \"" + politician.getName() + "\", " +
                                    "\"address\": \"" + politician.getAddress() + "\", " +
                                    "\"phoneNumber\": \"" + politician.getPhoneNumber() + "\"";
                        }
                        break;
                    case "citizen":
                        CitizenController citizenController = new CitizenController();
                        CitizenModel citizen = citizenController.getUserById(userId);
                        if (citizen != null) {
                            additionalDetails = ", \"name\": \"" + citizen.getName() + "\", " +
                                    "\"address\": \"" + citizen.getAddress() + "\", " +
                                    "\"phoneNumber\": \"" + citizen.getPhoneNumber() + "\"";
                        }
                        break;
                    case "admin":
                        AdminController adminController = new AdminController();
                        AdminModel admin = adminController.getUserById(userId);
                        if (admin != null) {
                            additionalDetails = ", \"name\": \"" + admin.getFullname() + "\", " +
                                    "\"phoneNumber\": \"" + admin.getPhone_number() + "\"";
                        }
                        break;
                    case "moderator":
                        ModeratorController moderatorController = new ModeratorController();
                        ModeratorModel moderator = moderatorController.getUserById(userId);
                        if (moderator != null) {
                            additionalDetails = ", \"name\": \"" + moderator.getFullname() + "\", " +
                                    "\"phoneNumber\": \"" + moderator.getPhone_number() + "\"";
                        }
                        break;
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Construct JSON response
                String jsonResponse = "{"
                        + "\"userId\":" + user.getUserId() + ","
                        + "\"email\":\"" + user.getEmail() + "\","
                        + "\"userType\":\"" + user.getUserType() + "\","
                        + "\"created_at\":\"" + user.getCreated_at() + "\""
                        + additionalDetails
                        + "}";

                response.getWriter().write(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.setContentType("application/json");
                response.getWriter().write("{\"error\":\"User not found\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Invalid User ID format\"}");
        }
    }
}

