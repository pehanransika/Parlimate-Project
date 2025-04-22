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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

</head>

<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="admin/assets/logo.png" alt="Parlimate" id="logo" />
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
                Total <span>${totalCount}</span> records
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
                        <td>No of Participants</td>

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
                            <td>${meeting.participantcount}</td>
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
                                                '${meeting.estimatedduration}',
                                                '${meeting.participantcount}',
                                                '${meeting.discussionformat}',
                                                '${meeting.preferredhost}')"
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
        <p><strong>No of Participants:</strong> <span id="popup-participants"></span></p>
        <p><strong>Type of the Meeting:</strong> <span id="popup-typeofthemeeting"></span></p>
        <p><strong>Host :</strong> <span id="popup-host"></span></p>

        <!-- Buttons -->
        <div id="response-buttons">
            <button onclick="showAcceptFields()">Accept</button>
            <button onclick="rejectMeeting()">Reject</button>
        </div>

        <!-- Extra fields shown when Accept is clicked -->
        <div id="accept-extra-fields" style="display: none; margin-top: 15px;">
            <h3>Confirm and Provide Details</h3>

            <form method="post" action="CreateMeetingServlet">
                <p><strong>ID:</strong><br>
                    <input type="text" name="politicianId" id="accepted-politicianId" readonly required />
                </p>
                <p><strong>Final Topic:</strong><br>
                    <input type="text" name="topic" id="accepted-topic" required />
                </p>

                <p><strong>Description:</strong><br>
                    <textarea name="description" id="accepted-description" rows="3" required></textarea>
                </p>

                <p><strong>Date:</strong><br>
                    <input type="date" name="date" id="accepted-date" required />
                </p>

                <p><strong>Final Time:</strong><br>
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
    function openPopup(id, user, title, purpose, date, time, duration, participants, typeofthemeeting, host) {
        document.getElementById("popup-id").innerText = id || "Not Specified";
        document.getElementById("popup-user").innerText = user || "Not Specified";
        document.getElementById("popup-title").innerText = title || "Not Specified";
        document.getElementById("popup-purpose").innerText = purpose || "Not Specified";
        document.getElementById("popup-date").innerText = date || "Not Specified";
        document.getElementById("popup-time").innerText = time || "Not Specified";
        document.getElementById("popup-duration").innerText = duration || "Not Specified";
        document.getElementById("popup-participants").innerText = participants || "Not Specified";
        document.getElementById("popup-typeofthemeeting").innerText = typeofthemeeting || "Not Specified";
        document.getElementById("popup-host").innerText = host || "Not Specified";
        document.getElementById("accepted-politicianId").value = document.getElementById("popup-id").textContent;
        document.getElementById("accepted-topic").value = document.getElementById("popup-title").textContent;
        document.getElementById("accepted-description").value = document.getElementById("popup-purpose").textContent;
        document.getElementById("accepted-date").value = document.getElementById("popup-date").textContent;
        document.getElementById("accepted-time").value = document.getElementById("popup-time").textContent;
        document.getElementById("accepted-typeofthemeeting").value = document.getElementById("popup-typeofthemeeting").textContent;
        document.getElementById("accepted-host").value = document.getElementById("popup-host").textContent;

        // Optional: Set placeholders for platform, deadline, and slots if not in popup
        document.getElementById("accepted-platform").placeholder = "Enter platform (e.g. Zoom, Google Meet)";
        document.getElementById("accepted-deadline").value = ""; // Let user pick
        document.getElementById("accepted-slots").value = ""; // Let user enter


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

    function showAcceptFields() {
        document.getElementById("accept-extra-fields").style.display = "block";
        document.getElementById("response-buttons").style.display = "none";
    }

    function rejectMeeting() {
        alert("Meeting Rejected.");
        // Send rejection to servlet here if needed
        closePopup();
    }

    function submitAcceptedDetails() {
        // Get values from the popup labels (view-only data)
        const politicianId = document.getElementById('accepted-politicianId').value;
        const typeofthemeeting = document.getElementById('accepted-typeofthemeeting').value;
        const topic = document.getElementById('accepted-topic').value;
        const description = document.getElementById('accepted-description').value;
        const date = document.getElementById('accepted-date').value;
        const time = document.getElementById('accepted-time').value;
        const platform = document.getElementById('accepted-platform').value;
        const host = document.getElementById('accepted-host').value;
        const deadline = document.getElementById('accepted-deadline').value;
        const slots = document.getElementById('accepted-slots').value;

        console.log("=== Debug Values Before Form Submission ===");
        console.log("politicianId:", politicianId);
        console.log("topic:", topic);
        console.log("description:", description);
        console.log("date:", date);
        console.log("time:", time);
        console.log("typeofthemeeting:", typeofthemeeting);
        console.log("platform:", platform);
        console.log("host:", host);
        console.log("deadline:", deadline);
        console.log("slots:", slots);
        console.log("===========================================");

        // Create FormData to send data via POST
        const formData = new FormData();
        formData.append("politicianId", politicianId);
        formData.append("topic", topic);
        formData.append("description", description);
        formData.append("date", date);
        formData.append("time", time);
        formData.append("typeofthemeeting", typeofthemeeting);
        formData.append("host", host);
        formData.append("platform", platform);
        formData.append("deadlinetoregister", deadline);
        formData.append("slots", slots);
        formData.append("availableSlots", slots); // Optional: keep if needed

        // Submit to backend
        fetch("CreateMeetingServlet", {
            method: "POST",
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    alert("Meeting accepted and sent to servlet.");
                    closePopup(); // Assuming this closes the popup
                } else {
                    alert("Error submitting meeting details.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Something went wrong while submitting.");
            });
    }



    function closePopup() {
        document.getElementById("popup-container").style.display = "none";
        document.getElementById("accept-extra-fields").style.display = "none";
        document.getElementById("response-buttons").style.display = "block";

        // Clear inputs
        document.getElementById("accepted-topic").value = "";
        document.getElementById("accepted-description").value = "";
        document.getElementById("accepted-time").value = "";
    }

</script>
</body>
</html>
