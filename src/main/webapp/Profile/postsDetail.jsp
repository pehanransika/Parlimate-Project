<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My posts</title>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="../container.css"/>
    <link rel="stylesheet" href="../postDetails.css"/>
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

    <style>
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
</head>

<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<div class="container">
    <div class="pageTitles">
        <h2 class="title">My posts</h2>
        <div class="subTitle">Political activities and Discussions</div>
    </div>

    <div class="search">
        <label for="searchInput" class="icon">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
        <input type="text" id="searchInput" placeholder="Search posts..." onkeyup="filterAnnouncements()">
    </div>
    <ul class="post-list">
        <c:forEach var="post" items="${allposts}">
            <li class="post-item post reactable">
                <div class="post-header row">
                    <div class="pro-img"></div>
                    <div class="posted-by col">
                        <p class="pName">${post.name}</p>
                        <p class="pDate">${post.datetime}</p>
                    </div>
                </div>
                <div class="post-content">
                    <div class="seperator sepT"></div>
                        ${post.content}
                </div>
                <div class="post-actions">
                    <!-- Update Button triggers the popup modal with announcement data -->
                    <button class="button button-update"
                            onclick="openEditPopup('${post.postId}', '${post.userId}',  '${fn:escapeXml(post.content)}', '${post.datetime}')">
                        Update
                    </button>


                    <!-- Delete Button -->
                    <form action="DeletePostServlet" method="post"
                          onsubmit="return confirm('Are you sure you want to delete this post?');"
                          style="display:inline;">
                        <input type="hidden" name="postid" value="${post.postId}"/>
                        <button type="submit" class="button button-delete">Delete</button>
                    </form>


                </div>
                <div class="reactions">
                    <button class="like btn">
					<span class="reactIcon">
						<i class="fa-solid fa-thumbs-up"></i>
					</span>
                        <span>like</span>
                        <span class="count"> 32k </span>
                    </button>
                    <button class="comment btn">
					<span class="reactIcon">
						<i class="fa-solid fa-message"></i>
					</span>
                        <span>comment</span>
                        <span class="count">1k</span>
                    </button>
                    <button class="share btn">
					<span class="reactIcon">
						<i class="fa-duotone fa-solid fa-share-all"></i>
					</span>
                        <span>share</span>
                    </button>
                </div>
            </li>
            &nbsp;&nbsp;
        </c:forEach>
    </ul>
</div>

<!-- Update Announcement Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <div class="title">
            <span>Edit Post</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>

        <form action="UpdatePostServlet" method="post">
            <!-- Hidden fields for post ID and user ID -->
            <input type="hidden" name="postid" id="postid" value="${postid}"/>
            <input type="hidden" name="userid" id="userid" value="${userid}"/>

            <!-- Content Section -->
            <div class="formSection">
                <label for="editContent">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>

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
    function openEditPopup(postid, userid, content, datetime) {
        // Show the popup modal
        document.getElementById('editPopup').style.display = 'flex';

        // Remove milliseconds from the datetime value
        const formattedDatetime = datetime.substring(0, 16);

        // Populate the form with the current announcement data
        document.getElementById('postid').value = postid;
        document.getElementById('userid').value = userid;

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
