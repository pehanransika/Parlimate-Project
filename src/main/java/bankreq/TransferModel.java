package bankreq;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class TransferModel {
    private Integer transfer_id;
    private Integer user_id;
    private Integer fundraiser_id;
    private BigDecimal amount;
    private String currency;
    private String receipt_image_path;

    private Timestamp transfer_date;




    public TransferModel(Integer transfer_id, Integer user_id, Integer fundraiser_id, BigDecimal amount, String currency,
                         String receipt_image_path,
                         Timestamp transfer_date) {
        this.transfer_id = transfer_id;
        this.user_id = user_id;
        this.fundraiser_id = fundraiser_id;
        this.amount = amount;
        this.currency = currency;
        this.receipt_image_path = receipt_image_path;
        this.transfer_date = transfer_date;
    }



    // Getters and Setters
    public Integer getTransfer_id() {
        return transfer_id;
    }

    public void setTransfer_id(Integer transfer_id) {
        this.transfer_id = transfer_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getFundraiser_id() {
        return fundraiser_id;
    }

    public void setFundraiser_id(Integer fundraiser_id) {
        this.fundraiser_id = fundraiser_id;
    }


    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getReceipt_image_path() {
        return receipt_image_path;
    }

    public void setReceipt_image_path(String receipt_image_path) {
        this.receipt_image_path = receipt_image_path;
    }



    public Timestamp getTransfer_date() {
        return transfer_date;
    }

    public void setTransfer_date(Timestamp transfer_date) {
        this.transfer_date = transfer_date;
    }


    // toString() method for debugging

}