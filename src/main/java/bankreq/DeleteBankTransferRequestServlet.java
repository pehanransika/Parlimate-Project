package bankreq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteBankTransferRequestServlet")
public class DeleteBankTransferRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the transfer ID from the request parameter
            String transferIdParam = request.getParameter("transferId"); // Use transferId to match form

            System.out.println("Received transferId: " + transferIdParam);

            // Validate the request ID
            if (transferIdParam == null || transferIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing or invalid.");
            }

            // Parse to integer
            int transferId = Integer.parseInt(transferIdParam);

            // Attempt deletion
            boolean isDeleted = TransferController.deleteTransfers(transferId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Transaction Deleted Successfully'); window.history.back();</script>");
            } else {

                response.setContentType("text/html");
                response.getWriter().println("<script>alert('transaction not found or already deleted.'); window.location.href='error.jsp';</script>");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Request ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid request ID format.'); window.location.href='error.jsp';</script>");
        } catch (Exception e) {
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again later.'); window.location.href='error.jsp';</script>");
        }
    }
}