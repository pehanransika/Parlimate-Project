package com.ann;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementController {

    // Method to check if a politician exists
    public static boolean isPoliticianExists(int politicianid) throws SQLException {
        String query = "SELECT COUNT(*) FROM politician WHERE politician_id = ?"; // Correct column name

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, politicianid);  // Bind the politician ID parameter

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count > 0, politician exists
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log the error for debugging
            throw e;
        }
        return false;
    }

    // Method to publish an announcement
    public static boolean PublishAnnouncement(int politicianid, String title, String content) throws SQLException {
        // First, check if the politician exists
        if (!isPoliticianExists(politicianid)) {
            throw new SQLException("Politician ID does not exist.");
        }

        // SQL query for inserting a new announcement
        String query = "INSERT INTO announcement (politicianid, title, content, datetime) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set values in the prepared statement
            stmt.setInt(1, politicianid);
            stmt.setString(2, title);
            stmt.setString(3, content);
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));

            // Execute update and check if any rows were affected
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();
            throw e; // Rethrow the exception to be handled by the servlet
        }
    }

    public static List<AnnouncementModel> getById(String announcementid) {
        int convertedID = Integer.parseInt(announcementid);  // Convert String to int

        // SQL query to retrieve the announcement by its ID along with politician name
        String query = "SELECT a.announcementid, a.politicianid, a.title, a.content, a.datetime, p.name AS politicianName "
                + "FROM announcement a "
                + "JOIN politician p ON a.politicianid = p.politician_id "
                + "WHERE a.announcementid = ?";
        // Join with politician table to fetch politician's name

        // Create a list to store the result
        ArrayList<AnnouncementModel> announcements = new ArrayList<>();

        // Database connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the query
            stmt.setInt(1, convertedID);

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int announcementid1 = rs.getInt("announcementid");
                    int politicianid = rs.getInt("politicianid");
                    String title = rs.getString("title");
                    String content = rs.getString("content");
                    LocalDateTime datetime = rs.getTimestamp("datetime").toLocalDateTime();
                    String politicianName = rs.getString("politicianName");  // Fetch politician's name

                    // Create an AnnouncementModel object and add it to the list
                    AnnouncementModel announcement = new AnnouncementModel(announcementid1, politicianid, title, content, datetime, politicianName);
                    announcements.add(announcement);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Return the list of announcements (could be empty if no result)
        return announcements;
    }

    //get all data
    public static List<AnnouncementModel> getAllAnnouncements() {
        ArrayList<AnnouncementModel> announcements = new ArrayList<>();

        // SQL query to fetch all announcements with politician name
        String query = "SELECT a.announcementid, a.politicianid, a.title, a.content, a.datetime, p.name AS politicianName "
                + "FROM announcement a "
                + "JOIN politician p ON a.politicianid = p.politician_id "
                + "ORDER BY a.datetime DESC"; // Sort announcements by datetime in descending order

        // Database connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int announcementid = rs.getInt("announcementid");
                    int politicianid = rs.getInt("politicianid");
                    String title = rs.getString("title");
                    String content = rs.getString("content");
                    LocalDateTime datetime = rs.getTimestamp("datetime").toLocalDateTime();
                    String politicianName = rs.getString("politicianName");

                    // Log retrieved data for debugging
                    System.out.println("Retrieved: " + title + " by " + politicianName);
                    System.out.println("Politician Name (from getById): " + politicianName);

                    // Create an AnnouncementModel object and add it to the list
                    // Ensure no null value for politicianName
                    if (politicianName == null) {
                        politicianName = "Unknown";  // Default value if null
                    }

                    AnnouncementModel announcement = new AnnouncementModel(announcementid, politicianid, title, content, datetime, politicianName);
                    announcements.add(announcement);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Log the number of retrieved announcements
        System.out.println("Total announcements: " + announcements.size());

        // Return the list of announcements (could be empty if no result)
        return announcements;
    }

    public static List<AnnouncementModel> getMyAnnouncements(int politicianId) {
        ArrayList<AnnouncementModel> announcements = new ArrayList<>();

        // SQL query to fetch all announcements with politician name
        String query = "SELECT a.announcementid, a.politicianid, a.title, a.content, a.datetime, p.name AS politicianName "
                + "FROM announcement a "
                + "JOIN politician p ON a.politicianid = p.politician_id "
                + "WHERE a.politicianid = " + politicianId + " "
                + "ORDER BY a.datetime DESC"
                ; // Sort announcements by datetime in descending order

        // Database connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int announcementid = rs.getInt("announcementid");
                    int politicianid = rs.getInt("politicianid");
                    String title = rs.getString("title");
                    String content = rs.getString("content");
                    LocalDateTime datetime = rs.getTimestamp("datetime").toLocalDateTime();
                    String politicianName = rs.getString("politicianName");

                    // Log retrieved data for debugging
                    System.out.println("Retrieved: " + title + " by " + politicianName);
                    System.out.println("Politician Name (from getById): " + politicianName);

                    // Create an AnnouncementModel object and add it to the list
                    // Ensure no null value for politicianName
                    if (politicianName == null) {
                        politicianName = "Unknown";  // Default value if null
                    }

                    AnnouncementModel announcement = new AnnouncementModel(announcementid, politicianid, title, content, datetime, politicianName);
                    announcements.add(announcement);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Log the number of retrieved announcements
        System.out.println("Total announcements: " + announcements.size());

        // Return the list of announcements (could be empty if no result)
        return announcements;
    }



    //Update Data
    public static boolean updateAnnouncement(int announcementid, String title, String content, LocalDateTime datetime) {
        String query = "UPDATE announcement SET title = ?, content = ?, datetime = ? WHERE announcementid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setTimestamp(3, Timestamp.valueOf(datetime)); // Convert LocalDateTime to Timestamp
            stmt.setInt(4, announcementid); // Set the announcementid

            // Execute the update and return true if rows are updated
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            // Log detailed exception message
            System.err.println("Error updating announcement: " + e.getMessage());
            e.printStackTrace();
            return false; // Return false if an exception occurs
        }
    }

    //Delete Data
    public static boolean deleteAnnouncement(int announcementid) {
        boolean isDeleted = false;
        String query = "DELETE FROM announcement WHERE announcementid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the prepared statement
            stmt.setInt(1, announcementid);

            // Execute the delete operation and check if any row was deleted
            int rowsDeleted = stmt.executeUpdate();
            isDeleted = rowsDeleted > 0; // True if at least one row was deleted

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDeleted;
    }

}
