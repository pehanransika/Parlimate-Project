package comment;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class CommentModel {
    private int commentid;
    private int userid;
    private int postid;
    private String content;
    private Timestamp time;
    private String name;

    public CommentModel(int commentid, int userid, int postid, String content, LocalDateTime time,String name){

        this.commentid=commentid;
        this.userid=userid;
        this.postid=postid;
        this.content=content;
        this.time= Timestamp.valueOf(time);
        this.name=name;
    }

    public CommentModel() {

    }

    public int getCommentid(){
        return commentid;
    }
    public void setCommentid(int commentid){
        this.commentid=commentid;
    }
    public int getUserid(){
        return userid;
    }
    public void setUserid(int userid){
        this.userid=userid;
    }
    public int getPostid(){
        return postid;
    }
    public void setPostid(int postid){
        this.postid=postid;
    }
    public String getContent(){
        return content;
    }
    public void setContent(String content){
        this.content=content;
    }
    public Timestamp getTime(){
        return time;
    }
    public void setTime(Timestamp time){
        this.time=time;
    }

    public String getName(){return  name;}
    public void setName(String name){this.name=name;}
}
