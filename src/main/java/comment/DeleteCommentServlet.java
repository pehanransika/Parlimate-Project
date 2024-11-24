package comment;

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
            // Retrieve the announcement ID from the request parameter
            String commentIdParam = request.getParameter("commentid");

            // Log the parameter for debugging
            System.out.println("Received commentid: " + commentIdParam);

            // Check if the parameter is null or empty
            if (commentIdParam == null ||commentIdParam.trim().isEmpty()) {
                throw new NumberFormatException("Comment ID is missing or invalid");
            }

            // Convert the parameter to an integer
            int commentId = Integer.parseInt(commentIdParam);

            // Call the delete method from the controller
            boolean isDeleted =CommentController.deleteComment(commentId);

            if (isDeleted) {
                // If deletion is successful, redirect with a success message
                String alertMessage = "Data Deleted Successfully";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href='ViewCommentServlet';</script>");
            } else {
                // If deletion fails, retrieve announcement details and show error page
                List<CommentModel> commentsDetails = CommentController.getById(commentIdParam);
                request.setAttribute("commentsDetails", commentsDetails);

                RequestDispatcher dispatcher = request.getRequestDispatcher("wrong.jsp");
                dispatcher.forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Handle invalid or missing announcement ID
            e.printStackTrace();
            response.getWriter().println("<script>alert('Invalid announcement ID'); window.location.href='ViewCommentServlet';</script>");
        } catch (Exception e) {
            // General exception handling
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred'); window.location.href='ViewCommentServlet';</script>");
        }
    }

}

