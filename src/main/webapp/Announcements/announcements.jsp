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
    <link rel="stylesheet" href="./pop.css">
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
    <div class="popup-modal">
        <div class="popup">
            <div class="title">
                New Announcement
                <div class="close-btn btn" id="popup-close-btn">
                    <i class="fa-solid fa-times"></i>
                </div>
                <div class="breakLine"></div>
            </div>
            <div class="content">
                <div class="account row">
                    <div class="user-profile">
                        <div class="prof-img"></div>
                        <div class="user-name">Manuja Ransara</div>
                    </div>
                    <div class="switch-btn capitalize">
                        <a href="#"
                        >switch account
                            <i class="fa-regular fa-chevron-down"></i
                            ></a>
                    </div>
                </div>
                <div class="discussion-title col">
                    <div class="title capitalize">title</div>
                    <input
                            autocomplete="off"
                            type="text"
                            name="add-post-title"
                            id="add-post-title"
                            placeholder="Enter the title of the announcement"
                    />
                </div>
                <div class="caption-box col content-pd">
                    <div class="title capitalize">content</div>
                    <textarea
                            autocomplete="off"
                            name="add-post-caption"
                            id="add-post-caption"
                            placeholder="Enter the content of the announcement"
                    ></textarea>
                </div>

                <div class="popbtns capitalize">
                    <div class="clear-btn" id="popup-clear-btn">
                        Clear
                        <i class="fa-sharp fa-solid fa-rotate-left"></i>
                    </div>
                    <div class="post-btn" id="popup-post-btn">
                        post announcement
                        <i class="fa-duotone fa-solid fa-check"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="popup-modal" id="editPopup">
        <div class="popup">
            <div class="title">
                <span>Edit Announcement</span>
                <button id="popup-close-btn" onclick="closeEditPopup()">
                    <i class="fa-solid fa-times"></i>
                </button>
                <div class="breakLine"></div>
            </div>
            <div class="content">
                <div class="formSection">
                    <label for="editTitle">Title</label>
                    <input
                            type="text"
                            id="editTitle"
                            placeholder="Edit title here..."
                    />
                </div>

                <div class="formSection">
                    <label for="editContent">Content</label>
                    <textarea
                            id="editContent"
                            placeholder="Edit content here..."
                    ></textarea>
                </div>

                <div class="popbtns">
                    <div class="post-btn" onclick="saveEdit()">Save</div>
                </div>
            </div>
        </div>
    </div>
    <div class="popup-modal" id="deletePopup">
        <div class="popup">
            <div class="title">
                <span>Confirm Deletion</span>
                <button id="popup-close-btn" onclick="closeDeletePopup()">X</button>
                <div class="breakLine"></div>
            </div>
            <div class="content">
                <p>Are you sure you want to delete this announcement?</p>
                <div class="popbtns">
                    <div class="post-btn" onclick="confirmDelete()">Yes, Delete</div>
                    <div onclick="closeDeletePopup()">Cancel</div>
                </div>
            </div>
        </div>
    </div>

    <div class="pageTitles">
        <h2 class="title">Announcements</h2>
        <div class="subTitle">
            Politicians and political parties announcements
        </div>
    </div>
    <div class="row">
        <div class="announcements col">
            <button class="add-announcement">
                <i class="fa-solid fa-plus"></i>
                <span> add announcement </span>
            </button>

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
                    <div class="ann-btns rown">
                        <button
                                class="edit-btn"
                                onclick="openEditPopup(this)"
                        >
                            Edit
                        </button>
                        <button class="delete-btn" onclick="openDeletePopup(this)">Delete</button>

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
                    <div class="ann-btns rown">
                        <button
                                class="edit-btn"
                                onclick="openEditPopup(this)"
                        >
                            Edit
                        </button>
                        <button class="delete-btn" onclick="openDeletePopup(this)">Delete</button>

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
                    <div class="ann-btns rown">
                        <button
                                class="edit-btn"
                                onclick="openEditPopup(this)"
                        >
                            Edit
                        </button>
                        <button class="delete-btn" onclick="openDeletePopup(this)">Delete</button>

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

<script>
    const addAnnBtn = document.querySelector("button.add-announcement");
    const popCloseBtn = document.querySelector("#popup-close-btn");


    closeEditPopup();
    closeDeletePopup();


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

    function openEditPopup(button) {
        const card = button.closest(".announcement-card");
        const title = card.querySelector(".post-title").innerText;
        const content = card.querySelector(".content p").innerText;

        document.getElementById("editTitle").value = title;
        document.getElementById("editContent").value = content;

        document.body.classList.add("popup-active-edit");
        document.getElementById("editPopup").style.display = "block";

        // Store reference to the card being edited
        document.getElementById("editPopup").dataset.currentCard = card;
    }

    function closeEditPopup() {
        document.body.classList.remove("popup-active-edit");
        document.getElementById("editPopup").style.display = "none";
    }

    function saveEdit() {
        const card =
            document.getElementById("editPopup").dataset.currentCard;
        const title = document.getElementById("editTitle").value;
        const content = document.getElementById("editContent").value;

        // Update the card with new values
        card.querySelector(".post-title").innerText = title;
        card.querySelector(".content p").innerText = content;

        // Close the popup
        closeEditPopup();
    }


    // delete announcement
    function openDeletePopup(button) {
        const card = button.closest('.announcement-card');

        // Store reference to the card being deleted
        document.getElementById('deletePopup').dataset.currentCard = card;

        document.body.classList.add('popup-active-delete');
        document.getElementById('deletePopup').style.display = 'block';
    }

    function closeDeletePopup() {
        document.body.classList.remove('popup-active-delete');
        document.getElementById('deletePopup').style.display = 'none';
    }

    function confirmDelete() {
        const card = document.getElementById('deletePopup').dataset.currentCard;

        // Remove the card from the DOM
        card.remove();

        // Close the popup
        closeDeletePopup();
    }

</script>
<script src="../script.js"></script>
</body>
</html>
