package meetingreq;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Represents a meeting request with relevant details.
 */
public class MeetingRequestModel {

    // Fields
    private int meetingrequestid;           // Primary key with auto-increment
    private String topic;                   // Topic of the meeting
    private int politician_id;              // Foreign key referencing Politician's ID
    private String purposeofmeeting;        // Purpose of the meeting
    private LocalDate proposaldate;         // Scheduled date of the meeting
    private LocalTime proposaltime;         // Scheduled time of the meeting
    private String estimatedduration;       // Approximate duration of the meeting
    private String opponentname;            // Names of opponents
    private String partyaffiliation;        // Political affiliations of participants
    private String discussionformat;        // Format of the meeting (e.g., panel, town hall)
    private String preferredhost;           // Preferred host for the meeting
    private int participantcount;

    // Parameterized constructor
    public MeetingRequestModel(int meetingrequestid, String topic, int politician_id, String purposeofmeeting,
                               LocalDate proposaldate, LocalTime proposaltime, String estimatedduration, String opponentname,
                               String partyaffiliation, String discussionformat, String preferredhost , int participantcount) {
        this.meetingrequestid = meetingrequestid;
        this.topic = topic;
        this.politician_id = politician_id;
        this.purposeofmeeting = purposeofmeeting;
        this.proposaldate = proposaldate;
        this.proposaltime = proposaltime;
        this.estimatedduration = estimatedduration;
        this.opponentname = opponentname;
        this.partyaffiliation = partyaffiliation;
        this.discussionformat = discussionformat;
        this.preferredhost = preferredhost;
        this.participantcount = participantcount;
    }

    // Getters and Setters
    public int getMeetingrequestid() {
        return meetingrequestid;
    }

    public void setMeetingrequestid(int meetingrequestid) {
        this.meetingrequestid = meetingrequestid;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public int getPolitician_id() {
        return politician_id;
    }

    public void setPolitician_id(int politician_id) {
        this.politician_id = politician_id;
    }

    public String getPurposeofmeeting() {
        return purposeofmeeting;
    }

    public void setPurposeofmeeting(String purposeofmeeting) {
        this.purposeofmeeting = purposeofmeeting;
    }

    public LocalDate getProposaldate() {
        return proposaldate;
    }

    public void setProposaldate(LocalDate proposaldate) {
        this.proposaldate = proposaldate;
    }

    public LocalTime getProposaltime() {
        return proposaltime;
    }

    public void setProposaltime(LocalTime proposaltime) {
        this.proposaltime = proposaltime;
    }

    public String getEstimatedduration() {
        return estimatedduration;
    }

    public void setEstimatedduration(String estimatedduration) {
        this.estimatedduration = estimatedduration;
    }

    public String getOpponentname() {
        return opponentname;
    }

    public void setOpponentname(String opponentname) {
        this.opponentname = opponentname;
    }

    public String getPartyaffiliation() {
        return partyaffiliation;
    }

    public void setPartyaffiliation(String partyaffiliation) {
        this.partyaffiliation = partyaffiliation;
    }

    public String getDiscussionformat() {
        return discussionformat;
    }

    public void setDiscussionformat(String discussionformat) {
        this.discussionformat = discussionformat;
    }

    public String getPreferredhost() {
        return preferredhost;
    }

    public void setPreferredhost(String preferredhost) {
        this.preferredhost = preferredhost;
    }

    public int getparticipantcount() {return participantcount;}

    public void setparticipantcount(int participantcount) {this.participantcount = participantcount;}

    // Override toString for better readability
    @Override
    public String toString() {
        return "MeetingRequestModel{" +
                "meetingrequestid=" + meetingrequestid +
                ", topic='" + topic + '\'' +
                ", politician_id=" + politician_id +
                ", purposeofmeeting='" + purposeofmeeting + '\'' +
                ", proposaldate=" + proposaldate +
                ", proposaltime=" + proposaltime +
                ", estimatedduration='" + estimatedduration + '\'' +
                ", opponentname='" + opponentname + '\'' +
                ", partyaffiliation='" + partyaffiliation + '\'' +
                ", discussionformat='" + discussionformat + '\'' +
                ", preferredhost='" + preferredhost + '\'' +
                ", participantcount=" + participantcount +
                '}';
    }
}


