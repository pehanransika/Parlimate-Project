<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <style>


    </style>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management | Admin Dashboard</title>

    <link rel="stylesheet" href="./userManagment.css" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./profile.css"/>

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
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/solid.css"
    />
    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
    />
</head>
<body class="">
<div class="navMenu f-col center">
    <div class="logo">
        <img src="../assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="../Home/index.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="nav-item f-row active">
                    <i class="fa-regular fa-users"></i>
                    <span>user management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>fundraise management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-check-to-slot"></i>
                    <span>survey management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-cards-blank"></i>
                    <span>post management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-comments"></i>
                    <span>Comment Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>requests</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-money-bill-transfer"></i>
                    <span>bank transfer management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>platform settings</span>
                </a>
            </li>
        </ul>
        <ul>
            <li>
                <a href="#" class="f-row profile">
                    <div class="p-img"></div>
                    <div class="sUser f-col">
                        <div class="name">Naleeka Kumarasinghe</div>
                        <div class="role">Admin</div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#" class="f-row log-out">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    log out
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="pageContent">
    <div class="container f-col">
        <div class="top f-row">
            <div class="page f-col">
                <div class="page-title capitalize">User management</div>
                <div class="page-desc">
                    Manage user roles, permissions, and activity logs.
                </div>
            </div>

        </div>
        <div class="content f-col">
            <div class="topS f-row">
                <div class="show f-row">
                    Shows
                    <select name="rows" id="rows">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="50">50</option>
                    </select>
                    entries per page
                </div>

                <div class="actions f-row">
                    <div class="search-bar">
                        <label for="user-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </label>
                        <input
                                type="search"
                                placeholder="Search by name/userId"
                                name="user-search"
                                id="user-search"
                        />
                    </div>
                    <div class="filter">
                        <button class="filter-btn f-row" id="filter-btn">
                            <i class="fa-solid fa-filter"></i>
                            Filter
                        </button>
                    </div>
                    <button class="add-btn f-row" id="openPopup">
                        <i class="fa-sharp fa-solid fa-plus"></i>
                        Add User
                    </button>

                </div>
            </div>
            <div class="total-records f-row">
                total <span> 560 </span> records
            </div>
            <div class="data f-col">
                <table class="users">
                    <thead>
                    <tr>
                        <td>User ID</td>
                        <td>Email</td>
                        <td>Role</td>
                        <td>status</td>
                        <td class="head-row f-row">joined on</td>
                        <td>View Profile</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${getallUsers}">
                        <tr>
                            <td>${user.userId}</td>
                            <td >
                                <div class="p-img"></div>
                                <div class="credentials f-col">
                                    <div class="name">${user.email}</div>


                                </div>
                            </td>


                            <td class="role">
                                <span class="${user.userType.toLowerCase()}">${user.userType}</span>
                            </td>
                            <td>Active</td>
                            <td>${user.created_at}</td>
                            <td class="actbtn">
                                <button>
                                    <i class="fa-regular fa-ellipsis-vertical"></i>
                                </button>
                                <ul class="menu">
                                    <li class="f-row" >
                                        <i class="fa-regular fa-user"></i>
                                        <button class="view-profile-btn" data-user-id="${user.userId}">
                                            <i class="fa-regular fa-user"></i>
                                            View Profile
                                        </button>
                                    </li>


                                    <li class="f-row del-user">
                                        <i class="fa-regular fa-trash"></i>
                                        delete user
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>


                    </tbody>
                    <div class="pagination capitalize f-row">
                        <span>prev</span>
                        <span class="curr-page">1</span>
                        <span>next</span>
                    </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- Popup -->
<!-- Profile Popup -->
<div id="profilePopup" class="popup">
    <div class="popup-content">
        <span class="close" onclick="closeProfilePopup()">&times;</span>
        <h2>Profile Details</h2>
        <div id="profileDetails">
            <!-- User details will be loaded here dynamically -->
        </div>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('.actbtn button').forEach(button => {
            button.addEventListener('click', function(event) {
                event.stopPropagation(); // Prevents closing immediately after opening
                let menu = this.nextElementSibling;
                document.querySelectorAll('.actbtn .menu').forEach(m => {
                    if (m !== menu) {
                        m.classList.remove('nav-active');
                    }
                });
                menu.classList.toggle('nav-active');
            });
        });

        // Close the menu when clicking outside
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("view-profile-btn")) {
                let userId = event.target.getAttribute("data-user-id");
                openProfilePopup(userId);
            }
        });

    });


    // Function to close profile popup
    function closeProfilePopup() {
        document.getElementById("profilePopup").style.display = "none";
    }

    // Attach event listeners
    document.querySelectorAll(".view-profile-btn").forEach(button => {
        button.addEventListener("click", function () {
            const userId = this.getAttribute("data-user-id");
            openProfilePopup(userId);
        });
    });

    // Attach functions to the window object so they can be accessed in inline onclick events
    window.openProfilePopup = openProfilePopup;
    window.closeProfilePopup = closeProfilePopup;
    });

    function openProfilePopup(userId) {
        fetch(`/UserDetailsServlet?userId=${userId}`)
            .then(response => response.json())
            .then(user => {
                if (user.error) {
                    document.getElementById("profileDetails").innerHTML = `<p>${user.error}</p>`;
                } else {
                    document.getElementById("profileDetails").innerHTML = `
                    <p><strong>User ID:</strong> ${user.userId}</p>
                    <p><strong>Email:</strong> ${user.email}</p>
                    <p><strong>Role:</strong> ${user.userType}</p>
                    <p><strong>Joined On:</strong> ${user.created_at}</p>
                `;
                    document.getElementById("profilePopup").style.display = "block";
                }
            })
            .catch(error => {
                console.error("Error fetching user details:", error);
                document.getElementById("profileDetails").innerHTML = "<p>Failed to load user details.</p>";
            });
    }

    function closeProfilePopup() {
        document.getElementById("profilePopup").style.display = "none";
    }

    // Sample user data (Replace with actual data fetching logic)
    const usersData = [
        <c:forEach var="user" items="${allUsers}">
        {
            userId: "${user.userId}",
            email: "${user.email}",
            userType: "${user.userType}",
            created_at: "${user.created_at}"
        },
        </c:forEach>
    ];

    // Attach event listeners dynamically
    document.addEventListener("DOMContentLoaded", function () {
        // Toggle dropdown menu
        document.querySelectorAll('.actbtn button').forEach(button => {
            button.addEventListener('click', function (event) {
                event.stopPropagation();
                let menu = this.nextElementSibling;
                document.querySelectorAll('.actbtn .menu').forEach(m => {
                    if (m !== menu) {
                        m.classList.remove('nav-active');
                    }
                });
                menu.classList.toggle('nav-active');
            });
        });

        // Close the menu when clicking outside
        document.addEventListener("click", function (event) {
            document.querySelectorAll('.actbtn .menu').forEach(menu => {
                if (!menu.contains(event.target)) {
                    menu.classList.remove('nav-active');
                }
            });
        });

        // Open profile popup
        document.addEventListener("click", function (event) {
            if (event.target.classList.contains("view-profile-btn")) {
                let userId = event.target.getAttribute("data-user-id");
                openProfilePopup(userId);
            }
        });
    });



    // Toggle popup-active class on body when delete user button is clicked
    document.querySelectorAll(".del-user").forEach(button => {
        button.addEventListener("click", function() {
            document.body.classList.add("popup-active");
            document.querySelector(".delete-user-popup").classList.add("popup-show");
        });
    });

    // Close popup when close button is clicked
    document.querySelectorAll(".close-btn").forEach(button => {
        button.addEventListener("click", function() {
            document.body.classList.remove("popup-active");
            document.querySelector(".filter-user-popup").classList.remove("popup-show");
            document.querySelector(".delete-user-popup").classList.remove("popup-show");
        });
    });

    // Close popup when proceed button is clicked
    document.querySelector(".proceed").addEventListener("click", function() {
        document.body.classList.remove("popup-active");
        document.querySelector(".delete-user-popup").classList.remove("popup-show");
    });
    });



</script>
</body>

</html>
