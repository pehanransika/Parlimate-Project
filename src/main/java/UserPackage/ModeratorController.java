package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ModeratorController {

    public static List<ModeratorModel> ModeratorProfile(int id) {
        List<ModeratorModel> moderators = new ArrayList<>();
        String sql = "SELECT * FROM moderator WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int moderatorId = rs.getInt("moderatorid");
                    String fullName = rs.getString("fullname");
                    String phoneNumber = rs.getString("phone_number");
                    int userId = rs.getInt("userid");

                    ModeratorModel moderator = new ModeratorModel(moderatorId, fullName, phoneNumber, userId);
                    moderators.add(moderator);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from moderator table: " + e.getMessage());
        }

        return moderators;
    }
    public ModeratorModel getUserById(int userId) {
        ModeratorModel moderator = null;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM Moderators WHERE userid = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                moderator = new ModeratorModel(
                        rs.getInt("moderatorid"),
                        rs.getString("fullname"),
                        rs.getString("phone_number"),
                        rs.getInt("userid")
                );
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return moderator;
    }
}
