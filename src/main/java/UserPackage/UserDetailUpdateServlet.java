package UserPackage;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.Part;
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

        String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + "user_" + userId ;

        // Ensure the user-specific directory exists
        File userDir = new File(uploadPath);
        if (!userDir.exists()) {
            userDir.mkdirs(); // Create the directory (including parent directories if needed)
        }

        // Extract file names for NIC front and back
        String ProfileImageName = extractFileName(profile_img);
        String BannerImageName = extractFileName(banner_img);

        // Set the full paths for NIC front and back
        String ProfileImagePath = uploadPath + File.separator + ProfileImageName;
        String BannerImagePath = uploadPath + File.separator + BannerImageName;

        // Write files to the specified paths
        profile_img.write(ProfileImagePath);
        banner_img.write(BannerImagePath);

        boolean isUpdated = false;
        Object userProfile = null;

        try {
            System.out.println(userType);
            switch (userType.toLowerCase()) {
                case "citizen":
                    isUpdated = CitizenController.updateCitizenUser(userId, name, district, province, address, p_no, political_view,ProfileImageName,BannerImageName);
                    if (isUpdated) {
                        List<CitizenModel> updatedCitizen = CitizenController.CitizenProfile(userId);
                        if (!updatedCitizen.isEmpty()) {
                            userProfile = updatedCitizen.get(0);
                            session.setAttribute("userProfile", userProfile);
                        }
                    }
                    break;
                case "politician":
                    System.out.println("in Politician");
                    isUpdated = PoliticianController.updatePoliticianProfile(userId, name, address,p_no,district,province,political_view,ProfileImageName,BannerImageName);
                    if(isUpdated) {
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
                response.getWriter().println("<script>window.location.href='./Profile/profile.jsp';</script>");
            } else {
                // Redirect back with error message
                session.setAttribute("updateError", "Failed to update profile");
                response.sendRedirect("../Parlimate/Profile/profile.jsp");
            }
        } catch (
                Exception e) {
            e.printStackTrace();
            session.setAttribute("updateError", "An error occurred: " + e.getMessage());
            response.sendRedirect("../Profile/profile.jsp");
        }
    }

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