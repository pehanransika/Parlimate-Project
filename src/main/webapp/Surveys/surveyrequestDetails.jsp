<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>My Survey Requests</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="details.css">
</head>

<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <div class="pageTitles">

        <br>
        <h2 class="title">My Survey Requests</h2>
        <div class="subTitle">Manage your survey requests</div>
    </div>

    <ul class="request-list">
        <c:forEach var="request" items="${allSurveyRequests}">
            <li class="request-item col">
                <div class="request-header">
                    <span class="title">Request ID: ${request.surveyRequestId}</span>
                    <p class="date">Requested on: ${request.requestTime}</p>
                </div>
                <div class="request-content col">
                    <p>User ID: <span>${request.userId}</span></p>
                    <p>Question Text: <span>${request.questionText}</span></p>
                    <p>Answer 1: <span>${request.answer01}</span></p>
                    <p>Answer 2: <span>${request.answer02}</span></p>
                    <p>Answer 3: <span>${request.answer03}</span></p>
                    <p>Answer 4: <span>${request.answer04}</span></p>
                </div>
                <div class="request-actions row">
                    <button class="button button-update"
                            onclick="openEditPopup(
                                    '${request.surveyRequestId}',
                                    '${request.userId}',
                                    '${fn:escapeXml(request.questionText)}',
                                    '${request.answer01}',
                                    '${request.answer02}',
                                    '${request.answer03}',
                                    '${request.answer04}',
                                    '${request.requestTime}')">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Edit
                    </button>

                    <form action="DeleteSurveyRequestServlet" method="post"
                          onsubmit="return confirm('Are you sure you want to delete this request?');"
                          style="display:inline;">
                        <input type="hidden" name="surveyRequestId" value="${request.surveyRequestId}" />
                        <button type="submit" class="button button-delete">
                            <i class="fa-solid fa-trash"></i>
                            Delete
                        </button>
                    </form>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>

<!-- Update Request Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <div class="title">
            <span>Edit Survey Request</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <form action="UpdateSurveyRequestServlet" method="post">
            <input type="hidden" name="surveyRequestId" id="surveyRequestId" />
            <div class="formSection">
                <label for="editUserId">User ID</label>
                <input type="text" id="editUserId" name="userId" required />
            </div>
            <div class="formSection">
                <label for="editQuestionText">Question Text</label>
                <textarea id="editQuestionText" name="questionText" required></textarea>
            </div>
            <div class="formSection">
                <label for="editAnswer01">Answer 1</label>
                <input type="text" id="editAnswer01" name="answer01" required />
            </div>
            <div class="formSection">
                <label for="editAnswer02">Answer 2</label>
                <input type="text" id="editAnswer02" name="answer02" required />
            </div>
            <div class="formSection">
                <label for="editAnswer03">Answer 3</label>
                <input type="text" id="editAnswer03" name="answer03" required />
            </div>
            <div class="formSection">
                <label for="editAnswer04">Answer 4</label>
                <input type="text" id="editAnswer04" name="answer04" required />
            </div>
            <div class="formSection">
                <label for="editRequestTime">Request Time</label>
                <input type="datetime-local" id="editRequestTime" name="requestTime" required />
            </div>
            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditPopup(surveyRequestId, userId, questionText, answer01, answer02, answer03, answer04, requestTime) {
        document.getElementById('editPopup').style.display = 'flex';
        document.getElementById('surveyRequestId').value = surveyRequestId;
        document.getElementById('editUserId').value = userId;
        document.getElementById('editQuestionText').value = questionText;
        document.getElementById('editAnswer01').value = answer01;
        document.getElementById('editAnswer02').value = answer02;
        document.getElementById('editAnswer03').value = answer03;
        document.getElementById('editAnswer04').value = answer04;
        document.getElementById('editRequestTime').value = requestTime;
    }
    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }
</script>

</body>
</html>