<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>My fundraises</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./details.css">

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

<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <div class="pageTitles">
        <h2 class="title">My Fundraisers</h2>
        <div class="subTitle">
            Fueling Change Through Collective Action
        </div>
    </div>

    <div class="search">
        <label for="searchInput" class="icon">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
        <input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">
    </div>
    <ul class="request-list">
        <c:forEach var="request" items="${allRequests}">
            <li class="request-item col">
                <div class="request-header">
                    <span class="title">${request.title}</span>
                    <p class="date">${request.datetime}</p>
                </div>
                <div class="request-content col">
                    <p>Description: <span> ${request.description}</span></p>
                    <p>Category: <span> ${request.category}</span></p>
                    <p>Contact Number: <span> ${request.contact_no}</span></p>
                    <p>Target Amount: <span class="cap"> ${request.currency} ${request.targetAmount}</span></p>
                    <p>Attachment: <span> <a href="${request.attachmentUrl}" target="_blank">View Attachment</a> </span></p>
                    <p>Photos: <span> <a href="${request.photos}" target="_blank">View Photos</a> </span></p>
                <div class="seperator"></div>
                </div>
                <div class="request-actions row">
                    <button
                            class="button button-update"
                            onclick="openEditPopup(
                                    '${request.requestId}',
                                    '${request.title}',
                                    '${fn:escapeXml(request.description)}',
                                    '${request.category}',
                                     '${request.contact_no}',
                                    '${request.targetAmount}',
                                    '${request.currency}',
                                    '${request.datetime}',
                                    '${request.photos}',
                                    '${request.attachmentUrl}')">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Edit
                    </button>

                    <!-- Delete Button -->
                    <form action="DeleteRequestServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this request?');" style="display:inline;">
                        <input type="hidden" name="requestId" value="${request.requestId}" />
                        <button type="submit" class="button button-delete">
                            <i class="fa-classic fa-solid fa-trash fa-fw"></i>
                            Delete</button>
                    </form>
                </div>

            </li>
        </c:forEach>
    </ul>

</div>
<!-- Search Bar -->


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
                <label for="editContactNo">Contact NO</label>
                <textarea id="editContactNo" name="contact_no" required>${contact_no}</textarea>
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
            <div class="formSection">
                <label for="editPhotos">Photos</label>
                <input type="text" id="editPhotos" name="attachmentUrl" value="${photos}" placeholder="Enter URL of attachment" />
                <input type="file" name="attachment" id="editPhotoFile" />
            </div>

            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>

    </div>
</div>

<script>
    function openEditPopup(requestId, title, description, category,contact_no,photos, targetAmount, currency, datetime, attachment_url) {
        document.getElementById('editPopup').style.display = 'flex';

        document.getElementById('requestId').value = requestId;
        document.getElementById('editTitle').value = title;
        document.getElementById('editDescription').value = description;
        document.getElementById('editContactNo').value = contact_no;
        document.getElementById('editCategory').value = category;
        document.getElementById('editTargetAmount').value = targetAmount;
        document.getElementById('editCurrency').value = currency;
        document.getElementById('editAttachment').value = attachment_url;
        document.getElementById('editPhotos').value = photos;
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
<script src="../loadSidebar.js"></script>
<script>
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            if (body.classList.contains("sidebar-deactive")) {
                body.classList.remove("sidebar-deactive");
            } else {
                body.classList.add("sidebar-deactive");
            }
        })
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        })
    });
</script>
</html>
