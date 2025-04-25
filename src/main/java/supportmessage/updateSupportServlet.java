package supportmessage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/updateSupportServlet")
public class updateSupportServlet extends HttpServlet {
    private SupportMessageController supportMessageController;

    // Email configuration
    private final String senderEmail = "pixeylon@gmail.com";
    private final String senderPassword = "uwwy cmxc ujip yvmo";

    @Override
    public void init() throws ServletException {
        super.init();
        supportMessageController = new SupportMessageController();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String idStr = request.getParameter("id");
        String answer = request.getParameter("answer");
        String userEmail = request.getParameter("email");
        String userName = request.getParameter("name");

        try {
            // Parse the ID
            int id = Integer.parseInt(idStr);

            // Update the answer using SupportMessageController
            boolean updated = supportMessageController.updateAnswer(id, answer);

            if (updated) {
                // Send email to the user
                sendEmail(userEmail, userName, answer);

                // Redirect back to the support management page with success message
                response.sendRedirect(request.getContextPath() + "/admin/UserSupport/GetSupportMesssageServlet?success=Answer updated and email sent successfully");
            } else {
                // Redirect with error message
                response.sendRedirect(request.getContextPath() + "/admin/UserSupport/GetSupportMesssageServlet?error=Failed to update answer");
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID format
            response.sendRedirect(request.getContextPath() + "/admin/UserSupport/GetSupportMesssageServlet?error=Invalid message ID");
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/UserSupport/GetSupportMesssageServlet?error=An error occurred");
        }
    }

    private void sendEmail(String recipientEmail, String userName, String answer) throws MessagingException {
        // Set properties for the mail session
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // Create a new email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail.trim()));
        message.setSubject("Response to Your Support Inquiry");

        // HTML content for the email
        String content = "Dear " + userName + ",<br><br>" +
                "Thank you for reaching out to us. Here is our response to your inquiry:<br><br>" +
                "<b>Response:</b> " + answer + "<br><br>" +
                "We hope this addresses your concern. Feel free to contact us again if you have further questions.<br><br>" +
                "Regards,<br>Parlimate Support Team";

        message.setContent(content, "text/html");

        // Send the email
        Transport.send(message);
    }
}