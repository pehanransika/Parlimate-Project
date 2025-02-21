package Suerveyreq;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class SuerveyRequestModel {
    private Integer surveyRequestId;
    private Integer userId;

    private String questionType;
    private String questionText;
    private Timestamp requestTime;

    public SuerveyRequestModel(Integer surveyRequestId, Integer userId,  String questionType, String questionText, LocalDateTime requestTime) {
        this.surveyRequestId = surveyRequestId;
        this.userId = userId;

        this.questionType = questionType;
        this.questionText = questionText;
        this.requestTime = Timestamp.valueOf(requestTime);
    }

    public Integer getSurveyRequestId() {
        return surveyRequestId;
    }

    public void setSurveyRequestId(Integer surveyRequestId) {
        this.surveyRequestId = surveyRequestId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }


    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public Timestamp getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Timestamp requestTime) {
        this.requestTime = requestTime;
    }
}
