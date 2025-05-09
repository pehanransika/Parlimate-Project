package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/UpdateNewRequestServlet")
@MultipartConfig
public class UpdateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and validate request ID
            String requestIdParam = request.getParameter("requestId");
            System.out.println("Request ID received: " + requestIdParam);

            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing.");
            }

            int requestId = Integer.parseInt(requestIdParam);

            // Other parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountParam = request.getParameter("targetAmount");
            String currency = request.getParameter("currency");
            String contact_no=request.getParameter("contact_no");
            String photos=request.getParameter("photos");
            String attachment_url = request.getParameter("attachment_url");  // Fixed parameter name
            String status=request.getParameter("status");

            // Validate target amount
            if (targetAmountParam == null || targetAmountParam.trim().isEmpty()) {
                throw new NumberFormatException("Target amount is missing.");
            }
            BigDecimal targetAmount = new BigDecimal(targetAmountParam);

            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller method
            boolean isUpdated = RequestController.updateFundraisingRequest(
                    requestId, title, description, category, targetAmount, currency,contact_no,photos, datetime, attachment_url,status);

            if (isUpdated) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request Updated Successfully'); window.history.back();</script>");
            } else {
                request.setAttribute("error", "Failed to update the request.");
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid input: " + e.getMessage() + "'); window.history.back();</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Error processing request. Please try again later.'); window.location.href='error.jsp';</script>");
        }
    }
}
