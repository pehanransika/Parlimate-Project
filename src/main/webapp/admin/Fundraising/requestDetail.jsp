<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home | Admin Dashboard</title>

    <link rel="stylesheet" href="./home.css">
    <link rel="stylesheet" href="../index.css">

    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />

    <style>
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
        }

        .formSection {
            margin-bottom: 15px;
        }

        .formSection label {
            display: block;
            margin-bottom: 5px;
        }

        .formSection input, .formSection textarea, .formSection select {
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

<div class="navMenu f-col center">
    <div class="logo">
        <img src="../assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li><a href="#" class="nav-item f-row active"><i class="fa-regular fa-house"></i> <span>Home</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-users"></i> <span>User Management</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-briefcase"></i> <span>Fundraise Management</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-check-to-slot"></i> <span>Survey Management</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-cards-blank"></i> <span>Post Management</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-circle-check"></i> <span>Requests</span></a></li>
            <li><a href="#" class="nav-item f-row"><i class="fa-regular fa-sliders-up"></i> <span>Platform Settings</span></a></li>
        </ul>
        <ul>
            <li>
                <a href="#" class="f-row profile">
                    <div class="p-img"></div>
                    <div class="sUser f-col">
                        <div class="name">Naleeka Kumarasinghe</div>
                        <div class="role">Admin</div>
                    </div>
                </a>
            </li>
            <li><a href="#" class="f-row log-out"><i class="fa-solid fa-right-from-bracket"></i> Log Out</a></li>
        </ul>
    </div>
</div>

<div class="search">
    <label for="searchInput" class="icon">
        <i class="fa-solid fa-magnifying-glass"></i>
    </label>
    <input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">
</div>

<c:choose>
    <c:when test="${not empty allRequests}">
        <ul class="request-list">
            <c:forEach var="request" items="${allRequests}">
                <li class="request-item col">
                    <div class="request-header">
                        <span class="title">${fn:escapeXml(request.title)}</span>
                        <p class="date">${request.datetime}</p>
                    </div>
                    <div class="request-content col">
                        <p>Description: <span>${fn:escapeXml(request.description)}</span></p>
                        <p>Category: <span>${request.category}</span></p>
                        <p>Target Amount: <span class="cap">${request.currency} ${request.targetAmount}</span></p>
                        <p>Attachment:
                            <c:choose>
                                <c:when test="${not empty request.attachmentUrl}">
                                    <a href="${fn:escapeXml(request.attachmentUrl)}" target="_blank">View Attachment</a>
                                </c:when>
                                <c:otherwise>
                                    No Attachment
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div class="seperator"></div>
                    </div>
                    <div class="request-actions row">
                        <button class="button button-update"
                                onclick="openEditPopup('${fn:escapeXml(request.requestId)}',
                                        '${fn:escapeXml(request.title)}',
                                        '${fn:escapeXml(request.description)}',
                                        '${request.category}',
                                        '${request.targetAmount}',
                                        '${request.currency}',
                                        '${request.datetime}',
                                        '${fn:escapeXml(request.attachmentUrl)}')">
                            <i class="fa-solid fa-pen-to-square"></i> Edit
                        </button>
                        <form action="DeleteRequestServlet" method="post"
                              onsubmit="return confirm('Are you sure you want to delete this request?');"
                              style="display:inline;">
                            <input type="hidden" name="requestId" value="${request.requestId}" />
                            <button type="submit" class="button button-delete">
                                <i class="fa-solid fa-trash fa-fw"></i> Delete
                            </button>
                        </form>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <p>No fundraising requests found.</p>
    </c:otherwise>
</c:choose>

</body>
</html>
