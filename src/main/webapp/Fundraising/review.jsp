<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cardreq.OrderDetail" %>
<%
    OrderDetail order = (OrderDetail) request.getAttribute("orderDetail");
%>
<html>
<head>
    <title>Review Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
        }
        .info {
            margin: 10px 0;
        }
        .label {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Review Payment Details</h2>

    <div class="info"><span class="label">Transaction ID:</span> <%= order.getTransactionId() %></div>
    <div class="info"><span class="label">Amount:</span> <%= order.getAmount() %> <%= order.getCurrency() %></div>
    <div class="info"><span class="label">Request ID:</span> <%= order.getRequestId() %></div>
    <div class="info"><span class="label">Payment ID:</span> <%= order.getPaymentId() %></div>
    <div class="info"><span class="label">Created At:</span> <%= order.getCreateTime() %></div>

    <br><br>


    <form action="${pageContext.request.contextPath}/Fundraising/ConfirmPaymentServlet" method="POST">
        <input type="hidden" name="paymentId" value="<%= order.getPaymentId() %>">
        <input type="hidden" name="transactionId" value="<%= order.getTransactionId() %>">
        <input type="hidden" name="amount" value="<%= order.getAmount() %>">

        <input type="hidden" name="currency" value="<%= order.getCurrency() %>">
        <input type="hidden" name="requestid" value="<%=order.getRequestId()%>">
        <input type="hidden" name="createTime" value="<%= order.getCreateTime() %>">
        <button type="submit">Confirm Payment</button>
    </form>

</div>

</body>
</html>

