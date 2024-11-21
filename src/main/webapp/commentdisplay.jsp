<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="/index/sidebar.jsp" %>

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
            padding: 15px;
            margin-bottom: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: relative;
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

        .action-buttons {
            margin-top: 10px;
            text-align: right;
        }

        .update-button {
            background-color: #6a0dad; /* Purple color */
            color: white;
            padding: 5px 10px;
            font-size: 14px;
            text-decoration: none;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }

        .delete-button {
            background-color: #FF5733;
            color: white;
            padding: 5px 10px;
            font-size: 14px;
            text-decoration: none;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .update-button:hover {
            background-color: #520c8a; /* Darker purple for hover effect */
        }

        .delete-button:hover {
            background-color: #c4401e;
        }

        .popup-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .popup {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            position: relative;
        }

        .popup .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
            font-size: 20px;
            background: none;
            border: none;
            color: #999;
        }

        .popup .close-btn:hover {
            color: #333;
        }

        .formSection {
            margin-bottom: 15px;
        }

        .formSection label {
            display: block;
            margin-bottom: 5px;
        }

        .formSection input, .formSection textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .popbtns {
            text-align: center;
            margin-top: 20px;
        }

        .post-btn {
            padding: 10px 20px;
            background-color: #6a5acd;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .post-btn:hover {
            background-color: #5b4ab5;
        }
    </style>
</head>
<body>

<div class="comments-section">
    <h2>Comments</h2>

    <!-- If there are comments, display them -->
    <c:forEach var="comment" items="${allcomments}">
        <div class="comment">
            <!-- Display the timestamp -->
            <span>${comment.datetime}</span>

            <!-- Display the comment content -->
            <p>${comment.content}</p>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <!-- Update Button -->
                <button class="update-button" onclick="openEditPopup('${comment.commentid}', '${comment.userid}', '${fn:escapeXml(comment.content)}', '${comment.datetime}')">
                    Update
                </button>

                <!-- Delete Button -->
                <form action="DeleteCommentServlet" method="post" style="display:inline;">
                    <input type="hidden" name="commentid" value="${comment.commentid}">
                    <button type="submit" class="delete-button">Delete</button>
                </form>
            </div>
        </div>
    </c:forEach>

    <!-- If no comments are available, show a default message -->
    <c:if test="${empty allcomments}">
        <p class="no-comments">No comments yet. Be the first to comment!</p>
    </c:if>
</div>

<!-- Edit Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <button class="close-btn" onclick="closeEditPopup()">×</button>
        <h3>Edit Comment</h3>
        <form action="UpdateCommentServlet" method="post">
            <input type="hidden" name="commentid" id="commentid">
            <input type="hidden" name="userid" id="userid">
            <div class="formSection">
                <label for="editContent">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>

            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<!-- Go Back Button -->
<div class="button-container">
    <a href="index.jsp" class="back-button">Go Back</a>
</div>

<script>
    function openEditPopup(commentid, userid, content, datetime) {
        document.getElementById('editPopup').style.display = 'flex';
        document.getElementById('commentid').value = commentid;
        document.getElementById('userid').value = userid;
        document.getElementById('editContent').value = content;
        document.getElementById('editDatetime').value = datetime.substring(0, 16); // Format datetime
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }
</script>

</body>
<script src="script.js"></script>
<script src="home.js"></script>
</html>
