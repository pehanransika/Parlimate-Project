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
            String bankName = request.getParameter("bank_name");
            String accountHolder = request.getParameter("account_holder_name");
            String accountNumber = request.getParameter("account_number");
            String branch = request.getParameter("branch");
            String amountStr = request.getParameter("amount");
            String currency = request.getParameter("currency");
            String referenceCode = request.getParameter("reference_code");
String receipt_image_path=request.getParameter("receipt_image_path");
            // Validate required fields
            validateRequiredFields(fundraiserIdStr, userIdStr, bankName, accountHolder,
                    accountNumber, amountStr, currency);

            // Parse numeric values
            int fundraiserId = Integer.parseInt(fundraiserIdStr);
            int userId = Integer.parseInt(userIdStr);
            BigDecimal amount = validateAmount(amountStr);

            // Process file upload with null check
            Part receiptPart = request.getPart("receipt_image_path");
            if (receiptPart == null) {
                throw new ServletException("No file part in request");
            }

            String receiptPath = saveUploadedFile(receiptPart);

            // Create transfer
            boolean isCreated = TransferController.createBankTransfer(
                    userId,
                    fundraiserId,
                    bankName,
                    accountHolder,
                    accountNumber,
                    branch,
                    amount,
                    currency,
                    receiptPath,
                    referenceCode,
                    new Timestamp(System.currentTimeMillis())
            );

            handleResponse(response, isCreated);

        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void validateRequiredFields(String... fields) throws ServletException {
        for (String field : fields) {
            if (field == null || field.trim().isEmpty()) {
                throw new ServletException("All required fields must be filled");
            }
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
        if (filePart == null || filePart.getSize() == 0) {
            throw new ServletException("Receipt file is required");
        }

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

    private void handleResponse(HttpServletResponse response, boolean success)
            throws IOException {
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