package fundreq;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteRequestServlet")
public class DeleteRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the request ID from the request parameter ('requestid')
            String requestIdParam = request.getParameter("requestid");
            System.out.println("Received requestid: " + requestIdParam);

            // Validate parameter
            if (requestIdParam == null || requestIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Request ID is missing or invalid.");
            }

            // Parse to integer
            int requestId = Integer.parseInt(requestIdParam);

            // Attempt deletion
            boolean isDeleted = RequestController.deleteFundraisingRequest(requestId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Request Deleted Successfully'); window.location.href='GetAllRequestsServlet';</script>");
            } else {
                // Fetch details and forward to error page
                List<RequestModel> requestDetails = (List<RequestModel>) RequestController.getFundraisingRequestById(requestId);

                if (requestDetails == null || requestDetails.isEmpty()) {
                    response.setContentType("text/html");
                    response.getWriter().println("<script>alert('Request not found or already deleted.'); window.location.href='GetAllRequestsServlet';</script>");
                } else {
                    request.setAttribute("requestDetails", requestDetails);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Request ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid request ID.'); window.location.href='GetAllRequestsServlet';</script>");
        } catch (Exception e) {
            System.err.println("Error during request deletion: " + e.getMessage());
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again.'); window.location.href='GetAllRequestsServlet';</script>");
        }
    }
}

