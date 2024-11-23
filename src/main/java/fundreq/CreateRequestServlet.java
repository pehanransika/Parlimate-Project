package fundreq;

import fundreq.RequestController;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Part;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import java.io.File;

@WebServlet("/CreateNewRequestServlet")
@MultipartConfig
public class CreateRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int defaultUserId = 2;

            // Retrieve form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String targetAmountStr = request.getParameter("targetamount");
            String currency = request.getParameter("currency");
            String datetimeStr = request.getParameter("datetime");

            // Handle file upload using getPart
            Part attachmentPart = request.getPart("attachmentUrl");  // Corresponds to the file input name
            String attachmentUrl = null;

            if (attachmentPart != null && attachmentPart.getSize() > 0) {
                String fileName = getFileNameFromPart(attachmentPart);
                // Get the real path of the 'uploads' folder in the deployed application
                String uploadDirPath = getServletContext().getRealPath("/") + "uploads";
                File uploadDir = new File(uploadDirPath);

                // Ensure the directory exists
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();  // Create the directory if it doesn't exist
                }

                // Save the file
                String savePath = uploadDirPath + File.separator + fileName;
                System.out.println("Upload path: " + savePath);  // Debugging log
                attachmentPart.write(savePath);
                attachmentUrl = "uploads/" + fileName;  // Save relative path to the DB
            }

            // Validate required fields
            if (title == null || title.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    category == null || category.trim().isEmpty() ||
                    targetAmountStr == null || targetAmountStr.trim().isEmpty() ||
                    currency == null || currency.trim().isEmpty() ||
                    datetimeStr == null || datetimeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("All fields are required except Attachment URL.");
            }

            // Parse and validate target amount
            BigDecimal targetAmount = new BigDecimal(targetAmountStr);
            if (targetAmount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Target amount must be greater than zero.");
            }

            // Parse datetime
            Timestamp datetime = Timestamp.valueOf(datetimeStr.replace("T", " ") + ":00");

            // Call the RequestController
            boolean isCreated = RequestController.createFundraisingRequest(
                    defaultUserId, title, description, category, targetAmount, currency, attachmentUrl);

            // Response
            if (isCreated) {
                response.getWriter().println("<script>alert('Request Published Successfully'); window.location.href='GetAllRequestServlet';</script>");
            } else {
                request.setAttribute("error", "Failed to create fundraising request.");
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }

    private String getFileNameFromPart(Part part) {
        String contentDisposition = part.getHeader("Content-Disposition");
        String fileName = null;
        if (contentDisposition != null) {
            String[] elements = contentDisposition.split(";");
            for (String element : elements) {
                if (element.trim().startsWith("filename")) {
                    fileName = element.split("=")[1].trim().replace("\"", "");
                }
            }
        }
        return fileName;
    }
}
