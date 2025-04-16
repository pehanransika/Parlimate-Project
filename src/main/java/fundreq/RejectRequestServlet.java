package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/RejectRequestServlet")
public class RejectRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get parameters
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String rejectionReason = request.getParameter("rejectionReason");


            // Validate reason (server-side validation is still important)
            if (rejectionReason == null || rejectionReason.trim().length() < 10) {
                throw new ServletException("Rejection reason must be at least 10 characters");
            }

            // Create rejected request
            RejectedRequest rejectedRequest = new RejectedRequest();
            rejectedRequest.setRequestId(requestId);
            rejectedRequest.setReasonForReject(rejectionReason);
            rejectedRequest.setRejectionDate(new Timestamp(System.currentTimeMillis()));

            // Process rejection
            boolean success = RejectedRequestController.rejectAndDeleteRequest(rejectedRequest);

            if (success) {
                // Store alert in session
                String alertMessage = "Request   rejected successfully!\n" +
                        "Reason: " + rejectionReason;

                request.getSession().setAttribute("lastAlert", alertMessage);

                // Add to alerts history
                List<String> alerts = (List<String>) request.getSession().getAttribute("userAlerts");
                if (alerts == null) {
                    alerts = new ArrayList<>();
                }
                alerts.add(alertMessage);
                request.getSession().setAttribute("userAlerts", alerts);

                // Redirect to confirmation
                RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/Fundraising/FundraisingManagementServlet");

                dispatcher.forward(request, response);
            } else {
                throw new ServletException("Failed to process rejection");
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}