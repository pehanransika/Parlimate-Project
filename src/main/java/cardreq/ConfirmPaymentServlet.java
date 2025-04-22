package cardreq;

import fundreq.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

@WebServlet("/Fundraising/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String paymentId = request.getParameter("paymentId");
            String transactionId = request.getParameter("transactionId");
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            int requestId = Integer.parseInt(request.getParameter("requestid"));
            String currency = request.getParameter("currency");
            Timestamp createTime = Timestamp.valueOf(request.getParameter("createTime"));

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO payments (payment_id, transaction_id, amount, requestid, currency, create_time) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, paymentId);
                    stmt.setString(2, transactionId);
                    stmt.setBigDecimal(3, amount);
                    stmt.setInt(4, requestId);
                    stmt.setString(5, currency);
                    stmt.setTimestamp(6, createTime);

                    int rowsInserted = stmt.executeUpdate();

                    if (rowsInserted > 0) {
                        request.getRequestDispatcher("${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Failed to insert order.");
                        request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("errorpayment.jsp").forward(request, response);
        }
    }
}

