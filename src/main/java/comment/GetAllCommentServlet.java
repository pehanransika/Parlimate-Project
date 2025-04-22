package comment;

import post.PostModel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetAllCommentServlet")
public class GetAllCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get postId from the request
            String postId = request.getParameter("postId");

            // Check if postId is null or empty
            if (postId == null || postId.isEmpty()) {
                request.setAttribute("error", "Post ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }


            // Fetch comments for the given postId
            List<CommentModel> allComment = CommentController.getCommentsByPostId(Integer.parseInt(postId));

            // Set the list of comments as a request attribute
            request.setAttribute("allComment", allComment);

            // Optionally: Fetch post details (like title, content, etc.)

            // Forward to comment.jsp to display comments
            RequestDispatcher dispatcher = request.getRequestDispatcher("comment.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve comments. Please try again later.");
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
