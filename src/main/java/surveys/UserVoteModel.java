package surveys;

public class UserVoteModel {
    private int userId;
    private int answerId;
    private int answerNumber;

    // Constructor
    public UserVoteModel(int userId, int answerId, int answerNumber) {
        this.userId = userId;
        this.answerId = answerId;
        this.answerNumber = answerNumber;
    }

    // Getters and setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getAnswerNumber() {
        return answerNumber;
    }

    public void setAnswerNumber(int answerNumber) {
        this.answerNumber = answerNumber;
    }
}
