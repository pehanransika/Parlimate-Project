package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.swing.plaf.synth.SynthTextAreaUI;
import java.io.File;
import java.io.IOException;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024,      // 1 MB
        maxFileSize         = 5 * 1024 * 1024,  // 5 MB
        maxRequestSize      = 20 * 1024 * 1024  // 20 MB
)
@WebServlet("/UserDetailUpdateServlet")
public class UserDetailUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        int userId = user.getUserId();
        String userType = user.getUserType();
        String name = request.getParameter("full-name");
        String district = request.getParameter("district");
        String address = request.getParameter("address");
        String p_no = request.getParameter("phoneNumber");
        String province = request.getParameter("province");
        String political_view = request.getParameter("political_view");
        Part profile_img = request.getPart("profile-img");
        Part banner_img = request.getPart("banner-img");

        System.out.println();
        // Define upload path
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "user_" + userId;

        // Ensure the user-specific directory exists
        File userDir = new File(uploadPath);
        if (!userDir.exists()) {
            userDir.mkdirs(); // Create the directory (including parent directories if needed)
        }

        // Log upload path and directory writability for debugging
        System.out.println("Upload Path: " + uploadPath);
        System.out.println("Directory writable: " + userDir.canWrite());

        // Extract file names for profile and banner images
        String profileImageName = extractFileName(profile_img);
        String bannerImageName = extractFileName(banner_img);

        // Validate file names
        if (profileImageName == null || profileImageName.isEmpty() || bannerImageName == null || bannerImageName.isEmpty()) {
            session.setAttribute("updateError", "Invalid image file(s)");
            response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
            return;
        }

        // Set the full paths for profile and banner images
        String profileImagePath = uploadPath + File.separator + profileImageName;
        String bannerImagePath = uploadPath + File.separator + bannerImageName;

        // Delete existing files to avoid overwrite issues
        File profileFile = new File(profileImagePath);
        if (profileFile.exists()) {
            profileFile.delete();
            System.out.println("Deleted existing profile image: " + profileImagePath);
        }
        File bannerFile = new File(bannerImagePath);
        if (bannerFile.exists()) {
            bannerFile.delete();
            System.out.println("Deleted existing banner image: " + bannerImagePath);
        }

        // Write files to the specified paths
        try {
            profile_img.write(profileImagePath);
            banner_img.write(bannerImagePath);
            System.out.println("Successfully wrote profile image to: " + profileImagePath);
            System.out.println("Successfully wrote banner image to: " + bannerImagePath);
        } catch (IOException e) {
            e.printStackTrace();
            session.setAttribute("updateError", "Failed to save images: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
            return;
        }

        boolean isUpdated = false;
        Object userProfile = null;

        try {
            System.out.println("User Type: " + userType);
            switch (userType.toLowerCase()) {
                case "citizen":
                    isUpdated = CitizenController.updateCitizenUser(userId, name, district, province, address, p_no, political_view, profileImageName, bannerImageName);
                    if (isUpdated) {
                        List<CitizenModel> updatedCitizen = CitizenController.CitizenProfile(userId);
                        if (!updatedCitizen.isEmpty()) {
                            userProfile = updatedCitizen.get(0);
                            session.setAttribute("userProfile", userProfile);
                        }
                    }
                    break;
                case "politician":
                    System.out.println("Updating Politician Profile");
                    isUpdated = PoliticianController.updatePoliticianProfile(userId, name, address, p_no, district, province, political_view, profileImageName, bannerImageName);
                    if (isUpdated) {
                        List<PoliticianModel> updatedPolitician = PoliticianController.PoliticianProfile(userId);
                        if (!updatedPolitician.isEmpty()) {
                            userProfile = updatedPolitician.get(0);
                            session.setAttribute("userProfile", userProfile);
                        }
                    }
                    break;
            }

            if (isUpdated) {
                // Redirect to profile page with success message
                session.setAttribute("updateSuccess", "Profile updated successfully!");
                response.getWriter().println("<script>window.location.href='" + request.getContextPath() + "/Profile/profile.jsp';</script>");
            } else {
                // Redirect back with error message
                session.setAttribute("updateError", "Failed to update profile");
                response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("updateError", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Profile/profile.jsp");
        }
    }

    private String extractFileName(Part part) {
        if (part == null) return null;
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                    return fileName.isEmpty() ? null : fileName;
                }
            }
        }
        return null;
    }
}