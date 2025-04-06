package fundreq;

import java.sql.Timestamp;

public class ApproveModel {
    private int requestid;

    private String title;
    private String description;
    private String contact_no;
    private String category;
    private double targetamount;
    private String attachment_url;
    private String photos;
    private String status;
    private Timestamp approvalDate;

    public ApproveModel(int requestid, String title, String description,
                        String contact_no, String category, double targetamount,
                        String attachment_url, String photos, Timestamp approvalDate) {
        this.requestid = requestid;

        this.title = title;
        this.description = description;
        this.contact_no = contact_no;
        this.category = category;
        this.targetamount = targetamount;
        this.attachment_url = attachment_url;
        this.photos = photos;
        this.status = "APPROVED";
        this.approvalDate = approvalDate;
    }

    // Getters
    public int getRequestId() { return requestid; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }

    public String getContact_no() {
        return contact_no;
    }
    public String getCategory() { return category; }
    public double getTargetamount() { return targetamount; }
    public String getAttachmentUrl() { return attachment_url; }
    public String getPhotos() { return photos; }
    public String getStatus() { return status; }
    public Timestamp getApprovalDate() { return approvalDate; }

    // Setters
    public void setRequestId(int requestid) { this.requestid = requestid; }

    public void setTitle(String title) { this.title = title; }
    public void setDescription(String description) { this.description = description; }

    public void setContact_no(String contact_no) {
        this.contact_no = contact_no;
    }
    public void setCategory(String category) { this.category = category; }
    public void setTargetamount(double targetamount) { this.targetamount = targetamount; }
    public void setAttachmentUrl(String attachment_url) { this.attachment_url = attachment_url; }
    public void setPhotos(String photos) { this.photos = photos; }
    public void setStatus(String status) { this.status = status; }
    public void setApprovalDate(Timestamp approvalDate) { this.approvalDate = approvalDate; }
}