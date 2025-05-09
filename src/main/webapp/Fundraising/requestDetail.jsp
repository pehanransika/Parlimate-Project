<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>My Fundraisers</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./details.css">

    <style>
        /* Full-screen modal overlay */
        .popup-modal {
            display: none;
            position: fixed;
            z-index: 9999;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            overflow-y: auto; /* Allows scrolling if content is too long */
        }


        /* Popup box */
        .popup {
            background-color: #fff;
            padding: 25px 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            max-height: 80vh; /* Allow the modal to grow up to 80% of the viewport height */
            overflow-y: auto; /* Enable vertical scrolling if content exceeds the height */
            position: relative;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.3s ease;
        }

        /* Close button styling */
        .popup .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: transparent;
            border: none;
            font-size: 18px;
            color: #444;
            cursor: pointer;
        }

        /* Form sections */
        .formSection {
            margin-bottom: 15px;
        }

        .formSection label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        .formSection input,
        .formSection textarea,
        .formSection select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .formSection input:focus,
        .formSection textarea:focus,
        .formSection select:focus {
            border-color: #6a5acd;
            outline: none;
        }

        /* Button container */
        .popbtns {
            text-align: center;
            margin-top: 20px;
        }

        /* Submit button */
        .post-btn {
            padding: 10px 20px;
            background-color: #6a5acd;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .post-btn:hover {
            background-color: #5b4ab5;
        }

        /* Optional fade-in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
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
                    <p>Description: <span>${request.description}</span></p>
                    <p>Category: <span>${request.category}</span></p>
                    <p>Contact Number: <span>${request.contact_no}</span></p>
                    <p>Target Amount: <span class="cap">${request.currency} ${request.targetAmount}</span></p>
                    <p>Attachment:
                        <c:if test="${not empty request.attachmentUrl}">
                            <a href="${pageContext.request.contextPath}/${request.attachmentUrl}" target="_blank">View Attachment</a>
                        </c:if>
                        <c:if test="${empty request.attachmentUrl}">
                            No attachment available
                        </c:if>
                    </p>
                    <p>Photos:
                        <c:if test="${not empty request.photos}">
                            <a href="${pageContext.request.contextPath}/${request.photos}" target="_blank">View Photos</a>
                        </c:if>
                        <c:if test="${empty request.photos}">
                            No photos available
                        </c:if>
                    </p>
                </div>
                <div class="request-actions row">
                    <button class="button button-update" onclick="openEditPopup(
                            '${request.requestId}', '${request.title}', '${fn:escapeXml(request.description)}',
                            '${request.category}', '${request.contact_no}', '${request.targetAmount}',
                            '${request.currency}', '${request.datetime}', '${request.photos}',
                            '${request.attachmentUrl}')">
                        <i class="fa-solid fa-pen-to-square"></i> Edit
                    </button>

                    <form action="DeleteRequestServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this request?');" style="display:inline;">
                        <input type="hidden" name="requestId" value="${request.requestId}" />
                        <button type="submit" class="button button-delete">
                            <i class="fa-solid fa-trash"></i> Delete
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
            <span>Edit Request</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>

        <form action="UpdateRequestServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="requestId" id="requestId" />

            <div class="formSection">
                <label for="editTitle">Title</label>
                <input type="text" id="editTitle" name="title" required />
            </div>

            <div class="formSection">
                <label for="editDescription">Description</label>
                <textarea id="editDescription" name="description" required></textarea>
            </div>

            <div class="formSection">
                <label for="editContactNo">Contact No</label>
                <input type="text" id="editContactNo" name="contact_no" required />
            </div>

            <div class="formSection">
                <label for="editCategory">Category</label>
                <select id="editCategory" name="category" required>
                    <option value="" disabled selected>--Select a Category--</option>
                    <option value="Education">Education</option>
                    <option value="Health">Health</option>
                    <option value="Environment">Environment</option>
                    <option value="Community">Community</option>
                </select>
            </div>

            <div class="formSection">
                <label for="editTargetAmount">Target Amount</label>
                <input type="number" id="editTargetAmount" name="targetAmount" step="0.01" required />
            </div>

            <div class="formSection">
                <label for="editCurrency">Currency</label>
                <select id="editCurrency" name="currency" required>
                    <option value="" disabled selected>--Select Currency--</option>
                    <option value="USD">LKR</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                    <option value="INR">INR</option>
                    <option value="GBP">GBP</option>
                </select>
            </div>

            <div class="formSection">
                <label for="editAttachmentUrl">Attachment URL</label>
                <input type="text" id="editAttachmentUrl" name="attachmentUrl" placeholder="Enter URL" />
                <input type="file" name="attachmentFile" />
            </div>

            <div class="formSection">
                <label for="editPhotoUrl">Photo URL</label>
                <input type="text" id="editPhotoUrl" name="photoUrl" placeholder="Enter photo URL" />
                <input type="file" name="photoFile" />
            </div>

            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Function to open the Edit Popup and pre-fill form fields
    function openEditPopup(requestId, title, description, category, contact_no, targetAmount, currency, datetime, photos, attachmentUrl) {
        console.log("openEditPopup called with:", requestId, title, description);

        const popup = document.getElementById('editPopup');

        if (popup) {
            popup.style.display = 'flex';
        }

        document.getElementById('requestId').value = requestId || '';
        document.getElementById('editTitle').value = title || '';
        document.getElementById('editDescription').value = description || '';
        document.getElementById('editContactNo').value = contact_no || '';
        document.getElementById('editCategory').value = category || '';
        document.getElementById('editTargetAmount').value = targetAmount || '';
        document.getElementById('editCurrency').value = currency || '';
        document.getElementById('editAttachmentUrl').value = attachmentUrl || '';
        document.getElementById('editPhotoUrl').value = photos || '';
    }

    // Function to close the Edit Popup
    function closeEditPopup() {
        console.log('closeEditPopup called');  // Debugging line

        const popup = document.getElementById('editPopup');

        if (!popup) {
            console.error('Popup modal element not found');
            return;
        }

        popup.style.display = 'none';
    }
    // Function to close the Edit Popup

    // Function to filter request cards/items by search input
    function filterRequests() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const items = document.querySelectorAll('.request-item');

        items.forEach(item => {
            const title = item.querySelector('.request-header .title')?.textContent.toLowerCase() || '';
            const description = item.querySelector('.request-content')?.textContent.toLowerCase() || '';
            const matches = title.includes(input) || description.includes(input);
            item.style.display = matches ? 'block' : 'none';
        });
    }
</script>

<script src="../loadSidebar.js"></script>
<script>
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            body.classList.toggle("sidebar-deactive");
        });
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        });
    });
</script>

</body>
</html>
