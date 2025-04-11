<%@ page import="UserPackage.UserModel" %>

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

    // You can now use this userId as needed
%>

<% response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="http://localhost:8080/Parlimate/index/sidebar1.css" rel="stylesheet" />
    <link href="http://localhost:8080/Parlimate/index/header/header.css" rel="stylesheet" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meeting room | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./discussion-room.css" />
    <link rel="stylesheet" href="./reqPop.css" />
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
                <!-- <i class="fa-regular fa-comment-middle"></i> -->
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
                        <label class="title" for="disc-title"
                        >proposed Title</label
                        >
                        <input type="hidden" name="politicianid" id="politicianid" value="${userProfile.politicianId}" />
                        <input
                                type="text"
                                name="topic"
                                id="disc-title"
                                required
                                placeholder="Education reform policies"
                        />
                    </div>
                    <div class="field">
                        <label class="title" for="disc-desc"
                        >Purpose of the debate</label
                        >
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
                            <label class="title" for="disc-time"
                            >time</label
                            >
                            <input
                                    type="time"
                                    name="proposaltime"
                                    id="disc-time"
                                    required
                            />
                        </div>
                    </div>
                    <div class="field">
                        <label class="title" for="disc-dur"
                        >Estimated duration</label
                        >
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
                        <button type="button" class="cancel-btn btn">
                            Cancel
                        </button>
                        <button type="button" class="next-btn btn">
                            Next
                            <i class="fa-solid fa-arrow-right"></i>
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
                            <input type="text" id="opponent-name" name="opponentname" placeholder="Enter opponent name">
                        </div>
                        <div class="field">
                            <label class="title" for="opponent-party">Opponent's Party</label>
                            <input type="text" id="opponent-party" name="partyaffiliation" placeholder="Enter opponent's party">
                        </div>
                    </div>
                    <div class="field">
                        <label class="title">
                            <input type="checkbox" id="allow-participants" name="allowParticipants">
                            Allow Live Participants
                            <i class="fa-solid fa-circle-info" title="Ticking this will allow participants to join the meeting and interact"></i>
                        </label>
                    </div>

                    <div id="participant-fields" style="display: none;">
                        <div class="field">
                            <label class="title" for="participant-count">Number of Participants Allowed</label>
                            <input type="number" id="participant-count" name="participantCount" min="1" placeholder="Enter number of participants">
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
                        <button type="button" class="prev-btn btn">back</button>
                        <button type="submit" class="next-btn btn">
                            request <i class="fa-solid fa-check"></i>
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
            engage with ongoing live video discussions
        </div>
    </div>
    <div class="discussions col">
        <div class="navigations row">
            <div class="nav-btn">
                <button value="upcoming" class="capitalize nav-active">
                    Upcoming
                </button>
            </div>
            <div class="nav-btn">
            <button value="ongoing" class="capitalize" onclick="window.location.href='http://localhost:8080/Parlimate/GetOngoingMeetingsServlet'">
                Ongoing
            </button>
            </div>
            <div class="nav-btn">
                <button value="registered" class="capitalize">
                    Registered
                </button>
            </div>
        </div>
        <div class="nav-body col">

            <div class="meeting-btns row">
                <c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
                <a href="GetAllMeetingRequestServlet" class="myMeetings row">
                    <span> My meeting </span
                    ><i class="fa-solid fa-clock"></i>
                </a>   </c:if>
                <div class="newmeeting row">
                 <c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
                            <span> request meeting </span
                            ><i class="fa-solid fa-pencil"></i>
                 </c:if>
                </div>


            </div>

            <div class="items col">
                <c:forEach var="allmeetings" items="${allMeetingsUser}">
                    <div class="item live row"
                         style="animation-delay: 0.25s"
                         data-meetingid="${allmeetings.meetingId}"
                         data-topic="${allmeetings.topic}"
                         data-date="${allmeetings.date}"
                         data-description="${allmeetings.description}"
                         data-time="${allmeetings.time}">
                        <div class="panelists">
                            <div class="pImgs row">
                                <div class="prof-img">
                                    <img src="../assets/images/ranil.jpg" alt="" />
                                </div>
                                <div class="prof-img">
                                    <img src="../assets/images/images.jpeg" alt="" />
                                </div>
                            </div>
                        </div>

                        <div class="item-content live col">
                            <div class="item-title">
                                <div class="title" style="font-size: 15px;">
                                        ${allmeetings.topic}
                                </div>
                                <div class="time-period small-text row" style="font-size: 15px; font-weight: bold; color: #4a4443;">
                                    <i class="fa-solid fa-clock"></i>
                                    <div class="start"> ${allmeetings.time}</div>
                                    <div class="date">${allmeetings.date}</div>
                                </div>
                                <div class="body">${allmeetings.description}</div>
                                <div class="body">${allmeetings.typeofthemeeting}</div>
                                <div class="body">${allmeetings.host}</div>
                            </div>
                            <div class="item-interactive row">
                                <a href="#" class="small-text item-yt">
                                    <i class="fa-brands fa-youtube"></i>
                                    Watch on Youtube
                                </a>
                                <a href="#" class="small-text item-sp">
                                    <i class="fa-brands fa-spotify"></i>
                                        ${allmeetings.platform}
                                </a>
                                <span class="small-text item-live request-join-btn">
                                    <i class="fa-solid fa-signal-stream"></i>
                                        Request to Join
                                </span>

                                </span>
                                <div class="body" style="color: #ea2f07">Registration Deadline - ${allmeetings.deadlinetoregister}</div>
                            </div>
                        </div>
                        <div class="post-options col">
                            <div class="status capitalize row">
                                <span>${allmeetings.politicianId}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
    </div>
</div>

<div class="live-meeting-popup" style="display: flex; background: rgba(0,0,0,0.6);">
    <div class="popup-container">
        <div class="head row">
            <div class="title">Request to Join</div>
            <div class="cls-btn btn">
                <i class="fa-solid fa-x"></i>
            </div>
        </div>
        <div class="content">
            <!-- These will be dynamically updated -->
            <div class="body" id="meetingid">MeetingID</div>
            <div class="meeting-title">Topic</div>
            <div class="date capitalize">Date</div>
            <div class="body" id="description">Description</div>
            <div class="body" id="time">Time</div>
            <div class="profs row">
                <div class="prof-img"></div>
                <div class="prof-img"></div>
            </div>
            <div class="seats">
                <span>12</span> more seats available
            </div>
            <div class="gmail-input">
                <label for="gmail">Enter your Gmail address:</label>
                <input type="email" id="gmail" name="gmail" placeholder="yourname@gmail.com" required>
            </div>
            <div class="conf">
                Are you sure you want to join the live meeting via Zoom?
            </div>
            <div class="warning">
                The invitation will be sent via e-mail. You must obey and respect
                <a href="#" target="_blank" class="rules" rel="noopener noreferrer">rules & regulations</a>
                in the live meeting. Any unnecessary behavior may lead to permanent/temporary ban from this platform.
            </div>
        </div>
        <div class="btns row">
            <button class="close">Close</button>
            <button class="confirm row">
                Confirm <i class="fa-solid fa-check"></i>
            </button>
        </div>
    </div>
</div>
</body>
<script src="../script.js"></script>
<script src="../loadSidebar.js"></script>
<%--<script src="http://localhost:8080/Parlimate/DiscussionRoom/discussin.js"></script>--%>
<script src="./reqPop.js"></script>
<script>
    const loggedInUserId = <%= userId %>;
    console.log("User ID from session:", loggedInUserId);

    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll(".item-live");

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

                console.log("📦 Data:", { topic, date, description, time });

                const popup = document.querySelector(".live-meeting-popup");
                popup.querySelector("#meetingid").textContent= meetingid;
                popup.querySelector(".meeting-title").textContent = topic;
                popup.querySelector(".date").textContent = date;
                popup.querySelector("#description").textContent = description;
                popup.querySelector("#time").textContent = "Time: " + time;

                body.classList.add("overlay-active");
            });
        });

        document.querySelector(".live-meeting-popup .close").addEventListener("click", () => {
            body.classList.remove("overlay-active");
        });

        document.querySelector(".live-meeting-popup .cls-btn").addEventListener("click", () => {
            body.classList.remove("overlay-active");
        });

        document.querySelector(".live-meeting-popup .close").addEventListener("click", () => {
            body.classList.remove("overlay-active");
        });

        document.querySelector(".live-meeting-popup .cls-btn").addEventListener("click", () => {
            body.classList.remove("overlay-active");
        });

        document.querySelector(".live-meeting-popup .btns .confirm").addEventListener("click", () => {
            const email = document.getElementById("gmail").value.trim();
            const meetingId = document.querySelector("#meetingid").textContent.trim();


            // Basic email validation regex
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Check if email is empty, invalid, or missing required fields
            if (!email || !emailRegex.test(email)) {
                alert("Please enter a valid email address.");
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
                    return res.text(); // try reading raw text
                })
                .then(text => {
                    try {
                        const result = JSON.parse(text);  // safely parse
                        console.log("✅ Server Response:", result);

                        // Check if the response indicates an error (duplicate registration)
                        if (result.status === "error" && result.message) {
                            alert(result.message); // Show error message (e.g., "You have already registered for this meeting.")
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
        });




        function displayNotification(msg, timeout = 3000) {
            console.log("notification is called");
            const notificationMsg = document.querySelector("#notification"); // Make sure this exists in your HTML
            if (notificationMsg) {
                notificationMsg.innerHTML = msg;
                body.classList.add("noti-active");

                setTimeout(() => {
                    body.classList.remove("noti-active");
                }, timeout);
            }
        }
    });

    document.getElementById('disc-date').min = new Date().toISOString().split('T')[0];
    const navBtns = document.querySelectorAll(".nav-btn button");

    navBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            navBtns.forEach((btn) => {
                btn.classList.remove("nav-active");
            });
            btn.classList.add("nav-active");
        });
    });

    const discussionFormat = document.getElementById('disc-pref');
    const opponentFields = document.getElementById('opponent-fields');

    discussionFormat.addEventListener('change', function () {
        if (this.value === 'Open-debate') {
            opponentFields.style.display = 'block';
        } else {
            opponentFields.style.display = 'none';
        }
    });

    const allowParticipantsCheckbox = document.getElementById('allow-participants');
    const participantFields = document.getElementById('participant-fields');

    allowParticipantsCheckbox.addEventListener('change', function () {
        participantFields.style.display = this.checked ? 'block' : 'none';
    });
</script>
</html>
