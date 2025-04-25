package supportmessage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/GetSupportMesssageServlet")
public class GetSupportMesssageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Call the controller method
        SupportMessageController controller = new SupportMessageController();
        List<SupportMessageModel> messages = controller.getAllMessages();
        int totalCount = messages.size();

        // Set messages as a request attribute
        request.setAttribute("messages", messages);
        request.setAttribute("totalCount", totalCount);

        // Forward to JSP page
        request.getRequestDispatcher("/admin/UserSupport/userSupport.jsp").forward(request, response);
    }
}
