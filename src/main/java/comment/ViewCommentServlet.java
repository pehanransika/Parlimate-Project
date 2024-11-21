package comment;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewNewCommentServlet")
public class ViewCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handling GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetching all comments
        List<CommentModel> allComments = CommentController.getAllcomments();

        // Setting the comments as a request attribute
        request.setAttribute("allcomments", allComments);

        // Forwarding the request to the JSP (commentdisplay.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("commentdisplay.jsp");
        dispatcher.forward(request, response);  // Using forward instead of include
    }

    // Handling POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);  // Forwarding POST to GET
    }
}

