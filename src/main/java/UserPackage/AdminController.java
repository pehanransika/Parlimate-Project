package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminController {

    public static List<AdminModel> AdminProfile(int id) {
        List<AdminModel> admins = new ArrayList<>();

        String sql = "SELECT * FROM admin WHERE userid = '"+id+"'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {



            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int adminId = rs.getInt("adminid");
                    String fullName = rs.getString("fullname");
                    String phoneNumber = rs.getString("phone_number");
                    int userId = rs.getInt("userid"); // Ensure this matches your DB schema

                    AdminModel admin = new AdminModel(adminId, fullName, phoneNumber, userId);
                    admins.add(admin);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from admin table: " + e.getMessage());
        }

        return admins;
    }
}
