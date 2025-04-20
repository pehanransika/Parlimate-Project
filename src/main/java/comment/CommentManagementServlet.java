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

@WebServlet("/CommentManagementServlet")
public class CommentManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get postId from the request


            // Fetch comments for the given postId
            List<CommentModel> alladminComment = CommentController.getAllcomments();
            // Set the list of comments as a request attribute
            request.setAttribute("alladminComment", alladminComment);

            // Optionally: Fetch post details (like title, content, etc.)


            // Forward to comment.jsp to display comments
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/CommentManagement/CommentManagement.jsp");
            dispatcher.forward(request, response);
            System.out.println("Requests found: " + (alladminComment != null ? alladminComment.size() : "null"));


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
