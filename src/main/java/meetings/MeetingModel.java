package meetings;

public class MeetingModel {
    private int meetingId;
    private int politicianId;
    private String politicianName;
    private String topic;
    private String description;
    private java.sql.Date date;
    private java.sql.Time time;
    private String typeofthemeeting;
    private String host;
    private String platform;
    private java.sql.Date deadlinetoregister;

    // Constructor
    public MeetingModel(int meetingId, int politicianId, String politicianName, String topic, String description, java.sql.Date date,
                        java.sql.Time time, String typeofthemeeting, String host, String platform, java.sql.Date deadlinetoregister) {
        this.meetingId = meetingId;
        this.politicianId = politicianId;
        this.politicianName = politicianName;
        this.topic = topic;
        this.description = description;
        this.date = date;
        this.time = time;
        this.typeofthemeeting = typeofthemeeting;
        this.host = host;
        this.platform = platform;
        this.deadlinetoregister = deadlinetoregister;
    }

    // Default constructor
    public MeetingModel() {
    }

    // Getters and Setters
    public int getMeetingId() {
        return meetingId;
    }

    public void setMeetingId(int meetingId) {
        this.meetingId = meetingId;
    }

    public int getPoliticianId() {
        return politicianId;
    }

    public void setPoliticianId(int politicianId) {
        this.politicianId = politicianId;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public java.sql.Date getDate() {
        return date;
    }

    public void setDate(java.sql.Date date) {
        this.date = date;
    }

    public java.sql.Time getTime() {
        return time;
    }

    public void setTime(java.sql.Time time) {
        this.time = time;
    }

    public String getTypeofthemeeting() {
        return typeofthemeeting;
    }

    public void setTypeofthemeeting(String typeofthemeeting) {
        this.typeofthemeeting = typeofthemeeting;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public java.sql.Date getDeadlinetoregister() {
        return deadlinetoregister;
    }

    public void setDeadlinetoregister(java.sql.Date deadlinetoregister) {
        this.deadlinetoregister = deadlinetoregister;
    }

    // Optional: Override toString() method to display object details
    @Override
    public String toString() {
        return "MeetingModel [meetingId=" + meetingId + ", politicianId=" + politicianId + ",topic=" + topic + ", description=" + description + ", date=" + date + ", time="
                + time + ", typeofthemeeting=" + typeofthemeeting + ", host=" + host + ", platform=" + platform
                + ", deadlinetoregister=" + deadlinetoregister + "]";
    }
}

