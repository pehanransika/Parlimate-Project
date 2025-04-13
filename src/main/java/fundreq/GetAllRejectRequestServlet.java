package fundreq;


import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/GetAllRejectRequestServlet ")
public class  GetAllRejectRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get all rejected requests from controller
            List<RejectedRequest> rejectedRequests = RejectedRequestController.getAllRejectedRequests();

            // Set the list as a request attribute
            request.setAttribute("rejectedRequests", rejectedRequests);

            // Forward to JSP for display
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/Fundraising/fundraisingManagement.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            // Log the error
            System.err.println("Error retrieving rejected requests: " + e.getMessage());
            e.printStackTrace();

            // Set error message and redirect to error page
            request.setAttribute("errorMessage", "Failed to load rejected requests. Please try again later.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If needed for any post operations
        doGet(request, response);
    }
}