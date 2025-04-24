package surveys;

public class PercentageModel {
    private int percentageId;
    private int answerId;
    private double percentage;

    public PercentageModel() {}

    public PercentageModel(int percentageId, int answerId, double percentage) {
        this.percentageId = percentageId;
        this.answerId = answerId;
        this.percentage = percentage;
    }

    // Getters and Setters
    public int getPercentageId() {
        return percentageId;
    }

    public void setPercentageId(int percentageId) {
        this.percentageId = percentageId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }
}
