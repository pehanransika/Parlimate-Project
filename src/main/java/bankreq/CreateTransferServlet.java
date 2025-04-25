package bankreq;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

@WebServlet("/CreateTransferServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,     // 5MB
        maxRequestSize = 10 * 1024 * 1024  // 10MB
)
public class CreateTransferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Retrieve form data
            String fundraiserIdStr = request.getParameter("fundraiser_id");
            String userIdStr = request.getParameter("user_id");
            String amountStr = request.getParameter("amount");  // Retrieve amount as string
            String currency = request.getParameter("currency");

            // Validate required fields
            validateRequiredFields(fundraiserIdStr, userIdStr, amountStr, currency);

            // Parse numeric values
            int fundraiserId = Integer.parseInt(fundraiserIdStr);
            int userId = Integer.parseInt(userIdStr);
            BigDecimal amount = validateAmount(amountStr);  // Correct amount validation

            // Process file upload
            Part receiptPart = request.getPart("receipt_image_path");
            if (receiptPart == null || receiptPart.getSize() == 0) {
                throw new ServletException("Receipt file is required");
            }

            String receiptPath = saveUploadedFile(receiptPart);

            // Create transfer
            boolean isCreated = TransferController.createBankTransfer(
                    userId,
                    fundraiserId,
                    amount,
                    currency,
                    receiptPath,
                    new Timestamp(System.currentTimeMillis())
            );

            handleResponse(response, isCreated);

        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void validateRequiredFields(String fundraiserIdStr, String userIdStr, String amountStr, String currency) throws ServletException {
        if (fundraiserIdStr == null || fundraiserIdStr.trim().isEmpty()) {
            throw new ServletException("Fundraiser ID is required");
        }

        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            throw new ServletException("User ID is required");
        }

        if (amountStr == null || amountStr.trim().isEmpty()) {
            throw new ServletException("Amount is required");
        }

        if (currency == null || currency.trim().isEmpty()) {
            throw new ServletException("Currency is required");
        }
    }


    private BigDecimal validateAmount(String amountStr) throws ServletException {
        try {
            BigDecimal amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new ServletException("Amount must be greater than zero");
            }
            return amount;
        } catch (NumberFormatException e) {
            throw new ServletException("Invalid amount format");
        }
    }

    private String saveUploadedFile(Part filePart) throws IOException, ServletException {
        String uploadDirPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = getFileName(filePart);
        String filePath = uploadDirPath + File.separator + fileName;
        filePart.write(filePath);

        return "uploads/" + fileName;
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) {
            return "receipt_" + System.currentTimeMillis();
        }
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "receipt_" + System.currentTimeMillis();
    }

    private void handleResponse(HttpServletResponse response, boolean success) throws IOException {
        if (success) {
            response.getWriter().println(
                    "<script>alert('Transfer submitted successfully!'); " +
                            "window.location.href='GetAllFundraisingApprovelServlet';</script>");
        } else {
            response.sendRedirect("transferError.jsp?error=Failed+to+process+transfer");
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             Exception e) throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("error", e.getMessage());
        request.getRequestDispatcher("transferError.jsp").forward(request, response);
    }
}