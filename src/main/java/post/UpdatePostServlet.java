<<<<<<< HEAD
package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/UpdateNewPostServlet")
public class UpdatePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the form
            int postid = Integer.parseInt(request.getParameter("postid"));

            String content = request.getParameter("content");

            // Set the current timestamp
            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller to update the announcement
            boolean isUpdated = PostController.updatePost(postid, content, datetime);

            if (isUpdated) {
                // If successful, retrieve the updated list of posts
                List<PostModel> posts = PostController.getListPosts();
                request.setAttribute("posts", posts);

                // Show alert and redirect to GetPostAllServlet
                String alertMessage = "Post Updated Successfully";
               // response.getWriter().println("<script>alert('" + alertMessage + "'); </script>");
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("setTimeout(function() { location.reload(true); }, 100);"); // Reload with a slight delay
                response.getWriter().println("</script>");
            } else {
                // If update fails, forward to the error page
                String alertMessage = "Failed to update the post.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request'); window.location.href='wrong.jsp';</script>");
        }
    }
}
=======
package post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/UpdateNewPostServlet")
public class UpdatePostServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the form
            int postid = Integer.parseInt(request.getParameter("postid"));

            String content = request.getParameter("content");

            // Set the current timestamp
            LocalDateTime datetime = LocalDateTime.now();

            // Call the controller to update the announcement
            boolean isUpdated = PostController.updatePost(postid, content, datetime);

            if (isUpdated) {
                // If successful, retrieve the updated list of posts
                List<PostModel> posts = PostController.getListPosts();
                request.setAttribute("posts", posts);

                // Show alert and redirect to GetPostAllServlet
                String alertMessage = "Post Updated Successfully";
               // response.getWriter().println("<script>alert('" + alertMessage + "'); </script>");
                response.setContentType("text/html");
                response.getWriter().println("<script>");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("setTimeout(function() { location.reload(true); }, 100);"); // Reload with a slight delay
                response.getWriter().println("</script>");
            } else {
                // If update fails, forward to the error page
                String alertMessage = "Failed to update the post.";
                request.setAttribute("error", alertMessage);
                RequestDispatcher dis = request.getRequestDispatcher("wrong.jsp");
                dis.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request'); window.location.href='wrong.jsp';</script>");
        }
    }
}
>>>>>>> master
