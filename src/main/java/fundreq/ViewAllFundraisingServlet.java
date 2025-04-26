package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/ViewAllFundraisingServlet")
public class ViewAllFundraisingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String requestId = request.getParameter("requestId");
System.out.println(requestId);
            // Check if postId is null or empty
            if (requestId == null || requestId.isEmpty()) {
                request.setAttribute("error", "Request ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            // Fetch all fundraising requests from FundraisingRequestController
            List<RequestModel> allapprovalFundraisings= Collections.singletonList(RequestController.getFundraisingRequestById(Integer.parseInt(requestId)));

            // Set the list as a request attribute
            request.setAttribute("allapprovalFundraisings", allapprovalFundraisings);

            // Forward to requestsDetail.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/Fundraising/fundraiseview.jsp");


            dispatcher.forward(request, response);
            System.out.println("Requests found: " + (allapprovalFundraisings != null ? allapprovalFundraisings.size() : "null"));
        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve fundraising requests. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delegate POST requests to GET method
        doGet(request, response);
    }
}
