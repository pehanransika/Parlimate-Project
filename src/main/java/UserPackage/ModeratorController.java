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
}
