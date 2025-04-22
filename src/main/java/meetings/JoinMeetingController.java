package meetings;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class JoinMeetingController {
    public static boolean addUserToMeeting(String meetingId, String userId, String email) throws SQLException {
        String insertQuery = "INSERT INTO meetingusers (meetingid, userid, email) VALUES (?, ?, ?)";
        String checkQuery = "SELECT COUNT(*) FROM meetingusers WHERE meetingid = ? AND userid = ?";
        String updateSlotsQuery = "UPDATE meetings SET availableslots = availableslots - 1 WHERE meetingid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, Integer.parseInt(meetingId));
            checkStmt.setInt(2, Integer.parseInt(userId));
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                return false;  // Already registered
            }

            // Insert the user
            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setInt(1, Integer.parseInt(meetingId));
                insertStmt.setInt(2, Integer.parseInt(userId));
                insertStmt.setString(3, email);
                insertStmt.executeUpdate();

                // Update available slots only if insert succeeds
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSlotsQuery)) {
                    updateStmt.setInt(1, Integer.parseInt(meetingId));
                    updateStmt.executeUpdate();
                }

                return true;
            }
        }
    }

    public static boolean addUserToWishlist(String meetingId, String userId, String email) throws SQLException {
        // Assuming you have a method for DB connection and executing the SQL query
        String query = "INSERT INTO meetingwishlist (meetingid, userid, email) VALUES (?, ?, ?)";

        // Check if the user is already registered for the meeting
        String checkQuery = "SELECT COUNT(*) FROM meetingwishlist WHERE meetingid = ? AND userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(checkQuery)) {

            stmt.setInt(1, Integer.parseInt(meetingId));
            stmt.setInt(2, Integer.parseInt(userId));
            ResultSet rs = stmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // If user is already in the meeting
                return false;  // Indicating failure due to duplicate
            }

            // If no duplicate, proceed to insert the user into the meeting
            try (PreparedStatement insertStmt = conn.prepareStatement(query)) {
                insertStmt.setInt(1, Integer.parseInt(meetingId));
                insertStmt.setInt(2, Integer.parseInt(userId));
                insertStmt.setString(3, email);
                insertStmt.executeUpdate();
                return true;  // Successfully inserted
            }
        }
    }
    public static boolean withdrawRegistration(String meetingId, String userId) {
        String deleteQuery = "DELETE FROM meetingusers WHERE meetingId = ? AND userId = ?";
        String updateSlotsQuery = "UPDATE meetings SET availableSlots = availableSlots + 1 WHERE meetingId = ?";
        String selectWishlistQuery = "SELECT * FROM meetingwishlist WHERE meetingId = ? ORDER BY timestamp ASC LIMIT 1"; // Use 'id' or correct ordering column

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery)) {

            // Step 1: Delete the user registration
            deleteStmt.setInt(1, Integer.parseInt(meetingId));
            deleteStmt.setInt(2, Integer.parseInt(userId));
            int rowsAffected = deleteStmt.executeUpdate();

            if (rowsAffected > 0) {
                // Step 2: Update availableSlots
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSlotsQuery)) {
                    updateStmt.setInt(1, Integer.parseInt(meetingId));
                    updateStmt.executeUpdate();
                }

                // Step 3: Select first user in wishlist
                try (PreparedStatement selectStmt = conn.prepareStatement(selectWishlistQuery)) {
                    selectStmt.setInt(1, Integer.parseInt(meetingId));
                    try (ResultSet rs = selectStmt.executeQuery()) {
                        if (rs.next()) {
                            String wishlistUserId = rs.getString("userId");
                            String wishlistEmail = rs.getString("email");

                            // Step 4: Add user to meeting
                            System.out.println(wishlistUserId + " " + wishlistEmail);
                            addUserToMeeting(meetingId, wishlistUserId, wishlistEmail);

                            // Step 5: Send email
                            String subject = "Meeting Registration Confirmation";
                            String message = "You have been successfully registered for Meeting ID: " + meetingId;
                            sendEmail(wishlistEmail, subject, message);
                        }
                    }
                }

                return true;
            } else {
                return false; // No rows deleted
            }

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }




    public static List<RegisteredUserModel> getRegisteredUsers(int meetingId) {
        String query = "SELECT userid, email FROM meetingusers WHERE meetingid = ?";
        List<RegisteredUserModel> users = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, meetingId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int userId = rs.getInt("userid");
                    String email = rs.getString("email");

                    RegisteredUserModel user = new RegisteredUserModel(userId, email, meetingId);
                    users.add(user);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // You can log this instead
        }

        return users;
    }

    public static void sendEmail(String toEmail, String subject, String messageText) {
        final String fromEmail = "pixeylon@gmail.com"; // Your email
        final String password = "uwwy cmxc ujip yvmo";      // Your email password or app password

        // Set mail server properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // For Gmail
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Create session
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Compose message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(messageText);

            // Send message
            Transport.send(message);

            System.out.println("Email sent successfully to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}


