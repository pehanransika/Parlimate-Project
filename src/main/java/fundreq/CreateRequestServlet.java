package fundreq;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import java.sql.Timestamp;

@WebServlet("/CreateNewRequestServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,     // 5MB
        maxRequestSize = 10 * 1024 * 1024  // 10MB
)
public class CreateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Default values
    private static final int DEFAULT_USER_ID = 2;
    private static final String DEFAULT_STATUS = "PENDING";
    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve form data with proper null checks
            String title = validateRequiredField(request.getParameter("title"), "Title");
            String description = validateRequiredField(request.getParameter("description"), "Description");
            String category = validateRequiredField(request.getParameter("category"), "Category");
            String targetAmountStr = validateRequiredField(request.getParameter("targetamount"), "Target Amount");
            String currency = validateRequiredField(request.getParameter("currency"), "Currency");
            String contact_no = validateRequiredField(request.getParameter("contact_no"), "Contact Number");
            String username = request.getParameter("username");

            // Convert userId with default
            int userId = parseUserId(request.getParameter("userid"));

            // Parse and validate target amount
            BigDecimal targetamount = parseTargetAmount(targetAmountStr);

            // Handle file uploads
            String photos = processFileUpload(request.getPart("photos"), true, request);
            String attachmentUrl = processFileUpload(request.getPart("attachmentUrl"), false, request);

            // Create current timestamp
            Timestamp datetime = new Timestamp(System.currentTimeMillis());

            // Get status or use default
            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = DEFAULT_STATUS;
            }

            // Call controller
            boolean isCreated = RequestController.createFundraisingRequest(
                    userId, title, description, category, targetamount, currency,
                    contact_no, photos, datetime, attachmentUrl, username, status
            );

            // Handle response
            if (isCreated) {
                response.getWriter().println(
                        "<script>alert('Request Published Successfully'); " +
                                "window.location.href='GetAllRequestServlet';</script>");
            } else {
                handleError(request, response, "Failed to create fundraising request", "wrong.jsp");
            }

        } catch (IllegalArgumentException e) {
            handleError(request, response, e.getMessage(), "wrong.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            handleError(request, response, "An unexpected error occurred: " + e.getMessage(), "wrong.jsp");
        }
    }

    // ========== HELPER METHODS ========== //

    private String validateRequiredField(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value.trim();
    }

    private int parseUserId(String userIdStr) {
        if (userIdStr == null || userIdStr.isEmpty()) {
            return DEFAULT_USER_ID;
        }
        try {
            return Integer.parseInt(userIdStr);
        } catch (NumberFormatException e) {
            return DEFAULT_USER_ID;
        }
    }

    private BigDecimal parseTargetAmount(String amountStr) {
        try {
            BigDecimal amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Target amount must be greater than zero");
            }
            return amount;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid target amount format");
        }
    }

    private String processFileUpload(Part filePart, boolean isImage, HttpServletRequest request)
            throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Validate file type if it's an image
        if (isImage) {
            validateImageFile(filePart);
        }

        return saveUploadedFile(filePart, request);
    }

    private void validateImageFile(Part filePart) throws IOException {
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IllegalArgumentException("Only image files are allowed for photos");
        }
    }

    private String saveUploadedFile(Part filePart, HttpServletRequest request) throws IOException {
        // Get application path and construct upload directory path
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + UPLOAD_DIR;

        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get and sanitize filename
        String fileName = getFileName(filePart);
        String safeFileName = sanitizeFileName(fileName);
        String uniqueFileName = generateUniqueFileName(uploadDir, safeFileName);

        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);

        // Return relative path for web access
        return UPLOAD_DIR + "/" + uniqueFileName;
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "file_" + System.currentTimeMillis();
    }

    private String sanitizeFileName(String fileName) {
        // Remove path information and replace special characters
        String cleanName = new File(fileName).getName();
        return cleanName.replaceAll("[^a-zA-Z0-9.-]", "_");
    }

    private String generateUniqueFileName(File uploadDir, String fileName) {
        // If file doesn't exist, return original name
        if (!new File(uploadDir, fileName).exists()) {
            return fileName;
        }

        // Add timestamp before extension
        int dotIndex = fileName.lastIndexOf('.');
        String baseName = (dotIndex == -1) ? fileName : fileName.substring(0, dotIndex);
        String extension = (dotIndex == -1) ? "" : fileName.substring(dotIndex);

        return baseName + "_" + System.currentTimeMillis() + extension;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage, String errorPage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(errorPage).forward(request, response);
    }
}