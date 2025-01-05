<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<<<<<<< HEAD
<%
    HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<html>
<head>
    <title>My announcements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="../container.css"/>
=======

<html>
<head>
    <title>Announcements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fb;
            margin: 20px;
            padding: 20px;
        }
        body.sidebar-deactive .sidebar {
            transform: translateX(-100%);
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-top: 80px;

        }

        .button-home {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .button-home:hover {
            background-color: #0056b3;
        }

        h2 {
            color: #3a3a3a;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Search Input Styles */
        #searchInput {
            width: 100%;
            max-width: 200px;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            margin-left: 250px;
        }

        #searchInput:focus {
            border-color: #007bff;
        }

        /* Announcement List Styles */
        .announcement-list {
            list-style-type: none;
            padding: 0;
            margin-left: 300px;
            margin-right: 20px;
            gap: 1.5rem;
        }


        .announcement-item {
            background-color: #ffffff;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            position: relative;
            display: flex;
            cursor: pointer;
            flex-direction: column;
            gap: 15px;
        }
        .announcement-item:hover {
            outline: 1px solid rgb(185, 185, 185);
            border-left: 0.75rem solid #5490FF;
        }


        .announcement-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .announcement-info h3 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }

        .announcement-info p {
            margin: 0;
            font-size: 14px;
            color: #888;
        }

        .announcement-content {
            margin-top: 10px;
            font-size: 16px;
            color: #555;
        }

        /* Button Styles */
        .announcement-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .button {
            border: none;
            padding: 10px 0; /* Adjusted padding for consistent height */
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            width: 100px; /* Ensures both buttons have the same width */
            height: 40px; /* Ensures both buttons have the same height */
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .button-update {
            background-color: #6a5acd; /* Light purple */
            color: white;
        }

        .button-update:hover {
            background-color: #5b4ab5;
        }

        .button-delete {
            background-color: #f44336; /* Red */
            color: white;
        }

        .button-delete:hover {
            background-color: #e53935;
        }

        /* Popup Modal Styles */
        .popup-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .popup {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            position: relative;
        }

        .popup .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }

        .formSection {
            margin-bottom: 15px;
        }

        .formSection label {
            display: block;
            margin-bottom: 5px;
        }

        .formSection input, .formSection textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .popbtns {
            text-align: center;
            margin-top: 20px;
        }

        .post-btn {
            padding: 10px 20px;
            background-color: #6a5acd;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .post-btn:hover {
            background-color: #5b4ab5;
        }
    </style>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../container.css" />
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
    <link rel="stylesheet" href="./ann.css">
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
<<<<<<< HEAD
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <div class="pageTitles">
        <h2 class="title">My Announcements</h2>
        <div class="subTitle">All your published announcements</div>
    </div>

    <div class="search">
        <label for="searchInput" class="search-icon">
            <i class="fa-classic fa-solid fa-magnifying-glass fa-fw"></i>
        </label>
        <input type="text" id="searchInput" placeholder="Search announcements..." onkeyup="filterAnnouncements()">
    </div>

    <ul class="announcement-list">
        <c:forEach var="announcement" items="${allannouncements}">
            <li class="announcement-item col">
                <div class="announcement-header">
                    <div class="announcement-info row">
                        <div class="ann-pub-img"></div>
                        <div class="publisher">
                            <div class="ann-publisher">
                                    ${announcement.politicianName != null ? announcement.politicianName : "Unknown"}
                            </div>
                            <p class="ann-date">
                                <i class="fa-solid fa-clock"></i>
                                    ${announcement.datetime}</p>
                        </div>
                    </div>
                </div>
                <div class="cont col">
                    <p class="ann-title">${announcement.title}</p>
                    <p class="announcement-content">
                            ${announcement.content}
                    </p>

                </div>
                <div class="announcement-actions">
                    <!-- Update Button triggers the popup modal with announcement data -->
                    <button class="button button-update"
                            onclick="openEditPopup('${announcement.announcementid}', '${announcement.politicianid}', '${fn:escapeXml(announcement.title)}', '${fn:escapeXml(announcement.content)}', '${announcement.datetime}')">
                        Edit
                    </button>

                    <!-- Delete Button -->
                    <form action="DeleteServlet" method="post"
                          onsubmit="return confirm('Are you sure you want to delete this announcement?');"
                          style="display:inline;">
                        <input type="hidden" name="announcementid" value="${announcement.announcementid}"/>
                        <button type="submit" class="button button-delete">remove</button>
                    </form>
                </div>
            </li>
        </c:forEach>
    </ul>

</div>

=======

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


<div class="top-bar">

    <a href="announcements.jsp" class="button-home">Go to Announcements</a>
</div>

<h2>My Announcements</h2>

<input type="text" id="searchInput" placeholder="Search announcements..." onkeyup="filterAnnouncements()">

<ul class="announcement-list">
    <c:forEach var="announcement" items="${allannouncements}">
        <li class="announcement-item">
            <div class="announcement-header">
                <div class="announcement-info">
                    <h3>By: ${announcement.politicianName != null ? announcement.politicianName : "Unknown"}</h3>
                    <h3>${announcement.title}</h3>
                    <p>${announcement.datetime}</p>


                </div>
            </div>
            <div class="announcement-content">
                    ${announcement.content}
            </div>
            <div class="announcement-actions">
                <!-- Update Button triggers the popup modal with announcement data -->
                <button class="button button-update" onclick="openEditPopup('${announcement.announcementid}', '${announcement.politicianid}', '${fn:escapeXml(announcement.title)}', '${fn:escapeXml(announcement.content)}', '${announcement.datetime}')">Update</button>

                <!-- Delete Button -->
                <form action="DeleteServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this announcement?');" style="display:inline;">
                    <input type="hidden" name="announcementid" value="${announcement.announcementid}" />
                    <button type="submit" class="button button-delete">Delete</button>
                </form>
            </div>
        </li>
    </c:forEach>
</ul>

>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
<!-- Update Announcement Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <div class="title">
            <span>Edit Announcement</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>

        <form action="UpdateServlet" method="post">
            <!-- Hidden fields for announcement ID and politician ID -->
<<<<<<< HEAD
            <input type="hidden" name="announcementid" id="announcementid"/>
            <input type="hidden" name="politicianid" id="politicianid"/>
=======
            <input type="hidden" name="announcementid" id="announcementid" />
            <input type="hidden" name="politicianid" id="politicianid" />
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595

            <!-- Title Section -->
            <div class="formSection">
                <label for="editTitle">Title</label>
<<<<<<< HEAD
                <input type="text" id="editTitle" name="title" placeholder="Edit title here..." required/>
=======
                <input type="text" id="editTitle" name="title" placeholder="Edit title here..." required />
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
            </div>

            <!-- Content Section -->
            <div class="formSection">
                <label for="editContent">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>

<<<<<<< HEAD

=======
            <!-- Date and Time Section -->


            <!-- Save Button -->
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>
    </div>

</div>

<script>
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            if (body.classList.contains("sidebar-deactive")) {
                body.classList.remove("sidebar-deactive");
            } else {
                body.classList.add("sidebar-deactive");
            }
        });
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        });
    });
<<<<<<< HEAD

=======
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
    // Function to open the modal and populate the form
    function openEditPopup(announcementid, politicianid, title, content, datetime) {
        // Show the popup modal
        document.getElementById('editPopup').style.display = 'flex';

        // Remove milliseconds from the datetime value
        const formattedDatetime = datetime.substring(0, 16);

        // Populate the form with the current announcement data
        document.getElementById('announcementid').value = announcementid;
        document.getElementById('politicianid').value = politicianid;
        document.getElementById('editTitle').value = title;
        document.getElementById('editContent').value = content;
        document.getElementById('editDatetime').value = formattedDatetime;
    }

    // Function to close the popup modal
    function closeEditPopup() {
        // Hide the popup modal
        document.getElementById('editPopup').style.display = 'none';
    }

    // Function to filter announcements
    function filterAnnouncements() {
        const input = document.getElementById("searchInput").value.toUpperCase();
        const listItems = document.querySelectorAll(".announcement-item");

        listItems.forEach(item => {
            const text = item.textContent || item.innerText;
            item.style.display = text.toUpperCase().includes(input) ? "" : "none";
        });
    }

</script>
<script src="../script.js"></script>
</body>

</html>
