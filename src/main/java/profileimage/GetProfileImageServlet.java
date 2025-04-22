package profileimage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/GetProfileImageServlet")
public class GetProfileImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get politician ID from request parameters
            String idParam = request.getParameter("politicianId");
            int politicianId = Integer.parseInt(idParam);

            // Fetch the image path from the model
            String imagePath = PoliticianImageModel.getImagePathByPoliticianId(politicianId);
            if (imagePath == null || imagePath.isEmpty()) {
                imagePath = "Politician/default.jpg";
            }

            // Resolve the full image path
            String realPath = getServletContext().getRealPath("/images/" + imagePath);
            File imageFile = new File(realPath);

            // Check if file exists
            if (!imageFile.exists()) {
                imageFile = new File(getServletContext().getRealPath("/images/Politician/default.jpg"));
            }

            // Detect MIME type (e.g. image/jpeg, image/png)
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

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load image.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
