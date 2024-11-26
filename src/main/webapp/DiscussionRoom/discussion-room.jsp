<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Discussion Room | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
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
    <style>
        .logo-img{
            height: 1.3rem;
        }
    </style>
</head>
<body class="">

<div class="reqPop">
    <div class="bg"></div>
    <form action="CreateMeetingRequestServlet" method="post">
        <input type="hidden" name="politicianid" value="123">


        <div class="head">
            <div id="meetClsBtn">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                    <path d="..." stroke="#292929" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
            </div>
            <div class="title">Request Discussion</div>
            <div class="separator"></div>
        </div>
        <div class="body">
            <div id="progress" class="progress row">
                <div class="item item-active" data-title="DebDetails">Debate Details</div>
                <div class="item" data-title="OppDetails">Opponents Info</div>
                <div class="item" data-title="AddDetails">Additional Information</div>
                <div class="separator"></div>
            </div>
            <div class="input-container">
                <!-- Debate Details -->
                <div class="input-group form-active">
                    <div class="field">
                        <label class="title" for="disc-title">Proposed Title</label>
                        <input type="text" name="topic" id="disc-title" required placeholder="Education reform policies" />
                    </div>
                    <div class="field">
                        <label class="title" for="disc-desc">Purpose of the debate</label>
                        <textarea name="purposeofmeeting" id="disc-desc" required placeholder="To discuss proposed funding strategies"></textarea>
                    </div>
                    <div class="multi-fields">
                        <div class="field">
                            <label class="title" for="disc-date">Proposed Date</label>
                            <input type="date" name="proposaldate" id="disc-date" required />
                        </div>
                        <div class="field">
                            <label class="title" for="disc-time">Time</label>
                            <input type="time" name="proposaltime" id="disc-time" required />
                        </div>
                    </div>
                    <div class="field">
                        <label class="title" for="disc-dur">Estimated Duration</label>
                        <div class="drop-type">
                            <select name="time_unit" id="time-unit">
                                <option value="hour">hour</option>
                                <option value="minute">minute</option>
                            </select>
                            <input type="number" name="estimatedduration" id="disc-dur" placeholder="2" required />
                        </div>
                    </div>
                    <div class="bottom">
                        <button type="button" class="cancel-btn btn">Cancel</button>
                        <button type="button" class="next-btn btn">Next <i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                </div>
                <!-- Opponents Info -->
                <div class="input-group">
                    <div class="field">
                        <label class="title" for="disc-opNames">Opponents names</label>
                        <input type="text" name="opponentname" id="disc-opNames" required placeholder="Sajith Premadasa" />
                    </div>
                    <div class="field">
                        <label class="title" for="disc-party-aff">Party Affiliation(s)</label>
                        <input type="text" name="partyaffiliation" required placeholder="Samagi Jana Balawegaya" id="disc-party-aff" />
                    </div>
                    <div class="bottom">
                        <button type="button" class="prev-btn btn">Back</button>
                        <button type="button" class="next-btn btn">Next <i class="fa-solid fa-arrow-right"></i></button>
                    </div>
                </div>
                <!-- Additional Information -->
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
                    <div class="field">
                        <label class="title" for="disc-party-aff">Preferred Host <span>(Optional)</span></label>
                        <input type="text" name="preferredhost" placeholder="Chathura Senarathne" id="disc-party-aff" />
                    </div>
                    <div class="bottom">
                        <button type="button" class="prev-btn btn">Back</button>
                        <button type="submit" class="next-btn btn">Request <i class="fa-solid fa-check"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </form>


</div>
<div class="notification-msg"></div>

<<%@ include file="../index/sidebar.jsp" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="./index.jsp">
                <img src="../logo%202.png" class="logo-img" alt="">
            </a>
        </div>
    </div>
    <div class="headerSearchBar row">
        <input type="search" name="mainSearch" id="headerSearchBar"
               placeholder="Search politicians, Political parties...." />
        <label for="headerSearchBar">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
    </div>
    <div class="headerBtns">
        <div class="headerBtn">
            <input type="checkbox" name="notifi" id="notificationBtn" />
            <label for="notificationBtn" class="btn">
                <i class="fa-solid fa-bell"></i>
            </label>
            <span class="tip">notifications</span>
            <div class="dropDownMenu">
                <ul>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                </ul>
                <a href="./Announcements/announcements.html" class="bottom-btn small-text capitalize">
                    see all notifications
                </a>
            </div>
        </div>
        <div class="headerBtn">
            <input type="checkbox" name="profile" id="profileBtn" />
            <label for="profileBtn" class="btn">
                <i class="fa-solid fa-user"></i>
            </label>
            <span class="tip">profile</span>
            <div class="dropDownMenu">
                <div class="profile">
                    <a href="../Profile/profile.html">
                        <div class="img"></div>
                        <div class="details">
                            <div class="name medium-text bold">
                                Naleeka Kumarasinghe
                            </div>
                            <div class="email small-text">
                                knaleeka845@gmail.com
                            </div>
                        </div>
                    </a>
                </div>
                <ul class="capitalize">
                    <li>
                        <a href="#">
									<span>
										<i class="fa-regular fa-gear"></i>
									</span>
                            <span> account settings </span>
                        </a>
                    </li>
                    <div class="sep-line"></div>
                    <li>
                        <a href="#">
									<span>
										<i class="fa-regular fa-circle-question"></i>
									</span>
                            <span> help center </span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
									<span>
										<i class="fa-regular fa-star"></i>
									</span>
                            <span> upgrade plan </span>
                        </a>
                    </li>
                    <div class="sep-line"></div>

                    <li>
                        <div class="logoutBtn capitalize">
                            <div class="cont">
                                <input type="checkbox" name="logoutBtn" id="logoutBtn" />
                                <label for="logoutBtn">
                                    <i class="fa-solid fa-sign-out"></i>
                                    <span>logout</span>
                                </label>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container col">
    <div class="pageTitles">
        <h2 class="title">Discussion room</h2>
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
            <!-- <div class="body-top row">
                <div class="sort-btn row capitalize">
                    <i class="fa-regular fa-bars-filter"></i>
                    <span class="sort-type">newest first</span>
                </div>
            </div> -->
            <div class="newmeeting row">
						<span> request meeting </span
                        ><i class="fa-solid fa-pencil"></i>
            </div>
            <div class="items col">
                <div
                        class="item live row"
                        style="animation-delay: 0.25s"
                >
                    <div class="panelists">
                        <div class="pImgs row">
                            <div class="prof-img">
                                <img src="../assets/ranil.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images.jpeg"
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
                                <img src="../assets/AKD.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images.jpeg"
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
                                <img src="../assets/AKD.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images.jpeg"
                                        alt=""
                                />
                            </div>
                            <div class="prof-img">
                                <img src="../assets/ranil.jpg" alt="" />
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
                                        src="../assets/images.jpeg"
                                        alt=""
                                />
                            </div>
                        </div>
                    </div>
                    <div class="item-content col">
                        <div class="item-title">
                            <div class="title">
                                How to Improve the Education System with
                                the Help of Sajith Premadasa’s
                                ‘Cake-Cutting’ Strategies!
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
                                <img src="../assets/AKD.jpg" alt="" />
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
                                <img src="../assets/ranil.jpg" alt="" />
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
                                <img src="../assets/ranil.jpg" alt="" />
                            </div>
                            <div class="prof-img">
                                <img
                                        src="../assets/images.jpeg"
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
<script src="./discussin.js"></script>
<script src="reqPop.js"></script>
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
