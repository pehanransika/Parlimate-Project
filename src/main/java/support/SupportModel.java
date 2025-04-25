package support;

import java.sql.Timestamp;

public class SupportModel {
    private String name;
    private String email;
    private String message;
    private Timestamp submittedAt;
    private String answer;

    public SupportModel(String name, String email, String message, Timestamp submittedAt, String answer) {
        this.name = name;
        this.email = email;
        this.message = message;
        this.submittedAt = submittedAt;
        this.answer = answer;
    }

    // Optional: Constructor without submittedAt (for insert operations)
    public SupportModel(String name, String email, String message) {
        this.name = name;
        this.email = email;
        this.message = message;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Timestamp submittedAt) {
        this.submittedAt = submittedAt;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
