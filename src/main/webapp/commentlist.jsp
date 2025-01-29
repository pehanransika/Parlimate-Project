<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>Comments Section</title>
    <style>
        .comments-section {
            width: 60%;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .comments-section h2 {
            margin-bottom: 20px;
        }

        .comment {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .comment:last-child {
            border-bottom: none;
        }

        .comment span {
            display: block;
            font-size: 0.9em;
            color: #555;
            margin-bottom: 5px;
        }

        .comment p {
            font-size: 1em;
            color: #333;
        }

        .no-comments {
            text-align: center;
            font-size: 1em;
            color: #888;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .back-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<a href="ViewCommentServlet" class="see-my-comments-button">
    <button class="see-my-comments-button">
        <i class="fa-solid fa-comment"></i>
        <span>See my Comments</span>
    </button>
</a>
<div class="comments-section">
    <h2>Comments</h2>

    <!-- If there are comments, display them -->
    <c:forEach var="comment" items="${allcomments}">
        <div class="comment">
            <!-- Display the timestamp -->
            <span>${comment.datetime}</span>

            <!-- Display the comment content -->
            <p>${comment.content}</p>
        </div>
    </c:forEach>

    <!-- If no comments are available, show a default message -->
    <c:if test="${empty allcomments}">
        <p class="no-comments">No comments yet. Be the first to comment!</p>
    </c:if>
</div>

<!-- Go Back Button -->
<div class="button-container">
    <a href="index.jsp" class="back-button">Go Back</a>
</div>

</body>
<script src="script.js"></script>
<script src="home.js"></script>
</html>
