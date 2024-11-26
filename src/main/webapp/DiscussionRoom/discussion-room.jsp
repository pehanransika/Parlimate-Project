<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Discussion Room | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./discussion-room.css" />
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
<div class="notification-msg"></div>

<<%@ include file="../index/sidebar.jsp" %>


<%@ include file="../index/header/header.jsp" %>
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
