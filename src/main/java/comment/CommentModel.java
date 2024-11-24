package comment;

import java.time.LocalDateTime;

public class CommentModel {
    private int commentid;
    private int userid;
    private int postid;
    private String content;
    private LocalDateTime datetime;

    public CommentModel(int commentid, int userid, int postid, String content, LocalDateTime datetime) {
        this.commentid = commentid;
        this.userid = userid;
        this.postid = postid;
        this.content = content;
        this.datetime = datetime;
    }

    public int getCommentid() {
        return commentid;
    }

    public int getUserid() {
        return userid;
    }

    public int getPostid() {
        return postid;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getDatetime() {
        return datetime;
    }
}

