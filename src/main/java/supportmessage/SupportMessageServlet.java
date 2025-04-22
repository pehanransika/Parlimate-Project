package supportmessage;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import supportmessage.SupportMessageController;
import supportmessage.SupportMessageModel;

@WebServlet("/SupportMessageServlet")
public class SupportMessageServlet extends HttpServlet {
    private SupportMessageController controller;

    @Override
    public void init() {
        controller = new SupportMessageController(); // Initialize controller
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("Here at SupportMessageServlet");
        // Get the form data from the request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String messageText = request.getParameter("message");

        // Create a new SupportMessageModel object
        SupportMessageModel message = new SupportMessageModel();
        message.setName(name);
        message.setEmail(email);
        message.setMessage(messageText);
        message.setSubmittedAt(new Timestamp(System.currentTimeMillis()));

        // Call the controller to insert the message
        boolean success = controller.insertMessage(message);

        // Send response to the client
        if (success) {
            // If success, show an alert and redirect to a different page
            response.setContentType("text/html");
            response.getWriter().write(
                    "<script type=\"text/javascript\">" +
                            "alert('Message sent successfully!');" +
                            "window.location.href = '/Parlimate/Help/help.jsp';" +  // Replace with your desired page URL
                            "</script>"
            );
        } else {
            // If failure, show an alert and redirect back to the form
            response.setContentType("text/html");
            response.getWriter().write(
                    "<script type=\"text/javascript\">" +
                            "alert('Failed to send message. Please try again later.');" +
                            "window.location.href = '/Parlimate/Help/help.jsp';" +  // Replace with your form page URL
                            "</script>"
            );
        }
    }
}
