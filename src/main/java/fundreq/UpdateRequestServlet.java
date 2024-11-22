package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/UpdateRequestServlet")
public class UpdateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the form
            String requestIdParam = request.getParameter("requestid");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountParam = request.getParameter("targetamount");
            String currency = request.getParameter("currency");

            // Validate numeric inputs
            if (requestIdParam == null || requestIdParam.trim().isEmpty() ||
                    targetAmountParam == null || targetAmountParam.trim().isEmpty()) {
                throw new NumberFormatException("Missing or invalid numeric inputs.");
            }

            int requestId = Integer.parseInt(requestIdParam);
            double targetAmount = Double.parseDouble(targetAmountParam);

            // Set the current timestamp
            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller to update the fundraising request
            boolean isUpdated = RequestController.updateFundraisingRequest(
                    requestId, title, description, category, BigDecimal.valueOf(targetAmount), currency, datetime);

            if (isUpdated) {
                // If successful, retrieve the updated list of requests
                List<RequestModel> requests = RequestController.getAllFundraisingRequests();
                request.setAttribute("requests", requests);

                // Show alert and redirect to GetAllRequestsServlet
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request Updated Successfully'); window.location.href='GetAllRequestsServlet';</script>");
            } else {
                // If update fails, forward to the error page
                request.setAttribute("error", "Failed to update the request.");
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Handle invalid numeric inputs
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid input format. Please check the data entered.'); window.location.href='wrong.jsp';</script>");
        } catch (Exception e) {
            // Handle any other exceptions
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Error processing request. Please try again later.'); window.location.href='wrong.jsp';</script>");
        }
    }
}

