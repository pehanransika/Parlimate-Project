<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile | Parlimate</title>
    <link rel="stylesheet" href="../../sidebar1.css" />
    <link rel="stylesheet" href="../../header.css" />
    <link rel="stylesheet" href="../../index.css" />
    <link rel="stylesheet" href="../profile.css" />
    <link rel="stylesheet" href="./edit.css" />
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
<div class="sidebar pd-1">
    <div class="searchBar">
        <input
                type="search"
                name="sideBarSearch"
                id="sideBarSearch"
                placeholder="Search..."
        />
        <label for="sideBarSearch">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
    </div>
    <div class="navs">
        <ul>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-Home"
                        value="../../index.html"
                />
                <label for="nav-Home"
                ><i class="fa-solid fa-house"></i>Home</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-announcements"
                        value="../../Announcements/announcements.html"
                />
                <label for="nav-announcements"
                ><i class="fa-solid fa-bullhorn"></i
                >Announcements</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-fundraise"
                        value="../../Fundraising/fundraising.html"
                />
                <label for="nav-fundraise"
                ><i class="fa-solid fa-coins"></i>Fundraises</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-noti"
                        value="../../notifications.html"
                />
                <label for="nav-noti">
                    <i class="fa-solid fa-bell"></i>Notifications
                </label>
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-survey"
                        value="../../Surveys/surveys.html"
                />
                <label for="nav-survey"
                ><i class="fa-solid fa-clipboard"></i>Surveys</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-discusRoom"
                        value="../../DiscussionRoom/discussion-room.html"
                />
                <label for="nav-discusRoom"
                ><i class="fa-solid fa-people-group"></i>Discussion
                    Room</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-help"
                        value="help.html"
                />
                <label for="nav-help"
                ><i class="fa-solid fa-headset"></i
                >Help/Support</label
                >
            </li>
            <li>
                <input
                        type="radio"
                        name="nav"
                        id="nav-settings"
                        value="settings.html"
                />
                <label for="nav-settings"
                ><i class="fa-solid fa-gear"></i>Settings</label
                >
            </li>
        </ul>
    </div>

    <div class="logoutBtn capitalize">
        <div class="cont">
            <input type="checkbox" name="logoutBtn" id="logoutBtn" />
            <label for="logoutBtn">
                <i class="fa-solid fa-sign-out"></i>
                <span>logout</span>
            </label>
        </div>
    </div>
</div>
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
        <div class="profile-details profile-details-edit col">
            <div class="inp-field row">
                <div class="de-titles col">
                    <div class="title b-title">Public Profile</div>
                    <div class="description">
                        This will be displayed on your profile.
                    </div>
                </div>
                <div class="de-content col">
                    <input
                            type="text"
                            name="name"
                            id="profile-name"
                            placeholder="Naleeka Kumarasinghe"
                    />

                    <input
                            type="text"
                            placeholder="@itsNaleeka"
                            name="profile-username"
                            id="profile-username"
                    />
                </div>
            </div>
            <div class="inp-field row">
                <div class="de-titles col">
                    <div class="title">Bio</div>
                    <div class="description">
                        A brief description about your self.
                    </div>
                </div>
                <div class="de-content col">
							<textarea
                                    name="user-bio"
                                    id="user-bio"
                                    placeholder="User's bio"
                            ></textarea>
                </div>
            </div>
            <div class="inp-field row">
                <div class="de-titles col">
                    <div class="title">profession</div>
                    <div class="description">
                        Your current profession.
                    </div>
                </div>
                <div class="de-content col">
                    <input
                            type="text"
                            name="name"
                            id="profile-profession"
                            placeholder="Software Engineer"
                    />
                </div>
            </div>
            <div class="inp-field row">
                <div class="de-titles col">
                    <div class="title">Birthday</div>
                </div>
                <div class="de-content col">
                    <input
                            type="date"
                            name="profile-bday"
                            id="profile-bday"
                    />
                </div>
            </div>
            <div class="inp-field row">
                <div class="de-titles col">
                    <div class="title">educational qualifications</div>
                    <div class="description">
                        Your educational qualifications.
                    </div>
                </div>
                <div class="de-content col">
                    <div class="field">
                        <input
                                type="text"
                                name="name"
                                id="profile-profession"
                                placeholder="Graduate at UOC"
                        />
                        <button class="add-btn">Add</button>
                    </div>
                    <div class="qualifications col">
								<span class="row">
									Computer Science undergraduate at UCSC
									<button class="remove-btn">x</button>
								</span>
                        <span class="row">
									Computer Science undergraduate at UCSC
									<button class="remove-btn">x</button>
								</span>
                    </div>
                </div>
            </div>
            <div class="form-btns row">
                <button class="btn cap cancel-btn">cancel</button>
                <button class="btn cap save-btn">save changes</button>
            </div>
        </div>
        <div class="reset-password col">
            <h3 class="title">reset password</h3>
            <p>Do you want to change your password ?</p>
            <div class="password-fields col">
                <div class="pswd-field">
                    <input
                            type="password"
                            placeholder="Enter your current password"
                    />
                    <i class="fa-solid fa-eye"></i>
                </div>
                <div class="pswd-field">
                    <input
                            type="password"
                            placeholder="Enter your new password"
                    />
                    <i class="fa-solid fa-eye"></i>
                </div>
                <div class="pswd-field">
                    <input
                            type="password"
                            placeholder="Confirm your new password "
                    />
                    <i class="fa-solid fa-eye"></i>
                </div>
            </div>
            <div class="confirm">
                <button class="confirm-btn cap btn">confirm</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="../../script.js"></script>
<script>
    const eyes = document.querySelectorAll(".fa-eye");
    eyes.forEach((eye) => {
        eye.addEventListener("click", () => {
            const input = eye.previousElementSibling;
            if (input.type === "password") {
                input.type = "text";
                eye.classList.remove("fa-eye");
                eye.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                eye.classList.remove("fa-eye-slash");
                eye.classList.add("fa-eye");
            }
        });
    });
</script>
</html>
