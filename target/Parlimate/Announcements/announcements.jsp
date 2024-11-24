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
    <link rel="stylesheet" href="./ann.css" />

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />
</head>
<body>

<%@ include file="../index/sidebar.jsp" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-solid fa-bars"></i>
        </div>
        <div class="logo">
            <a href="./index.html">PARLIMATE</a>
        </div>
    </div>
    <div class="headerBtns">
        <div class="headerBtn">
            <input type="checkbox" name="profile" id="profileBtn" />
            <label for="profileBtn" class="btn">
                <i class="fa-solid fa-user"></i>
            </label>
            <div class="dropDownMenu">
                <div class="profile">
                    <a href="../Profile/profile.html">
                        <div class="details">
                            <div class="name medium-text bold">Naleeka Kumarasinghe</div>
                            <div class="email small-text">knaleeka845@gmail.com</div>
                        </div>
                    </a>
                </div>
                <ul>
                    <li><a href="#">Account Settings</a></li>
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Upgrade Plan</a></li>
                    <li>
                        <div class="logoutBtn">
                            <input type="checkbox" name="logoutBtn" id="logoutBtn" />
                            <label for="logoutBtn">
                                <i class="fa-solid fa-sign-out"></i> Logout
                            </label>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container col">
    <div class="popup-modal">
        <div class="popup">
            <!-- Announcement Form -->
            <form action="PublishAnnouncementServlet" method="post">
                <div class="title">
                    New Announcement
                    <div class="close-btn btn" id="popup-close-btn">
                        <i class="fa-solid fa-times"></i>
                    </div>
                    <div class="breakLine"></div>
                </div>
                <div class="content">
                    <!-- Politician ID (hidden field) -->
                    <input type="hidden" name="politicianid" id="politicianid" value="1" />

                    <!-- Announcement Title -->
                    <div class="discussion-title col">
                        <label for="add-post-title">Title</label>
                        <input
                                autocomplete="off"
                                type="text"
                                name="title"
                                id="add-post-title"
                                placeholder="Enter the title of the announcement"
                                required
                        />
                    </div>

                    <!-- Announcement Content -->
                    <div class="caption-box col content-pd">
                        <label for="add-post-caption">Content</label>
                        <textarea
                                autocomplete="off"
                                name="content"
                                id="add-post-caption"
                                placeholder="Enter the content of the announcement"
                                required
                        ></textarea>
                    </div>

                    <!-- Form Buttons -->
                    <div class="popbtns capitalize">
                        <button type="reset" class="clear-btn" id="popup-clear-btn">
                            Clear <i class="fa-solid fa-rotate-left"></i>
                        </button>
                        <button type="submit" class="post-btn" id="popup-post-btn">
                            Post Announcement <i class="fa-solid fa-check"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="pageTitles">
        <h2 class="title">Announcements</h2>
        <div class="subTitle">Politicians and political parties announcements</div>
    </div>

    <div class="announcements col">
        <button class="add-announcement" id="add-announcement-btn">
            <i class="fa-solid fa-plus"></i>
            <span> Add Announcement </span>
        </button>

        <!-- Announcement Cards Example -->
        <div class="post announcement-card">
            <div class="post-head">
                <div class="post-details row">
                    <div class="img"></div>
                    <div class="user-details col">
                        <div class="name">Naleeka Kumarasinghe</div>
                        <div class="posted-date row">
                            <span class="date">August 11, 2024</span>
                            <span class="time">2:00 PM</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content col">
                <h2 class="post-title">New Policy Announcement</h2>
                <p>
                    A new policy has been introduced regarding remote work. Please follow the new guidelines starting next month.
                </p>
            </div>
        </div>
    </div>
</div>

<script src="../script.js"></script>
<script>
    // Open and close the popup form
    const addAnnouncementBtn = document.getElementById('add-announcement-btn');
    const popupModal = document.querySelector('.popup-modal');
    const closePopupBtn = document.getElementById('popup-close-btn');

    addAnnouncementBtn.addEventListener('click', () => {
        popupModal.style.display = 'block';
    });

    closePopupBtn.addEventListener('click', () => {
        popupModal.style.display = 'none';
    });
</script>
</body>
</html>
