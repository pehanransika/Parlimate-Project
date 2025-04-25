package publicprofile;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetPoliticianProfileDetailsAdminServlet")
public class GetPoliticianProfileDetailsAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String viewType = request.getParameter("view"); // "1", "2", or "compare"
            String nameParam1 = request.getParameter("politicianName1");

            System.out.println("Request parameters: viewType=" + viewType + ", nameParam1=" + nameParam1);

            PoliticianProfileController controller = new PoliticianProfileController();
            PoliticianProfileModel profile1 = controller.getProfileByPoliticianName(nameParam1);

            // Check if profile1 is not null and forward to the JSP
            if (profile1 != null) {
                System.out.println("Profile for politicianName1 added.");
                System.out.println("Full Name: " + profile1.getImagePath());

                request.setAttribute("profiles1", profile1);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/ProfileManagement/profileManagement.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error fetching profile for politicianName1: " + request.getParameter("politicianName1"));
            request.setAttribute("error", "Error fetching profile for politicianName1.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
