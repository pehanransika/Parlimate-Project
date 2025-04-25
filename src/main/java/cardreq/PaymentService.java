package cardreq;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class PaymentService{
    private static final String CLIENT_ID="AZ_rtWH4axaUp9AJCJGBcHtiehqLzeIk1UVC2oUOG-wvaPEwrnRzDde42FQZ9C0vDFGCNWv1fGFlM9iH";
    private static final String CLIENT_SECRET="ECmPft2P73gzkPORisZeL_NOszoetMqv6DD0X5PFlpFibblOXuXIZGTSxPlBV9SRRyheyUbGKS3HLKWI";

    private static final String MODE = "sandbox";


    public String authorizePayment(OrderDetail orderDetail) throws PayPalRESTException {
        try {
            Payer payer = getPayerInformation();
            RedirectUrls redirectUrls = getRedirectURLs(orderDetail);
            List<Transaction> listTransaction = getTransactionInformation(orderDetail);

            Payment requestPayment = new Payment();
            requestPayment.setTransactions(listTransaction);
            requestPayment.setRedirectUrls(redirectUrls);
            requestPayment.setPayer(payer);
            requestPayment.setIntent("authorize");

            APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

            Payment approvedPayment = requestPayment.create(apiContext);

            if (approvedPayment == null) {
                System.err.println(" PayPal returned null payment object.");
                return null;
            }

            String approvalLink = getApprovalLink(approvedPayment);
            if (approvalLink == null) {
                System.err.println(" Approval URL not found.");
                return null;
            }

            return approvalLink;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }



    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }

        return approvalLink;
    }
    private List<Transaction> getTransactionInformation(OrderDetail orderDetail) {
        // Calculate total amount in USD (convert if LKR)
        BigDecimal totalAmount;
        if ("LKR".equalsIgnoreCase(orderDetail.getCurrency())) {
            // Convert LKR to USD (using exchange rate 300 LKR = 1 USD)
            double exchangeRate = 300.0;
            totalAmount = BigDecimal.valueOf(orderDetail.getAmount().doubleValue() / exchangeRate)
                    .setScale(2, RoundingMode.HALF_UP);
        } else {
            totalAmount = orderDetail.getAmount().setScale(2, RoundingMode.HALF_UP);
        }

        // Create amount details - must sum to total amount
        Details details = new Details();
        details.setShipping("0.00");
        details.setTax("0.00");
        details.setSubtotal(totalAmount.toString()); // Subtotal must equal item total

        // Create amount object
        Amount amount = new Amount();
        amount.setCurrency("USD"); // Always use USD for PayPal
        amount.setTotal(totalAmount.toString());
        amount.setDetails(details);

        // Create single item
        Item item = new Item();
        item.setName("Payment");
        item.setCurrency("USD");
        item.setPrice(totalAmount.toString()); // Must match subtotal
        item.setQuantity("1");
        item.setTax("0.00");

        // Create item list
        ItemList itemList = new ItemList();
        itemList.setItems(Collections.singletonList(item));

        // Create transaction
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("Payment #" + orderDetail.getTransactionId());
        transaction.setItemList(itemList);

        return Collections.singletonList(transaction);
    }


    private RedirectUrls getRedirectURLs(OrderDetail orderDetail) {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/Parlimate/Fundraising/cancel.jsp");

        redirectUrls.setReturnUrl(
                "http://localhost:8080/Parlimate/Fundraising/ReviewPaymentServlet?requestId=" + orderDetail.getRequestId()
        );


        return redirectUrls;
    }

    public static Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext=new APIContext(CLIENT_ID,CLIENT_SECRET,MODE);
       return Payment.get(apiContext, String.valueOf(paymentId));
}

    private Payer getPayerInformation(){
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        PayerInfo payerInfo=new PayerInfo();
        payerInfo.setFirstName("Himasha");
        payerInfo.setLastName("Menmenda");
        payerInfo.setEmail("himashachinthani@gmail.com");

        payer.setPayerInfo(payerInfo);
return payer;
    }
}