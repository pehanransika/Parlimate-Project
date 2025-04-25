package surveys;

public class ResponseModel {
    private int responseId;
    private int surveyId;
    private int questionId;
    private int answerId;
    private int userId;

    public ResponseModel() {}

    public ResponseModel(int responseId, int surveyId, int questionId, int answerId, int userId) {
        this.responseId = responseId;
        this.surveyId = surveyId;
        this.questionId = questionId;
        this.answerId = answerId;
        this.userId = userId;
    }

    // Getters and Setters
    public int getResponseId() {
        return responseId;
    }

    public void setResponseId(int responseId) {
        this.responseId = responseId;
    }

    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}

