

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundraisers</title>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="fundraising.css" rel="stylesheet">
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../container.css" />

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
<body>
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
<div class="container">
    <main>
        <div class="fundraisers-container">
            <div id="fundraisers" class="section">
                <h2>Fundraisers</h2>
                <table class="fundraisers-table">
                    <tr>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Ms. Saint-Martin Doranyia Pascal's Contribution to Political Platform</h3>
                                <p>Ms. Saint-Martin Doranyia Pascal is reported to have made a real donation to a political platform...</p>
                                <div class="donation-amount">
                                    <p>LKR.182.49</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Another Donor's Contribution</h3>
                                <p>This donor has contributed significantly to a political cause...</p>
                                <div class="donation-amount">
                                    <p>LKR.250.00</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Third Donor's Contribution</h3>
                                <p>Another significant contribution to the political platform...</p>
                                <div class="donation-amount">
                                    <p>LKR.300.00</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Fourth Donor's Contribution</h3>
                                <p>This donor is also making a difference with their contribution...</p>
                                <div class="donation-amount">
                                    <p>LKR.500.00</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Fifth Donor's Contribution</h3>
                                <p>An important contribution that supports our cause...</p>
                                <div class="donation-amount">
                                    <p>LKR.350.00</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                        <td>
                            <div class="fundraiser-card">
                                <img src="images/tree.jpg" alt="Donation Image">
                                <h3>Sixth Donor's Contribution</h3>
                                <p>Another valuable contribution helping the platform...</p>
                                <div class="donation-amount">
                                    <p>LKR.450.00</p>
                                </div>
                                <button class="view-more">View More</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="more-donations-container">
                <button class="more-donations"><i class="bx bx-plus"></i> More Donations</button>
            </div>
            <div class="fundraiser-actions">
                <button class="donate">Donate</button>
                <button class="report">Report</button>
            </div>

        </div>
    </main>
</div>
</body>
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
</script>
</html>
