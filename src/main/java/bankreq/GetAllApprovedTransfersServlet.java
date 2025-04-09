package bankreq;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetAllApprovedTransfersServlet")
public class GetAllApprovedTransfersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get all approved transfers
            List<ApprovedTransferModel> approvedTransfers =
                    ApprovedTransferController.getAllApprovedTransfers();

            // Set as request attribute
            request.setAttribute("approvedTransfers", approvedTransfers);

            // Forward to JSP page
            request.getRequestDispatcher("/admin/BankTransferManagement/GetAllApprovedTransfersServlet")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving approved transfers: " + e.getMessage());
            request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                    .forward(request, response);
        }
    }
}