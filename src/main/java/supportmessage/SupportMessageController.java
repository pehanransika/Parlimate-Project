package supportmessage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.ann.DBConnection;

public class SupportMessageController {

    public boolean insertMessage(SupportMessageModel message) {

        System.out.println("Here at SupportMessageController");
        String sql = "INSERT INTO support_messages (name, email, message, submitted_at) VALUES (?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, message.getName());
            stmt.setString(2, message.getEmail());
            stmt.setString(3, message.getMessage());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<SupportMessageModel> getAllMessages() {
        List<SupportMessageModel> messages = new ArrayList<>();
        String sql = "SELECT * FROM support_messages ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                SupportMessageModel msg = new SupportMessageModel();
                msg.setId(rs.getInt("id"));
                msg.setName(rs.getString("name"));
                msg.setEmail(rs.getString("email"));
                msg.setMessage(rs.getString("message"));
                msg.setSubmittedAt(rs.getTimestamp("submitted_at"));
                messages.add(msg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }
}
