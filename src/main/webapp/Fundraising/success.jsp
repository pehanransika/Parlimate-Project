<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Payment Successful</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      padding: 20px;
    }
    .success-box {
      background: white;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      text-align: center;
      max-width: 500px;
      width: 100%;
    }
    .success-icon {
      color: #28a745;
      font-size: 48px;
      margin-bottom: 20px;
    }
    h1 {
      color: #28a745;
      margin-bottom: 15px;
    }
    .btn {
      display: inline-block;
      background: #28a745;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 4px;
      margin-top: 20px;
      font-weight: bold;
      transition: background 0.3s;
    }
    .btn:hover {
      background: #218838;
    }
  </style>
</head>
<body>
<div class="success-box">
  <div class="success-icon">✓</div>
  <h1>Payment Successful!</h1>
  <p>Thank you for your donation. Your payment has been processed successfully.</p>
  <a href="/Parlimate/Fundraising/GetAllFundraisingApprovelServlet" class="btn">Go to Fundraisers</a>
</div>
</body>
</html>