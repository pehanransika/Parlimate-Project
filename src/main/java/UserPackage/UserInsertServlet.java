
package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.annotation.MultipartConfig;
@MultipartConfig
@WebServlet("/UserNewInsertServlet")
public class UserInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("Password");
        String userType = req.getParameter("userType");

        // Hash the password
        String hashedPassword = passwordHashing.hashPassword(password);
        if (hashedPassword == null) {
            String alertMessage = "Error while processing the password. Please try again.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
            return;
        }

        int userId;
        boolean isType = false;

        // Insert user into the database
        userId = UserController.insertUser(email, hashedPassword, userType);
        if (userId == -2) { // Duplicate email
            String alertMessage = "Duplicate email entered. Please use a different email.";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
            return;
        }

        // Process user type-specific logic
        if (userId > 0) {
            if ("Citizen".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");
                String profile = req.getParameter("district");
                String imgUrl = req.getParameter("img_url");

                isType = CitizenController.insertCitizen(userId, name, address, phoneNumber, profile, imgUrl);
            } else if ("Politician".equals(userType)) {
                String name = req.getParameter("name");
                String address = req.getParameter("address");
                String phoneNumber = req.getParameter("phoneNumber");

                // Get the uploaded files (NIC front and back)
                Part NICfrontPart = req.getPart("nic-front");
                Part NICbackPart = req.getPart("nic-back");

                // Define the upload directory for the user
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "user_" + userId;

                // Ensure the user-specific directory exists
                File userDir = new File(uploadPath);
                if (!userDir.exists()) {
                    userDir.mkdirs(); // Create the directory (including parent directories if needed)
                }

                // Extract file names for NIC front and back
                String NICfrontFileName = extractFileName(NICfrontPart);
                String NICbackFileName = extractFileName(NICbackPart);

                // Set the full paths for NIC front and back
                String NICfrontPath = uploadPath + File.separator + NICfrontFileName;
                String NICbackPath = uploadPath + File.separator + NICbackFileName;

                // Write files to the specified paths
                NICfrontPart.write(NICfrontPath);
                NICbackPart.write(NICbackPath);

                // Insert politician details into the database
                isType = PoliticianController.insertPolitician(userId, name, address, phoneNumber, NICfrontFileName, NICbackFileName);

                // Handle the result (optional)
                if (isType) {
                    System.out.println("Politician details added successfully!");
                } else {
                    System.out.println("Failed to add politician details.");
                }

            } else if ("Political-Party".equals(userType)) {
                String name = req.getParameter("partyName");
                String address = req.getParameter("partyAddress");
                String phoneNumber = req.getParameter("partyPhoneNumber");
                String logoImg = req.getParameter("logoImg");
                int noOfMembers = Integer.parseInt(req.getParameter("noOfMembers"));

                isType = PoliticalPartyController.insertPoliticalParty(userId, name, phoneNumber, address, logoImg, noOfMembers);
            }
        }

        // Handle success or failure
        if (isType) {
            String alertMessage = "Registered Successfully";
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('" + alertMessage + "');");
            resp.getWriter().println("window.location.href='index.jsp';");
            resp.getWriter().println("</script>");
        } else {
            RequestDispatcher dis2 = req.getRequestDispatcher("index.jsp");
            dis2.forward(req, resp);
        }
    }

    // Helper method to extract file name
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    return content.substring(content.indexOf("=") + 2, content.length() - 1);
                }
            }
        }
        return null; // Return null if no filename is found
    }

}

