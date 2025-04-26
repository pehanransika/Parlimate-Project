<%@ page import="UserPackage.UserModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    HttpSession session1 = request.getSession(false); // Don't create a new session if one doesn't exist
    if (session1 == null || session1.getAttribute("user") == null) {
        // User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }

    // Session exists and user is logged in
    UserModel user = (UserModel) session1.getAttribute("user");
    int userId = user.getUserId();
    String userEmail = user.getEmail(); // Assuming UserModel has getEmail() method
    boolean isGmail = userEmail != null && userEmail.toLowerCase().endsWith("@gmail.com");
%>

<% response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="http://localhost:8080/Parlimate/index/sidebar1.css" rel="stylesheet"/>
    <link href="http://localhost:8080/Parlimate/index/header/header.css" rel="stylesheet"/>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Meeting room | Parlimate</title>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="./discussion-room.css"/>
    <link rel="stylesheet" href="./reqPop.css"/>
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
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
    />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
    <div class="reqPop">
        <div class="bg"></div>
        <form action="CreateMeetingRequestServlet" method="post">
            <div class="head">
                <div id="meetClsBtn">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="icon">
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                    >
                        <path
                                d="M12 21C13.78 21 15.5201 20.4722 17.0001 19.4832C18.4802 18.4943 19.6337 17.0887 20.3149 15.4442C20.9961 13.7996 21.1743 11.99 20.8271 10.2442C20.4798 8.49836 19.6226 6.89472 18.364 5.63604C17.1053 4.37737 15.5016 3.5202 13.7558 3.17294C12.01 2.82567 10.2004 3.0039 8.55585 3.68509C6.91131 4.36628 5.50571 5.51983 4.51677 6.99987C3.52784 8.47991 3 10.22 3 12C3 13.44 3.338 14.8 3.94 16.007C4.393 16.918 3.763 18.147 3.523 19.044C3.46983 19.2424 3.46982 19.4513 3.52297 19.6497C3.57613 19.8481 3.68057 20.029 3.8258 20.1742C3.97103 20.3194 4.15194 20.4239 4.35033 20.477C4.54872 20.5302 4.75761 20.5302 4.956 20.477C5.853 20.237 7.082 19.607 7.993 20.061C9.23821 20.6793 10.6097 21.0007 12 21Z"
                                stroke="#292929"
                                stroke-width="1.5"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                        />
                    </svg>
                </div>
                <div class="title">Request Discussion</div>
                <div class="separator"></div>
            </div>
            <div class="body">
                <div id="progress" class="progress row">
                    <div class="item item-active" data-title="DebDetails">
                        Debate Details
                    </div>
                    <div class="item" data-title="AddDetails">
                        Additional Information
                    </div>
                    <div class="separator"></div>
                </div>

                <div class="input-container">
                    <div class="input-group form-active">
                        <div class="field">
                            <label class="title" for="disc-title">Proposed Title</label>
                            <input type="hidden" name="politicianid" id="politicianid"
                                   value="${userProfile.politicianId}"/>
                            <input
                                    type="text"
                                    name="topic"
                                    id="disc-title"
                                    required
                                    placeholder="Education reform policies"
                            />
                        </div>
                        <div class="field">
                            <label class="title" for="disc-desc">Purpose of the debate</label>
                            <textarea
                                    name="purposeofmeeting"
                                    id="disc-desc"
                                    required
                                    placeholder="To discuss proposed funding strategies"
                                    aria-required="true"
                            ></textarea>
                        </div>
                        <div class="multi-fields">
                            <div class="field">
                                <label class="title" for="disc-date">Proposed Date</label>
                                <input
                                        type="date"
                                        name="proposaldate"
                                        id="disc-date"
                                        required
                                        min=""
                                />
                            </div>
                            <div class="field">
                                <label class="title" for="disc-time">Time</label>
                                <input
                                        type="time"
                                        name="proposaltime"
                                        id="disc-time"
                                        required
                                />
                            </div>
                        </div>
                        <div class="field">
                            <label class="title" for="disc-dur">Estimated duration</label>
                            <div class="drop-type">
                                <input
                                        type="text"
                                        name="estimatedduration"
                                        id="disc-dur"
                                        placeholder="2"
                                        required
                                />
                            </div>
                            <div class="separator"></div>
                        </div>
                        <div class="bottom">
                            <button type="button" class="cancel-btn btn">Cancel</button>
                            <button type="button" class="next-btn btn">
                                Next <i class="fa-solid fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>
                    <div class="input-group">
                        <div class="field">
                            <label class="title" for="disc-pref">Preferred Discussion Format</label>
                            <select name="discussionformat" id="disc-pref">
                                <option value="Open-debate">Open debate</option>
                                <option value="Moderated-discussion">Moderated Discussion</option>
                                <option value="QA">Q&A</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div id="opponent-fields" style="display: none;">
                            <div class="field">
                                <label class="title" for="opponent-name">Opponent Name</label>
                                <input type="text" id="opponent-name" name="opponentname"
                                       placeholder="Enter opponent name">
                            </div>
                            <div class="field">
                                <label class="title" for="opponent-party">Opponent's Party</label>
                                <input type="text" id="opponent-party" name="partyaffiliation"
                                       placeholder="Enter opponent's party">
                            </div>
                        </div>
                        <div class="field">
                            <label class="title">
                                <input type="checkbox" id="allow-participants" name="allowParticipants">
                                Allow Live Participants
                                <i class="fa-solid fa-circle-info"
                                   title="Ticking this will allow participants to join the meeting and interact"></i>
                            </label>
                        </div>

                        <div id="participant-fields" style="display: none;">
                            <div class="field">
                                <label class="title" for="participant-count">Number of Participants Allowed</label>
                                <input type="number" id="participant-count" name="participantCount" min="1"
                                       placeholder="Enter number of participants">
                            </div>
                        </div>

                        <div class="field">
                            <label class="title" for="disc-party-host">Preferred Host <span>(Optional)</span></label>
                            <select id="disc-party-host" name="preferredhost">
                                <option value="Hashan Perera">Hashan Perera</option>
                                <option value="Gayan Fernando">Gayan Fernando</option>
                                <option value="Jiranthan Rasamanikkam">Jiranthan Rasamanikkam</option>
                            </select>
                            <div class="separator"></div>
                        </div>

                        <div class="bottom">
                            <button type="button" class="prev-btn btn">Back</button>
                            <button type="submit" class="next-btn btn">
                                Request <i class="fa-solid fa-check"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</c:if>

<div class="notification-msg"></div>
<div class="container col">
    <div class="pageTitles">
        <h2 class="title">Meeting room</h2>
        <div class="subTitle">
            Engage with ongoing live video discussions
        </div>
    </div>
    <div class="navigations row" style="align-self: center">
        <div class="nav-btn">
            <button value="upcoming" class="capitalize nav-active"
                    onclick="window.location.href='http://localhost:8080/Parlimate/DiscussionRoom/GetAllMeetingUserServlet'">
                Upcoming
            </button>
        </div>
        <div class="nav-btn">
            <button value="ongoing" class="capitalize"
                    onclick="window.location.href='http://localhost:8080/Parlimate/GetOngoingMeetingsServlet'">
                Ongoing
            </button>
        </div>
        <div class="nav-btn">
            <button value="registered" class="capitalize"
                    onclick="window.location.href='http://localhost:8080/Parlimate/GetRegisteredMeetingsServlet'">
                Registered
            </button>
        </div>
    </div>
    <div class="meeting-top f-row">
        <div class="search-filter row">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="search-input" placeholder="Search by topic or politician name"/>
            </div>
            <div class="filter-group">
                <input type="date" id="date-filter"/>
            </div>
            <div class="filter-group">
                <select id="status-filter">
                    <option selected value="all" disabled>Meeting Status</option>
                    <option value="all">All Meetings</option>
                    <option value="upcoming">Upcoming Meetings</option>
                    <option value="past">Past Meetings</option>
                    <option value="open-reg">Open Registration</option>
                    <option value="closed-reg">Closed Registration</option>
                </select>
            </div>
        </div>
        <div class="dropdown">
            <div class="main-btn f-row capitalize">meetings <i class="fa-regular fa-circle-chevron-down"></i></div>
            <div class="meeting-btns f-col">
                <c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
                    <a href="GetMyMeetingRequests?userId=${user.userId}" class="myMeetings row">
                        <i class="fa-regular fa-hourglass"></i>
                        <span>My meeting requests</span>
                    </a>
                </c:if>
                <button class="newmeeting row">
                    <c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
                        <i class="fa-regular fa-video"></i>
                        <span>Request meeting</span>
                    </c:if>
                </button>
            </div>
        </div>
    </div>
    <div class="discussions col">
        <div class="nav-body col">
            <div class="items col">
                <c:forEach var="allmeetings" items="${allMeetingsUser}">
                    <div class="item live f-col"
                         style="animation-delay: 0.25s"
                         data-meetingid="${allmeetings.meetingId}"
                         data-topic="${allmeetings.topic}"
                         data-date="${allmeetings.date}"
                         data-description="${allmeetings.description}"
                         data-time="${allmeetings.time}"
                         data-available-slots="${allmeetings.availableSlots}"
                         data-image-url="GetProfileImageServlet?politicianId=${allmeetings.politicianId}"
                         data-politician-name="${allmeetings.politicianName}"
                         data-deadline="${allmeetings.deadlinetoregister}">

                        <div class="item-content live col">
                            <div class="body disc-type">${allmeetings.typeofthemeeting}</div>
                            <div class="panelists">
                                <div class="pImgs row">
                                    <div class="prof-img">
                                        <img src="GetProfileImageServlet?politicianId=${allmeetings.politicianId}"
                                             alt="Profile"
                                             onerror="console.error('Error loading image: ' + this.src)"
                                             onload="console.log('Image URL loaded: ' + this.src)"/>
                                    </div>
                                </div>
                            </div>
                            <div class="item-title">
                                <div class="title meeting">
                                        ${allmeetings.topic} by <span
                                        class="italic"> ${allmeetings.politicianName} </span>
                                </div>
                                <div class="time-period f-row ">
                                    <span class="start">Scheduled on </span>
                                    <span class="formatDateAndTime">${allmeetings.time} ${allmeetings.date}</span>
                                </div>
                                <div class="meeting-desc">${allmeetings.description}</div>
                                <div class="meeting-host body">hosted by: ${allmeetings.host}
                                    on ${allmeetings.platform}</div>
                                <div class="meeting-deadline">Registration Deadline
                                    - ${allmeetings.deadlinetoregister}</div>
                            </div>
                            <div class="item-interactive row">
                                <a href="#" class="small-text item-yt">
                                    <i class="fa-brands fa-youtube"></i>
                                    Watch on Youtube
                                </a>

                                <span class="small-text item-live request-join-btn">
                                    <i class="fa-solid fa-signal-stream"></i>
                                    Request to Join
                                </span>

                            </div>
                        </div>

                            <%--                        <div class="post-options col">--%>
                            <%--                            <div class="status capitalize row">--%>
                            <%--                                <span>${allmeetings.politicianId}</span>--%>
                            <%--                            </div>--%>
                            <%--                        </div>--%>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="live-meeting-popup" style="display: none; background: rgba(0,0,0,0.6);">
    <div class="popup-container">
        <div class="close-btn btn">
            <i class="fa-solid fa-x"></i>
        </div>
        <div class="top f-row">
            <div class="icon">
                <i class="fa-solid fa-hand"></i>
            </div>
            <div class="title">Request to Join</div>

        </div>
        <div class="content">
            <div class="f-col meeting-send" style="align-items: center;gap: 2.5rem">
                <img id="popup-profile-img" src="" alt="Profile"/>
                <div class="f-col" style="gap: 0.5rem">
                    <div class="slots">[slot count]</div>
                    <div class="gmail-input">
                        <input type="email" id="gmail" name="gmail"
                               placeholder="yourname@gmail.com"
                            <%= isGmail ? "value=\"" + userEmail + "\" readonly" : "required" %>>
                        <% if (!isGmail) { %>
                        <span id="gmail-error" style="color: red; display: none;">Please enter a valid Gmail address (@gmail.com)</span>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="body" id="meetingid">MeetingID</div>
            <div class="meeting-title">Topic</div>
            <div class="date capitalize">Date</div>
            <div class="body" id="description">Description</div>
            <div class="body" id="time">Time</div>

            <div class="conf">
                Are you sure you want to join the live meeting via Zoom?
            </div>
            <div class="warning">
                The invitation will be sent via e-mail. You must obey and respect
                <a href="#" target="_blank" class="rules" rel="noopener noreferrer">rules & regulations</a>
                in the live meeting. Any unnecessary behavior may lead to permanent/temporary ban from this platform.
            </div>
        </div>
        <div class="footer row">
            <button class="close scndry-btn">Close</button>
            <button class="confirm prmry-btn row">
                Confirm <i class="fa-solid fa-check"></i>
            </button>
        </div>
    </div>
</div>

</body>
<script src="../script.js"></script>
<script src="../loadSidebar.js"></script>
<script src="./reqPop.js"></script>
<script>


    const loggedInUserId = <%= userId %>;
    const isUserEmailGmail = <%= isGmail %>;
    console.log("User ID from session:", loggedInUserId);
    console.log("Is user email Gmail?", isUserEmailGmail);

    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll(".item-live");
        const meetingItems = document.querySelectorAll('.item.live');
        const searchInput = document.getElementById('search-input');
        const dateFilter = document.getElementById('date-filter');
        const statusFilter = document.getElementById('status-filter');

        // Hide join button for meetings with passed deadlines
        meetingItems.forEach(function (item) {
            const deadlineText = item.dataset.deadline;
            const deadlineMatch = deadlineText.match(/(\d{4}-\d{2}-\d{2})/); // match YYYY-MM-DD

            if (deadlineMatch) {
                const deadlineDate = new Date(deadlineMatch[1]);
                const currentDate = new Date();

                if (currentDate > deadlineDate) {
                    const requestBtn = item.querySelector('.request-join-btn');
                    if (requestBtn) {
                        requestBtn.style.display = 'none';
                    }
                }
            }
        });

        // Search and Filter Logic
        function filterMeetings() {
            const searchText = searchInput.value.toLowerCase();
            const filterDate = dateFilter.value;
            const status = statusFilter.value;
            const currentDate = new Date();

            meetingItems.forEach(item => {
                const topic = item.dataset.topic.toLowerCase();
                const politicianName = item.dataset.politicianName.toLowerCase();
                const meetingDate = new Date(item.dataset.date);
                const deadlineDate = new Date(item.dataset.deadline.match(/(\d{4}-\d{2}-\d{2})/)[1]);

                // Search filter
                const matchesSearch = searchText === '' || topic.includes(searchText) || politicianName.includes(searchText);

                // Date filter
                const matchesDate = !filterDate || item.dataset.date === filterDate;

                // Status filter
                let matchesStatus = true;
                if (status === 'upcoming') {
                    matchesStatus = meetingDate >= currentDate;
                } else if (status === 'past') {
                    matchesStatus = meetingDate < currentDate;
                } else if (status === 'open-reg') {
                    matchesStatus = deadlineDate >= currentDate;
                } else if (status === 'closed-reg') {
                    matchesStatus = deadlineDate < currentDate;
                }

                // Show or hide item
                if (matchesSearch && matchesDate && matchesStatus) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        // Event listeners for filters
        searchInput.addEventListener('input', filterMeetings);
        dateFilter.addEventListener('change', filterMeetings);
        statusFilter.addEventListener('change', filterMeetings);

        buttons.forEach(button => {
            button.addEventListener("click", () => {
                console.log("✅ Button clicked");

                const item = button.closest(".item");
                if (!item) return;

                const meetingid = item.dataset.meetingid;
                const topic = item.dataset.topic;
                const date = item.dataset.date;
                const description = item.dataset.description;
                const time = item.dataset.time;
                const slots = item.dataset.availableSlots;
                const imageUrl = item.dataset.imageUrl;

                console.log("📦 Data:", {topic, date, description, time, slots});

                const popup = document.querySelector(".live-meeting-popup");
                popup.querySelector("#meetingid").textContent = meetingid;
                popup.querySelector(".meeting-title").textContent = topic;
                popup.querySelector(".date").textContent = date;
                popup.querySelector("#description").textContent = description;
                popup.querySelector("#time").textContent = "Time: " + time;
                popup.querySelector("#popup-profile-img").src = imageUrl;

                const slotsElement = popup.querySelector(".slots");
                const confirmBtn = popup.querySelector(".confirm");
                const confMessage = popup.querySelector(".conf");

                if (parseInt(slots) === 0) {
                    slotsElement.textContent = "No slots available";
                    confirmBtn.innerHTML = 'Add to Wishlist <i class="fa-solid fa-heart"></i>';
                    confMessage.textContent = "Sorry, no slots available. You can add this meeting to your wishlist.";

                    confirmBtn.onclick = () => {
                        const email = popup.querySelector("#gmail").value.trim();
                        const meetingId = document.querySelector("#meetingid").textContent.trim();

                        if (!validateEmail(email)) {
                            return;
                        }

                        console.log("Meeting ID:", meetingId);
                        console.log("User ID:", loggedInUserId);
                        console.log("Email:", email);

                        const params = new URLSearchParams();
                        params.append("meetingId", meetingId);
                        params.append("userId", loggedInUserId);
                        params.append("email", email);

                        fetch("/Parlimate/AddToWishlistServlet", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: params.toString()
                        })
                            .then(res => {
                                if (!res.ok) throw new Error("Server error during wishlist submission");
                                return res.text();
                            })
                            .then(responseText => {
                                try {
                                    const result = JSON.parse(responseText);
                                    console.log("✅ Wishlist Response:", result);

                                    if (result.status === "success") {
                                        displayNotification("Meeting added to wishlist!");
                                    } else if (result.message) {
                                        alert(result.message);
                                    } else {
                                        alert("Something went wrong while adding to wishlist.");
                                    }

                                    document.body.classList.remove("overlay-active");
                                } catch (e) {
                                    console.error("❌ Failed to parse JSON response:", e, "Raw text:", responseText);
                                }
                            })
                            .catch(err => {
                                console.error("❌ Error adding to wishlist:", err);
                            });
                    };
                } else {
                    slotsElement.innerHTML = slots + " more seats available";
                    confirmBtn.innerHTML = 'Confirm <i class="fa-solid fa-check"></i>';
                    confMessage.textContent = "Are you sure you want to join the live meeting via Zoom?";

                    confirmBtn.onclick = () => {
                        const email = document.getElementById("gmail").value.trim();
                        const meetingId = document.querySelector("#meetingid").textContent.trim();

                        if (!validateEmail(email)) {
                            return;
                        }

                        if (!meetingId || !loggedInUserId) {
                            alert("Missing required fields.");
                            return;
                        }

                        console.log("Meeting ID:", meetingId);
                        console.log("User ID:", loggedInUserId);
                        console.log("Email:", email);

                        const params = new URLSearchParams();
                        params.append("meetingId", meetingId);
                        params.append("userId", loggedInUserId);
                        params.append("email", email);

                        fetch("/Parlimate/JoinMeetingServlet", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: params.toString()
                        })
                            .then(res => {
                                if (!res.ok) throw new Error("Server returned error");
                                return res.text();
                            })
                            .then(text => {
                                try {
                                    const result = JSON.parse(text);
                                    console.log("✅ Server Response:", result);

                                    if (result.status === "error" && result.message) {
                                        alert(result.message);
                                    } else {
                                        displayNotification("Your invitation has been sent!");
                                    }

                                    document.body.classList.remove("overlay-active");
                                } catch (e) {
                                    console.error("❌ JSON Parse Error:", e, "Raw response:", text);
                                }
                            })
                            .catch(err => {
                                console.error("❌ Error:", err);
                            });
                    };
                }

                document.body.classList.add("overlay-active");
                popup.style.display = 'flex';
            });
        });

        document.querySelector(".live-meeting-popup .close").addEventListener("click", () => {
            document.body.classList.remove("overlay-active");
            document.querySelector(".live-meeting-popup").style.display = 'none';
        });

        document.querySelector(".live-meeting-popup .close-btn").addEventListener("click", () => {
            document.body.classList.remove("overlay-active");
            document.querySelector(".live-meeting-popup").style.display = 'none';
        });

        function validateEmail(email) {
            if (!email) {
                alert("Please enter an email address.");
                return false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email format.");
                return false;
            }

            if (!isUserEmailGmail && !email.toLowerCase().endsWith("@gmail.com")) {
                const errorSpan = document.getElementById("gmail-error");
                if (errorSpan) {
                    errorSpan.style.display = "block";
                }
                return false;
            }

            const errorSpan = document.getElementById("gmail-error");
            if (errorSpan) {
                errorSpan.style.display = "none";
            }
            return true;
        }

        function displayNotification(msg, timeout = 3000) {
            console.log("notification is called");
            const notificationMsg = document.querySelector(".notification-msg");
            if (notificationMsg) {
                notificationMsg.innerHTML = msg;
                document.body.classList.add("noti-active");

                setTimeout(() => {
                    document.body.classList.remove("noti-active");
                }, timeout);
            }
        }

        document.getElementById('disc-date').min = new Date().toISOString().split('T')[0];

        const navBtns = document.querySelectorAll(".nav-btn button");
        navBtns.forEach((btn) => {
            btn.addEventListener("click", () => {
                navBtns.forEach((btn) => btn.classList.remove("nav-active"));
                btn.classList.add("nav-active");
            });
        });

        const discussionFormat = document.getElementById('disc-pref');
        const opponentFields = document.getElementById('opponent-fields');
        discussionFormat.addEventListener('change', function () {
            opponentFields.style.display = this.value === 'Open-debate' ? 'block' : 'none';
        });

        const allowParticipantsCheckbox = document.getElementById('allow-participants');
        const participantFields = document.getElementById('participant-fields');
        allowParticipantsCheckbox.addEventListener('change', function () {
            participantFields.style.display = this.checked ? 'block' : 'none';
        });
    });
</script>

</html>