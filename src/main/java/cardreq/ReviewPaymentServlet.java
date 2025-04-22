package cardreq;

import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.OffsetDateTime;

@WebServlet("/ReviewPaymentServlet")
public class ReviewPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewPaymentServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String requestIdStr = request.getParameter("requestId");
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        try {
            // Validate input parameters
            if (paymentId == null || payerId == null || requestIdStr == null) {
                request.setAttribute("errorMessage", "Missing required parameters.");
                request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
                return;
            }

            // Parse requestId
            int requestId;
            try {
                requestId = Integer.parseInt(requestIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid request ID format.");
                request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
                return;
            }

            // Get PayPal payment details
            PaymentService paymentService = new PaymentService();
            Payment payment = paymentService.getPaymentDetails(paymentId);

            if (payment != null && !payment.getTransactions().isEmpty()) {
                Transaction transaction = payment.getTransactions().get(0);

                BigDecimal amount = new BigDecimal(transaction.getAmount().getTotal());
                String currency = transaction.getAmount().getCurrency();
                String transactionId = payment.getId();

                OffsetDateTime odt = OffsetDateTime.parse(payment.getCreateTime());
                Timestamp createTime = Timestamp.from(odt.toInstant());

                OrderDetail orderDetail = new OrderDetail(
                        paymentId,
                        transactionId,
                        amount,
                        requestId,
                        currency,
                        createTime
                );

                request.setAttribute("orderDetail", orderDetail);
                request.getRequestDispatcher("review.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Transaction list is empty or payment is null.");
                request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
            }

        } catch (PayPalRESTException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "PayPal error: " + e.getMessage());
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        }
    }
}
