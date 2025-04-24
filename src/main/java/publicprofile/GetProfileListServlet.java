package publicprofile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetProfileListServlet")
public class GetProfileListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Instantiate the DAO
        PoliticianProfileController politicianprofile = new PoliticianProfileController();

        // Get all profiles
        List<PoliticianProfileModel> profilesList = politicianprofile.getAllProfiles();

        // Set the profiles list as a request attribute
        request.setAttribute("profilesList", profilesList);

        // Dispatch to the JSP
        request.getRequestDispatcher("/admin/ProfileManagement/profileManagementAll.jsp").forward(request, response);
    }
}