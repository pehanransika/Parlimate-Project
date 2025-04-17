package UserPackage;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserDetailUpdateServlet")
public class UserDetailUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        int userId = user.getUserId();
        String userType = user.getUserType();
        String name = request.getParameter("full-name");
        String district = request.getParameter("district");

        boolean isUpdated = false;
        Object userProfile = null;

        try {
            switch (userType.toLowerCase()) {
                case "citizen":
                    isUpdated = CitizenController.updateCitizenUser(userId, name, district);
                    if (isUpdated) {
                        List<CitizenModel> updatedCitizen = CitizenController.CitizenProfile(userId);
                        if (!updatedCitizen.isEmpty()) {
                            userProfile = updatedCitizen.get(0);
                            session.setAttribute("userProfile", userProfile);
                        }
                    }
                    break;
                case "politician":
//                    isUpdated = PoliticianController.updatePolitician(userId,name,)
            }

            if (isUpdated) {
                // Redirect to profile page with success message
                session.setAttribute("updateSuccess", "Profile updated successfully!");
                response.sendRedirect("../Parlimate/Profile/profile.jsp");
            } else {
                // Redirect back with error message
                session.setAttribute("updateError", "Failed to update profile");
                response.sendRedirect("../Parlimate/Profile/profile.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("updateError", "An error occurred: " + e.getMessage());
            response.sendRedirect("../Profile/profile.jsp");
        }
    }
}
