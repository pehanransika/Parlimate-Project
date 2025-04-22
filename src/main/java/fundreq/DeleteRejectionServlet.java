package fundreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteRejectionServlet")
public class DeleteRejectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the request ID from the request parameter
            String rejectionIdParam = request.getParameter("rejectionId"); // Use requestId to match form

            System.out.println("Received rejectionId: " + rejectionIdParam);

            // Validate the request ID
            if (rejectionIdParam == null || rejectionIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Rejection ID is missing or invalid.");
            }

            // Parse to integer
            int rejectionId = Integer.parseInt(rejectionIdParam);

            // Attempt deletion
            boolean isDeleted =RejectedRequestController.deleteRejectedRequest(rejectionId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Rejection Deleted Successfully'); window.location.reload();</script>");

            } else {
                // If the request is not found
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Rejection not found or already deleted.'); window.location.href='error.jsp';</script>");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Rejection ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid rejection ID format.'); window.location.href='error.jsp';</script>");
        } catch (Exception e) {
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again later.'); window.location.href='error.jsp';</script>");
        }
    }
}
