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
            // Retrieve all approved transfers from the controller
            List<ApprovedTransferModel> approvedTransfers =
                    ApprovedTransferController.getAllApprovedTransfers();

            // Set the data as a request attribute
            request.setAttribute("approvedTransfers", approvedTransfers);

            // Forward to the actual JSP that displays the approved transfers
            request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            // Set the error message to show in the JSP
            request.setAttribute("error", "Error retrieving approved transfers: " + e.getMessage());

            // Forward to the same JSP even on error
            request.getRequestDispatcher("/admin/BankTransferManagement/BankTransferManagement.jsp")
                    .forward(request, response);
        }
    }
}
