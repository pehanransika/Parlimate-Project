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

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get and validate requestId
            String requestIdParam = request.getParameter("requestId");
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                sendErrorResponse(out, "Request ID cannot be empty!", "fundraisingManagement.jsp");
                return;
            }

            int requestId;
            try {
                requestId = Integer.parseInt(requestIdParam);
            } catch (NumberFormatException e) {
                sendErrorResponse(out, "Invalid Request ID format!", "fundraisingManagement.jsp");
                return;
            }

            // Get and validate rejection reason
            String rejectionReason = request.getParameter("rejectionReason");
            if (rejectionReason == null || rejectionReason.trim().isEmpty()) {
                sendErrorResponse(out, "Rejection reason cannot be empty!", "fundraisingManagement.jsp");
                return;
            }

            // Validate reason length
            rejectionReason = rejectionReason.trim();
            if (rejectionReason.length() < 10) {
                sendErrorResponse(out, "Rejection reason must be at least 10 characters long!",
                        "fundraisingManagement.jsp");
                return;
            }

            // Create rejected request object
            RejectedRequest rejectedRequest = new RejectedRequest();
            rejectedRequest.setRequestId(requestId);
            rejectedRequest.setReasonForReject(rejectionReason);
            rejectedRequest.setRejectionDate(new Timestamp(System.currentTimeMillis()));

            // Process rejection
            boolean success = RejectedRequestController.rejectAndDeleteRequest(rejectedRequest);

            if (success) {
                sendSuccessResponse(out, "Request rejected successfully!", "fundraisingManagement.jsp");
            } else {
                sendErrorResponse(out, "Failed to reject request. Please try again.",
                        "fundraisingManagement.jsp");
            }

        } catch (Exception e) {
            logError("Error in RejectRequestServlet", e);
            sendErrorResponse(out, "An unexpected error occurred. Please try again later.",
                    "error.jsp");
        } finally {
            out.close();
        }
    }

    private void sendSuccessResponse(PrintWriter out, String message, String redirectPage) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + escapeJavaScript(message) + "');");
        out.println("window.location.href='" + redirectPage + "';");
        out.println("</script>");
    }

    private void sendErrorResponse(PrintWriter out, String message, String redirectPage) {
        out.println("<script type='text/javascript'>");
        out.println("alert('" + escapeJavaScript(message) + "');");
        out.println("window.location.href='" + redirectPage + "';");
        out.println("</script>");
    }

    private String escapeJavaScript(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("'", "\\'")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

    private void logError(String message, Exception e) {
        System.err.println(message);
        e.printStackTrace();
    }
}