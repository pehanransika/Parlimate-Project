package UserPackage;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/load-parties") // Use a unique URL, NOT profile.jsp
public class GetPartyListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("GetPartyListServlet");
        try{
            List<PoliticalPartyModel> politicalPartyList = PoliticalPartyController.getPartiesList();
            System.out.println("Parties found: " + politicalPartyList.size());
            request.setAttribute("politicalPartyList", politicalPartyList);
        }
        catch (Exception e){
            e.printStackTrace();
        }

    }
}