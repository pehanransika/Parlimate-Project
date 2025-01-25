package fundreq;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class RequestModel {
    private Integer requestId;        // Unique identifier for the request
    private Integer userId;           // User who submitted the request
    private String title;             // Campaign title
    private String description;       // Campaign details
    private String category;          // Campaign category
    private BigDecimal targetAmount;  // Goal amount
    private String currency;          // Currency type
    private Timestamp datetime;       // Timestamp for when the request is created
    private String  attachment_url;     // URL to the attachment (file)
<<<<<<< HEAD
    private String name;

    // Constructor
    public RequestModel(Integer requestId, Integer userId, String title, String description,
                        String category, BigDecimal targetAmount, String currency, Timestamp datetime, String  attachment_url , String name) {
=======

    // Constructor
    public RequestModel(Integer requestId, Integer userId, String title, String description,
                        String category, BigDecimal targetAmount, String currency, Timestamp datetime, String  attachment_url) {
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
        this.requestId = requestId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.category = category;
        this.targetAmount = targetAmount;
        this.currency = currency;
        this.datetime = datetime;
        this. attachment_url =  attachment_url;  // New field
<<<<<<< HEAD
        this.name = name;
=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
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
        return targetAmount;
    }

    public void setTargetAmount(BigDecimal targetAmount) {
        this.targetAmount = targetAmount;
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

    public String getAttachmentUrl() {
        return  attachment_url;
    }

    public void setAttachmentUrl(String  attachment_url) {
        this. attachment_url =  attachment_url;
    }
<<<<<<< HEAD

    public String getName() {
        return  name;
    }

    public void setName(String  name) {
        this. name =  name;
    }
=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
}
