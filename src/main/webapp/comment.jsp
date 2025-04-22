<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Comments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f5;
            padding: 30px;
        }
        ul.comment-list {
            list-style: none;
            padding: 0;
        }
        .comment-item {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 20px;
        }
        .comment-header {
            font-weight: bold;
            font-size: 18px;
            color: #333;
            display: flex;
            justify-content: space-between;
        }
        .comment-text {
            margin: 15px 0;
            font-size: 16px;
            color: #444;
        }
        .comment-footer {
            font-size: 14px;
            color: #777;
        }
        .comment-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        .button {
            padding: 6px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .button-edit {
            background-color: #4caf50;
            color: white;
        }
        .button-delete {
            background-color: #f44336;
            color: white;
        }
        .button-update {
            background-color: #28a745;
            color: white;
        }

        /* Modal Styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            width: 400px;
            position: relative;
        }
        .modal-header {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .modal-footer {
            margin-top: 15px;
            text-align: right;
        }
        .close {
            position: absolute;
            top: 8px;
            right: 12px;
            font-size: 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h2>All Comments</h2>

<ul class="comment-list">
    <c:forEach var="comment" items="${allComment}">
        <li class="comment-item">
            <div class="comment-header">
                <span>Username: ${comment.name}</span>
            </div>

            <div class="comment-text">
                    ${fn:escapeXml(comment.content)}
            </div>

            <div class="comment-footer">
                Posted on: ${comment.time}
            </div>

            <div class="comment-actions">
                <c:if test="${userProfile.userId == comment.userid}">
                    <!-- Update Button triggers popup -->
                    <button type="button" class="button button-update"
                            onclick="openUpdateModal('${comment.commentid}', '${fn:escapeXml(comment.content)}', '${fn:escapeXml(comment.name)}')">
                        <i class="fa-solid fa-pen-to-square"></i> Update
                    </button>

                    <!-- Delete Form -->
                    <form action="DeleteNewCommentServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this comment?');">
                        <input type="hidden" name="commentId" value="${comment.commentid}" />
                        <button type="submit" class="button button-delete">
                            <i class="fa-solid fa-trash"></i> Delete
                        </button>
                    </form>
                </c:if>
            </div>
        </li>
    </c:forEach>
</ul>

<!-- Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header">Update Comment</div>
        <form action="UpdateNewCommentServlet" method="post">
            <input type="hidden" name="commentid" id="modalCommentId">

            <label>Username:</label>
            <input type="text" id="modalUsername" disabled style="width:100%; margin-bottom: 10px;" />

            <label for="modalContent">Comment:</label>
            <textarea name="content" id="modalContent" rows="4" style="width:100%;" required></textarea>

            <div class="modal-footer">
                <button type="submit" class="button button-update">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openUpdateModal(commentId, content, username) {
        document.getElementById('modalCommentId').value = commentId;
        document.getElementById('modalContent').value = content;
        document.getElementById('modalUsername').value = username;
        document.getElementById('updateModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('updateModal').style.display = 'none';
    }
</script>

</body>
</html>
