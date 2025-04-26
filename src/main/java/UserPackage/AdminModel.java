package UserPackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import meetings.DBConnection;

public class AdminModel {
    private int adminid;
    private String fullname;
    private String phone_number;
    private int userid;

    // Default constructor
    public AdminModel() {
    }

    // Parameterized constructor
    public AdminModel(int adminid, String fullname, String phone_number, int userid) {
        this.adminid = adminid;
        this.fullname = fullname;
        this.phone_number = phone_number;
        this.userid = userid;
    }

    // Method to get admin name by user ID
    public String getAdminNameByUserId(int userId) {
        System.out.println(userId);
        String adminName = null;
        String query = "SELECT fullname FROM admin WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                adminName = rs.getString("fullname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error retrieving admin name: " + e.getMessage());
        }

        return adminName;
    }

    // Getters and Setters
    public int getAdminid() {
        return adminid;
    }

    public void setAdminid(int adminid) {
        this.adminid = adminid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }
}