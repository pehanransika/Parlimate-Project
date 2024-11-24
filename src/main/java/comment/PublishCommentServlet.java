package comment;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/PublishNewCommentServlet")
public class PublishCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Set default values for user ID and post ID if not provided
            int defaultUserId = 1; // Default user ID
            int defaultPostId = 1; // Default post ID

            // Retrieve form data
            String userIdStr = request.getParameter("userid");
            int userid = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            String postIdStr = request.getParameter("postid");
            int postid = (postIdStr != null && !postIdStr.isEmpty())
                    ? Integer.parseInt(postIdStr)
                    : defaultPostId;

            String content = request.getParameter("content");

            // Call the controller to publish the comment
            boolean isTrue = CommentController.PublishComment(userid, postid, content);

            if (isTrue) {
                // If successful, show alert and redirect to done.jsp
                String alertMessage = "Comment Published Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='ViewCommentServlet';</script>");
            } else {
                // If not successful, forward to the error page
                String alertMessage = "Failed to publish comment.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }
}

