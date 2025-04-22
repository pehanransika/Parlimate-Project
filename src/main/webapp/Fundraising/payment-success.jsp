<%@ page import="java.io.*, java.net.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Successful</title>
</head>
<body>

<%
    String tx = request.getParameter("tx");
    String identityToken = "YOUR_PDT_IDENTITY_TOKEN"; // ← Replace this with your real token

    if (tx != null && !tx.isEmpty()) {
        String query = "cmd=_notify-synch&tx=" + tx + "&at=" + identityToken;
        URL url = new URL("https://www.sandbox.paypal.com/cgi-bin/webscr");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setDoOutput(true);
        connection.setRequestMethod("POST");

        OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream());
        writer.write(query);
        writer.flush();

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String line;
        boolean success = false;
        String txn_id = null;

        while ((line = reader.readLine()) != null) {
            if (line.equals("SUCCESS")) {
                success = true;
            }
            if (line.startsWith("txn_id=")) {
                txn_id = line.substring(7);
            }
        }
        writer.close();
        reader.close();

        if (success && txn_id != null) {
%>
<h1>Thank You for Your Payment!</h1>
<p>Your transaction has been completed successfully.</p>
<p><strong>Transaction ID:</strong> <%= txn_id %></p>
<%
} else {
%>
<p>There was a problem verifying your transaction. Please contact support.</p>
<%
    }
} else {
%>
<p>No transaction ID received. Payment may not have been completed.</p>
<%
    }
%>

<a href="/your-app">Return to Home</a>
</body>
</html>

