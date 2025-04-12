package fundreq;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailService {
    public static void sendRejectionEmail(int requestId, String reason) {
        try {
            // 1. Get request details from database
            String[] requestDetails = getRequestDetails(requestId);
            String userEmail = requestDetails[0];
            String requestTitle = requestDetails[1];

            // 2. Configure email properties
            Properties props = new Properties();
            props.put("mail.smtp.host", "your.smtp.server.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // 3. Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("admin@yourdomain.com", "yourpassword");
                }
            });

            // 4. Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("admin@yourdomain.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject("Fundraising Request Rejected: " + requestTitle);

            String emailContent = "Dear User,\n\n" +
                    "We regret to inform you that your fundraising request has been rejected.\n\n" +
                    "Request Title: " + requestTitle + "\n" +
                    "Request ID: " + requestId + "\n" +
                    "Reason for Rejection: " + reason + "\n\n" +
                    "You may contact us if you have any questions.\n\n" +
                    "Sincerely,\nThe Fundraising Team";

            message.setText(emailContent);

            // 5. Send email
            Transport.send(message);

        } catch (Exception e) {
            System.err.println("Error sending rejection email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String[] getRequestDetails(int requestId) {
        // Implement database query to get user email and request title
        // Return as String array: [email, title]
        return new String[]{"user@example.com", "Sample Request"};
    }
}