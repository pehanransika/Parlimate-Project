<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                            <div class="ann-title">${announcement.title}</div>
                </div>
                <p class="announcement-content">
                        ${announcement.content}
                </p>
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
            <input type="hidden" name="announcementid" id="announcementid"/>
            <input type="hidden" name="politicianid" id="politicianid"/>

            <!-- Title Section -->
            <div class="formSection">
                <label for="editTitle">Title</label>
                <input type="text" id="editTitle" name="title" placeholder="Edit title here..." required/>
            </div>

            <!-- Content Section -->
            <div class="formSection">
                <label for="editContent">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>

            <!-- Date and Time Section -->


            <!-- Save Button -->
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
