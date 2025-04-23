<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meeting Management | Admin Dashboard</title>

    <!-- CSS Links -->
    <link rel="stylesheet" href="admin/meetingManagement/meetingManagement.css" />
    <link rel="stylesheet" href="admin/index.css" />

    <!-- fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link
            rel="stylesheet"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
    />

    <!-- icons -->
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

    <!-- Inline CSS for filter and popup styling -->
    <style>
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-right: 10px;
        }
        .filter-group label {
            margin-right: 5px;
        }
        .filter-group input, .filter-group select {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .clear-btn {
            background-color: #ff4d4d;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .clear-btn:hover {
            background-color: #cc0000;
        }
        .email-list-popup {
            z-index: 1000;
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.6);
            display: none;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }
        .email-list-popup.active {
            display: flex;
        }
        .email-list-popup .popup-container {
            background: var(--main-color, white); /* Fallback to white */
            border-radius: 1rem;
            max-width: 40rem;
            width: 100%;
            padding: 2rem;
            box-shadow: 0 0 1rem rgba(0, 0, 0, 0.15);
            animation: zoomin 0.3s ease forwards;
            border: 1px solid rgb(217, 217, 217);
        }
        .email-list-popup .head {
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            display: flex;
        }
        .email-list-popup .title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-color, #1e3a8a); /* Fallback color */
        }
        .email-list-popup .cls-btn {
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0.5rem;
            transition: background 0.2s ease;
        }
        .email-list-popup .cls-btn:hover {
            background: rgba(0, 0, 0, 0.05);
        }
        .email-list-popup .content {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .email-list-popup .body {
            font-size: 0.95rem;
            color: #444;
        }
        .email-list-popup .btns {
            justify-content: flex-end;
            margin-top: 2rem;
            display: flex;
        }
        .email-list-popup .btns button.close {
            background: var(--primary-color, #1e3a8a); /* Fallback color */
            color: var(--main-color, white);
            border: none;
            border-radius: 0.5rem;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .email-list-popup .btns button.close:hover {
            background: #2a4edc;
        }
        @keyframes zoomin {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="<%= request.getContextPath() %>/admin/assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="<%= request.getContextPath() %>/Home/index.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>Home</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/userManagment.jsp" class="nav-item f-row active">
                    <i class="fa-regular fa-users"></i>
                    <span>User Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>Fundraise Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-check-to-slot"></i>
                    <span>Survey Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-cards-blank"></i>
                    <span>Post Management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/meetingManagement/meetingManagement.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>Meeting Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>Platform Settings</span>
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
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="f-row log-out">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Log out
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="pageContent">
    <div class="container f-col">
        <div class="top f-row">
            <div class="page f-col">
                <div class="page-title capitalize">Meeting Management</div>
                <div class="page-desc">
                    Manage meeting requests, schedule meetings.
                </div>
            </div>
        </div>
        <div class="content f-col">
            <div class="topS f-row">
                <div class="show f-row">
                    Shows
                    <select name="rows" id="rows" onchange="applyFilters()">
                        <option value="10" ${param.rows == '10' ? 'selected' : ''}>10</option>
                        <option value="20" ${param.rows == '20' ? 'selected' : ''}>20</option>
                        <option value="50" ${param.rows == '50' ? 'selected' : ''}>50</option>
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
                                placeholder="Search by topic or date"
                                name="user-search"
                                id="user-search"
                                oninput="filterTable()"
                        />
                    </div>
                    <div class="filter-group">
                        <label for="filter-date">Date:</label>
                        <input
                                type="date"
                                id="filter-date"
                                name="filterDate"
                                value="${param.filterDate}"
                                onchange="applyFilters()"
                        />
                    </div>
                    <div class="filter-group">
                        <label for="filter-type">Type:</label>
                        <select id="filter-type" name="filterType" onchange="applyFilters()">
                            <option value="" ${empty param.filterType ? 'selected' : ''}>All</option>
                            <option value="Online" ${param.filterType == 'Online' ? 'selected' : ''}>Online</option>
                            <option value="In-Person" ${param.filterType == 'In-Person' ? 'selected' : ''}>In-Person</option>
                            <option value="Hybrid" ${param.filterType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                        </select>
                    </div>
                    <button class="clear-btn" onclick="clearFilters()">Clear Filters</button>
                    <div class="scheduled-meeting">
                        <button class="filter-btn f-row" id="request-btn">
                            <i class="fa-solid fa-filter"></i>
                            Meeting Requests
                        </button>
                    </div>
                    <button class="add-btn f-row">
                        <i class="fa-sharp fa-solid fa-plus"></i>
                        Schedule Meeting
                    </button>
                </div>
            </div>
            <h2 class="section-title">Scheduled Meetings</h2>
            <div class="total-records f-row">
                Total <span>${totalCount}</span> records
            </div>

            <div class="data f-col">
                <table class="users" id="meetings-table">
                    <thead>
                    <tr>
                        <td>Meeting ID</td>
                        <td>Politician ID</td>
                        <td>Topic</td>
                        <td>Description</td>
                        <td>Date</td>
                        <td>Time</td>
                        <td>Host</td>
                        <td>Platform</td>
                        <td>Deadline</td>
                        <td>Available Slots</td>
                        <td>Registered Users</td>
                        <td>Wishlist</td>
                        <td>Action</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="meetings" items="${allMeetings}">
                        <tr>
                            <td>${meetings.meetingId}</td>
                            <td>${meetings.politicianId}</td>
                            <td>${meetings.topic}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:length(meetings.description) > 50}">
                                        ${fn:substring(meetings.description, 0, 50)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${meetings.description}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${meetings.date}</td>
                            <td>${meetings.time}</td>
                            <td>${meetings.host}</td>
                            <td>${meetings.platform}</td>
                            <td>${meetings.deadlinetoregister}</td>
                            <td>${meetings.availableSlots}</td>
                            <td>
                                <form action="GetRegisteredUserServlet" method="get">
                                    <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                    <button type="submit">View</button>
                                </form>
                            </td>
                            <td>
                                <form action="GetRegisteredWishlistServlet" method="get">
                                    <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                    <button type="submit">View</button>
                                </form>
                            </td>
                            <td>
                                <button onclick="showMeetingDetails('${meetings.meetingId}', '${meetings.politicianId}', '${fn:escapeXml(meetings.topic)}', '${fn:escapeXml(meetings.description)}', '${meetings.date}', '${meetings.time}', '${meetings.typeofthemeeting}', '${fn:escapeXml(meetings.host)}', '${meetings.platform}', '${meetings.deadlinetoregister}', '${meetings.slots}', '${meetings.availableSlots}')" style="color: blue; margin-right: 5px;">View Details</button>
                                <form action="SendDeleteEmailServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this meeting?');" style="display: inline;">
                                    <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                    <button type="submit" style="color: red;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="pagination capitalize f-row">
                    <c:set var="pageSize" value="${param.rows != null ? param.rows : 10}" />
                    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                    <c:set var="totalPages" value="${(totalCount + pageSize - 1) / pageSize}" />
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}&rows=${pageSize}&filterDate=${param.filterDate}&filterType=${param.filterType}&user-search=${param['user-search']}">prev</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}&rows=${pageSize}&filterDate=${param.filterDate}&filterType=${param.filterType}&user-search=${param['user-search']}" class="${i == currentPage ? 'curr-page' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}&rows=${pageSize}&filterDate=${param.filterDate}&filterType=${param.filterType}&user-search=${param['user-search']}">next</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Popup for Scheduling Meeting -->
<div id="popup-container" style="display: none;">
    <div class="popup-box">
        <h2>Meeting Details</h2>
        <div id="schedule-meeting-fields" style="display: none; margin-top: 15px;">
            <form method="post" action="CreateMeetingServlet" onsubmit="return validateForm()">
                <p><strong>Admin ID:</strong><br>
                    <input type="text" name="politicianId" id="accepted-politicianId" required />
                </p>
                <p><strong>Topic:</strong><br>
                    <input type="text" name="topic" id="accepted-topic" required />
                </p>
                <p><strong>Description:</strong><br>
                    <textarea name="description" id="accepted-description" rows="3" required></textarea>
                </p>
                <p><strong>Date:</strong><br>
                    <input type="date" name="date" id="accepted-date" required />
                </p>
                <p><strong>Time:</strong><br>
                    <input type="time" name="time" id="accepted-time" required />
                </p>
                <p><strong>Type of the Meeting:</strong><br>
                    <input type="text" name="typeofthemeeting" id="accepted-typeofthemeeting" required />
                </p>
                <p><strong>Platform:</strong><br>
                    <input type="text" name="platform" id="accepted-platform" required />
                </p>
                <p><strong>Host:</strong><br>
                    <input type="text" name="host" id="accepted-host" required />
                </p>
                <p><strong>Deadline to Register:</strong><br>
                    <input type="date" name="deadlinetoregister" id="accepted-deadline" required />
                </p>
                <p><strong>Number of Slots:</strong><br>
                    <input type="number" name="slots" id="accepted-slots" min="1" required />
                </p>
                <button type="submit">Submit</button>
            </form>
        </div>
        <br>
        <button onclick="closePopup()">Close</button>
    </div>
</div>

<!-- Popup for Viewing Meeting Details -->
<div id="meeting-details-popup" class="email-list-popup">
    <div class="popup-container">
        <div class="head">
            <span class="title">Meeting Details</span>
            <span class="cls-btn" onclick="closeMeetingDetailsPopup()">
                <i class="fa-solid fa-xmark"></i>
            </span>
        </div>
        <div class="content">
            <div class="body">
                <p><strong>Meeting ID:</strong> <span id="popup-meeting-id"></span></p>
                <p><strong>Politician ID:</strong> <span id="popup-politician-id"></span></p>
                <p><strong>Topic:</strong> <span id="popup-topic"></span></p>
                <p><strong>Description:</strong> <span id="popup-description"></span></p>
                <p><strong>Date:</strong> <span id="popup-date"></span></p>
                <p><strong>Time:</strong> <span id="popup-time"></span></p>
                <p><strong>Type:</strong> <span id="popup-type"></span></p>
                <p><strong>Host:</strong> <span id="popup-host"></span></p>
                <p><strong>Platform:</strong> <span id="popup-platform"></span></p>
                <p><strong>Deadline to Register:</strong> <span id="popup-deadline"></span></p>
                <p><strong>Slots:</strong> <span id="popup-slots"></span></p>
                <p><strong>Available Slots:</strong> <span id="popup-available-slots"></span></p>
            </div>
        </div>
        <div class="btns">
            <button class="close" onclick="closeMeetingDetailsPopup()">Close</button>
        </div>
    </div>
</div>

<script>
    function openPopup() {
        document.getElementById("popup-container").style.display = "block";
        document.getElementById("schedule-meeting-fields").style.display = "block";
        document.getElementById("accepted-politicianId").value = "";
        document.getElementById("accepted-topic").value = "";
        document.getElementById("accepted-description").value = "";
        document.getElementById("accepted-date").value = "";
        document.getElementById("accepted-time").value = "";
        document.getElementById("accepted-typeofthemeeting").value = "";
        document.getElementById("accepted-platform").value = "";
        document.getElementById("accepted-host").value = "";
        document.getElementById("accepted-deadline").value = "";
        document.getElementById("accepted-slots").value = "";
    }

    function closePopup() {
        document.getElementById("popup-container").style.display = "none";
        document.getElementById("schedule-meeting-fields").style.display = "none";
    }

    function showMeetingDetails(meetingId, politicianId, topic, description, date, time, type, host, platform, deadline, slots, availableSlots) {
        document.getElementById("popup-meeting-id").textContent = meetingId;
        document.getElementById("popup-politician-id").textContent = politicianId;
        document.getElementById("popup-topic").textContent = topic;
        document.getElementById("popup-description").textContent = description;
        document.getElementById("popup-date").textContent = date;
        document.getElementById("popup-time").textContent = time;
        document.getElementById("popup-type").textContent = type;
        document.getElementById("popup-host").textContent = host;
        document.getElementById("popup-platform").textContent = platform;
        document.getElementById("popup-deadline").textContent = deadline;
        document.getElementById("popup-slots").textContent = slots;
        document.getElementById("popup-available-slots").textContent = availableSlots;
        document.getElementById("meeting-details-popup").classList.add("active");
    }

    function closeMeetingDetailsPopup() {
        document.getElementById("meeting-details-popup").classList.remove("active");
    }

    function validateForm() {
        const slots = document.getElementById("accepted-slots").value;
        if (slots <= 0) {
            alert("Number of slots must be positive");
            return false;
        }
        const meetingDate = document.getElementById("accepted-date").value;
        const deadline = document.getElementById("accepted-deadline").value;
        if (new Date(deadline) > new Date(meetingDate)) {
            alert("Registration deadline cannot be after the meeting date");
            return false;
        }
        return true;
    }

    function filterTable() {
        const searchInput = document.getElementById("user-search").value.toLowerCase();
        const table = document.getElementById("meetings-table");
        const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const topic = rows[i].getElementsByTagName("td")[2].textContent.toLowerCase();
            const date = rows[i].getElementsByTagName("td")[4].textContent.toLowerCase();
            if (topic.includes(searchInput) || date.includes(searchInput)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }

    function applyFilters() {
        const rows = document.getElementById("rows").value;
        const filterDate = document.getElementById("filter-date").value;
        const filterType = document.getElementById("filter-type").value;

        const url = new URL(window.location.href);
        url.searchParams.set("rows", rows);
        if (filterDate) url.searchParams.set("filterDate", filterDate);
        else url.searchParams.delete("filterDate");
        if (filterType) url.searchParams.set("filterType", filterType);
        else url.searchParams.delete("filterType");
        url.searchParams.set("page", "1");
        url.searchParams.delete("user-search");
        window.location.href = url.toString();
    }

    function clearFilters() {
        document.getElementById("user-search").value = "";
        document.getElementById("filter-date").value = "";
        document.getElementById("filter-type").value = "";
        filterTable();
        applyFilters();
    }

    document.addEventListener("DOMContentLoaded", function () {
        const scheduleBtn = document.querySelector(".add-btn.f-row");
        if (scheduleBtn) {
            scheduleBtn.addEventListener("click", openPopup);
        }

        document.getElementById("request-btn").addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet";
        });
    });
</script>
</body>
</html>