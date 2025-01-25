package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetNewPostAllServlet")
public class GetPostAllServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            // Fetch all posts from PostController
            String user_idStr = request.getParameter("user_id");
            System.out.println(user_idStr);
            int user_id = Integer.parseInt(user_idStr);
            List<PostModel> allPosts = PostController.getAllPosts(user_id);

            request.setAttribute("allposts", allPosts);
            // Forward to postDetail.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("postsDetail.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            // Log the exception for debugging
            e.printStackTrace();

            // Set error message and forward to an error page
            request.setAttribute("error", "Unable to retrieve posts. Please try again later.");
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
