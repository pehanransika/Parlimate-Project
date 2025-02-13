package comment;

import com.ann.AnnouncementModel;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CommentController {

    // Method to check if a post exists
    public static boolean isPostExists(int postid) throws SQLException {
        String query = "SELECT COUNT(*) FROM post WHERE postid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, postid);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // If count > 0, post exists
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return false;
    }

    // Method to publish a comment
    public static boolean PublishComment(int userid, int postid, String content) throws SQLException {
        // First, check if the post exists
        if (!isPostExists(postid)) {
            throw new SQLException("Post ID does not exist.");
        }

        String query = "INSERT INTO comment (userid, postid, content, datetime) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userid);
            stmt.setInt(2, postid);
            stmt.setString(3, content);
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Current timestamp

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static List<CommentModel> getAllcomments() {
        ArrayList<CommentModel> comments = new ArrayList<>();
        String query = "SELECT c.commentid, c.userid, c.postid, c.content, c.datetime "
                + "FROM \"comment\" c "  // Use double quotes for the table name
                + "JOIN post p ON c.postid = p.postid "
                + "JOIN users u ON c.userid = u.user_id";

        // Database connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int commentid = rs.getInt("commentid");
                    int userid = rs.getInt("userid");
                    int postid = rs.getInt("postid");
                    String content = rs.getString("content");
                    LocalDateTime datetime = rs.getTimestamp("datetime").toLocalDateTime();

                    // Create a CommentModel object
                    CommentModel comment = new CommentModel(commentid, userid, postid, content, datetime);
                    comments.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Return the list of comments (could be empty if no result)
        return comments;
    }

    public static List<CommentModel> getById(String commentid) {
        int convertedID = Integer.parseInt(commentid);  // Convert String to int



         String query = "SELECT c.commentid, c.userid, c.postid, c.content, c.datetime \n" +
                 "FROM comment c\n" +
                 "JOIN post p ON c.postid = p.postid\n" +
                 "JOIN users u ON c.userid = u.user_id;\n";
        // Join with politician table to fetch politician's name

        // Create a list to store the result
        ArrayList<CommentModel> comments = new ArrayList<>();

        // Database connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the query
            stmt.setInt(1, convertedID);

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int commentid1 = rs.getInt("commentid");
                    int userid = rs.getInt("userid");
                    int postid = rs.getInt("postid");
                    String content = rs.getString("content");
                    LocalDateTime datetime = rs.getTimestamp("datetime").toLocalDateTime();

                    CommentModel comment = new CommentModel(commentid1, userid, postid, content, datetime);
                   comments.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        return comments;
    }
    //Update Data
    public static boolean updateComment(int commentid, String content, LocalDateTime datetime) {
        String query = "UPDATE comment SET content = ?, datetime = ? WHERE commentid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, content);
            stmt.setTimestamp(2, Timestamp.valueOf(datetime)); // Convert LocalDateTime to Timestamp
            stmt.setInt(3, commentid);

            // Execute the update and return true if at least one row was updated
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            // Log detailed exception message for debugging
            System.err.println("Error updating comment with ID " + commentid + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    //Delete Data
    public static boolean deleteComment(int commentid) {
        boolean isDeleted = false;
        String query = "DELETE FROM comment WHERE commentid = ?";

        try (Connection conn = com.ann.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter for the prepared statement
            stmt.setInt(1, commentid);

            // Execute the delete operation and check if any row was deleted
            int rowsDeleted = stmt.executeUpdate();
            isDeleted = rowsDeleted > 0; // True if at least one row was deleted

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDeleted;
    }






}
