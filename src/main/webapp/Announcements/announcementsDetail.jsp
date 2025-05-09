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
    <title>My Announcements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Announcements | Parlimate</title>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/container.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Announcements/ann.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"/>
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"/>
    <link rel="stylesheet" href="../hashtag.css"/>
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>
<body class="">
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<div class="container">
    <ul class="announcement-list f-col">
        <div class="top">
            <div class="pageTitles">
                <h2 class="title">My Announcements</h2>
                <div class="subTitle">All your published announcements</div>
            </div>
            <div class="search">
                <label for="searchInput" class="search-icon">
                    <i class="fa-classic fa-solid fa-magnifying-glass fa-fw"></i>
                </label>
                <input type="text" id="searchInput" placeholder="Search announcements..."
                       onkeyup="filterAnnouncements()">
            </div>
        </div>
        <c:forEach var="announcement" items="${myannouncements}">
            <li class="announcement-item f-row">
                <div class="ann-details">
                    <div class="announcement-header">
                        <div class="announcement-info">
                            <div class="author f-col">
                                <div class="postedby f-row"> by
                                    <span class="pol-name" style="margin-left: 0.25rem">
                                            ${announcement.politicianName != null ? announcement.politicianName : "Unknown"}
                                    </span>
                                </div>
                            </div>
                            <br>
                            <div class="ann-date f-row" style="margin-top: -1rem">
                                <i class="fa-solid fa-clock-seven"></i>
                                <span class="formatDate" data-date="${announcement.datetime}">
                                        ${announcement.datetime}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="announcement-content f-col">
                        <p class="ann-title">${announcement.title}</p>
                        <p class="announcement-content hashtags">
                                ${announcement.content}
                        </p>
                    </div>
                    <div class="announcement-actions">
                        <button class="button button-update"
                                onclick="openEditPopup('${announcement.announcementid}', '${announcement.politicianid}', '${fn:escapeXml(announcement.title)}', '${fn:escapeXml(announcement.content)}', '${announcement.datetime}')">
                            Edit
                        </button>
                        <form action="DeleteServlet" method="post" class="delete-form"
                              style="display:inline;">
                            <input type="hidden" name="announcementid" value="${announcement.announcementid}"/>
                            <input type="hidden" name="politicianid" value="${announcement.politicianid}"/>
                            <button type="submit" class="button button-delete">remove</button>
                        </form>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<form action="UpdateServlet" method="post" class="popup-modal" id="editPopup">
    <div class="popup">
        <button class="close-btn" type="button" onclick="closeEditPopup()">
            <i class="fa-solid fa-times"></i>
        </button>
        <div class="top">
            <div class="icon">
                <i class="fa-regular fa-pencil"></i>
            </div>
            <div class="title">
                <span>Edit Announcement</span>
            </div>
        </div>
        <div class="popup-content f-col">
            <input type="hidden" name="announcementid" id="announcementid"/>
            <input type="hidden" name="politicianid" id="politicianid"/>
            <div class="formSection f-col">
                <label for="editTitle" class="title">Title</label>
                <input type="text" id="editTitle" name="title" placeholder="Edit title here..." required/>
            </div>
            <div class="formSection f-col">
                <label for="editContent" class="title">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>
        </div>
        <div class="footer">
            <button type="submit" class="prmry-btn post-btn">Save Changes</button>
        </div>
    </div>
</form>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                window.location.href = selectedValue;
            }
        });
    });

    function openEditPopup(announcementid, politicianid, title, content, datetime) {
        document.getElementById('editPopup').style.display = 'flex';
        const formattedDatetime = datetime.substring(0, 16);
        document.getElementById('announcementid').value = announcementid;
        document.getElementById('politicianid').value = politicianid;
        document.getElementById('editTitle').value = title;
        document.getElementById('editContent').value = content;
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }

    function filterAnnouncements() {
        const input = document.getElementById("searchInput").value.toUpperCase();
        const listItems = document.querySelectorAll(".announcement-item");
        listItems.forEach(item => {
            const text = item.textContent || item.innerText;
            item.style.display = text.toUpperCase().includes(input) ? "" : "none";
        });
    }

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

        // Handle delete confirmation with SweetAlert2
        document.querySelectorAll('.delete-form').forEach(form => {
            form.addEventListener('submit', function (e) {
                e.preventDefault();
                Swal.fire({
                    title: 'Are you sure?',
                    text: 'Do you want to delete this announcement?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });
        });

        // Handle update form submission
        document.getElementById('editPopup').addEventListener('submit', function (e) {
            e.preventDefault();
            const form = this;
            fetch(form.action, {
                method: 'POST',
                body: new FormData(form)
            }).then(response => {
                if (response.ok) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Announcement updated successfully.',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        window.location.reload();
                    });
                } else {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Failed to update announcement.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            }).catch(() => {
                Swal.fire({
                    title: 'Error!',
                    text: 'An error occurred while updating.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            });
        });

        processHashtags();
    });
</script>
<script src="../hashtag.js"></script>
<script src="../formatDate.js"></script>
<script src="../script.js"></script>
</body>
</html>