
<%
    String requestId = request.getParameter("requestId"); // Get from URL
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>PayPal Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .payment-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #003087;
            margin-bottom: 30px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f8f8;
            width: 40%;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #009cde;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #007bb6;
        }
        .note {
            font-size: 14px;
            color: #666;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="payment-container">
    <h1>PayPal Payment</h1>

    <!-- ? Fixed action path -->
    <form action="${pageContext.request.contextPath}/AuthorizePaymentServlet" method="POST">

        <input type="hidden" name="requestId" value="<%= requestId %>" />

        <table>
            <tr>
                <th>Amount:</th>
                <td><input type="text" name="amount" value="10.00" required></td>
            </tr>
            <tr>
                <th>Currency:</th>
                <td>
                    <select name="currency" required>
                        <option value="USD" selected>USD ($)</option>
                        <option value="LKR">LKR (Rs)</option>
                    </select>
                </td>
            </tr>
        </table>

        <input type="submit" value="Proceed to PayPal" />
        <p class="note">You will be redirected to PayPal to complete your payment securely</p>
    </form>
</div>
</body>
</html>