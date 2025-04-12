<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Approved Fundraisers</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/approved.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <h1><i class="fas fa-check-circle"></i> My Approved Fundraisers</h1>

    <div class="fundraiser-list">
        <c:forEach var="fund" items="${fundraisingRequests}">
            <div class="fundraiser-card">
                <div class="fundraiser-image" style="background-image: url('${fund.photos}')"></div>
                <div class="fundraiser-details">
                    <span class="category">${fund.category}</span>
                    <h3>${fund.title}</h3>
                    <p>${fund.description}</p>
                    <div class="fundraiser-meta">
                        <span><i class="fas fa-dollar-sign"></i> ${fund.targetamount}</span>
                        <a href="ViewFundraiserDetails?id=${fund.requestid}" class="view-button">
                            View <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>