package bankreq;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ApprovedTransferModel {
    private   int transfer_id;
    private int user_id;
    private int fundraiser_id;
    private String bank_name;
    private String account_holder_name;
    private String account_number;
    private String branch;
    private BigDecimal amount;
    private String currency;
    private String receipt_image_path;
    private String reference_code;
    private Integer verified_by;
    private Timestamp verified_at;
    private Timestamp transfer_date;

    public ApprovedTransferModel(int transfer_id, int user_id, int fundraiser_id,
                                 String bank_name, String account_holder_name, String account_number,
                                 String branch, BigDecimal amount, String currency,
                                 String receipt_image_path, String reference_code,
                                 Timestamp transfer_date, Integer verified_by, Timestamp verified_at) {
        this.transfer_id = transfer_id;
        this.user_id = user_id;
        this.fundraiser_id = fundraiser_id;
        this.bank_name = bank_name;
        this.account_holder_name = account_holder_name;
        this.account_number = account_number;
        this.branch = branch;
        this.amount = amount;
        this.currency = currency;
        this.receipt_image_path = receipt_image_path;
        this.reference_code = reference_code;
        this.transfer_date = transfer_date;
        this.verified_by = verified_by;
        this.verified_at = verified_at;
    }

    public ApprovedTransferModel(int transferId, int fundraiserId, String bankName, String accountHolderName, String accountNumber, String branch, BigDecimal amount, String currency, String receiptImagePath, String referenceCode, Timestamp transferDate, int verifiedBy, Timestamp verified_at, int user_id) {
    }



    // Getters and Setters
    public int getTransfer_id() {
        return transfer_id;
    }


    public void setTransfer_id(int transfer_id) {
        this.transfer_id = transfer_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getFundraiser_id() {
        return fundraiser_id;
    }

    public void setFundraiser_id(int fundraiser_id) {
        this.fundraiser_id = fundraiser_id;
    }

    public String getBank_name() {
        return bank_name;
    }

    public void setBank_name(String bank_name) {
        this.bank_name = bank_name;
    }

    public String getAccount_holder_name() {
        return account_holder_name;
    }

    public void setAccount_holder_name(String account_holder_name) {
        this.account_holder_name = account_holder_name;
    }

    public String getAccount_number() {
        return account_number;
    }

    public void setAccount_number(String account_number) {
        this.account_number = account_number;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
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

    public String getReference_code() {
        return reference_code;
    }

    public void setReference_code(String reference_code) {
        this.reference_code = reference_code;
    }

    public Integer getVerified_by() {
        return verified_by;
    }

    public void setVerified_by(Integer verified_by) {
        this.verified_by = verified_by;
    }

    public Timestamp getVerified_at() {
        return verified_at;
    }

    public void setVerified_at(Timestamp verified_at) {
        this.verified_at = verified_at;
    }

    public Timestamp getTransfer_date() {
        return transfer_date;
    }

    public void setTransfer_date(Timestamp transfer_date) {
        this.transfer_date = transfer_date;
    }
}