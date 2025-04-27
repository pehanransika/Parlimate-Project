package surveys;

import UserPackage.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SurveyUserProfileController {
    public static SurveyUserProfileModel getSurveyUserProfile(int userId) {
        SurveyUserProfileModel profile = null;

        String userQuery = "SELECT * FROM users WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement userStmt = conn.prepareStatement(userQuery)) {

            userStmt.setInt(1, userId);
            ResultSet userRs = userStmt.executeQuery();

            if (userRs.next()) {
                String email = userRs.getString("email");
                String userType = userRs.getString("user_type");
                String createdAt = userRs.getString("created_at");

                String name = "";
                String district = "";
                String imageUrl = "";

                // Determine table based on userType
                switch (userType.toLowerCase()) {
                    case "citizen":
                        String citizenQuery = "SELECT * FROM citizen WHERE user_id = ?";
                        try (PreparedStatement stmt = conn.prepareStatement(citizenQuery)) {
                            stmt.setInt(1, userId);
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                name = rs.getString("name");
                                district = rs.getString("district");
                                imageUrl = rs.getString("image_url");

                            }
                        }
                        break;
                    case "politician":
                        String politicianQuery = "SELECT * FROM politician WHERE user_id = ?";
                        try (PreparedStatement stmt = conn.prepareStatement(politicianQuery)) {
                            stmt.setInt(1, userId);
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                name = rs.getString("name");
                                district = rs.getString("district");
                                imageUrl = rs.getString("image_url");
                            }
                        }
                        break;
                    case "political party":
                        String partyQuery = "SELECT * FROM political_party WHERE user_id = ?";
                        try (PreparedStatement stmt = conn.prepareStatement(partyQuery)) {
                            stmt.setInt(1, userId);
                            ResultSet rs = stmt.executeQuery();
                            if (rs.next()) {
                                name = rs.getString("name");
                                district = rs.getString("district");
                                imageUrl = rs.getString("image_url");
                            }
                        }
                        break;
                }

                profile = new SurveyUserProfileModel(
                        userId, email, userType, createdAt,name, imageUrl, district
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profile;
    }
}
