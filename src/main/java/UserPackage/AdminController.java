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
    public AdminModel getUserById(int userId) {
        AdminModel admin = null;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM admins WHERE userid = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                admin = new AdminModel(
                        rs.getInt("adminid"),
                        rs.getString("fullname"),
                        rs.getString("phone_number"),
                        rs.getInt("userid")
                );
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
}
