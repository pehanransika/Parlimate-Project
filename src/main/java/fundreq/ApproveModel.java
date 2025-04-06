package fundreq;

import java.sql.Timestamp;

public class ApproveModel {
    private int requestId;
    private String title;
    private String description;
    private String contactNo;
    private String category;
    private double targetamount;  // Changed field name
    private String attachmentUrl;
    private String photos;
    private String status;
    private Timestamp approvalDate;

    // Constructor
    public ApproveModel(int requestId, String title, String description,
                           String contactNo, String category, double targetamount,
                           String attachmentUrl, String photos, Timestamp approvalDate) {
        this.requestId = requestId;
        this.title = title;
        this.description = description;
        this.contactNo = contactNo;
        this.category = category;
        this.targetamount = targetamount;  // Updated parameter
        this.attachmentUrl = attachmentUrl;
        this.photos = photos;
        this.status = "APPROVED";
        this.approvalDate = approvalDate;
    }

    // Getters and Setters
    public int getRequestId() { return requestId; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getContactNo() { return contactNo; }
    public String getCategory() { return category; }
    public double getTargetammount() { return targetamount; }  // Updated getter
    public String getAttachmentUrl() { return attachmentUrl; }
    public String getPhotos() { return photos; }
    public String getStatus() { return status; }
    public Timestamp getApprovalDate() { return approvalDate; }

    // Setter for targetammount
    public void setTargetammount(double targetammount) {
        this.targetamount = targetammount;
    }
    // ... other setters
}