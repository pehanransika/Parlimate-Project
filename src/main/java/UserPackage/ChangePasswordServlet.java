package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ChangePasswordServlet: Received POST request to /Profile/ChangePasswordServlet");

        try {
            String userIdStr = request.getParameter("userId");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");

            System.out.println("Parameters - userId: " + userIdStr + ", currentPassword: [hidden], newPassword: [hidden]");

            int userId = Integer.parseInt(userIdStr);
            System.out.println("Processing request for userId: " + userId);
            boolean passwordChanged = UserController.changePassword(userId, currentPassword, newPassword);

            if (passwordChanged) {
                System.out.println("Password changed successfully, setting successMessage and redirecting to /Profile/profile.jsp");
                request.getSession().setAttribute("successMessage", "Password updated successfully.");
                response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
            } else {
                System.out.println("Password change failed, setting errorMessage and forwarding to /Profile/profile.jsp");
                request.setAttribute("errorMessage", "Current password is incorrect or user not found.");
                request.getRequestDispatcher("/Profile/profile.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.err.println("NumberFormatException: " + e.getMessage());
            System.out.println("Setting errorMessage and forwarding to /Profile/profile.jsp");
            request.setAttribute("errorMessage", "Invalid user ID format.");
            request.getRequestDispatcher("/Profile/profile.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("SQLException: " + e.getMessage());
            System.out.println("Setting errorMessage and forwarding to /Profile/profile.jsp");
            request.setAttribute("errorMessage", "An error occurred while updating the password: " + e.getMessage());
            request.getRequestDispatcher("/Profile/profile.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            System.out.println("Setting errorMessage and forwarding to /Profile/profile.jsp");
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/Profile/profile.jsp").forward(request, response);
        }
    }
}