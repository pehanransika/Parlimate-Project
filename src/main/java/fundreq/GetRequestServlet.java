package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/Fundraising/GetRequestServlet")
public class GetRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all fundraising requests
            List<RequestModel> allRequests = RequestController.getAllFundraisingRequests();

            if (allRequests == null || allRequests.isEmpty()) {
                System.out.println("No fundraising requests found.");
            } else {
                System.out.println("Fundraising requests retrieved: " + allRequests.size());
            }

            // Set the list as a request attribute
            request.setAttribute("allRequests", allRequests);

            // Forward to requestDetail.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/Fundraising/requestDetail.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Log the exception

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve fundraising requests. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/Fundraising/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
