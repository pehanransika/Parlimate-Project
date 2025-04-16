package fundreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RestoreApprovedFundraisingRequestServlet")
public class RestoreApprovedFundraisingRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the request ID from the request parameter
            String requestIdParam = request.getParameter("requestId"); // Use requestId to match form

            System.out.println("Received requestId: " + requestIdParam);

            // Validate the request ID
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing or invalid.");
            }

            // Parse to integer
            int requestId = Integer.parseInt(requestIdParam);

            // Attempt deletion
            boolean isAdded = ApproveController.restorerequest(requestId);

            if (isAdded) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request Restore Successfully'); window.history.back();</script>");
            } else {
                // If the request is not found
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request not found or already deleted.'); window.location.href='error.jsp';</script>");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Request ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid request ID format.'); window.location.href='error.jsp';</script>");
        } catch (Exception e) {
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again later.'); window.location.href='error.jsp';</script>");
        }
    }
}
