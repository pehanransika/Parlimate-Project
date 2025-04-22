package comment;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CommentController {

    // Method to check if the post exists in the database
    public static boolean isPostExist(int postId) throws SQLException {
        String query = "SELECT COUNT(*) FROM post WHERE postid=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Correct parameter index to 1 for the postid.
            stmt.setInt(1, postId); // Set the postid at index 1

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

    // Method to publish the comment
    public static boolean PublishComment(int userid, int postId, String content,String name) throws SQLException {
       if (!isPostExist(postId)) {
            throw new SQLException("Post Id does not exist"); // Post doesn't exist, throw exception
        }

        String query = "INSERT INTO comment(userid, postid, content, time,name) VALUES(?, ?, ?, ?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userid);        // Bind userid to first parameter
            stmt.setInt(2, postId);        // Bind postid to second parameter
            stmt.setString(3, content);    // Bind content to third parameter
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Set the current time for the comment
stmt.setString(5,name);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if the insert was successful
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }
    public static List<CommentModel> getAllcomments() {
        ArrayList<CommentModel> comments = new ArrayList<>();
        String query = "SELECT c.commentid, c.userid, c.postid, c.content, c.time,c.name "
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
                    LocalDateTime time = rs.getTimestamp("time").toLocalDateTime();
                    String name=rs.getString("name");

                    // Create a CommentModel object
                    CommentModel comment = new CommentModel(commentid, userid, postid, content, time,name);
                    comments.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Return the list of comments (could be empty if no result)
        return comments;
    }
    public static List<CommentModel> getCommentsByPostId(int postId) throws Exception {
        List<CommentModel> commentList = new ArrayList<>();

        // Define SQL query
        String query = "SELECT * FROM comment WHERE postid = ?";  // You may adjust based on your table structure

        // Initialize resources
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the postId parameter in the query
            stmt.setInt(1, postId);

            // Execute the query and retrieve the result
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    // Retrieve data from the result set
                    int commentid = rs.getInt("commentid");
                    int userid = rs.getInt("userid");
                    String content = rs.getString("content");
                    LocalDateTime time = rs.getTimestamp("time").toLocalDateTime();
                    String name = rs.getString("name");

                    // Create a new CommentModel object
                    CommentModel comment = new CommentModel();
                    comment.setCommentid(commentid);
                    comment.setUserid(userid);
                    comment.setPostid(postId);
                    comment.setContent(content);
                    comment.setTime(Timestamp.valueOf(time));
                    comment.setName(name);

                    // Add the comment to the list
                    commentList.add(comment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error fetching comments by post ID", e);
        }

        return commentList;
    }
    public static boolean updateComment(int commentid, String content, LocalDateTime time) {
        String query = "UPDATE comment SET content = ?, time = ? WHERE commentid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, content);
            stmt.setTimestamp(2, Timestamp.valueOf(time)); // Convert LocalDateTime to Timestamp
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
