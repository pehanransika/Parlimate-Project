package fundreq;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class RequestModel {
    private Integer requestId;        // Unique identifier for the request
    private Integer userId;           // User who submitted the request
    private String title;             // Campaign title
    private String description;       // Campaign details
    private String category;          // Campaign category
    private BigDecimal targetamount;  // Goal amount
    private String currency;          // Currency type
    private Timestamp datetime;       // Timestamp for when the request is created
    private String  attachment_url;
    private String contact_no;
    private String photos;
    private String name;
private String status;

    // Constructor
    public RequestModel(Integer requestId, Integer userId, String title, String description,
                        String category, BigDecimal targetamount, String currency, String contact_no,String photos,Timestamp datetime, String  attachment_url , String name,String status) {
        this.requestId = requestId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.category = category;
        this.targetamount = targetamount;
        this.currency = currency;
        this.datetime = datetime;
        this. attachment_url =  attachment_url;
        this.contact_no=contact_no;
        this.photos=photos;
        this.name = name;
        this.status=status;

    }

    public RequestModel() {

    }

    public RequestModel(int requestId, int user_id, String title, String description, String category, String contactNo, BigDecimal targetAmount, String currency, Timestamp datetime, String photos, String attachmentUrl) {
    }

    // Getters and Setters
    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getTargetAmount() {
        return targetamount;
    }

    public void setTargetAmount(BigDecimal targetAmount) {
        this.targetamount = targetAmount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public Timestamp getDatetime() {
        return datetime;
    }

    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }

    public String getContact_no(){return contact_no;}

    public void setContact_no(String contact_no){this.contact_no=contact_no;}

    public String getPhotos(){return photos;}

    public void setPhotos(String photos){this.photos=photos;}

    public String getAttachmentUrl() {
        return  attachment_url;
    }

    public void setAttachmentUrl(String  attachment_url) {
        this. attachment_url =  attachment_url;
    }

    public String getName() {
        return  name;
    }

    public void setName(String  name) {
        this. name =  name;
    }

    public String getStatus(){return status;}

    public void setStatus(String status){this.status=status;}


}
