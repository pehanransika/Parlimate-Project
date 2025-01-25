package com.ann;

import java.time.LocalDateTime;

public class AnnouncementModel {
    private int announcementid;
    private int politicianid;
    private String title;
    private String content;
    private LocalDateTime datetime;
    private String politicianName;

    public AnnouncementModel(int announcementid, int politicianid, String title, String content, LocalDateTime datetime,String politicianName) {
        this.announcementid = announcementid;
        this.politicianid = politicianid;
        this.title = title;
        this.content = content;
        this.datetime = datetime;
        this.politicianName = politicianName;
    }

    public int getannouncementid() {
        return announcementid;
    }

    public void setannouncementid(int announcementid) {
        this.announcementid = announcementid;
    }

    public int getpoliticianid() {
        return politicianid;
    }

    public void setpoliticianid(int politicianid) {
        this.politicianid = politicianid;
    }

    public String gettitle() {
        return title;
    }

    public void settitle(String title) {
        this.title = title;
    }

    public String getcontent() {
        return content;
    }

    public void setcontent(String content) {
        this.content = content;
    }

    public LocalDateTime getdatetime() {
        return datetime = datetime;
    }

    public void setdatetime(LocalDateTime datetime) {
        this.datetime = datetime;
    }
    public String getPoliticianName() {
        return politicianName;
    }

    public void setPoliticianName(String politicianName) {
        this.politicianName = politicianName;
    }
}


