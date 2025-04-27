package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/GetUserImageServlet")
public class GetUserImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_IMAGE_PATH = "images/default.jpg"; // Default image in webapp

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get user ID from request parameters
            String userIdStr = request.getParameter("userId");
            int userId = Integer.parseInt(userIdStr);

            // Fetch the image path from the database
            String imagePath = getUserImagePath(userId);
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = DEFAULT_IMAGE_PATH;
            }

            // Resolve the full image path
            String realPath = getServletContext().getRealPath("/" + imagePath);
            File imageFile = new File(realPath);

            // Check if file exists
            if (!imageFile.exists()) {
                imageFile = new File(getServletContext().getRealPath("/" + DEFAULT_IMAGE_PATH));
            }

            // Detect MIME type (e.g., image/jpeg, image/png)
            String mime = getServletContext().getMimeType(imageFile.getName());
            if (mime == null) {
                mime = "application/octet-stream";
            }

            // Set response headers
            response.setContentType(mime);
            response.setContentLength((int) imageFile.length());

            // Stream image content to client
            try (FileInputStream in = new FileInputStream(imageFile);
                 OutputStream out = response.getOutputStream()) {

                byte[] buffer = new byte[4096];
                int bytesRead;

                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

        } catch (NumberFormatException e) {
            // Handle invalid userId
            serveDefaultImage(response);
        } catch (SQLException e) {
            e.printStackTrace();
            serveDefaultImage(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load image.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String getUserImagePath(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String imagePath = null;

        try {
            conn = DBConnection.getConnection(); // Assuming DBConnection class exists
            String sql = "SELECT imagepath FROM userimage WHERE userid = ? ORDER BY imageid DESC LIMIT 1";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                imagePath = rs.getString("imagepath");
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        return imagePath;
    }

    private void serveDefaultImage(HttpServletResponse response) throws IOException {
        String realPath = getServletContext().getRealPath("/" + DEFAULT_IMAGE_PATH);
        File imageFile = new File(realPath);

        String mime = getServletContext().getMimeType(imageFile.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }

        response.setContentType(mime);
        response.setContentLength((int) imageFile.length());

        try (FileInputStream in = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}