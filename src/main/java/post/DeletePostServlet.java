
package post;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteNewPostServlet")
public class DeletePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the post ID from the request parameter ('postid')
            String postIdParam = request.getParameter("postid");
            System.out.println("Received postid: " + postIdParam);

            // Validate parameter
            if (postIdParam == null || postIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Post ID is missing or invalid.");
            }

            // Parse to integer
            int postId = Integer.parseInt(postIdParam);

            // Attempt deletion
            boolean isDeleted = PostController.deletePost(postId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("setTimeout(function() { location.reload(true); }, 100);"); // Reload with a slight delay
                response.getWriter().println("</script>");
            } else {
                // Fetch details and forward to error page
                List<PostModel> postsDetails = PostController.getById(postIdParam);
                request.setAttribute("postsDetails", postsDetails);

                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Post ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid post ID.'); window.location.href='GetPostAllServlet';</script>");
        } catch (Exception e) {
            System.err.println("Error during post deletion: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again.'); window.location.href='GetPostAllServlet';</script>");
        }
    }
}


package post;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteNewPostServlet")
public class DeletePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the post ID from the request parameter ('postid')
            String postIdParam = request.getParameter("postid");
            System.out.println("Received postid: " + postIdParam);

            // Validate parameter
            if (postIdParam == null || postIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Post ID is missing or invalid.");
            }

            // Parse to integer
            int postId = Integer.parseInt(postIdParam);

            // Attempt deletion
            boolean isDeleted = PostController.deletePost(postId);

            if (isDeleted) {
                // Redirect with success alert
                response.setContentType("text/html");
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("setTimeout(function() { location.reload(true); }, 100);"); // Reload with a slight delay
                response.getWriter().println("</script>");
            } else {
                // Fetch details and forward to error page
                List<PostModel> postsDetails = PostController.getById(postIdParam);
                request.setAttribute("postsDetails", postsDetails);

                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid Post ID: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Invalid post ID.'); window.location.href='GetPostAllServlet';</script>");
        } catch (Exception e) {
            System.err.println("Error during post deletion: " + e.getMessage());
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('An error occurred. Please try again.'); window.location.href='GetPostAllServlet';</script>");
        }
    }
}


