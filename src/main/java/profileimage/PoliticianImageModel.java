package profileimage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
// Adjust the import if your DB connection class is elsewhere

public class PoliticianImageModel {

    public static String getImagePathByPoliticianId(int politicianId) {
        String imagePath = null;

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT image_path FROM politician_images WHERE politician_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, politicianId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                imagePath = rs.getString("image_path");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return imagePath;
    }
}
