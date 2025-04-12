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
            // 1. Get approved transfers from service layer
            List<ApprovedTransferModel> approvedTransfers = ApprovedTransferController.getAllApprovedTransfers();

            // 2. Set data in request scope
            request.setAttribute("approvedTransfers", approvedTransfers);

            // 3. Forward to JSP view
            request.getRequestDispatcher("/Fundraising/AcceptBankTransfer.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading approved transfers: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}