package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

@WebServlet("/CreateNewRequestServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 5 * 1024 * 1024,     // 5MB
        maxRequestSize = 10 * 1024 * 1024  // 10MB
)
public class CreateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int defaultUserId = 2;

            // Retrieve form data with proper null checks
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountStr = request.getParameter("targetamount");
            String currency = request.getParameter("currency");
            String contact_no = request.getParameter("contact_no");
            String userIdStr = request.getParameter("userid");
            String username = request.getParameter("username");
            String status=request.getParameter("status");

            // Convert userId with default
            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            // Handle file uploads - these are optional
            Part attachmentPart = request.getPart("attachmentUrl");
            String attachmentUrl = null;

            Part photosPart = request.getPart("photos");
            String photos = null;

            // Process files only if they exist
            if (attachmentPart != null && attachmentPart.getSize() > 0) {
                attachmentUrl = saveUploadedFile(attachmentPart, getServletContext().getRealPath("/"));
            }

            if (photosPart != null && photosPart.getSize() > 0) {
                photos = saveUploadedFile(photosPart, getServletContext().getRealPath("/"));
            }

            // Validate only truly required fields
            // Replace the current validation with:
            if (title == null || title.trim().isEmpty()) {
                throw new IllegalArgumentException("Title is required");
            }
            if (description == null || description.trim().isEmpty()) {
                throw new IllegalArgumentException("Description is required");
            }
            if (category == null || category.trim().isEmpty()) {
                throw new IllegalArgumentException("Category is required");
            }
            if (targetAmountStr == null || targetAmountStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Target Amount is required");
            }
            if (currency == null || currency.trim().isEmpty()) {
                throw new IllegalArgumentException("Currency is required");
            }
            if (contact_no == null || contact_no.trim().isEmpty()) {
                throw new IllegalArgumentException("Contact Number is required");
            }

            // Parse and validate target amount
            BigDecimal targetamount;
            try {
                targetamount = new BigDecimal(targetAmountStr);
                if (targetamount.compareTo(BigDecimal.ZERO) <= 0) {
                    throw new IllegalArgumentException("Target amount must be greater than zero.");
                }
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid target amount format.");
            }

            // Create current timestamp
            Timestamp datetime = new Timestamp(System.currentTimeMillis());

            // Call controller with all parameters in correct order
            boolean isCreated = RequestController.createFundraisingRequest(
                    userId,
                    title,
                    description,
                    category,
                    targetamount,
                    currency,
                    contact_no,
                    photos,
                    datetime,
                    attachmentUrl,
                    username,
                    status


            );

            // Response handling
            if (isCreated) {
                response.getWriter().println(
                        "<script>alert('Request Published Successfully'); " +
                                "window.location.href='GetAllRequestServlet';</script>");
            } else {
                request.setAttribute("error", "Failed to create fundraising request.");
                request.getRequestDispatcher("wrong.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("wrong.jsp").forward(request, response);
        }
    }

    // Helper method to save uploaded files
    private String saveUploadedFile(Part filePart, String basePath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        // Create uploads directory if it doesn't exist
        String uploadDirPath = basePath + "uploads";
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get filename and save file
        String fileName = getFileNameFromPart(filePart);
        String savePath = uploadDirPath + File.separator + fileName;
        filePart.write(savePath);

        return "uploads/" + fileName;
    }

    private String getFileNameFromPart(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "file_" + System.currentTimeMillis();
    }
}