package bankreq;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/ApprovedTransferRequestServlet")
public class ApprovedTransferRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String transferIdStr = request.getParameter("transfer_id");

            // Validate input
            if (transferIdStr == null || transferIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Transfer ID is required");
            }

            // Parse to integer since transfer_id is INT in DB
            int transferId = Integer.parseInt(transferIdStr);

            // Call approval service with integer ID
            boolean success = ApprovedTransferController.approveTransferRequest(transferId);

            if (success) {
                response.setContentType("text/html");
                response.getWriter().println(
                        "<script>" +
                                "alert('Approve transfer successfully');" +
                                "window.location.href = '" + request.getContextPath() + "/admin/BankTransferManagement/GetAllApprovedTransfersServlet';" +
                                "</script>"
                );

            } else {
                request.setAttribute("error", "Failed to approve request");
                request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                        .forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Transfer ID format. Must be a number.");
            request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                    .forward(request, response);
        }
    }
}