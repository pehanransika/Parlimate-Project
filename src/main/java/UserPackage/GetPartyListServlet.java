package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/load-parties") // Use a unique URL, NOT profile.jsp
public class GetPartyListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        int userId = user.getUserId();
        System.out.println("GetPartyListServlet");
        try{
            List<PoliticalPartyModel> politicalPartyList = PoliticalPartyController.getPartiesList();
//            List<PoliticalPartyModel> preferedPoliticalPartyList = PoliticalPrefereceController.getPartyPreferences(userId);
            request.setAttribute("politicalPartyList", politicalPartyList);
//            request.setAttribute("preferredParties", preferedPoliticalPartyList);
        }
        catch (Exception e){
            e.printStackTrace();
        }

    }

}