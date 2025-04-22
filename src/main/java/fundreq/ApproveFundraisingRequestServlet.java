package fundreq;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet(
        name = "ApproveFundraisingRequestServlet",
        urlPatterns = {"/ApproveFundraisingRequestServlet"},
        loadOnStartup = 1
)
public class ApproveFundraisingRequestServlet extends HttpServlet {

    private static final String CONFIG_FILE = "/WEB-INF/email-config.properties";
    private Properties emailConfig;
    private boolean emailEnabled = false;

    @Override
    public void init() throws ServletException {
        try (InputStream input = getServletContext().getResourceAsStream(CONFIG_FILE)) {
            if (input != null) {
                emailConfig = new Properties();
                emailConfig.load(input);

                // Set required SMTP properties for Gmail
                emailConfig.setProperty("mail.smtp.auth", "true");
                emailConfig.setProperty("mail.smtp.starttls.enable", "true");
                emailConfig.setProperty("mail.smtp.host", "smtp.gmail.com");
                emailConfig.setProperty("mail.smtp.port", "587");
                emailConfig.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
                emailConfig.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");

                emailEnabled = true;
                System.out.println("Email configuration loaded successfully");
            } else {
                System.err.println("Email configuration file not found: " + CONFIG_FILE);
                emailEnabled = false;
            }
        } catch (IOException e) {
            System.err.println("Error loading email configuration: " + e.getMessage());
            emailEnabled = false;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String redirectUrl = request.getContextPath() + "/admin/Fundraising/GetApproveFundraisingServlet";

        try {
            // 1. Validate and parse request ID
            String requestIdStr = request.getParameter("requestId");
            if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Request ID is required");
            }
            int requestId = Integer.parseInt(requestIdStr);

            // 2. Approve the fundraising request
            boolean approvalSuccess = ApproveController.approveFundraisingRequest(requestId);
            if (!approvalSuccess) {
                session.setAttribute("error", "Failed to approve fundraising request");
                response.sendRedirect(redirectUrl);
                return;
            }

            // 3. Send email notification if enabled
            if (emailEnabled) {
                String requesterEmail = ApproveController.getRequesterEmail(requestId);
                if (requesterEmail != null && !requesterEmail.isEmpty()) {
                    boolean emailSent = sendApprovalEmail(requesterEmail, requestId);
                    if (!emailSent) {
                        session.setAttribute("warning", "Request approved but failed to send notification email");
                    }
                }
            } else {
                System.out.println("Email notifications are disabled - skipping email send");
            }

            // 4. Redirect with success message
            session.setAttribute("success", "Fundraising request approved successfully");
            response.sendRedirect(redirectUrl);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid request ID format");
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect(redirectUrl);
        }
    }

    private boolean sendApprovalEmail(String recipientEmail, int requestId) {
        if (!emailEnabled || emailConfig == null) {
            return false;
        }

        try {
            final String username = emailConfig.getProperty("mail.username");
            final String password = emailConfig.getProperty("mail.password");
            final String fromAddress = emailConfig.getProperty("mail.from", username);

            if (username == null || password == null) {
                System.err.println("Missing email username or password in properties.");
                return false;
            }

            Properties mailProps = new Properties();
            mailProps.putAll(emailConfig);

            Session session = Session.getInstance(mailProps, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            session.setDebug(true); // Optional for debugging

            // Construct the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromAddress));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));

            // Subject and body
            String subjectTemplate = emailConfig.getProperty("mail.approval.subject", "Fundraising Request #%d Approved");
            String subject = String.format(subjectTemplate, requestId);

            String bodyTemplate = emailConfig.getProperty("mail.approval.template",
                    "Dear Fundraiser,\n\n" +
                            "Your fundraising request (ID: %d) has been approved.\n\n" +
                            "You can now proceed with your campaign.\n\n" +
                            "Thank you,\nThe Fundraising Team");
            String body = String.format(bodyTemplate, requestId);

            message.setSubject(subject);
            message.setText(body);

            // Send the message
            Transport.send(message);
            System.out.println("Approval email sent to: " + recipientEmail);
            return true;

        } catch (MessagingException e) {
            System.err.println("Error sending approval email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
