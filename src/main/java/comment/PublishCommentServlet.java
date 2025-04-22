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
            // Retrieve parameters from the form
            int defaultUserId = 1;
            int defaultPostId = 1;
            String userIdStr = request.getParameter("userid");
            String username = request.getParameter("username");
            int userid = (userIdStr != null && !userIdStr.isEmpty())
                    ? Integer.parseInt(userIdStr)
                    : defaultUserId;

            String postIdStr = request.getParameter("postId");
            int postid = (postIdStr != null && !postIdStr.isEmpty())
                    ? Integer.parseInt(postIdStr)
                    : defaultPostId;

            String content = request.getParameter("content");


            // Publish the comment
            boolean isTrue = CommentController.PublishComment(userid, postid, content,username);

            if (isTrue) {
                // If successful, show alert and redirect to ViewCommentServlet

                response.getWriter().println("<script>alert('Comment Published Successfully'); window.location.href='GetAllCommentServlet';</script>");

            } else {
                // If unsuccessful, forward to the error page
                String alertMessage = "Failed to publish comment.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Provide a user-friendly error message
            String alertMessage = "Invalid input or database error. Please try again.";
            request.setAttribute("error", alertMessage);
            RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
            dis.forward(request, response);
        }
    }
}
