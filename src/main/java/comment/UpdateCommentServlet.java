package comment;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/UpdateNewCommentServlet")
public class UpdateCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from the form
            int commentid = Integer.parseInt(request.getParameter("commentId"));

            String content = request.getParameter("content");
            String timeStr = request.getParameter("time");

            // Set the current timestamp
            LocalDateTime time = LocalDateTime.now();

            // Call the controller to update the comment
            boolean isUpdated = CommentController.updateComment(commentid,content,time);

            if (isUpdated) {

                response.setContentType("text/html");
                response.getWriter().println(
                        "<script>" +
                                "alert('Comment Updated Successfully');" +
                                "window.location = document.referrer;" +
                                "</script>"
                );

            } else {
                // If update fails, forward to the error page
                String alertMessage = "Failed to update the =comment.";
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
