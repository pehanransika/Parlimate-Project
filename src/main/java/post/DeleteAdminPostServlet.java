package post;

import fundreq.RequestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteAdminPostServlet")
public class DeleteAdminPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the comment ID from the request parameter
            String postIdParam = request.getParameter("postId"); // Use commentid to match form

            System.out.println("Received postId: " + postIdParam);

            // Validate the comment ID
            if (postIdParam == null || postIdParam.trim().isEmpty()) {
                throw new NumberFormatException("post ID is missing or invalid.");
            }

            // Parse to integer
            int postId = Integer.parseInt(postIdParam);

            // Attempt deletion
            boolean isDeleted =PostController.deletePost(postId);


            if (isDeleted) {
                // If deletion is successful, redirect with a success message

                response.setContentType("text/html");
                response.getWriter().println(
                        "<script>" +
                                "alert('Post Deleted Successfully');" +
                                "window.location = document.referrer;" +
                                "</script>"
                );

            } else {
                // If deletion fails, retrieve post details and show error page
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Post not found or already deleted.'); window.location.href='error.jsp';</script>");

            }
        } catch (NumberFormatException e) {
            // Handle invalid or missing post ID
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid comment ID'); window.location.href='/admin/PostManagement/PostManagementServlet';</script>");
        } catch (Exception e) {
            // General exception handling
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred'); window.location.href='/admin/PostManagement/PostManagementServlet';</script>");
        }
    }

}
