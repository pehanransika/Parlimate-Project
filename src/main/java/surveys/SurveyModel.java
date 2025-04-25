package surveys;

import java.util.List;
import java.time.LocalDateTime;  // Import for LocalDateTime if you're using without timezone.

public class SurveyModel {
    private int surveyId;
    private String surveyTopic;
    private int numberOfQuestions;
    private int userId;
    private List<QuestionModel> questions;// List to hold questions
    private List<SurveyUserProfileModel> user;
    private LocalDateTime createdAt;  // Field for created_at
    private int totalVotes;
    // Constructor, including created_at
    public SurveyModel(int surveyId, String surveyTopic, int numberOfQuestions, int userId, LocalDateTime createdAt) {
        this.surveyId = surveyId;
        this.surveyTopic = surveyTopic;
        this.numberOfQuestions = numberOfQuestions;
        this.userId = userId;
        this.createdAt = createdAt;
    }

    // Getters and setters for all fields
    public int getSurveyId() {
        return surveyId;
    }

    public void setSurveyId(int surveyId) {
        this.surveyId = surveyId;
    }

    public String getSurveyTopic() {
        return surveyTopic;
    }

    public void setSurveyTopic(String surveyTopic) {
        this.surveyTopic = surveyTopic;
    }

    public int getNumberOfQuestions() {
        return numberOfQuestions;
    }

    public void setNumberOfQuestions(int numberOfQuestions) {
        this.numberOfQuestions = numberOfQuestions;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<QuestionModel> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionModel> questions) {
        this.questions = questions;
    }

    public List<SurveyUserProfileModel> getUser() {return user;}

    public void setUser(List<SurveyUserProfileModel> user) {
        this.user = user;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public int getTotalVotes() {return totalVotes;}

    public void setTotalVotes(int totalVotes) {
        this.totalVotes = totalVotes;
    }
}
