package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/CreateNewRequestServlet")
public class CreateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Default user ID to use when no user ID is provided
            int defaultUserId = 2;

            // Retrieve user ID from the form
            String userIdStr = request.getParameter("userid");
            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            // Retrieve form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountStr = request.getParameter("targetamount");
            String currency = request.getParameter("currency");

            // Validate input
            if (title == null || title.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    category == null || category.trim().isEmpty() ||
                    targetAmountStr == null || targetAmountStr.trim().isEmpty() ||
                    currency == null || currency.trim().isEmpty()) {
                throw new IllegalArgumentException("All fields are required.");
            }

            BigDecimal targetAmount;
            try {
                targetAmount = new BigDecimal(targetAmountStr);
                if (targetAmount.compareTo(BigDecimal.ZERO) <= 0) {
                    throw new IllegalArgumentException("Target amount must be greater than zero.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid target amount format.");
            }

            // Call the FundraisingRequestController to create the request
            boolean isCreated = RequestController.createFundraisingRequest(
                    userId, title, description, category, targetAmount, currency);

            if (isCreated) {
                // If successful, redirect with a success message
                String alertMessage = "Request Published Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetAllRequestsServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to create fundraising request.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Handle invalid numeric input
            e.printStackTrace();
            request.setAttribute("error", "Invalid numeric input. Please enter valid numbers.");
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        } catch (IllegalArgumentException e) {
            // Handle invalid input or validation errors
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again.");
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }
}
