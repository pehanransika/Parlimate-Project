<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./profile.css" />
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
<body>

<%@ include file="../index/sidebar.jsp" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="./index.html"> PARLIMATE </a>
        </div>
    </div>
    <div class="headerSearchBar row">
        <input
                type="search"
                name="mainSearch"
                id="headerSearchBar"
                placeholder="Search politicians, Political parties...."
        />
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
                                <span
                                >Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span
                                >
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
                                <span
                                >Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span
                                >
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
                                <span
                                >Lorem, ipsum dolor sit amet
											consectetur adipisicing elit. Qui,
											ullam. Quos aperiam in re</span
                                >
                            </div>
                        </a>
                    </li>
                </ul>
                <a
                        href="./Announcements/announcements.html"
                        class="bottom-btn small-text capitalize"
                >
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
                    <a href="#">
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
										<i
                                                class="fa-regular fa-circle-question"
                                        ></i>
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
                                <input
                                        type="checkbox"
                                        name="logoutBtn"
                                        id="logoutBtn"
                                />
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
    <div class="pro-imgs">
        <div class="cover-bg"></div>
        <div class="profile-pic"></div>
    </div>
    <div class="profile-container">
        <div class="profile-details col">
            <div class="user-ac row jc-sb">
                <div class="content-1 col">
                    <div class="name capitalize">
                        Naleeka Kumarasinghe
                        <span class="verified">verified</span>
                    </div>
                    <div class="row">
                        <div class="uName">
                            <i class="fa-regular fa-at"></i>
                            itsNaleeka
                        </div>

                        <div class="city">
                            <i class="fa-solid fa-location-dot"></i>
                            Kandy
                        </div>
                        <div class="jDate">
                            <i class="fa-solid fa-calendar"></i>
                            Joined on<span>Aug 2024</span>
                        </div>
                    </div>
                </div>
                <div class="content-2 row">
                    <div class="btn message capitalize row">
                        message
                    </div>
                    <div class="options btn">
                        <i class="fa-solid fa-ellipsis"></i>
                    </div>
                </div>
            </div>
            <div class="profession row">
                <i class="fa-solid fa-briefcase"></i>
                <span>Software Engineer</span>
            </div>
            <div class="bio col">
                <div class="title">Bio :</div>
                <span class="bio-content">
							A passionate advocate for change, [Your Name]
							believes in the power of informed and active
							citizenship. With a keen interest in politics and
							public policy, [he/she/they] is committed to staying
							updated on current issues and engaging in meaningful
							discussions. [Your Name] strives to bridge the gap
							between citizens and policymakers, ensuring that
							community voices are heard and represented. Whether
							it’s through online debates, local meetings, or
							volunteering, [he/she/they] is dedicated to making a
							difference and fostering a more inclusive and
							transparent political landscape.
						</span>
            </div>
            <div class="pol-interest">
                <div class="title">Political Interests</div>
                <div class="tags capitalize">
                    <a href="#"
                    >anura kumara dissanayake<span> AKD </span></a
                    >
                    <a href="#"
                    >Sunil Hadunhetti<span>hadunhettiSunil</span></a
                    >
                    <a href="#"
                    >Vijitha rajapakse<span>vijithaR</span></a
                    >
                    <a href="#"
                    >Harini amarasuriya<span>HariniA</span></a
                    >
                    <a href="#"
                    >Mahinda Rajapakse<span>mahindaR</span></a
                    >
                    <a href="#"
                    >Ranil Wickramasinghe<span>RanilW</span></a
                    >
                </div>
            </div>
        </div>
        <a href="./editProfile/edit.jsp" class="edit-btn btn row capitalize">
            <i class="fa-solid fa-pen-to-square"></i>
            edit profile
        </a>
    </div>
</div>
</body>
<script src="../script.js"></script>
</html>
