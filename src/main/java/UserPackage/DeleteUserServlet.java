package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteNewUserServlet")
public class  DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        String userType = req.getParameter("userType");

        if (idParam == null || userType == null || idParam.isEmpty() || userType.isEmpty()) {
            req.setAttribute("errorMessage", "User ID or User Type is missing.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid User ID format.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        // Attempt to delete the user and their specific type information
        boolean isUserDeleted = UserController.deleteUser(id);
        boolean isTypeDeleted = false;

        switch (userType) {
            case "Citizen":
                isTypeDeleted = CitizenController.deleteCitizen(id);
                break;
            case "Politician":
                isTypeDeleted = PoliticianController.deletePolitician(id);
                break;
            case "Political Party":
                isTypeDeleted = PoliticalPartyController.deletePoliticalParty(id);
                break;
            default:
                req.setAttribute("errorMessage", "Invalid User Type provided.");
                req.getRequestDispatcher("error.jsp").forward(req, resp);
                return;
        }

        // Check the status of both deletion operations
        if (isUserDeleted && isTypeDeleted) {
            req.setAttribute("successMessage", "Account deleted successfully.");
            req.getRequestDispatcher("success.jsp").forward(req, resp);
        } else {
            // Log detailed information for debugging
            if (!isUserDeleted) {
                System.err.println("Failed to delete user with ID: " + id);
            }
            if (!isTypeDeleted) {
                System.err.println("Failed to delete user type information for ID: " + id + ", User Type: " + userType);
            }

            req.setAttribute("errorMessage", "Failed to delete user or associated details.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
