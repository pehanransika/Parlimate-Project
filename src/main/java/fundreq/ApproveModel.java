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
    private String name;
    private int userid;
    private double totalLkr;


    public ApproveModel(int requestid, String title, String description,
                        String contact_no, String category, double targetamount,String status,
                        String attachment_url, String photos, Timestamp approvalDate,String name,int userid) {
        this.requestid = requestid;

        this.title = title;
        this.description = description;
        this.contact_no = contact_no;
        this.category = category;
        this.targetamount = targetamount;
        this.attachment_url = attachment_url;
        this.photos = photos;
        this.status = status;
        this.approvalDate = approvalDate;
        this.name=name;
        this.userid=userid;
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
    public String getName(){return name;}
    public int getUserid(){return userid;}

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
    public void setName(String name){this.name=name;}
    public void setUserid(int userid){this.userid=userid;}


    public double getTotalLkr() {
        return totalLkr;
    }

    public void setTotalLkr(double totalLkr) {
        this.totalLkr = totalLkr;
    }
}