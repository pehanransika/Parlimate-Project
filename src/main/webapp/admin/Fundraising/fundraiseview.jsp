<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Fundraising Request Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }

        .fundraise-view-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 30px;
        }

        .fundraise-view-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 40px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card-title {
            font-weight: bold;
            color: black;
            margin-bottom: 8px;
        }

        .card-content {
            color: #444;
            font-size: 16px;
        }

        .actions {
            text-align: center;
            margin-top: 30px;
        }

        .back-button {
            text-decoration: none;
            padding: 12px 25px;
            background-color: black;
            color: white;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: black;
        }
    </style>
</head>
<body>

<div class="fundraise-view-container">
    <h2>Fundraising Request Details</h2>
    <c:forEach var="fund" items="${allapprovalFundraisings}">
        <div class="card">
            <div class="card-title">Title:</div>
            <div class="card-content">${fund.title}</div>
        </div>

        <div class="card">
            <div class="card-title">Description:</div>
            <div class="card-content">${fund.description}</div>
        </div>
        <div class="card">
            <div class="card-title">Fundraiser name:</div>
            <div class="card-content">${fund.name}</div>
        </div>
        <div class="card">
            <div class="card-title">Contact Number:</div>
            <div class="card-content">${fund.contact_no}</div>
        </div>

        <div class="card">
            <div class="card-title">Category:</div>
            <div class="card-content">${fund.category}</div>
        </div>
        <div class="card">
            <div class="card-title">Target Amount:</div>
            <div class="card-content">${fund.targetAmount}</div>
        </div>



        <div class="card">
            <div class="card-title">Attachment:</div>
            <div class="card-content">
                <c:choose>
                    <c:when test="${not empty fund.attachmentUrl}">
                        <a href="${pageContext.request.contextPath}/${fund.attachmentUrl}" target="_blank">View Attachment</a>
                    </c:when>
                    <c:otherwise>
                        <span>No attachment</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="card">
            <div class="card-title">Photo:</div>
            <div class="card-content">
                <c:choose>
                    <c:when test="${not empty fund.photos}">
                        <a href="${pageContext.request.contextPath}/${fund.photos}" target="_blank">View Photo</a>
                    </c:when>
                    <c:otherwise>
                        <span>No photo</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="card">
            <div class="card-title">Status:</div>
            <div class="card-content">${fund.status}</div>
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="back-button">Back to All Requests</a>
        </div>
    </c:forEach>
</div>

</body>
</html>
