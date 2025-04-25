package supportmessage;

import java.sql.Timestamp;

public class SupportMessageModel {
    private int id;
    private String name;
    private String email;
    private String message;
    private Timestamp submittedAt;
    private String answer;
    private boolean answered; // NEW FIELD

    // Constructor with all fields
    public SupportMessageModel(int id, String name, String email, String message, Timestamp submittedAt, String answer, boolean answered) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.message = message;
        this.submittedAt = submittedAt;
        this.answer = answer;
        this.answered = answered;
    }

    // Constructor without answer or answered
    public SupportMessageModel(int id, String name, String email, String message, Timestamp submittedAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.message = message;
        this.submittedAt = submittedAt;
    }

    // Default constructor
    public SupportMessageModel() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public boolean isAnswered() {
        return answered;
    }

    public void setAnswered(boolean answered) {
        this.answered = answered;
    }

    // toString method
    @Override
    public String toString() {
        return "SupportMessageModel [id=" + id + ", name=" + name + ", email=" + email
                + ", message=" + message + ", submittedAt=" + submittedAt
                + ", answer=" + answer + ", answered=" + answered + "]";
    }
}
