<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management | Admin Dashboard</title>

    <link rel="stylesheet" href="./userManagment.css" />
    <link rel="stylesheet" href="../index.css" />

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
<div class="popup-overlay"></div>
<div class="delete-user-popup f-col popup">
    <div class="close-btn">
        <i class="fa-solid fa-xmark"></i>
    </div>
    <div class="head f-col">
        <div class="title">
            Are you sure you want to <span class="red">delete</span> user <span class="username capitalize">manuja ransara</span>?
        </div>
        <img src="../Frame 297.png" alt="delete user" width="200px">
    </div>
    <div class="warns">
        <ul class="f-col">
            <li class="warn f-row">
                <div class="icon">
                    <i class="fa-solid fa-fire"></i>
                </div>
                <div class="details f-col">
                    <div class="title">This action cannot be undone</div>
                    <div class="desc">Deleting this user is permanent and can not be reversed. Proceed with caution.</div>
                </div>
            </li>
            <li class="warn f-row">
                <div class="icon">
                    <i class="fa-solid fa-globe"></i>
                </div>
                <div class="details f-col">
                    <div class="title">System-Wide Impact</div>
                    <div class="desc">This action will affect multiple systems and can not be reversed. Proceed with caution.ere</div>
                </div>
            </li>
        </ul>
    </div>
    <div class="actions f-col">
        <div class="desc f-col">
            By selecting “Continue” you agree to the
            <a href="#">Parlimate User privacy policy</a>
        </div>
        <div class="btns f-row">
            <div class="cancel"></div>
            <button class="proceed">continue</button>
        </div>
    </div>
</div>
<div class="filter-user-popup f-col popup">
    <div class="close-btn">
        <i class="fa-solid fa-xmark"></i>
    </div>
    <div class="head f-col">
        <div class="title f-col">
            Filter Users
            <div class="desc">
                Filter users by type, activity, location, and more to manage your list efficiently
            </div>
        </div>
        <div class="content">
            <ul class="f-col">
                <li>
                    <input type="checkbox" name="filter-user-type" id="user-type">
                    <label for="user-type" class="f-row">
                        <span>User Type</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </label>
                    <div class=" dropdown-content users wrap f-row">
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-all" checked>
                            <label for="user-type-all" class="toggle-btn-check">
                                all
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-citizen">
                            <label for="user-type-citizen" class="toggle-btn-check">
                                Citizen
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-politician">
                            <label for="user-type-politician" class="toggle-btn-check">
                                politician
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-political-party">
                            <label for="user-type-political-party" class="toggle-btn-check">
                                political party
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-moderator">
                            <label for="user-type-moderator" class="toggle-btn-check">
                                moderator
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-type-filter" id="user-type-admin">
                            <label for="user-type-admin" class="toggle-btn-check">
                                admin
                            </label>
                        </div>
                    </div>
                </li>
                <li>
                    <input type="checkbox" name="filter-user-status" id="user-status">
                    <label for="user-status" class="f-row">
                        <span>User status</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </label>
                    <div class=" dropdown-content users f-row">
                        <div>
                            <input type="checkbox" name="user-status-filter" id="user-status-all" checked>
                            <label for="user-status-all" class="toggle-btn-check">
                                all
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-status-filter" id="user-status-active">
                            <label for="user-status-active" class="toggle-btn-check">
                                active
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-status-filter" id="user-status-banned">
                            <label for="user-status-banned" class="toggle-btn-check">
                                banned
                            </label>
                        </div>
                        <div>
                            <input type="checkbox" name="user-status-filter" id="user-status-inactive">
                            <label for="user-status-inactive" class="toggle-btn-check">
                                inactive
                            </label>
                        </div>

                    </div>
                </li>
                <li>
                    <div class="city f-row">
                        <span>City :</span>
                        <select name="filter-city" id="filter-city">
                            <option value="all">all</option>
                            <option value="kandy">kandy</option>
                            <option value="jaffna">jaffna</option>
                            <option value="colombo">colombo</option>
                            <option value="galle">galle</option>
                        </select>
                    </div>
                </li>
                <div class="divider-line"></div>
                <li>
                    <input type="checkbox" name="filter-user-sort" id="user-sort">
                    <label for="user-sort" class="f-row">
                        <span>sort by</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </label>
                    <div class=" dropdown-content sort users f-col">
                        <div class="attribute f-row">
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-id" checked>
                                <label for="user-sort-id" class="toggle-btn-check">
                                    id
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-username">
                                <label for="user-sort-username" class="toggle-btn-check">
                                    user name
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-lastactive">
                                <label for="user-sort-lastactive" class="toggle-btn-check">
                                    last active
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-joinddate">
                                <label for="user-sort-joinddate" class="toggle-btn-check">
                                    joind date
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-contribution">
                                <label for="user-sort-contribution" class="toggle-btn-check">
                                    contribution
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter" id="user-sort-reports">
                                <label for="user-sort-reports" class="toggle-btn-check">
                                    reports
                                </label>
                            </div>

                        </div>
                        <div class="order wrap f-row">
                            <div>
                                <input type="radio" name="user-sort-filter-sort"  id="user-sort-asc" checked>
                                <label for="user-sort-asc" class="toggle-btn-check">
                                    ascending
                                </label>
                            </div>
                            <div>
                                <input type="radio" name="user-sort-filter-sort" id="user-sort-desc">
                                <label for="user-sort-desc" class="toggle-btn-check">
                                    descending order
                                </label>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="action btns">
            <button class="cancel-btn">cancel</button>
            <button class="apply-btn">apply filter</button>
        </div>
    </div>
</div>
</div>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="../assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="../Home/index.html" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row active">
                    <i class="fa-regular fa-users"></i>
                    <span>user management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
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
                    <i class="fa-regular fa-circle-check"></i>
                    <span>requests</span>
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
            <div class="date">18 Jan, 2025</div>
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
                    <button class="add-btn f-row">
                        <i class="fa-sharp fa-solid fa-plus"></i>
                        Add user
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
                        <td>User Name</td>
                        <td>Role</td>
                        <td>Status</td>
                        <td class="head-row f-row">Joined on</td>
                        <td>Actions</td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td class="profile f-row">
                            <div class="p-img"></div>
                            <div class="credentials f-col">
                                <div class="name">John Doe</div>
                                <div class="email">jDoe@parlimate.com</div>
                            </div>
                        </td>
                        <td class="role">
                            <span class="admin">Admin</span>
                        </td>
                        <td>Active</td>
                        <td>18 Jan, 2025</td>
                        <td class="actbtn">
                            <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                            <ul class="menu">
                                <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
                                <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>
                                <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>
                                <li class="f-row del-user"><i class="fa-regular fa-trash"></i>delete user</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td class="profile f-row">
                            <div class="p-img"></div>
                            <div class="credentials f-col">
                                <div class="name">Michael Brown</div>
                                <div class="email">mBrown@parlimate.com</div>
                            </div>
                        </td>
                        <td class="role">
                            <span class="moderator">Moderator</span>
                        </td>
                        <td>Active</td>
                        <td>16 Jan, 2025</td>
                        <td class="actbtn">
                            <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                            <ul class="menu">
                                <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
                                <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>
                                <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>
                                <li class="f-row del-user"><i class="fa-regular fa-trash"></i>delete user</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td class="profile f-row">
                            <div class="p-img"></div>
                            <div class="credentials f-col">
                                <div class="name">Jane Smith</div>
                                <div class="email">jSmith@parlimate.com</div>
                            </div>
                        </td>
                        <td class="role">
                            <span class="citizen">Citizen</span>
                        </td>
                        <td>Inactive</td>
                        <td>17 Jan, 2025</td>
                        <td class="actbtn">
                            <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                            <ul class="menu">
                                <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
                                <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>
                                <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>
                                <li class="f-row del-user"><i class="fa-regular fa-trash"></i>delete user</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>9</td>
                        <td class="profile f-row">
                            <div class="p-img"></div>
                            <div class="credentials f-col">
                                <div class="name">David Lee</div>
                                <div class="email">dLee@parlimate.com</div>
                            </div>
                        </td>
                        <td class="role">
                            <span class="politician">Politician</span>
                        </td>
                        <td>Active</td>
                        <td>10 Jan, 2025</td>
                        <td class="actbtn">
                            <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                            <ul class="menu">
                                <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
                                <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>
                                <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>
                                <li class="f-row del-user"><i class="fa-regular fa-trash"></i>delete user</li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td>10</td>
                        <td class="profile f-row">
                            <div class="p-img"></div>
                            <div class="credentials f-col">
                                <div class="name">James White</div>
                                <div class="email">jWhite@parlimate.com</div>
                            </div>
                        </td>
                        <td class="role">
                            <span class="political-party">Political Party</span>
                        </td>
                        <td>Active</td>
                        <td>8 Jan, 2025</td>
                        <td class="actbtn">
                            <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                            <ul class="menu">
                                <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
                                <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>
                                <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>
                                <li class="f-row del-user"><i class="fa-regular fa-trash"></i>delete user</li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>


                <div class="pagination capitalize f-row">
                    <span>prev</span>
                    <span class="curr-page">1</span>
                    <span>next</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.querySelectorAll('.actbtn button').forEach(button => {
        button.addEventListener('click', () => {
            document.querySelectorAll('.actbtn .menu').forEach(menu => {
                if (menu !== button.nextElementSibling) {
                    menu.classList.remove('nav-active');
                }
            });
            button.nextElementSibling.classList.toggle('nav-active');
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        // Toggle popup-active class on body when filter button is clicked
        document.getElementById("filter-btn").addEventListener("click", function() {
            document.body.classList.toggle("popup-active");
            document.querySelector(".filter-user-popup").classList.toggle("popup-show");
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
