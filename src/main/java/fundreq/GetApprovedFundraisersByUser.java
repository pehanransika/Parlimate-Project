package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetApprovedFundraisersByUser")
public class GetApprovedFundraisersByUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userId = request.getParameter("userid");

            // Check if postId is null or empty
            if (userId == null || userId.isEmpty()) {
                request.setAttribute("error", "User ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            // Fetch all fundraising requests from FundraisingRequestController
            List<ApproveModel> fundraisingRequests = ApproveController.getApprovedFundraisersByUser(Integer.parseInt(userId));

            // Set the list as a request attribute
            request.setAttribute("fundraisingRequests", fundraisingRequests);

            // Forward to requestsDetail.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("myApprovedfundraises.jsp");


            dispatcher.forward(request, response);

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
