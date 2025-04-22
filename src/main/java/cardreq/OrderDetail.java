package cardreq;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderDetail {
    private String payment_id;
    private String transaction_id;
    private BigDecimal amount;
    private int requestid;
    private String currency;
    private Timestamp create_time;

    public OrderDetail() {}

    public OrderDetail(String payment_id, String transaction_id, BigDecimal amount, int requestid, String currency, Timestamp create_time) {
        this.payment_id = payment_id;
        this.transaction_id = transaction_id;
        this.amount = amount;
        this.requestid = requestid;
        this.currency = currency;
        this.create_time = create_time;
    }

    public String getPaymentId() {
        return payment_id;
    }

    public void setPaymentId(String payment_id) {
        this.payment_id = payment_id;
    }

    public String getTransactionId() {
        return transaction_id;
    }

    public void setTransactionId(String transaction_id) {
        this.transaction_id = transaction_id;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public  int getRequestId() {
        return requestid;
    }

    public void setRequestId(int requestid) {
        this.requestid = requestid;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public Timestamp getCreateTime() {
        return create_time;
    }

    public void setCreateTime(Timestamp create_time) {
        this.create_time = create_time;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + payment_id +
                ", transaction_id='" + transaction_id + '\'' +
                ", amount=" + amount +
                ", requestid=" + requestid +
                ", currency='" + currency + '\'' +
                ", createTime=" + create_time +
                '}';
    }
}
