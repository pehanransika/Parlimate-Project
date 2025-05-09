package fundreq;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class RequestController {

    // Method to check if a user exists
    public static boolean isUserExists(int userId) throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0; // If count > 0, user exists
            }
        } catch (SQLException e) {
            System.err.println("Error checking user existence: " + e.getMessage());
            throw e;
        }
    }

    // Method to create a new fundraising request
    public static boolean createFundraisingRequest(
            int userId,
            String title,
            String description,
            String category,
            BigDecimal targetamount,
            String currency,
            String contact_no,
            String photos,
            Timestamp datetime,
            String attachment_url,
            String name,
            String status

    ) throws SQLException {
        // Validate required fields
        if (isEmpty(title) || isEmpty(description) || isEmpty(category) ||
                targetamount == null || isEmpty(currency) || isEmpty(contact_no)) {
            throw new IllegalArgumentException("Missing required fields");
        }

        String query = "INSERT INTO fundraisingrequests (userid, title, description, category, " +
                "targetamount, currency, contact_no, photos, datetime, attachment_url, name, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set all parameters
            stmt.setInt(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, description);
            stmt.setString(4, category);
            stmt.setBigDecimal(5, targetamount);
            stmt.setString(6, currency);
            stmt.setString(7, contact_no);

            // Handle NULL photos and attachments
            if (photos != null) {
                stmt.setString(8, photos);
            } else {
                stmt.setNull(8, Types.VARCHAR);
            }

            stmt.setTimestamp(9, datetime);

            if (attachment_url != null) {
                stmt.setString(10, attachment_url);
            } else {
                stmt.setNull(10, Types.VARCHAR);
            }

            stmt.setString(11, name);
            stmt.setString(12, status);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    private static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Method to retrieve all fundraising requests
    public static List<RequestModel> getAllFundraisingRequests() throws SQLException {
        List<RequestModel> requests = new ArrayList<>();
        String query = "SELECT requestid, userid, title, description, category, targetamount, currency, contact_no,photos,datetime, attachment_url , name ,status FROM fundraisingrequests";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int requestId = rs.getInt("requestid");
                int userId = rs.getInt("userid");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String category = rs.getString("category");
                BigDecimal targetamount = rs.getBigDecimal("targetamount");
                String currency = rs.getString("currency");
                String contact_no = rs.getString("contact_no");
                String photos = rs.getString("photos");
                Timestamp datetime = rs.getTimestamp("datetime");
                String attachment_url = rs.getString("attachment_url");  // Fixed space issue
                String name = rs.getString("name");
                String status=rs.getString("status");

                RequestModel request = new RequestModel(requestId, userId, title, description,
                        category, targetamount, currency, contact_no, photos, datetime, attachment_url, name,status);
                requests.add(request);
            }
        }
        return requests;
    }


    // Method to retrieve a single fundraising request by ID
    public static RequestModel getFundraisingRequestById(int requestId) throws SQLException {
        String query = "SELECT requestid, userid, title, description, category, targetamount, currency, contact_no, photos, datetime, attachment_url, name, status " +
                "FROM fundraisingrequests WHERE requestid = ?";


        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {

                    int userId = rs.getInt("userid");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String category = rs.getString("category");
                    BigDecimal targetamount = rs.getBigDecimal("targetamount");
                    String currency = rs.getString("currency");
                    String contact_no = rs.getString("contact_no");
                    String photos = rs.getString("photos");
                    Timestamp datetime = rs.getTimestamp("datetime");
                    String attachment_url = rs.getString("attachment_url");
                    String name = rs.getString("name");
                   String status=rs.getString("status");
                    return new RequestModel(requestId, userId, title, description, category, targetamount, currency, contact_no, photos, datetime, attachment_url, name,status);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving fundraising request: " + e.getMessage());
            throw e;  // Rethrow the exception after logging it
        }
        return null;
    }


    // Method to update a fundraising request
    public static boolean updateFundraisingRequest(int requestId, String title, String description, String category,
                                                   BigDecimal targetamount, String currency, String contact_no, String photos, LocalDateTime datetime, String attachment_url,String status) throws SQLException {
        String query = "UPDATE fundraisingrequests SET title = ?, description = ?, category = ?, targetamount = ?, currency = ?, contact_no=?,photos=?,datetime = ?, attachment_url = ?,status=? WHERE requestId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set parameters in the correct order
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, category);
            stmt.setBigDecimal(4, targetamount);
            stmt.setString(5, currency);
            stmt.setString(6, contact_no);
            stmt.setString(7, photos);
            stmt.setTimestamp(8, Timestamp.valueOf(datetime));  // Convert LocalDateTime to Timestamp
            stmt.setString(9, attachment_url); // Correct position of attachment_url
            stmt.setInt(10, requestId);  // Ensure requestId is the last parameter
            stmt.setString(11,status);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating fundraising request: " + e.getMessage());
            throw e;
        }
    }


    // Method to delete a fundraising request
    public static boolean deleteFundraisingRequest(int requestId) throws SQLException {
        String query = "UPDATE fundraisingrequests SET status = 'DELETED' WHERE requestid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting fundraising request: " + e.getMessage());
            throw e;
        }
    }
    public static boolean restorerequest(int requestId) throws SQLException{
        String query="UPDATE fundraisingrequests SET status='PENDING' WHERE requestid=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting fundraising request: " + e.getMessage());
            throw e;
        }

    }
    public static boolean deleteRequest(int requestId) throws SQLException {
        String query = "DELETE FROM fundraisingrequests WHERE requestid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0; // Will return true if a row is deleted
        } catch (SQLException e) {
            System.err.println("Error deleting fundraising request: " + e.getMessage());
            throw e;
        }
    }
    public static List<RequestModel> getRequestsByUserId(int userId) throws SQLException {
        List<RequestModel> requests = new ArrayList<>();
        String query = "SELECT  * FROM fundraisingrequests WHERE userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the userId parameter before executing the query
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int requestId = rs.getInt("requestid");

                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String category = rs.getString("category");
                    BigDecimal targetamount = rs.getBigDecimal("targetamount");
                    String currency = rs.getString("currency");
                    String contact_no = rs.getString("contact_no");
                    String photos = rs.getString("photos");
                    Timestamp datetime = rs.getTimestamp("datetime");
                    String attachment_url = rs.getString("attachment_url");  // Fixed space issue
                    String name = rs.getString("name");
                    String status=rs.getString("status");

                    RequestModel request = new RequestModel(requestId, userId, title, description,
                            category, targetamount, currency, contact_no, photos, datetime, attachment_url, name,status);
                    requests.add(request);
                }
            }
        }
        return requests;
    }


}
