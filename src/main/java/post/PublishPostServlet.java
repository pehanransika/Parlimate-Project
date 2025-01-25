package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/PublishNewPostServlet")
public class PublishPostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Default user ID to use when no user ID is provided
            int defaultUserId = 2;

            // Retrieve user ID from the form
            String userIdStr = request.getParameter("userid");

            String username = request.getParameter("username");


            int userId = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            // Retrieve post content from the form
            String content = request.getParameter("content");

            // Validate input content
            if (content == null || content.trim().isEmpty()) {
                throw new IllegalArgumentException("Content cannot be empty.");
            }

            // Call the PostController to publish the post

            boolean isPublished = PostController.PublishPost(userId, content,username);

            boolean isPublished = PostController.PublishPost(userId, content);


            if (isPublished) {
                // If successful, redirect with a success message
                String alertMessage = "Post Published Successfully";

                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetPostListServlet';</script>");

                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='GetPostAllServlet';</script>");

            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish post.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Handle invalid user ID format
            e.printStackTrace();
            request.setAttribute("error", "Invalid User ID. Please enter a numeric value.");
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        } catch (IllegalArgumentException e) {
            // Handle empty or invalid content
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again.");
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }
}
