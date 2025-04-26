<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/25/2025
  Time: 4:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meeting Management | Admin Dashboard</title>

    <!-- CSS Links -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/UserSupport/userSupport.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/index.css" />

    <!-- icons -->
    <link
            rel="stylesheet"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
    />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>

<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Home/GetAnalyticsCountServlet" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>users</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>fundraise management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet" class="nav-item f-row">
                    <i class="fa-regular fa-check-to-slot"></i>
                    <span>survey management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-cards-blank"></i>
                    <span>post management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/CommentManagement/CommentManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-comments"></i>
                    <span>Comment Management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-money-bill-transfer"></i>
                    <span>bank transfer management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row active" >
                    <i class="fa-regular fa-circle-check"></i>
                    <span>Meeting Management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetProfileListServlet" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>Profile Management</span>
                </a>
            </li>
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
            <li>
                <a href="#" class="f-row log-out" onclick="logoutUser()">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    log out
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="pageContent">
    <div class="container f-col">
        <div class="top f-row">
            <div class="page f-col">
                <div class="page-title capitalize">User Support Management</div>
                <div class="page-desc">
                    Manage User Support, answer questions
                </div>
            </div>
        </div>
        <div class="content f-col">
            <div class="topS f-row">
                <div class="show f-row">
                    Shows
                    <select name="rows" id="rows">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="50">50</option>
                    </select>
                    entries per page
                </div>

                <div class="actions f-row">
                    <div class="search-bar">
                        <label for="user-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </label>
                        <input
                                type="search"
                                placeholder="Search by topic"
                                name="user-search"
                                id="user-search"
                                oninput="searchByTopic()"
                        />
                    </div>
                    <div class="scheduled-meeting">
                        <button class="filter-btn f-row" id="schedule-btn" onclick="window.location.href='${pageContext.request.contextPath}/admin/Home/GetAnalyticsCountServlet'">
                            <i class="fa-solid fa-house"></i>
                            Home Page
                        </button>
                    </div>

                    <div class="status-filter">
                        <select id="status-filter" onchange="filterByStatus()">
                            <option value="all">All Inquiries</option>
                            <option value="accepted">Answered</option>
                            <option value="non-accepted">Not Answered</option>
                        </select>
                    </div>
                    <div class="status-filter">
                        <select id="sort-filter" onchange="sortByDate()">
                            <option value="asc">Sort by Date (Ascending)</option>
                            <option value="desc">Sort by Date (Descending)</option>
                        </select>
                    </div>
                </div>
            </div>
            <h2 class="section-title">User Inquiries</h2>

            <div class="total-records f-row">
                Total <span>${totalCount}</span> records
            </div>

            <div class="data f-col">
                <table class="users">
                    <thead>
                    <tr>
                        <td>Name</td>
                        <td>Email Address</td>
                        <td>Message</td>
                        <td>Submitted Date</td>
                        <td>Submitted Time</td>
                        <td>Answer</td>
                        <td>Answered?</td>
                        <td>Action</td>
                    </tr>
                    </thead>

                    <tbody id="meeting-table-body">
                    <c:forEach var="messages" items="${messages}">
                        <tr>
                            <td>${messages.name}</td>
                            <td>${messages.email}</td>
                            <td>${messages.message}</td>
                            <td>
                                <fmt:formatDate value="${messages.submittedAt}" pattern="dd MMM yyyy" />
                            </td>
                            <td>
                                <fmt:formatDate value="${messages.submittedAt}" pattern="hh:mm a" />
                            </td>
                            <td>${messages.answer}</td>
                            <td>${messages.answered}</td>
                            <td>
                                <button
                                        class="view-button"
                                        onclick="openPopup(
                                                '${messages.id}',
                                                '${messages.name}',
                                                '${messages.email}',
                                                '${messages.message}',
                                                '${messages.submittedAt}',
                                                '${messages.answer}',
                                                '${messages.answered}')"
                                >
                                    View
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="pagination capitalize f-row">
                    <span>prev</span>
                    <span class="curr-page">1</span>
                    <span>next</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Main Meeting Details Popup -->
<div id="popup-container" style="display: none;">
    <div class="popup-box">
        <h2>Support Message Details</h2>

        <form id="support-form" action="updateSupportServlet" method="post">
            <input type="hidden" name="id" id="form-id">
            <input type="hidden" name="name" id="form-name">
            <input type="hidden" name="email" id="form-email">
            <input type="hidden" name="message" id="form-message">
            <input type="hidden" name="date" id="form-date">
            <input type="hidden" name="time" id="form-time">

            <p><strong>Support Message ID :</strong> <span id="popup-id"></span></p>
            <p><strong>Name :</strong> <span id="popup-name"></span></p>
            <p><strong>Email :</strong> <span id="popup-email"></span></p>
            <p><strong>Message :</strong> <span id="popup-message"></span></p>
            <p><strong>Submitted Date :</strong> <span id="popup-date"></span></p>
            <p><strong>Submitted Time :</strong> <span id="popup-time"></span></p>

            <p><strong>Answer :</strong>
                <textarea name="answer" id="popup-answer-input" rows="4" cols="50" required></textarea>
            </p>

            <input type="hidden" name="answered" value="Yes">
            <div class="scheduled-meeting">
            <button type="submit">Submit Response</button>
            </div>
        </form>

        <br><br>
        <button onclick="closePopup()">Close</button>
    </div>
</div>

<script>
    // Display success or error messages as alerts
    <c:if test="${not empty param.success}">
    alert("${param.success}");
    </c:if>
    <c:if test="${not empty param.error}">
    alert("${param.error}");
    </c:if>

    function openPopup(id, name, email, message, submittedAt, answer, answered) {
        // Get the popup container and form elements
        const popupContainer = document.getElementById('popup-container');
        const answerInput = document.getElementById('popup-answer-input');
        const submitButton = document.querySelector('#support-form button[type="submit"]');

        // Populate the popup fields
        document.getElementById('popup-id').textContent = id;
        document.getElementById('popup-name').textContent = name;
        document.getElementById('popup-email').textContent = email;
        document.getElementById('popup-message').textContent = message;

        // Format the submittedAt date and time
        const dateObj = new Date(submittedAt);
        const formattedDate = dateObj.toLocaleDateString('en-GB', {
            day: '2-digit',
            month: 'short',
            year: 'numeric'
        });
        const formattedTime = dateObj.toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        });

        document.getElementById('popup-date').textContent = formattedDate;
        document.getElementById('popup-time').textContent = formattedTime;
        document.getElementById('popup-answer-input').value = answer || '';

        // Populate hidden form fields
        document.getElementById('form-id').value = id;
        document.getElementById('form-name').value = name;
        document.getElementById('form-email').value = email;
        document.getElementById('form-message').value = message;
        document.getElementById('form-date').value = formattedDate;
        document.getElementById('form-time').value = formattedTime;

        // Handle answered status
        if (answered === 'true' || answered === true) {
            answerInput.setAttribute('readonly', 'readonly');
            submitButton.setAttribute('disabled', 'disabled');
            submitButton.style.opacity = '0.5';
            submitButton.style.cursor = 'not-allowed';
        } else {
            answerInput.removeAttribute('readonly');
            submitButton.removeAttribute('disabled');
            submitButton.style.opacity = '1';
            submitButton.style.cursor = 'pointer';
        }

        // Show the popup
        popupContainer.style.display = 'flex';
    }

    function closePopup() {
        // Hide the popup
        document.getElementById('popup-container').style.display = 'none';

        // Clear the form
        document.getElementById('support-form').reset();
    }

    function searchByTopic() {
        // Get the search input value
        const searchInput = document.getElementById('user-search').value.toLowerCase();
        const rows = document.querySelectorAll('#meeting-table-body tr');

        rows.forEach(row => {
            // Get the name, email, and message columns (indices 0, 1, 2)
            const name = row.cells[0].textContent.toLowerCase();
            const email = row.cells[1].textContent.toLowerCase();
            const message = row.cells[2].textContent.toLowerCase();

            // Show row if search term matches name, email, or message
            if (name.includes(searchInput) || email.includes(searchInput) || message.includes(searchInput)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function filterByStatus() {
        // Get the selected filter value
        const filterValue = document.getElementById('status-filter').value;
        const rows = document.querySelectorAll('#meeting-table-body tr');

        rows.forEach(row => {
            // Get the answered status (index 6)
            const answered = row.cells[6].textContent.toLowerCase();

            // Show rows based on filter
            if (filterValue === 'all') {
                row.style.display = '';
            } else if (filterValue === 'accepted' && answered === 'true') {
                row.style.display = '';
            } else if (filterValue === 'non-accepted' && answered === 'false') {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function sortByDate() {
        // Get the selected sort value
        const sortValue = document.getElementById('sort-filter').value;
        const tbody = document.getElementById('meeting-table-body');
        const rows = Array.from(tbody.querySelectorAll('tr'));

        // Sort rows based on Submitted Date (index 3)
        rows.sort((a, b) => {
            // Extract date text from the Submitted Date column
            const dateA = a.cells[3].textContent.trim();
            const dateB = b.cells[3].textContent.trim();

            // Convert date strings (e.g., "12 Jan 2023") to Date objects
            const dateObjA = new Date(dateA);
            const dateObjB = new Date(dateB);

            // Sort ascending or descending
            return sortValue === 'asc' ? dateObjA - dateObjB : dateObjB - dateObjA;
        });

        // Clear the tbody and append sorted rows
        tbody.innerHTML = '';
        rows.forEach(row => tbody.appendChild(row));
    }
</script>
</body>
</html>