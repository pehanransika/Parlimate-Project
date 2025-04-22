<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Payment Cancelled</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #fff3cd;
      color: #856404;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 100px auto;
      padding: 40px;
      background-color: #ffeeba;
      border-radius: 10px;
      text-align: center;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    h1 {
      font-size: 28px;
      margin-bottom: 20px;
    }

    p {
      font-size: 16px;
      margin-bottom: 30px;
    }

    .btn {
      padding: 10px 20px;
      background-color: #856404;
      color: white;
      border: none;
      border-radius: 5px;
      text-decoration: none;
      font-size: 16px;
    }

    .btn:hover {
      background-color: #6c5203;
    }
  </style>
</head>
<body>

<div class="container">
  <h1>Payment Cancelled</h1>
  <p>You have cancelled the payment process.</p>
  <p>If this was unintentional, please try again.</p>
  <a href="index.jsp" class="btn">Back to Home</a>
</div>

</body>
</html>
