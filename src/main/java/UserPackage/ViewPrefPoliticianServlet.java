package UserPackage;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/ViewPoliticsPreference")
public class ViewPrefPoliticianServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ViewPoliticianServlet");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        String userId = String.valueOf(user.getUserId());
        try {
            List<PoliticianModel> prefferedPoliticians = PoliticalPrefereceController.getPrefferedPoliticians(userId);
            request.setAttribute("prefferedPoliticians", prefferedPoliticians);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }


    }

}
