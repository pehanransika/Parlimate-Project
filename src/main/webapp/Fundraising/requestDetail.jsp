<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Posts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fb;
            margin: 20px;
            padding: 20px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-top: 80px;
        }

        .button-home {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .button-home:hover {
            background-color: #0056b3;
        }

        h2 {
            color: #3a3a3a;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Search Input Styles */
        #searchInput {
            width: 100%;
            max-width: 200px;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            margin-left: 250px;
        }

        #searchInput:focus {
            border-color: #007bff;
        }

        /* Fundraising Request List Styles */
        .request-list {
            list-style-type: none;
            padding: 0;
            margin-left: 300px;
            margin-right: 20px;
            gap: 1.5rem;
        }

        .request-item {
            background-color: #ffffff;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            position: relative;
            display: flex;
            cursor: pointer;
            flex-direction: column;
            gap: 15px;
        }

        .request-item:hover {
            outline: 1px solid rgb(185, 185, 185);
            border-left: 0.75rem solid #5490FF;
        }

        .request-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .request-info h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .request-info p {
            margin: 0;
            font-size: 14px;
            color: #888;
        }

        .request-content {
            margin-top: 10px;
            font-size: 16px;
            color: #555;
        }

        /* Button Styles */
        .request-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .button {
            border: none;
            padding: 10px 0; /* Adjusted padding for consistent height */
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            width: 100px; /* Ensures both buttons have the same width */
            height: 40px; /* Ensures both buttons have the same height */
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .button-update {
            background-color: #6a5acd; /* Light purple */
            color: white;
        }

        .button-update:hover {
            background-color: #5b4ab5;
        }

        .button-delete {
            background-color: #f44336; /* Red */
            color: white;
        }

        .button-delete:hover {
            background-color: #e53935;
        }

        /* Popup Modal Styles */
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
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./ann.css">
</head>

<body class="">

<%@ include file="../index/sidebar.jsp" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="./index.jsp">
                PARLIMATE
            </a>
        </div>
    </div>
    <div class="headerSearchBar row">
        <input type="search" name="mainSearch" id="headerSearchBar"
               placeholder="Search politicians, Political parties...." />
        <label for="headerSearchBar">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
    </div>
</div>

<div class="top-bar">
    <a href="index.jsp" class="button-home">Go to Home</a>
</div>

<h2>My Fundraising Requests</h2>

<!-- Search Bar -->
<input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">

<ul class="request-list">
    <c:forEach var="request" items="${allRequests}">
        <li class="request-item">
            <div class="request-header">
                <!-- Display Request Title and Timestamp -->
                <h3>${request.title}</h3>
                <p>${request.datetime}</p>
            </div>
            <div class="request-content">
                <!-- Display Request Details -->
                <p><strong>Description:</strong> ${request.description}</p>
                <p><strong>Category:</strong> ${request.category}</p>
                <p><strong>Target Amount:</strong> ${request.targetAmount} ${request.currency}</p>
                <p><strong>Attachment:</strong> <a href="${request.attachmentUrl}" target="_blank">View Attachment</a></p>
            </div>
            <div class="request-actions">
                <!-- Update Button triggers the popup modal with request data -->
                <button
                        class="button button-update"
                        onclick="openEditPopup(
                                '${request.requestId}',
                                '${request.title}',
                                '${fn:escapeXml(request.description)}',
                                '${request.category}',
                                '${request.targetAmount}',
                                '${request.currency}',
                                '${request.datetime}',
                                '${request.attachmentUrl}')">
                    Update
                </button>

                <!-- Delete Button -->
                <form action="DeleteRequestServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this request?');" style="display:inline;">
                    <input type="hidden" name="requestId" value="${request.requestId}" />
                    <button type="submit" class="button button-delete">Delete</button>
                </form>
            </div>
        </li>
    </c:forEach>
</ul>

<!-- Update Request Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <div class="title">
            <span>Edit Request</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>
        <form action="UpdateRequestServlet" method="post" enctype="multipart/form-data">
            <!-- Hidden field for request ID -->
            <input type="hidden" name="requestId" id="requestId" value="${requestId}" />

            <div class="formSection">
                <label for="editTitle">Title</label>
                <input type="text" id="editTitle" name="title" value="${title}" required />
            </div>

            <div class="formSection">
                <label for="editDescription">Description</label>
                <textarea id="editDescription" name="description" required>${description}</textarea>
            </div>

            <div class="formSection">
                <label for="editCategory">Category</label>
                <select id="editCategory" name="category" required>
                    <option value="" disabled>--Select a Category--</option>
                    <option value="Education" ${category == 'Education' ? 'selected' : ''}>Education</option>
                    <option value="Health" ${category == 'Health' ? 'selected' : ''}>Health</option>
                    <option value="Environment" ${category == 'Environment' ? 'selected' : ''}>Environment</option>
                    <option value="Community" ${category == 'Community' ? 'selected' : ''}>Community</option>
                </select>
            </div>

            <div class="formSection">
                <label for="editTargetAmount">Target Amount</label>
                <input type="number" id="editTargetAmount" name="targetAmount" value="${targetAmount}" step="0.01" required />
            </div>

            <div class="formSection">
                <label for="editCurrency">Currency</label>
                <select id="editCurrency" name="currency" required>
                    <option value="" disabled>--Select Currency--</option>
                    <option value="USD" ${currency == 'USD' ? 'selected' : ''}>USD</option>
                    <option value="EUR" ${currency == 'EUR' ? 'selected' : ''}>EUR</option>
                    <option value="INR" ${currency == 'INR' ? 'selected' : ''}>INR</option>
                    <option value="GBP" ${currency == 'GBP' ? 'selected' : ''}>GBP</option>
                </select>
            </div>

            <div class="formSection">
                <label for="editAttachment">Attachment URL</label>
                <input type="text" id="editAttachment" name="attachmentUrl" value="${attachmentUrl}" placeholder="Enter URL of attachment" />
                <input type="file" name="attachment" id="editAttachmentFile" />
            </div>

            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>

    </div>
</div>

<script>
    function openEditPopup(requestId, title, description, category, targetAmount, currency, datetime, attachment_url) {
        document.getElementById('editPopup').style.display = 'flex';

        document.getElementById('requestId').value = requestId;
        document.getElementById('editTitle').value = title;
        document.getElementById('editDescription').value = description;
        document.getElementById('editCategory').value = category;
        document.getElementById('editTargetAmount').value = targetAmount;
        document.getElementById('editCurrency').value = currency;
        document.getElementById('editAttachment').value = attachment_url;
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }

    function filterRequests() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const items = document.querySelectorAll('.request-item');

        items.forEach(item => {
            const title = item.querySelector('h3').textContent.toLowerCase();
            const description = item.querySelector('.request-content').textContent.toLowerCase();
            if (title.includes(input) || description.includes(input)) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
