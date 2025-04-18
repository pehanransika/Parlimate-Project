package bankreq;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetApprovedTransfersToUserServlet")
public class GetApprovedTransfersToUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get all approved transfers (assumes controller method works)
            List<ApprovedTransferModel> approvedTransferstouser = ApprovedTransferController.getAllApprovedTransfers();

            // Set data to request scope
            request.setAttribute("approvedTransferstouser", approvedTransferstouser);

            // Forward to JSP page
            request.getRequestDispatcher("/Fundraising/AcceptBankTransfer.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading approved transfers: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
