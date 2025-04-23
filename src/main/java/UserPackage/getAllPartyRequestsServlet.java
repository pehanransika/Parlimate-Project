package UserPackage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getAllPartyRequests")
public class getAllPartyRequestsServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            List<PartyRequestModel> parties = PartyRequestController.listAllPartyRequests();

            System.out.println(parties);

            request.setAttribute("parties", parties);
            request.getRequestDispatcher("/admin/userManagement/userManagement.jsp").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }
}
