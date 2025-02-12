<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("index.jsp");
        return;
    }%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcement Published</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: green;
        }
        p {
            text-align: center;
            font-size: 1.2em;
        }
        .button {
            display: block;
            width: 100%;
            text-align: center;
            margin-top: 20px;
        }
        .button a {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .button a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Announcement Published Successfully!</h2>
    <p>Your announcement has been published successfully.</p>

    <div class="button">
        <!-- Changed link from index.jsp to announcements.jsp -->
        <a href="announcements.jsp">Go Back to Announcements</a>
    </div>
</div>

</body>
</html>
