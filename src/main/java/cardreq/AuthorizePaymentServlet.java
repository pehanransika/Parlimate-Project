package cardreq;

import com.paypal.base.rest.PayPalRESTException;
import fundreq.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;

@WebServlet("/AuthorizePaymentServlet")
public class AuthorizePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AuthorizePaymentServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String amountStr = request.getParameter("amount");
        String currency = request.getParameter("currency");
        String requestIdStr = request.getParameter("requestId"); // 🟢 Correct parameter name

        try {
            if (amountStr == null || amountStr.isEmpty() || currency == null || currency.isEmpty()) {
                request.setAttribute("errorMessage", "Amount and currency are required.");
                request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
                return;
            }

            int requestId;

            if (requestIdStr != null && !requestIdStr.isEmpty()) {
                requestId = Integer.parseInt(requestIdStr);
            } else {
                requestId = getLatestApprovedRequestId();
                if (requestId == -1) {
                    request.setAttribute("errorMessage", "No approved requests found.");
                    request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
                    return;
                }
            }

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setAmount(new BigDecimal(amountStr));
            orderDetail.setCurrency(currency);
            orderDetail.setTransactionId("TXN-" + System.currentTimeMillis());
            orderDetail.setRequestId(requestId);

            PaymentService paymentService = new PaymentService();
            String approvalLink = paymentService.authorizePayment(orderDetail); // 🟢 Should include requestId in return URL

            if (approvalLink != null) {
                response.sendRedirect(approvalLink);
            } else {
                request.setAttribute("errorMessage", "Payment initialization failed. PayPal returned null.");
                request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
            }

        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", ex.getMessage());
            request.setAttribute("exceptionObj", ex);
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        } catch (NumberFormatException ex) {
            request.setAttribute("errorMessage", "Invalid request ID format.");
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", ex.getMessage());
            request.setAttribute("exceptionObj", ex);
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        }
    }

    private int getLatestApprovedRequestId() throws SQLException {
        int requestId = -1;

        String sql = "SELECT requestid FROM approved_requests ORDER BY approval_date DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                requestId = rs.getInt("requestid");
            }
        }

        return requestId;
    }
}
