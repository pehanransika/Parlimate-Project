package publicprofile;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/UploadImageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class UploadImageServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "images/Politician";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the absolute path to the upload folder
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Get the uploaded file part
        Part filePart = request.getPart("photo"); // "photo" is the input name in your JSP
        String submittedFileName = getFileName(filePart); // use this method to get original filename

        if (submittedFileName != null && !submittedFileName.isEmpty()) {
            String filePath = uploadPath + File.separator + submittedFileName;
            filePart.write(filePath); // Save the file

            // Store the relative path to be saved in DB or sent to JSP
            String relativePath = "Politician/" + submittedFileName;
            request.setAttribute("image_path", relativePath);
        }

        // Forward back to the JSP or wherever needed
        request.getRequestDispatcher("politicianProfile.jsp").forward(request, response);
    }

    // Helper method to extract file name from HTTP header content-disposition
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
