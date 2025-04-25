package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.SQLException;

@WebServlet("/PublishNewPostServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class PublishPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int defaultUserId = 2;
            String userIdStr = request.getParameter("userid");
            String username = request.getParameter("username");
            int userId = (userIdStr != null && !userIdStr.isEmpty()) ? Integer.parseInt(userIdStr) : defaultUserId;

            String content = request.getParameter("content");
            if (content == null || content.trim().isEmpty()) {
                throw new IllegalArgumentException("Content cannot be empty.");
            }

            Part filePart = request.getPart("images"); // form input name="images"
            String fileName = getFileName(filePart);

            String imagePath = null;
            if (fileName != null && !fileName.isEmpty()) {
                // Get the absolute path to the web application root
                String appPath = request.getServletContext().getRealPath(""); // Get the absolute path of the web application
                String uploadPath = appPath + File.separator + UPLOAD_DIR; // Define the upload folder path

                // Create uploads directory if it doesn't exist
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // Create the uploads directory
                }

                // Save the uploaded file to this folder
                String filePath = uploadPath + File.separator + fileName; // Full path for the file
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, new File(filePath).toPath()); // Save the file
                }

                // Store the relative path for saving in DB or returning to frontend
                imagePath = UPLOAD_DIR + "/" + fileName; // Relative path for usage in DB
            }


            // Publish post
            boolean isPublished = PostController.PublishPost(userId, content, username, imagePath);

            if (isPublished) {
                response.getWriter().println("<script>alert('Post Published Successfully'); window.location.href='GetPostListServlet';</script>");
            } else {
                request.setAttribute("error", "Failed to publish post.");
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String content : header.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}