package post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class PostController {

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

    // Method to publish a post
    public static boolean PublishPost(int userId, String content, String name, String images) throws SQLException {
        if (!isUserExists(userId)) {
            throw new SQLException("User ID does not exist.");
        }

        String query = "INSERT INTO post (userid, content, datetime, name, images) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.setString(2, content);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setString(4, name);
            stmt.setString(5, images);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error publishing post: " + e.getMessage());
            throw e;
        }
    }

    public static List<PostModel> getAllPosts(int user_id) throws SQLException {
        List<PostModel> posts = new ArrayList<>();
        String query = "SELECT postid, userid, content, datetime, name, images FROM post WHERE userid = ? ORDER BY datetime DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameter before executing the query
            stmt.setInt(1, user_id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int postId = rs.getInt("postid");
                    int userId = rs.getInt("userid");
                    String content = rs.getString("content");
                    Timestamp datetime = rs.getTimestamp("datetime");
                    String name = rs.getString("name");
                    String images = rs.getString("images");

                    PostModel post = new PostModel(userId, postId, datetime, content, name, images);
                    posts.add(post);
                }
            }
        }
        return posts;
    }

    public static List<PostModel> getListPosts() throws SQLException {
        List<PostModel> posts = new ArrayList<>();
        String query = "SELECT postid, userid, content, datetime, name, images FROM post";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int postId = rs.getInt("postid");
                int userId = rs.getInt("userid");
                String content = rs.getString("content");
                Timestamp datetime = rs.getTimestamp("datetime");
                String name = rs.getString("name");
                String images = rs.getString("images");

                PostModel post = new PostModel(userId, postId, datetime, content, name, images);
                posts.add(post);
            }
        }
        return posts;
    }

    // Method to get a single post by ID
    public static List<PostModel> getById(String postid) {
        int convertedID = Integer.parseInt(postid);
        String query = "SELECT postid, userid, content, datetime, name, images FROM post WHERE postid = ?";

        List<PostModel> posts = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, convertedID);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int postId = rs.getInt("postid");
                    int userId = rs.getInt("userid");
                    String content = rs.getString("content");
                    Timestamp datetime = rs.getTimestamp("datetime");
                    String name = rs.getString("name");
                    String images = rs.getString("images");

                    PostModel post = new PostModel(userId, postId, datetime, content, name, images);
                    posts.add(post);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    // Method to update a post
    public static boolean updatePost(int postid, String content, LocalDateTime datetime, String images) {
        String query = "UPDATE post SET content = ?, datetime = ?, images = ? WHERE postid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, content);
            stmt.setTimestamp(2, Timestamp.valueOf(datetime));
            stmt.setString(3, images);
            stmt.setInt(4, postid);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating post: " + e.getMessage());
        }
        return false;
    }

    // Method to delete a post
    public static boolean deletePost(int postid) {
        String query = "DELETE FROM post WHERE postid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, postid);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting post: " + e.getMessage());
        }
        return false;
    }

    // GET POST BY USERID
    public static List<PostModel> getPostByID(String userId) {
        List<PostModel> posts = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT postid, userid, content, datetime, name, images FROM post WHERE userid = ? ORDER BY datetime DESC";

            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, Integer.parseInt(userId));

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    posts.add(new PostModel(
                            rs.getInt("userid"),
                            rs.getInt("postid"),
                            rs.getTimestamp("datetime"),
                            rs.getString("content"),
                            rs.getString("name"),
                            rs.getString("images")
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println("ERROR in getPostByID: " + e.getMessage());
            e.printStackTrace();
        }

        return posts;
    }
}