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
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="admin/assets/logo.png" alt="Parlimate" id="logo" />
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
                <a href="#" class="f-row log-out">
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
                                placeholder="Search by name/userId"
                                name="user-search"
                                id="user-search"
                        />
                    </div>
                    <div class="scheduled-meeting">
                        <button class="filter-btn f-row" id="schedule-btn">
                            <i class="fa-solid fa-filter"></i>
                            Scheduled Meetings
                        </button>
                    </div>
                    <button class="add-btn f-row">
                        <i class="fa-sharp fa-solid fa-plus"></i>
                        Add User
                    </button>
                </div>
            </div>
            <h2 class="section-title">Meeting Requests</h2>
            <div class="total-records f-row">
                Total <span>560</span> records
            </div>
            <div class="data f-col">
                <table class="users">
                    <thead>
                    <tr>
                        <td>Meeting Request ID</td>
                        <td>User Name</td>
                        <td>Title</td>
                        <td>Purpose of the Meeting</td>
                        <td>Date</td>
                        <td>Time</td>
                        <td>Duration</td>
                        <td>Action</td> <!-- New Column for Button -->
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="meeting" items="${allMeetingRequestsAdmin}">
                        <tr>
                            <td>${meeting.meetingrequestid}</td>
                            <td>${meeting.politician_id}</td>
                            <td>${meeting.topic}</td>
                            <td>${meeting.purposeofmeeting}</td>
                            <td>${meeting.proposaldate}</td>
                            <td>${meeting.proposaltime}</td>
                            <td>${meeting.estimatedduration}</td>
                            <td>
                                <button
                                        class="view-button"
                                        onclick="openPopup(
                                                '${meeting.meetingrequestid}',
                                                '${meeting.politician_id}',
                                                '${meeting.topic}',
                                                '${meeting.purposeofmeeting}',
                                                '${meeting.proposaldate}',
                                                '${meeting.proposaltime}',
                                                '${meeting.estimatedduration}')"
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
        <h2>Meeting Details</h2>
        <p><strong>Meeting ID:</strong> <span id="popup-id"></span></p>
        <p><strong>User:</strong> <span id="popup-user"></span></p>
        <p><strong>Title:</strong> <span id="popup-title"></span></p>
        <p><strong>Purpose:</strong> <span id="popup-purpose"></span></p>
        <p><strong>Date:</strong> <span id="popup-date"></span></p>
        <p><strong>Time:</strong> <span id="popup-time"></span></p>
        <p><strong>Duration:</strong> <span id="popup-duration"></span></p>
        <button onclick="closePopup()">Close</button>
    </div>
</div>



<script>
    // Helper: open and close popups
        function openPopup(id, user, title, purpose, date, time, duration) {
        // Fill in your modal or popup fields here
        document.getElementById("popup-id").innerText = id;
        document.getElementById("popup-user").innerText = user;
        document.getElementById("popup-title").innerText = title;
        document.getElementById("popup-purpose").innerText = purpose;
        document.getElementById("popup-date").innerText = date;
        document.getElementById("popup-time").innerText = time;
        document.getElementById("popup-duration").innerText = duration;

        document.getElementById("popup-container").style.display = "block";
    }

        function closePopup() {
        document.getElementById("popup-container").style.display = "none";
    }


document.querySelectorAll('.actbtn button').forEach(button => {
        button.addEventListener('click', () => {
            document.querySelectorAll('.actbtn .menu').forEach(menu => {
                if (menu !== button.nextElementSibling) {
                    menu.classList.remove('nav-active');
                }
            });
            button.nextElementSibling.classList.toggle('nav-active');
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("schedule-btn").addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/GetAllMeetingServlet";
        });


        // Close popup when close button is clicked
        document.querySelectorAll(".close-btn").forEach(button => {
            button.addEventListener("click", function() {
                document.body.classList.remove("popup-active");
                document.querySelector(".filter-user-popup").classList.remove("popup-show");
            });
        });
    });
</script>
</body>
</html>
