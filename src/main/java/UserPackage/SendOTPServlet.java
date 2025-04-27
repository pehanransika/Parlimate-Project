package UserPackage;

import java.io.IOException;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.Properties;

@WebServlet("/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // You can store OTP in session
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        // Generate random 6-digit OTP
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);

        // Store OTP in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);

        // Send OTP to user's email
        String subject = "Your OTP Code";
        String message = "Your OTP is: " + otp;

        boolean emailSent = sendEmail(email, subject, String.valueOf(otp));

        if(emailSent){
            response.getWriter().write("OTP sent successfully!");
        } else {
            response.getWriter().write("Failed to send OTP.");
        }
    }

    private boolean sendEmail(String to, String subject, String otp) {
        final String from = "pixeylon@gmail.com"; // your email
        final String password = "uwwy cmxc ujip yvmo"; // your app password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);

            // Nicely formatted message
            String messageText = "Welcome to Parlimate!\n\n" +
                    "Thank you for joining our platform.\n\n" +
                    "Your One-Time Password (OTP) for verification is: " + otp + "\n\n" +
                    "Please enter this OTP to complete your registration.\n\n" +
                    "If you did not request this, please ignore this email.\n\n" +
                    "Best regards,\n" +
                    "Parlimate Team";

            message.setText(messageText);

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

}
