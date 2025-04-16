package fundreq;
import java.sql.Timestamp;

public class RejectedRequest {
    private int rejectionId;
    private int requestId;
    private String reasonForReject;
    private Timestamp rejectionDate;
    private String title;


    // Constructors
    public RejectedRequest() {}

    public RejectedRequest(int requestId, String reasonForReject,String title) {
        this.requestId = requestId;
        this.reasonForReject = reasonForReject;
        this.title=title;


    }

    // Getters and Setters
    public int getRejectionId() { return rejectionId; }
    public void setRejectionId(int rejectionId) { this.rejectionId = rejectionId; }

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public String getReasonForReject() { return reasonForReject; }
    public void setReasonForReject(String reasonForReject) { this.reasonForReject = reasonForReject; }

    public Timestamp getRejectionDate() { return rejectionDate; }
    public void setRejectionDate(Timestamp rejectionDate) { this.rejectionDate = rejectionDate; }

    public String getTitle(){return title;}
public void setTitle(String title){this.title=title;}

}
