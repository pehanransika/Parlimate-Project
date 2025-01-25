package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetNewPostListServlet")
public class GetPostListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all posts from PostController
<<<<<<< HEAD
            List<PostModel> allPosts = PostController.getListPosts();

=======
            List<PostModel> allPosts = PostController.getAllPosts();
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

            // Set the list as a request attribute
            request.setAttribute("allposts", allPosts);

            // Forward to postDetail.jsp
<<<<<<< HEAD
            RequestDispatcher dispatcher = request.getRequestDispatcher("Home.jsp");
=======
            RequestDispatcher dispatcher = request.getRequestDispatcher("postlist.jsp");
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
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
