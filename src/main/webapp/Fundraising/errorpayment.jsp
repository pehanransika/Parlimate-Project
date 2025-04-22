<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 40px;
            background-color: #f5c6cb;
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
            background-color: #721c24;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #5a161d;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Payment Failed</h1>
    <p>Oops! Something went wrong while processing your payment.</p>
    <p>Please check your connection or try again later.</p>
    <%-- Show the error message passed from the servlet --%>
    <p>Error: ${errorMessage}</p>

    <a href="index.jsp" class="btn">Back to Home</a>
</div>

</body>
</html>
