package cardreq;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class PaymentService{
    private static final String CLIENT_ID="AZ_rtWH4axaUp9AJCJGBcHtiehqLzeIk1UVC2oUOG-wvaPEwrnRzDde42FQZ9C0vDFGCNWv1fGFlM9iH";
    private static final String CLIENT_SECRET="ECmPft2P73gzkPORisZeL_NOszoetMqv6DD0X5PFlpFibblOXuXIZGTSxPlBV9SRRyheyUbGKS3HLKWI";

    private static final String MODE = "sandbox";


    public String authorizePayment(OrderDetail orderDetail) throws PayPalRESTException {
        try {
            Payer payer = getPayerInformation();
            RedirectUrls redirectUrls = getRedirectURLs(orderDetail); // ✅ pass orderDetail here
            List<Transaction> listTransaction = getTransactionInformation(orderDetail);

            Payment requestPayment = new Payment();
            requestPayment.setTransactions(listTransaction);
            requestPayment.setRedirectUrls(redirectUrls);
            requestPayment.setPayer(payer);
            requestPayment.setIntent("authorize");

            APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

            Payment approvedPayment = requestPayment.create(apiContext);

            if (approvedPayment == null) {
                System.err.println("❌ PayPal returned null payment object.");
                return null;
            }

            String approvalLink = getApprovalLink(approvedPayment);
            if (approvalLink == null) {
                System.err.println("❌ Approval URL not found.");
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
        // Create amount details (simplified since we don't have breakdown)
        Details details = new Details();
        details.setShipping(String.valueOf(BigDecimal.ZERO));  // No shipping info available
        details.setSubtotal(String.valueOf(orderDetail.getAmount())); // Using total as subtotal
        details.setTax(String.valueOf(BigDecimal.ZERO));      // No tax info available

        // Create amount object
        Amount amount = new Amount();
        amount.setCurrency(orderDetail.getCurrency()); // Use currency from order
        amount.setTotal(String.valueOf(orderDetail.getAmount()));
        amount.setDetails(details);

        // Create transaction
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("Payment #" + orderDetail.getTransactionId());

        // Create item list (simplified with single item)
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();

        Item item = new Item();
        item.setCurrency(orderDetail.getCurrency());
        item.setName("Payment");  // Generic name since no product info
        item.setPrice(String.valueOf(orderDetail.getAmount()));
        item.setTax(String.valueOf(BigDecimal.ZERO));
        item.setQuantity("1");

        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);

        // Return as list with single transaction
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;
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