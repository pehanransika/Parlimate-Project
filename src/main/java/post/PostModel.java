package post;

import java.sql.Timestamp;

public class PostModel {
    private Integer postId;
    private Integer userId;
    private String content;
    private Timestamp datetime;

    private String name;





    public PostModel(int userId, int postId, Timestamp datetime, String content,String name) {

    public PostModel(int userId, int postId, Timestamp datetime, String content) {

        this.userId = userId;
        this.postId = postId;
        this.datetime = datetime;
        this.content = content;

        this.name = name;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


}

