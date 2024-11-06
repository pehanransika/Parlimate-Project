<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./announcement.css" />
    <!-- <link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css""
/> -->

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
<body class="">

<%@ include file="../index/sidebar.jsp" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="./index.html">
                PARLIMATE
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
        <h2 class="title">Announcements</h2>
        <div class="subTitle">
            Politicians and political parties announcements
        </div>
    </div>
    <div class="row">
        <div class="announcements col">
            <!-- Announcement Card 1 -->
            <div class="post announcement-card">
                <div class="post-head">
                    <div class="post-details row">
                        <div class="img"></div>
                        <div class="user-details col">
                            <div class="name">Himasha Chinthani</div>
                            <div class="posted-date row">
										<span class="date"
                                        >August 10, 2024</span
                                        >
                                <span class="time">10:00 AM</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content col">
                    <h2 class="post-title">Team Meeting Update</h2>
                    <p>
                        There will be a team meeting next week to
                        discuss the project progress. Please be prepared
                        with your updates and reports.
                    </p>
                    <div class="location">
                        <span>Location: Conference Room 2</span>
                    </div>
                </div>
            </div>

            <!-- Announcement Card 2 -->
            <div class="post announcement-card">
                <div class="post-head">
                    <div class="post-details row">
                        <div class="img"></div>
                        <div class="user-details col">
                            <div class="name">Naleeka Kumarasinghe</div>
                            <div class="posted-date row">
										<span class="date"
                                        >August 11, 2024</span
                                        >
                                <span class="time">2:00 PM</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content col">
                    <h2 class="post-title">New Policy Announcement</h2>
                    <p>
                        A new company policy has been introduced
                        regarding remote work. All employees are
                        required to follow the new guidelines starting
                        from next month.
                    </p>
                    <div class="location">
                        <span>Location: HR Office</span>
                    </div>
                </div>
            </div>

            <!-- Add more cards as needed -->
            <div class="post announcement-card">
                <div class="post-head">
                    <div class="post-details">
                        <div class="img"></div>
                        <div>
                            <div class="name">Pehan Ransika</div>
                            <div class="posted-date">
                                <span>August 11, 2024</span>
                                <span>2:00 PM</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <h2 class="post-title">New Policy Announcement</h2>
                    <p>
                        A new company policy has been introduced
                        regarding remote work. All employees are
                        required to follow the new guidelines starting
                        from next month. A new company policy has been
                        introduced regarding remote work. All employees
                        are required to follow the new guidelines
                        starting from next month. A new company policy
                        has been introduced regarding remote work. All
                        employees are required to follow the new
                        guidelines starting from next month. A new
                        company policy has been introduced regarding
                        remote work. All employees are required to
                        follow the new guidelines starting from next
                        month. A new company policy has been introduced
                        regarding remote work. All employees are
                        required to follow the new guidelines starting
                        from next month.
                    </p>
                    <div class="location">
                        <span>Location: HR Office</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Politicians container -->
        <div class="politician-container">
            <div class="politician-card">
                <img src="path/to/photo.jpg" alt="Politician Photo" />
                <div class="politician-details">
                    <h3>Politician Name</h3>
                    <p>Political Party</p>
                    <p>District</p>
                </div>
            </div>
            <!-- More politician cards go here -->
            <div class="politician-card">
                <img src="path/to/photo.jpg" alt="Politician Photo" />
                <div class="politician-details">
                    <h3>Politician Name</h3>
                    <p>Political Party</p>
                    <p>District</p>
                </div>
            </div>

            <div class="politician-card">
                <img src="path/to/photo.jpg" alt="Politician Photo" />
                <div class="politician-details">
                    <h3>Politician Name</h3>
                    <p>Political Party</p>
                    <p>District</p>
                </div>
            </div>

            <div class="politician-card">
                <img src="path/to/photo.jpg" alt="Politician Photo" />
                <div class="politician-details">
                    <h3>Politician Name</h3>
                    <p>Political Party</p>
                    <p>District</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../script.js"></script>
</body>
</html>
