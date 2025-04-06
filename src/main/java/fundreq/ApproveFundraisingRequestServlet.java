package fundreq;  // Make sure this package matches your directory structure

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/admin/Fundraising/ApprovalFundraisingRequestServlet")

public class ApproveFundraisingRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String requestIdStr = request.getParameter("requestId");

            // Validate input
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Request ID is required");
            }

            int requestId = Integer.parseInt(requestIdStr);

            // Call your approval service
            boolean success = ApproveController.approveFundraisingRequest(requestId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/Fundraising/GetApproveFundraisingServlet?success=true");
            } else {
                request.setAttribute("error", "Failed to approve request");
                request.getRequestDispatcher("/admin/fundraising/fundraisingManagement.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/admin/fundraising/pendingRequests.jsp").forward(request, response);
        }
    }
}