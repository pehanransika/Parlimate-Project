<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Surveysss Details</title>
</head>
<body>
<h1>Survey Details</h1>
${user.email}
${userProfile.politicianId}


<c:if test="${empty surveys}">
    <p>No surveys available.</p>
</c:if>

<!-- Iterate over the list of surveys -->
<c:forEach var="survey" items="${surveys}">
    <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 20px;">
        <p>usersss:${survey.user[0].name}</p>
        <h2>Survey: ${survey.surveyTopic}</h2>
        <p>Survey id : ${survey.surveyId}</p>
        <p>Created by User ID: ${survey.userId} on ${survey.createdAt}</p>
        <p>Number of Questions: ${survey.numberOfQuestions}</p>
        <c:forEach items="${survey.questions}" var="question">
        <div style="margin-bottom:20px;">
            <p>Question ${question.questionNumber}: ${question.questionText}</p>

            <!-- Loop through each answer for the current question -->
            <c:forEach items="${question.answers}" var="answer">
                <p>Answer ${answer.answerNumber}: ${answer.answerText}</p>
            </c:forEach>
        </div>
        </c:forEach>


</c:forEach>
</body>
</html>
