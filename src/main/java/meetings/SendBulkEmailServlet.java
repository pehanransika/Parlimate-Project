package meetings;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/SendBulkEmailServlet")
public class SendBulkEmailServlet extends HttpServlet {

    // Replace with your actual email credentials
    private final String senderEmail = "pixeylon@gmail.com";
    private final String senderPassword = "uwwy cmxc ujip yvmo";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the form data
            String emailString = request.getParameter("emails"); // comma-separated string
            String meetingLink = request.getParameter("meetingLink");

            if (emailString == null || meetingLink == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Missing parameters.");
                return;
            }

            String[] emails = emailString.split(",");

            // Setup mail properties
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            // Authenticate
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            // Send emails
            for (String recipient : emails) {
                recipient = recipient.trim().replace("'", ""); // clean any extra quotes or spaces

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(senderEmail));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
                message.setSubject("Meeting Invitation");

                String emailContent = "Dear User,<br><br>"
                        + "You are invited to a meeting. Please use the link below to join:<br><br>"
                        + "<a href='" + meetingLink + "'>" + meetingLink + "</a><br><br>"
                        + "Regards,<br>Team";

                message.setContent(emailContent, "text/html");

                Transport.send(message);
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Emails sent successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error sending emails: " + e.getMessage());
        }
    }
}
