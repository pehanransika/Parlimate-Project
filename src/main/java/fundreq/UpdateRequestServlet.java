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
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve and validate request ID
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Request ID is missing.");
            }
            int requestId = Integer.parseInt(requestIdParam.trim());
            System.out.println("Request ID received: " + requestId);

            // Retrieve other parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountParam = request.getParameter("targetAmount");
            String currency = request.getParameter("currency");
            String contactNo = request.getParameter("contact_no");
            String photos = request.getParameter("photos");
            String attachmentUrl = request.getParameter("attachment_url");
            String status = request.getParameter("status");

            // Validate target amount
            if (targetAmountParam == null || targetAmountParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Target amount is missing.");
            }
            BigDecimal targetAmount = new BigDecimal(targetAmountParam.trim());

            // Current date-time for update
            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller method to update the record
            boolean isUpdated = RequestController.updateFundraisingRequest(
                    requestId, title, description, category, targetAmount, currency,
                    contactNo, photos, datetime, attachmentUrl, status
            );

            if (isUpdated) {
                response.getWriter().println("<script>alert('Request Updated Successfully'); window.history.back();</script>");
            } else {
                request.setAttribute("error", "Failed to update the request.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid number format: " + e.getMessage() + "'); window.history.back();</script>");
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid input: " + e.getMessage() + "'); window.history.back();</script>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request. Please try again later.'); window.location.href='error.jsp';</script>");
        }
    }
}
