<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session1.getAttribute("user") == null) {
        // User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Announcements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="../container.css"/>
    <link rel="stylesheet" href="./ann.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"/>
    <link rel="stylesheet" href="../hashtag.css"/>
</head>
<body>
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
    <div class="popup-modal">
        <form class="popup-content" action="PublishAnnouncementServlet" method="post">
            <div class="close-btn" id="popup-close-btn">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="top">
                <div class="icon">
                    <i class="fa-regular fa-bullhorn"></i>
                </div>
                <div class="title">Publish an Announcement</div>
            </div>
            <div class="content f-col">
                <input type="hidden" name="politicianid" id="politicianid" value="${userProfile.politicianId}"/>
                <div class="discussion-title f-col">
                    <label for="add-post-title" class="title capitalize">Title</label>
                    <input
                            autocomplete="off"
                            type="text"
                            name="title"
                            id="add-post-title"
                            placeholder="Enter the title of the announcement"
                            required
                    />
                </div>
                <div class="caption-box col content-pd">
                    <label for="add-post-caption" class="title capitalize">Content</label>
                    <textarea
                            autocomplete="off"
                            name="content"
                            id="add-post-caption"
                            placeholder="Enter the content of the announcement"
                            required
                    ></textarea>
                </div>
            </div>
            <div class="popbtns footer f-row capitalize">
                <button type="reset" class="clear-btn scndry-btn" id="popup-clear-btn">Clear</button>
                <button type="submit" class="post-btn prmry-btn" id="popup-post-btn">
                    Post Announcement <i class="fa-solid fa-check"></i>
                </button>
            </div>
        </form>
    </div>
</c:if>
<div class="container">
    <div class="announcement-list f-col">
        <div class="top f-row">
            <div class="pageTitles">
                <h2 class="title">Announcements</h2>
                <div class="subTitle">Politicians and political parties announcements</div>
            </div>
            <c:if test="${user.userType == 'Politician' || user.userType == 'Political Party'}">
                <div class="ann-btns-2 row">
                    <div class="dropdown">
                        <div class="dropdown-toggle f-row">Actions<i class="fa-regular fa-circle-chevron-down"></i></div>
                        <div class="dropdown-menu f-col">
                            <button class="add-announcement" id="add-announcement">
                                <i class="fa-solid fa-plus"></i>
                                <span>Add Announcement</span>
                            </button>
                            <a href="GetMyAnnouncements?politicianId=${userProfile.politicianId}">
                                <button class="add-announcement">
                                    <i class="fa-solid fa-eye"></i>
                                    <span>View My Announcements</span>
                                </button>
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        <ul class="f-col">
            <c:forEach var="announcement" items="${allannouncements}">
                <li class="announcement-item f-row">
                    <div class="profile-img-content">
                        <div class="pImage"
                             data-name="${announcement.politicianName != null ? announcement.politicianName : "Unknown"}">
                            <img src="https://avatar.iran.liara.run/username?username=${fn:replace(fn:escapeXml(announcement.politicianName), ' ', '+')}"/>
<%--                            <img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/images/user_${post.userId}/${userProfile.profileImg}"--%>
                                 alt="User Profile Image"
                                 style="width: 100%; height: 100%; border-radius: 50%"
                                 onerror="this.src='${pageContext.request.contextPath}/images/Users/user.png'" />
                        </div>
                    </div>
                    <div class="ann-details">
                        <div class="announcement-header">
                            <div class="announcement-info">
                                <div class="author f-row">
                                    <div class="details">
                                        <span class="postedby">By
                                            <span class="pol-name">
                                                    ${announcement.politicianName != null ? announcement.politicianName : "Unknown"}
                                            </span>
                                        </span>
                                        <div class="ann-date f-row">
                                            <i class="fa-solid fa-clock-seven"></i>
                                            <span class="formatDate" data-date="${announcement.datetime}">
                                                    ${announcement.datetime}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="announcement-content col">
                            <span class="ann-title">${announcement.title}</span>
                            <span class="ann-content hashtags">${announcement.content}</span>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<script src="../hashtag.js"></script>
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

    const addAnnBtn = document.getElementById("add-announcement");
    const popCloseBtn = document.querySelector("#popup-close-btn");

    addAnnBtn.addEventListener("click", () => {
        if (!body.classList.contains("popup-active")) {
            body.classList.add("popup-active");
        }
    });
    popCloseBtn.addEventListener("click", () => {
        if (body.classList.contains("popup-active")) {
            body.classList.remove("popup-active");
        }
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue;
            }
        });
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const dateElements = document.querySelectorAll('.formatDate');
        dateElements.forEach(element => {
            const rawDate = element.getAttribute('data-date');
            const date = new Date(rawDate);
            const formattedDate = new Intl.DateTimeFormat('en-US', {
                month: 'long',
                day: 'numeric',
                year: 'numeric',
                hour: 'numeric',
                minute: '2-digit',
                hour12: true
            }).format(date);
            element.textContent = formattedDate;
        });

        processHashtags();
    });
</script>
<script src="../script.js"></script>
</body>
</html>