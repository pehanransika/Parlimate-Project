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

    <!-- Inline CSS for Date Filter, View Button, and Meeting Status Filter -->
    <style>
        .date-filter {
            display: flex;
            align-items: center;
            margin-right: 10px;
        }
        .date-filter label {
            margin-right: 5px;
            color: #555;
        }
        .date-filter input[type="date"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            font-family: "Poppins", sans-serif;
        }
        .date-filter input[type="date"]:focus {
            outline: none;
            border-color: #1f1f1f;
        }
        .meeting-status-filter {
            display: flex;
            align-items: center;
            margin-right: 10px;
        }
        .meeting-status-filter select {
            color: #6b6b6b;
            border: 1px solid #8e8e8e;
            padding: 0.25rem;
            border-radius: 0.5rem;
            font-family: "Poppins", sans-serif;
            font-size: 0.8rem;
        }
        .meeting-status-filter select:focus {
            outline: none;
            border-color: #1f1f1f;
        }
        .view-btn {
            gap: 0.5rem;
            border-radius: 0.5rem;
            outline: none;
            border: none;
            color: #eeeeee;
            font-weight: 600;
            background: #1e1e1e;
            padding: 0.6rem 1rem;
            font-family: "Poppins", sans-serif;
            font-size: 0.8rem;
            cursor: pointer;
            transition: background 0.25s ease;
        }
        .view-btn:hover {
            background: #333333;
        }
        .view-btn:active {
            background: #0f0f0f;
        }
        #view-details p {
            margin: 0.5rem 0;
            font-family: "Poppins", sans-serif;
            font-size: 0.8rem;
        }
        #view-details p strong {
            color: #6b6b6b;
            font-weight: 600;
        }
        #view-details p span {
            color: #1e1e1e;
            font-weight: 400;
        }
    </style>

    <!-- Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
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
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="<%= request.getContextPath() %>/admin/assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="<%= request.getContextPath() %>/admin/Home/index.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>Home</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/userManagment.jsp" class="nav-item f-row">
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
                <a href="<%= request.getContextPath() %>/meetingManagement/meetingManagement.jsp" class="nav-item f-row active">
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
                        />
                    </div>
                    <div class="date-filter">
                        <label for="date-filter">
                            <i class="fa-solid fa-calendar-day"></i>
                        </label>
                        <input
                                type="date"
                                name="date-filter"
                                id="date-filter"
                                placeholder="Filter by date"
                        />
                    </div>
                    <div class="meeting-status-filter">
                        <select name="meeting-status" id="meeting-status">
                            <option value="all">All Meetings</option>
                            <option value="upcoming">Upcoming Meetings</option>
                            <option value="past">Past Meetings</option>
                        </select>
                    </div>
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
                <table class="users">
                    <thead>
                    <tr>
                        <td>Meeting ID</td>
                        <td>Politician ID</td>
                        <td>Topic</td>
                        <td>Description</td>
                        <td>Date</td>
                        <td>Time</td>
                        <td>Type</td>
                        <td>Platform</td>
                        <td>Deadline</td>
                        <td>Available Slots</td>
                        <td>Registered Users</td>
                        <td>Wishlist</td>
                        <td>Action</td>
                        <td>View</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="meetings" items="${allMeetings}">
                        <tr>
                            <td>${meetings.meetingId}</td>
                            <td>${meetings.politicianId}</td>
                            <td>${meetings.topic}</td>
                            <td>${meetings.description}</td>
                            <td>${meetings.date}</td>
                            <td>${meetings.time}</td>
                            <td>${meetings.typeofthemeeting}</td>
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
                                <form action="SendDeleteEmailServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this meeting?');">
                                    <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                    <button type="submit" style="color: red;">Delete</button>
                                </form>
                            </td>
                            <td>
                                <button class="view-btn" onclick="openViewPopup({
                                        meetingId: '${fn:escapeXml(meetings.meetingId)}',
                                        politicianId: '${fn:escapeXml(meetings.politicianId)}',
                                        topic: '${fn:escapeXml(meetings.topic)}',
                                        description: '${fn:escapeXml(meetings.description)}',
                                        date: '${fn:escapeXml(meetings.date)}',
                                        time: '${fn:escapeXml(meetings.time)}',
                                        type: '${fn:escapeXml(meetings.typeofthemeeting)}',
                                        host: '${fn:escapeXml(meetings.host)}',
                                        platform: '${fn:escapeXml(meetings.platform)}',
                                        deadline: '${fn:escapeXml(meetings.deadlinetoregister)}',
                                        slots: '${fn:escapeXml(meetings.slots)}',
                                        availableSlots: '${fn:escapeXml(meetings.availableSlots)}'
                                        })">View</button>
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

<div id="popup-container" style="display: none;">
    <div class="popup-box">
        <h2 id="popup-title">Meeting Details</h2>

        <!-- View Meeting Details (Read-Only) -->
        <div id="view-details" style="display: none; margin-top: 15px;">
            <p><strong>Meeting ID:</strong> <span id="view-meetingId"></span></p>
            <p><strong>Politician ID:</strong> <span id="view-politicianId"></span></p>
            <p><strong>Topic:</strong> <span id="view-topic"></span></p>
            <p><strong>Description:</strong> <span id="view-description"></span></p>
            <p><strong>Date:</strong> <span id="view-date"></span></p>
            <p><strong>Time:</strong> <span id="view-time"></span></p>
            <p><strong>Type of Meeting:</strong> <span id="view-type"></span></p>
            <p><strong>Host:</strong> <span id="view-host"></span></p>
            <p><strong>Platform:</strong> <span id="view-platform"></span></p>
            <p><strong>Deadline to Register:</strong> <span id="view-deadline"></span></p>
            <p><strong>Slots:</strong> <span id="view-slots"></span></p>
            <p><strong>Available Slots:</strong> <span id="view-availableSlots"></span></p>
        </div>

        <!-- Schedule Meeting Form -->
        <div id="accept-extra-fields" style="display: none; margin-top: 15px;">
            <form method="post" action="CreateMeetingServlet">
                <p><strong>Admin ID:</strong><br>
                    <input type="text" name="politicianId" id="accepted-politicianId" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Topic:</strong><br>
                    <input type="text" name="topic" id="accepted-topic" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Description:</strong><br>
                    <textarea name="description" id="accepted-description" rows="3" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;"></textarea>
                </p>
                <p><strong>Date:</strong><br>
                    <input type="date" name="date" id="accepted-date" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Time:</strong><br>
                    <input type="time" name="time" id="accepted-time" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Type of the Meeting:</strong><br>
                    <input type="text" name="typeofthemeeting" id="accepted-typeofthemeeting" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Platform:</strong><br>
                    <input type="text" name="platform" id="accepted-platform" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Host:</strong><br>
                    <input type="text" name="host" id="accepted-host" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Deadline to Register:</strong><br>
                    <input type="date" name="deadlinetoregister" id="accepted-deadline" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <p><strong>Number of Slots:</strong><br>
                    <input type="number" name="slots" id="accepted-slots" required style="width: 100%; padding: 0.5rem; border: 1px solid #8e8e8e; border-radius: 0.5rem; font-family: Poppins; font-size: 0.8rem;" />
                </p>
                <button type="submit" style="gap: 0.5rem; border-radius: 0.5rem; outline: none; border: none; color: #eeeeee; font-weight: 600; background: #1e1e1e; padding: 0.6rem 1rem; font-family: Poppins; font-size: 0.8rem;">Submit</button>
            </form>
        </div>

        <br>
        <button onclick="closePopup()" style="gap: 0.5rem; border-radius: 0.5rem; outline: none; border: 1px solid #d6d6d6; color: #242424; font-weight: 600; background: #eeeeee; padding: 0.6rem 1rem; font-family: Poppins; font-size: 0.8rem;">Close</button>
    </div>
</div>

<script>
    function openPopup() {
        document.getElementById("popup-container").style.display = "flex";
        document.getElementById("accept-extra-fields").style.display = "block";
        document.getElementById("view-details").style.display = "none";
        document.getElementById("popup-title").textContent = "Schedule Meeting";
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

    function openViewPopup(meeting) {
        document.getElementById("popup-container").style.display = "flex";
        document.getElementById("view-details").style.display = "block";
        document.getElementById("accept-extra-fields").style.display = "none";
        document.getElementById("popup-title").textContent = "View Meeting Details";

        // Populate view details
        document.getElementById("view-meetingId").textContent = meeting.meetingId;
        document.getElementById("view-politicianId").textContent = meeting.politicianId;
        document.getElementById("view-topic").textContent = meeting.topic;
        document.getElementById("view-description").textContent = meeting.description;
        document.getElementById("view-date").textContent = meeting.date;
        document.getElementById("view-time").textContent = meeting.time;
        document.getElementById("view-type").textContent = meeting.type;
        document.getElementById("view-host").textContent = meeting.host;
        document.getElementById("view-platform").textContent = meeting.platform;
        document.getElementById("view-deadline").textContent = meeting.deadline;
        document.getElementById("view-slots").textContent = meeting.slots;
        document.getElementById("view-availableSlots").textContent = meeting.availableSlots;
    }

    function closePopup() {
        document.getElementById("popup-container").style.display = "none";
        document.getElementById("view-details").style.display = "none";
        document.getElementById("accept-extra-fields").style.display = "none";
    }

    document.addEventListener("DOMContentLoaded", function () {
        const scheduleBtn = document.querySelector(".add-btn.f-row");
        if (scheduleBtn) {
            scheduleBtn.addEventListener("click", openPopup);
        }

        document.getElementById("request-btn").addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet";
        });

        document.querySelectorAll(".close-btn").forEach(button => {
            button.addEventListener("click", function() {
                document.body.classList.remove("popup-active");
                document.querySelector(".filter-user-popup").classList.remove("popup-show");
            });
        });

        // Filter logic
        const searchInput = document.getElementById("user-search");
        const dateFilter = document.getElementById("date-filter");
        const statusFilter = document.getElementById("meeting-status");

        function applyFilters() {
            const searchQuery = searchInput.value.toLowerCase();
            const selectedDate = dateFilter.value;
            const selectedStatus = statusFilter.value;
            const rows = document.querySelectorAll("table.users tbody tr");
            const now = new Date();

            let visibleRows = 0;

            rows.forEach(row => {
                const topic = row.cells[2].textContent.toLowerCase(); // Topic column (index 2)
                const date = row.cells[4].textContent; // Date column (index 4)
                const time = row.cells[5].textContent; // Time column (index 5)
                const meetingDateTime = new Date(`${date}T${time}`);

                // Check search filter
                const matchesSearch = searchQuery === "" || topic.includes(searchQuery);

                // Check date filter
                const matchesDate = selectedDate === "" || date === selectedDate;

                // Check status filter
                let matchesStatus = true;
                if (selectedStatus === "upcoming") {
                    matchesStatus = meetingDateTime > now;
                } else if (selectedStatus === "past") {
                    matchesStatus = meetingDateTime < now;
                }

                // Show/hide row based on all filters
                if (matchesSearch && matchesDate && matchesStatus) {
                    row.style.display = "";
                    visibleRows++;
                } else {
                    row.style.display = "none";
                }
            });

            // Update total records count
            document.querySelector(".total-records span").textContent = visibleRows;
        }

        // Add event listeners for all filters
        searchInput.addEventListener("input", applyFilters);
        dateFilter.addEventListener("change", applyFilters);
        statusFilter.addEventListener("change", applyFilters);

        // Initial filter application
        applyFilters();
    });
</script>
</body>
</html>