<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Wrong Action</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 100px;
        }
        .btn {
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            background-color: black;
            color: white;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #a9a9a9; /* Ash color */
        }
    </style>
</head>
<body>
<h1>Invalid Request</h1>
<p>The action you tried to perform is not allowed.</p>

<button class="btn" onclick="history.back();">Go Back</button>
<a href="index.jsp">
    <button class="btn">Go Home</button>
</a>
</body>
</html>
