package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetApprovedFundraisersByUser")
public class GetApprovedFundraisersByUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get current user ID from session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                // User not logged in, redirect to login page
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            // Fetch approved fundraisers for this specific user
            List<ApproveModel> fund = ApproveController.getApprovedFundraisersByUser(userId);

            // Set the list as a request attribute
            request.setAttribute("fund", fund);

            // Forward to the fundraising page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Fundraising/myApprovedfundraises.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve your approved fundraisers. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
