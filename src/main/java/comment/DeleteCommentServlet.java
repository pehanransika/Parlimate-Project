package comment;

import fundreq.RequestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteNewCommentServlet")
public class DeleteCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the comment ID from the request parameter
            String commentIdParam = request.getParameter("commentId"); // Use commentid to match form

            System.out.println("Received commentId: " + commentIdParam);

            // Validate the comment ID
            if (commentIdParam == null || commentIdParam.trim().isEmpty()) {
                throw new NumberFormatException("comment ID is missing or invalid.");
            }

            // Parse to integer
            int commentId = Integer.parseInt(commentIdParam);

            // Attempt deletion
            boolean isDeleted = CommentController.deleteComment(commentId);


            if (isDeleted) {
                // If deletion is successful, redirect with a success message

                response.setContentType("text/html");
                response.getWriter().println(
                        "<script>" +
                                "alert('Comment Deleted Successfully');" +
                                "window.location = document.referrer;" +
                                "</script>"
                );

            } else {
                // If deletion fails, retrieve comment details and show error page
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Comment not found or already deleted.'); window.location.href='error.jsp';</script>");

            }
        } catch (NumberFormatException e) {
            // Handle invalid or missing announcement ID
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid comment ID'); window.location.href='GetPostListServlet';</script>");
        } catch (Exception e) {
            // General exception handling
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred'); window.location.href='GetPostListServlet';</script>");
        }
    }

}
