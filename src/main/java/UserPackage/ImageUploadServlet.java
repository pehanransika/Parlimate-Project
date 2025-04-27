package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/Profile/ImageUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ImageUploadServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "images/Users";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        Part filePart = request.getPart("profileImage");

        if (filePart != null && userIdStr != null && !userIdStr.trim().isEmpty()) {
            int userId;
            try {
                userId = Integer.parseInt(userIdStr); // Convert userId to int
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Invalid user ID format.");
                response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
                return;
            }

            String fileName = extractFileName(filePart);
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            // Create directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file with userId prefix
            String filePath = uploadPath + File.separator + userId + "_" + fileName;
            filePart.write(filePath);

            // Relative path for database storage
            String imageUrl = UPLOAD_DIR + "/" + userId + "_" + fileName;

            // Update or insert image path in the database
            try {
                if (updateUserImage(userId, imageUrl)) {
                    request.getSession().setAttribute("successMessage", "Profile image uploaded successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to update image in database.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
        } else {
            request.getSession().setAttribute("errorMessage", "Invalid user ID or image file.");
        }

        response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
    }

    private boolean updateUserImage(int userId, String imagePath) throws SQLException {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement upsertStmt = null;
        ResultSet rs = null;
        boolean success = false;

        try {
            // Get connection from DBConnection class
            conn = DBConnection.getConnection();

            // Check if an entry exists for the userId
            String checkSql = "SELECT imageid FROM userimage WHERE userid = ? ORDER BY imageid DESC LIMIT 1";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Update existing record (most recent imageid)
                int imageId = rs.getInt("imageid");
                String updateSql = "UPDATE userimage SET imagepath = ? WHERE userid = ? AND imageid = ?";
                upsertStmt = conn.prepareStatement(updateSql);
                upsertStmt.setString(1, imagePath);
                upsertStmt.setInt(2, userId);
                upsertStmt.setInt(3, imageId);
            } else {
                // Insert new record (imageid will auto-increment)
                String insertSql = "INSERT INTO userimage (userid, imagepath) VALUES (?, ?)";
                upsertStmt = conn.prepareStatement(insertSql);
                upsertStmt.setInt(1, userId);
                upsertStmt.setString(2, imagePath);
            }

            // Execute the update or insert
            int rowsAffected = upsertStmt.executeUpdate();
            success = rowsAffected > 0;

        } finally {
            // Close resources
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (checkStmt != null) try { checkStmt.close(); } catch (SQLException ignored) {}
            if (upsertStmt != null) try { upsertStmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        return success;
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}