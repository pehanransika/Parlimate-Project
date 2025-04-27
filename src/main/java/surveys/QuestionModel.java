package surveys;

import java.util.List;

public class QuestionModel {
    private int questionId;
    private String questionText;
    private int questionNumber;
    private int numberOfAnswers;
    private List<AnswerModel> answers;
    private List<UserVoteModel> userVotes;


    public QuestionModel(int questionId, String questionText, int questionNumber, int numberOfAnswers) {
        this.questionId = questionId;
        this.questionText = questionText;
        this.questionNumber = questionNumber;
        this.numberOfAnswers = numberOfAnswers;
    }


    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public int getQuestionNumber() {
        return questionNumber;
    }

    public void setQuestionNumber(int questionNumber) {
        this.questionNumber = questionNumber;
    }

    public int getNumberOfAnswers() {
        return numberOfAnswers;
    }

    public void setNumberOfAnswers(int numberOfAnswers) {
        this.numberOfAnswers = numberOfAnswers;
    }

    public List<AnswerModel> getAnswers() {
        return answers;
    }

    public void setAnswers(List<AnswerModel> answers) {
        this.answers = answers;
    }

    public List<UserVoteModel> getUserVotes() {return userVotes;}

    public void setUserVotes(List<UserVoteModel> userVotes) {
        this.userVotes = userVotes;
    }
}
