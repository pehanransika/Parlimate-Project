package meetings;

import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1: Retrieve Parameters
        String to = request.getParameter("toEmail");
        String meetingLink = request.getParameter("meetingLink");

        // Debug logs
        System.out.println("Received request to send email.");
        System.out.println("To: " + to);
        System.out.println("Meeting Link: " + meetingLink);

        if (to == null || meetingLink == null || to.isEmpty() || meetingLink.isEmpty()) {
            System.out.println("Error: Email or meeting link missing.");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Email or meeting link is missing.");
            return;
        }

        String subject = "Meeting Invitation Link";
        String messageText = "Hello,\n\nHere is your meeting link:\n" + meetingLink + "\n\nBest regards.";

        final String from = "pixeylon@gmail.com";
        final String password = "uwwy cmxc ujip yvmo";

        // Step 2: SMTP Server Properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        System.out.println("SMTP properties configured.");

        // Step 3: Create Session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                System.out.println("Authenticating with Gmail...");
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            // Step 4: Create Message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(messageText);

            System.out.println("Message prepared. Sending now...");

            // Step 5: Send Message
            Transport.send(message);

            System.out.println("Email successfully sent to: " + to);
            response.sendRedirect("success.html");
        } catch (MessagingException e) {
            System.out.println("Failed to send email.");
            e.printStackTrace(); // logs the full error stack
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to send email: " + e.getMessage());
        }
    }
}
