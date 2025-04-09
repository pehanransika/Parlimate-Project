package surveys;

public class AnswerModel {
    private int answerId;
    private String answerText;
    private int answerNumber;
    private String imageUrl;

    // Constructor, getters, and setters
    public AnswerModel(int answerId, String answerText, int answerNumber, String imageUrl) {
        this.answerId = answerId;
        this.answerText = answerText;
        this.answerNumber = answerNumber;
        this.imageUrl = imageUrl;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public int getAnswerNumber() {
        return answerNumber;
    }

    public void setAnswerNumber(int answerNumber) {
        this.answerNumber = answerNumber;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
