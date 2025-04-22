package meetings;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/SendDeleteEmailServlet")
public class SendDeleteEmailServlet extends HttpServlet {

    private final String senderEmail = "pixeylon@gmail.com";
    private final String senderPassword = "uwwy cmxc ujip yvmo";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int meetingId = Integer.parseInt(request.getParameter("meetingId"));

            // Get all meetings and find the matching one
            List<MeetingModel> allMeetings = MeetingController.getAllMeetings();
            MeetingModel targetMeeting = null;

            for (MeetingModel meeting : allMeetings) {
                if (meeting.getMeetingId() == meetingId) {
                    targetMeeting = meeting;
                    break;
                }
            }

            if (targetMeeting == null) {
                throw new Exception("Meeting not found with ID: " + meetingId);
            }

            // Validate meeting date
            LocalDate today = LocalDate.now();
            LocalDate meetingDate = targetMeeting.getDate().toLocalDate(); // Make sure this returns LocalDate

            if (meetingDate.isBefore(today)) {
                response.setContentType("text/html");
                response.getWriter().println("<script type='text/javascript'>");
                response.getWriter().println("alert('Cannot delete a past meeting.');");
                response.getWriter().println("window.location.href = 'GetAllMeetingServlet';"); // change if needed
                response.getWriter().println("</script>");
                return;
            }

            // Proceed with sending emails
            List<RegisteredUserModel> registeredUsers = JoinMeetingController.getRegisteredUsers(meetingId);

            String topic = targetMeeting.getTopic();
            String date = String.valueOf(targetMeeting.getDate());
            String time = String.valueOf(targetMeeting.getTime());

            // Mail properties
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            String subject = "Meeting Cancellation Notice: " + topic;

            for (RegisteredUserModel user : registeredUsers) {
                String recipient = user.getEmail().trim();

                String content = "Dear Parlimate User,<br><br>" +
                        "We regret to inform you that the following meeting has been <strong>cancelled</strong>:<br><br>" +
                        "<b>Topic:</b> " + topic + "<br>" +
                        "<b>Date:</b> " + date + "<br>" +
                        "<b>Time:</b> " + time + "<br><br>" +
                        "We apologize for any inconvenience caused.<br><br>" +
                        "Regards,<br>Parlimate Team";

                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(senderEmail));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
                message.setSubject(subject);
                message.setContent(content, "text/html");

                try {
                    Transport.send(message);
                } catch (MessagingException e) {
                    e.printStackTrace(); // Optional logging
                }
            }

            // After sending all emails, delete the meeting
            MeetingController controller = new MeetingController();
            controller.deleteMeeting(meetingId);

            // Redirect after deletion
            response.sendRedirect("GetAllMeetingServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
