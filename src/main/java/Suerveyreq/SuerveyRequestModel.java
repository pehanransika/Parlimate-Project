package Suerveyreq;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class SuerveyRequestModel {
    private Integer surveyRequestId;
    private Integer userId;
    private String questionText;
    private String answer01;
    private String answer02;
    private String answer03;
    private String answer04;
    private Timestamp requestTime;


    public SuerveyRequestModel(Integer surveyRequestId, Integer userId,   String questionText, String answer01,String answer02,String answer03,String answer04, LocalDateTime requestTime) {
        this.surveyRequestId = surveyRequestId;
        this.userId = userId;
        this.questionText = questionText;
        this.answer01=answer01;
        this.answer02=answer02;
        this.answer03=answer03;
        this.answer04=answer04;
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




    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }
    public String getAnswer01(){
        return answer01;
    }
    public void setAnswer01(String answer01){
        this.answer01=answer01;
    }
    public String getAnswer02(){
        return answer02;
    }
    public void setAnswer02(String answer02){
        this.answer02=answer02;
    }
    public String getAnswer03(){
        return answer03;
    }
    public void setAnswer03(String answer03){
        this.answer03=answer03;
    }
    public String getAnswer04(){
        return answer04;
    }
    public void setAnswer04(String answer04){
        this.answer04=answer04;
    }
    public Timestamp getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Timestamp requestTime) {
        this.requestTime = requestTime;
    }
}
