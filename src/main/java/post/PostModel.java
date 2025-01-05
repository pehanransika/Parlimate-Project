package post;

import java.sql.Timestamp;

public class PostModel {
    private Integer postId;
    private Integer userId;
    private String content;
    private Timestamp datetime;
<<<<<<< HEAD
    private String name;
=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595




<<<<<<< HEAD
    public PostModel(int userId, int postId, Timestamp datetime, String content,String name) {
=======
    public PostModel(int userId, int postId, Timestamp datetime, String content) {
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
        this.userId = userId;
        this.postId = postId;
        this.datetime = datetime;
        this.content = content;
<<<<<<< HEAD
        this.name = name;

=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
    }


    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
<<<<<<< HEAD
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

}

