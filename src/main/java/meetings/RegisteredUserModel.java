package meetings;

public class RegisteredUserModel {
    private int userId;
    private String email;
    private int meetingId;

    public RegisteredUserModel(int userId, String email, int meetingId) {
        this.userId = userId;
        this.email = email;
        this.meetingId = meetingId;
    }

    public int getUserId() {
        return userId;
    }

    public String getEmail() {
        return email;
    }

    public int getMeetingId() {
        return meetingId;
    }
}