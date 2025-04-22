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
                        <td>Host</td>
                        <td>Platform</td>
                        <td>Deadline</td>
                        <td>Slots</td>
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
                            <td>${meetings.description}</td>
                            <td>${meetings.date}</td>
                            <td>${meetings.time}</td>
                            <td>${meetings.typeofthemeeting}</td>
                            <td>${meetings.host}</td>
                            <td>${meetings.platform}</td>
                            <td>${meetings.deadlinetoregister}</td>
                            <td>${meetings.slots}</td>
                            <td>${meetings.availableSlots}</td>
                            <td><form action="GetRegisteredUserServlet" method="get">
                                <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                <button type="submit">View</button>
                            </form></td>
                            <td><form action="GetRegisteredWishlistServlet" method="get">
                                <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                <button type="submit">View</button>
                            </form></td>
                            <td>
                                <form action="SendDeleteEmailServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this meeting?');">
                                    <input type="hidden" name="meetingId" value="${meetings.meetingId}" />
                                    <button type="submit" style="color: red;">Delete</button>
                                </form>
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
        <h2>Meeting Details</h2>

        <!-- Extra fields shown when Accept is clicked -->
        <div id="accept-extra-fields" style="display: none; margin-top: 15px;">

            <form method="post" action="CreateMeetingServlet">
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
                    <input type="number" name="slots" id="accepted-slots" required />
                </p>

                <button type="submit">Submit</button>
            </form>
        </div>

        <br>
        <button onclick="closePopup()">Close</button>
    </div>
</div>

<script>
    function openPopup() {
        // Show the popup container
        document.getElementById("popup-container").style.display = "block";

        // Also show the form fields inside the popup
        document.getElementById("accept-extra-fields").style.display = "block";

        // Clear form fields (in case it was previously filled)
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

    // Function to close the popup
    function closePopup() {
        document.getElementById("popup-container").style.display = "none";
    }

    // Add click event listener to the button
    document.addEventListener("DOMContentLoaded", function () {
        const scheduleBtn = document.querySelector(".add-btn.f-row");
        if (scheduleBtn) {
            scheduleBtn.addEventListener("click", openPopup);
        }
    });

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
        // Toggle popup-active class on body when filter button is clicked
        document.getElementById("request-btn").addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet";
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
