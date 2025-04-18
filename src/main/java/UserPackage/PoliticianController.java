package UserPackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoliticianController {

    // Method to insert a new politician record without political party ID
    public static boolean insertPolitician(int userId, String name, String address, String phoneNumber) {
        // SQL query to insert politician record
        String insertPoliticianSQL = "INSERT INTO politician (user_id, name, address, phone_number) VALUES (?, ?, ?, ?);";

        // Try-with-resources to manage database connection and statement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement insertPoliticianStmt = conn.prepareStatement(insertPoliticianSQL)) {

            // Set the values for the PreparedStatement
            insertPoliticianStmt.setInt(1, userId);           // Set the user ID
            insertPoliticianStmt.setString(2, name);          // Set the name
            insertPoliticianStmt.setString(3, address);       // Set the address
            insertPoliticianStmt.setString(4, phoneNumber);   // Set the phone number
            // Set the profile image URL

            // Execute the update and return true if the insertion was successful
            int rowsInserted = insertPoliticianStmt.executeUpdate();
            return rowsInserted > 0; // Return true if the politician was inserted, otherwise false

        } catch (SQLException e) {
            // Print the error message if an exception occurs
            System.err.println("Error inserting politician: " + e.getMessage());
            return false;
        }
    }
    public PoliticianModel getUserById(int userId) {
        PoliticianModel politician = null;
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM Politicians WHERE userId = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                politician = new PoliticianModel(
                        rs.getInt("userId"),
                        rs.getInt("politicianId"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phoneNumber"),
                        rs.getInt("politicalPartyId"),
                        rs.getString("district"),
                        rs.getString("province")
                );
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return politician;
    }
    public static List<PoliticianModel> PoliticianProfile(int id) {
        List<PoliticianModel> politicians = new ArrayList<>();
        String sql = "SELECT * FROM politician WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int politicianId = rs.getInt("politician_id");
                    int userId = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    int politicalPartyId = rs.getInt("political_party_id");
                    String district = rs.getString("district");
                    String province = rs.getString("province");

                    PoliticianModel politician = new PoliticianModel(userId, politicianId, name, address, phoneNumber, politicalPartyId, district, province);
                    politicians.add(politician);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving data from politician table: " + e.getMessage());
            e.printStackTrace();
        }

        return politicians;
    }

    public static boolean updatePolitician(int userId, String name, String address, String phoneNumber) {
        // SQL query to update politician record
        String updatePoliticianSQL = "UPDATE politician SET name = ?, address = ?, phone_number = ? WHERE user_id = ?";

        // Try-with-resources to manage database connection and statement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement updatePoliticianStmt = conn.prepareStatement(updatePoliticianSQL)) {

            // Set the values for the PreparedStatement
            updatePoliticianStmt.setString(1, name);           // Set the name
            updatePoliticianStmt.setString(2, address);        // Set the address
            updatePoliticianStmt.setString(3, phoneNumber);    // Set the phone number

            updatePoliticianStmt.setInt(4, userId);            // Set the user ID for the WHERE clause

            // Execute the update and return true if the update was successful
            int rowsUpdated = updatePoliticianStmt.executeUpdate();
            return rowsUpdated > 0; // Return true if the politician was updated, otherwise false

        } catch (SQLException e) {
            // Print the error message if an exception occurs
            System.err.println("Error updating politician: " + e.getMessage());
            return false;
        }
    }

    public static boolean updatePoliticianProfile(int userId, String name, String address, String phoneNumber, String district, String province){
        String query = "UPDATE politician SET name='"+name+"', address='"+address+"', phone_number='"+phoneNumber+"', district='"+district+"', province='"+province+"' WHERE user_id='"+userId+"'" ;

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query);

            int rowsUpdated = pstmt.executeUpdate();
            if(rowsUpdated > 0){
                System.out.println("Updated Politician Profile");
            }
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("not Updated Politician Profile");
            return false;
        }

    }

    public static boolean deletePolitician(int userId) {
        String sql = "DELETE FROM politician WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0; // Returns true if at least one row was deleted
        } catch (SQLException e) {
            System.err.println("Error deleting politician: " + e.getMessage());
        }
        return false;
    }

    public static List<PoliticianModel> getPoliticianList() {
        List<PoliticianModel> politicians = new ArrayList<>();
        String sql = "SELECT * FROM politician";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                PoliticianModel politician = new PoliticianModel(rs.getInt("user_id"),rs.getInt("politician_id"),rs.getString("name"),rs.getString("address"),rs.getString("phone_number"),rs.getInt("political_party_id"), rs.getString("district"), rs.getString("province"));
                politicians.add(politician);
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return politicians;
    }
}

