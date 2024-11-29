<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>
<% response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="../index/sidebar1.css" rel="stylesheet" />
    <link href="../index/header/header.css" rel="stylesheet" />
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
                <div class="item" data-title="OppDetails">
                    Opponents Info
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
                            <label class="title" for="disc-date"
                            >Proposed Date</label
                            >
                            <input
                                    type="date"
                                    name="proposaldate"
                                    id="disc-date"
                                    required
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
                        <label class="title" for="disc-opNames"
                        >Opponents names</label
                        >
                        <input
                                type="text"
                                name="opponentname"
                                id="disc-opNames"
                                required
                                placeholder="Sajith Premadasa"
                        />
                    </div>
                    <div class="field">
                        <label class="title" for="disc-party-aff"
                        >Party Affiliation(s)</label
                        >
                        <input
                                type="text"
                                required
                                placeholder="Samagi Jana Balawegaya"
                                id="disc-party-aff"
                                name="partyaffiliation"
                        />
                        <div class="separator"></div>
                    </div>
                    <div class="bottom">
                        <button type="button" class="prev-btn btn">
                            back
                        </button>
                        <button type="button" class="next-btn btn">
                            Next
                            <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
                <div class="input-group">
                    <div class="field">
                        <label class="title" for="disc-pref"
                        >Preferred Discussion Format</label
                        >
                        <select name="discussionformat" id="disc-pref">
                            <option value="Open-debate">
                                Open debate
                            </option>
                            <option value="Moderated-discussion">
                                Moderated Discussion
                            </option>
                            <option value="QA">Q&A</option>
                            <option value="Other">other</option>
                        </select>
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
                        <button type="button" class="prev-btn btn">
                            back
                        </button>
                        <button type="submit" class="next-btn btn">
                            request
                            <i class="fa-solid fa-check"></i>
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
                <button value="recent" class="capitalize nav-active">
                    recent
                </button>
            </div>
            <div class="nav-btn">
                <button value="today" class="capitalize">
                    ongoing
                </button>
            </div>
            <div class="nav-btn">
                <button value="upcoming" class="capitalize">
                    upcoming
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
                <div
                        class="item live row"
                        style="animation-delay: 0.25s"
                >
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/ranil.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images/images.jpeg"
                                        alt=""
                                />
                            </div>
                        </div>
                    </div>
                    <div class="item-content live col">
                        <div class="item-title">
                            <div class="title">
                                who is the best among two of us ?
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">7.00 PM</div>
                                >
                                <div class="end">9.00 PM</div>
                                <div class="date">Sept 14</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                            <span class="small-text item-live">
										<i
                                                class="fa-solid fa-signal-stream"
                                        ></i>
										Request to Join
									</span>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>ranil wickramasinghe</span>
                            <span>sajith premadasa</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 0.5s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/AKD.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images/images.jpeg"
                                        alt=""
                                />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                Post-Presidential election
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">8.00 PM</div>
                                >
                                <div class="end">10.00 PM</div>
                                <div class="date">Sept 15</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>Anura kumara dissanayake</span>
                            <span>sajith premadasa</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 0.75s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/AKD.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images/images.jpeg"
                                        alt=""
                                />
                            </div>
                            <div class="prof-img">
                                <img src="../assets/images/ranil.jpg" alt="" />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                Post-Presidential election
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">8.00 PM</div>
                                >
                                <div class="end">10.00 PM</div>
                                <div class="date">Sept 16</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>Anura kumara dissanayake</span>
                            <span>sajith premadasa</span>
                            <span>ranil wockramasinghe</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 1s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img
                                        src="../assets/images/images.jpeg"
                                        alt=""
                                />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                How to Improve the Education System with
                                the Help of Sajith Premadasa
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">1.00 AM</div>
                                >
                                <div class="end">5.00 AM</div>
                                <div class="date">Feb 30</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>sajith premadasa</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 1.25s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/AKD.jpg" alt="" />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                Why should we change the current
                                currupted political system ?
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">8.00 PM</div>
                                >
                                <div class="end">10.00 PM</div>
                                <div class="date">Sept 16</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>Anura kumara dissanayake</span>
                            <span>sajith premadasa</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 1.5s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/ranil.jpg" alt="" />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                72 years in Politics
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">8.00 PM</div>
                                >
                                <div class="end">10.00 PM</div>
                                <div class="date">Oct 15</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>Ranil wickramasinghe</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
                <div class="item row" style="animation-delay: 1.75s">
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/images/ranil.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images/images.jpeg"
                                        alt=""
                                />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                who is the best among two of us ?
                            </div>
                            <div class="time-period small-text row">
                                <i class="fa-solid fa-clock"></i>
                                <div class="start">7.00 PM</div>
                                >
                                <div class="end">9.00 PM</div>
                                <div class="date">Sept 14</div>
                            </div>
                        </div>
                        <div class="item-interactive row">
                            <a href="#" class="small-text item-yt">
                                <i class="fa-brands fa-youtube"></i>
                                Watch on Youtube
                            </a>
                            <a href="#" class="small-text item-sp">
                                <i class="fa-brands fa-spotify"></i>
                                Listen on Spotify
                            </a>
                        </div>
                    </div>
                    <div class="post-options col">
                        <div class="status capitalize row">
                            <span>ranil wickramasinghe</span>
                            <span>sajith premadasa</span>
                        </div>
                        <button class="share raw capitalize">
                            <i class="fa-solid fa-link"></i>
                            <span> copy link </span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="live-meeting-popup">
    <div class="popup-container">
        <div class="head row">
            <div class="title">Request to Join</div>
            <div class="cls-btn btn">
                <i class="fa-solid fa-x"></i>
            </div>
        </div>
        <div class="content">
            <div class="meeting-title">Post-presedential election</div>
            <div class="date capitalize">september 24 2024</div>
            <div class="profs row">
                <div class="prof-img"></div>
                <div class="prof-img"></div>
            </div>
            <div class="seats">
                <span>12</span> more seats available
            </div>
            <div class="conf">
                Are you sure you want to join the live meeting via Zoom
                ?
            </div>
            <div class="warning">
                The invitation will be send via e-mail. You must obey
                and respect
                <a
                        href="#"
                        target="_blank"
                        class="rules"
                        rel="noopener noreferrer"
                >rules & regulations</a
                >
                in the live meeting. Any unnecessary behavior may lead
                to permanent/temporary banned from this platform
            </div>
        </div>
        <div class="btns row">
            <button class="close">close</button>
            <button class="confirm row">
                confirm <i class="fa-solid fa-check"></i>
            </button>
        </div>
    </div>
</div>
</body>
<script src="../script.js"></script>
<script src="../loadSidebar.js"></script>
<script src="./discussin.js"></script>
<script src="./reqPop.js"></script>
<script>
    const navBtns = document.querySelectorAll(".nav-btn button");

    navBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            navBtns.forEach((btn) => {
                btn.classList.remove("nav-active");
            });
            btn.classList.add("nav-active");
        });
    });
</script>
</html>
