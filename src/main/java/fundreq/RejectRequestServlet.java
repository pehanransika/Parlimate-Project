package fundreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

@WebServlet("/RejectRequestServlet")
public class RejectRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Get and validate requestId
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                out.println("<script>alert('Request ID cannot be empty!'); "
                        + "window.history.back();</script>");
                return;
            }

            int requestId;
            try {
                requestId = Integer.parseInt(requestIdParam);
            } catch (NumberFormatException e) {
                out.println("<script>alert('Invalid Request ID format!'); "
                        + "window.history.back();</script>");
                return;
            }

            // Get and validate reason
            String reason = request.getParameter("reason");
            if (reason == null || reason.trim().isEmpty()) {
                out.println("<script>alert('Rejection reason cannot be empty!'); "
                        + "window.history.back();</script>");
                return;
            }

            // Validate minimum length
            if (reason.trim().length() < 10) {
                out.println("<script>alert('Rejection reason must be at least 10 characters long!'); "
                        + "window.history.back();</script>");
                return;
            }

            // Create and populate rejected request object
            RejectedRequest rejectedRequest = new RejectedRequest();
            rejectedRequest.setRequestId(requestId);
            rejectedRequest.setReasonForReject(reason);
            rejectedRequest.setRejectionDate(new Timestamp(System.currentTimeMillis()));

            // Add to database
            boolean success = RejectedRequestController.rejectAndDeleteRequest(rejectedRequest);

            if (success) {
                out.println("<script>alert('Request rejected successfully!'); "
                        + "window.location.href='viewRequests.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to reject request.'); "
                        + "window.history.back();</script>");
            }

        } catch (Exception e) {
            out.println("<script>alert('An unexpected error occurred. Please try again later.'); "
                    + "window.location.href='error.jsp';</script>");
            System.err.println("Error in RejectRequestServlet: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}