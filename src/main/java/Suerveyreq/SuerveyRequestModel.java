package Suerveyreq;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class SuerveyRequestModel {
    private Integer suerveyrequestid;
    private Integer userid;
    private String title;
    private String questiontype;
    private String questiontext;
    private Timestamp requesttime;

    public SuerveyRequestModel(Integer suerveyrequestid, Integer userid, String title, String questiontype, String questiontext, LocalDateTime requesttime){
        this.suerveyrequestid=suerveyrequestid;
        this.userid=userid;
        this.title=title;
        this.questiontype=questiontype;
        this.questiontext=questiontext;
        this.requesttime= Timestamp.valueOf(requesttime);
    }
    public Integer getSuerveyrequestid(){
        return suerveyrequestid;
    }
    public void setSuerveyrequestid(Integer suerveyrequestid){
        this.suerveyrequestid=suerveyrequestid;
    }
    public Integer getUserid(){
        return userid;
    }
    public void setUserid(Integer userid){
        this.userid=userid;
    }
    public String getTitle(){
        return title;
    }
    public void setTitle(String title){
        this.title=title;
    }
    public String getQuestiontype(){
        return questiontype;
    }
    public void setQuestiontype(String questiontype){
        this.questiontype=questiontype;
    }
    public String getQuestiontext(){
        return questiontext;
    }
    public void setQuestiontext(String questiontext){
        this.questiontext=questiontext;
    }
    public Timestamp getRequesttime(){
        return requesttime;
    }
    public void setRequesttime(Timestamp requesttime){
        this.requesttime=requesttime;
    }
}
