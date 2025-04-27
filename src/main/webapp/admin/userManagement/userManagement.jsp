<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pendingParties" value="${parties.stream().filter(p -> p.status == 'pending').toList()}" />
<c:set var="acceptedParties" value="${parties.stream().filter(p -> p.status == 'accepted').toList()}" />
<c:set var="rejectedParties" value="${parties.stream().filter(p -> p.status == 'rejected').toList()}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>User Management | Admin Dashboard</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/userManagement/userManagment.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/index.css"/>

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
            (user id :<span class="userid">null</span>)s
        </div>
        <%--        <img src="--%>
        <%--            ${pageContext.request.contextPath}/admin/assetsFrame 297.png--%>
        <%--" alt="delete user" width="200px">--%>
    </div>
    <div class="warns">
        <ul class="f-col">
            <li class="warn f-row">
                <div class="icon">
                    <i class="fa-solid fa-fire"></i>
                </div>
                <div class="details f-col">
                    <div class="title">This action cannot be undone</div>
                    <div class="desc">Deleting this user is permanent and can not be reversed.</div>
                </div>
            </li>
            <li class="warn f-row">
                <div class="icon">
                    <i class="fa-solid fa-globe"></i>
                </div>
                <div class="details f-col">
                    <div class="title">System-Wide Impact</div>
                    <div class="desc">This action will affect multiple systems and can not be reversed.</div>
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
            <button class="proceed" id="proceed-delete-btn">proceed with caution</button>
        </div>
    </div>
</div>

<div class="party-req-modal f-col popup" style="padding-block: 1rem">
    <div class="close-btn" id="party-req-close-btn">
        <i class="fa-solid fa-xmark"></i>
    </div>
    <div class="top f-row">
        <div class="title f-row">
            Political party requests
            <span class="requestsAmount">
                <c:choose>
                    <c:when test="${fn:length(pendingParties) > 9}">
                        9+
                    </c:when>
                    <c:otherwise>
                        ${fn:length(pendingParties)}
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>
    <div class="content f-col">

        <input type="checkbox" id="pending-request-table">
        <label class="f-col pending-table" for="pending-request-table">
            <div class="dropdown title f-row">
                <span class="status capitalize status-pending">pending requests</span>
                <i class="fa-regular fa-circle-chevron-down"></i>
            </div>
            <table style="width: 100%">
                <tr class="capitalize">
                    <th>Party name</th>
                    <th>HQ address</th>
                    <th>party leader</th>
                    <th>email</th>
                    <th>contact phone</th>
                    <th>submitted   date</th>
                    <th>action</th>
                </tr>
                <c:choose>
                    <c:when test="${empty pendingParties}">
                        <tr>
                            <td colspan="7" style="font-weight: 500; font-style: italic">
                                No pending requests were found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${parties}" var="party">
                            <c:choose>
                                <c:when test="${party.status == 'pending'}">
                                    <tr>
                                        <td>${party.name}</td>
                                        <td>${party.address}</td>
                                        <td>${party.leader}</td>
                                        <td>${party.email}</td>
                                        <td>${party.phoneNumber}</td>
                                        <td>${party.submittedDate}</td>
                                        <td data-reqid="${party.reqId}">
                                            <button class="btn-approve" data-name="${party.name}" data-address="${party.address}" data-leader="${party.leader}" data-reqId="${party.reqId}" data-email="${party.email}" data-phone="${party.phoneNumber}" , data-pswd="${party.password}">Approve</button>
                                            <button data-name="${party.name}" data-address="${party.address}" data-leader="${party.leader}" data-reqId="${party.reqId}" data-email="${party.email}" data-phone="${party.phoneNumber}" , data-pswd="${party.password}" class="btn-reject">Reject</button>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </table>
        </label>

        <input type="checkbox" id="accepted-request-table">
        <label class="f-col accept-table" for="accepted-request-table" >
            <div class="dropdown title f-row">
                <span class="status capitalize status-accepted">accepted requests</span>
                <i class="fa-regular fa-circle-chevron-down"></i>
            </div>
            <table style="width: 100%">
                <tr class="capitalize">
                    <th>Party name</th>
                    <th>HQ address</th>
                    <th>party leader</th>
                    <th>email</th>
                    <th>contact phone</th>
                    <th>submitted   date</th>
                </tr>
                <c:choose>
                    <c:when test="${empty acceptedParties}">
                        <tr>
                            <td colspan="7" style="font-weight: 500;  font-style: italic">
                                No accepted requests were found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${parties}" var="party">
                            <c:choose>
                                <c:when test="${party.status == 'accepted'}">
                                    <tr>
                                        <td>${party.name}</td>
                                        <td>${party.address}</td>
                                        <td>${party.leader}</td>
                                        <td>${party.email}</td>
                                        <td>${party.phoneNumber}</td>
                                        <td>${party.submittedDate}</td>

                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </table>
        </label>

        <input type="checkbox" id="rejected-request-table">
        <label class="f-col reject-table" for="rejected-request-table" >
            <div class="dropdown title f-row">
                <span class="status capitalize status-rejected">rejected requests</span>
                <i class="fa-regular fa-circle-chevron-down"></i>
            </div>
            <table style="width: 100%">
                <tr class="capitalize">
                    <th>Party name</th>
                    <th>HQ address</th>
                    <th>party leader</th>
                    <th>email</th>
                    <th>contact phone</th>
                    <th>submitted   date</th>
                </tr>
                <c:choose>
                    <c:when test="${empty acceptedParties}">
                        <tr>
                            <td colspan="7" style="font-weight: 500; font-style: italic">
                                No rejected requests were found
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${parties}" var="party">
                            <c:choose>
                                <c:when test="${party.status == 'rejected'}">
                                    <tr>
                                        <td>${party.name}</td>
                                        <td>${party.address}</td>
                                        <td>${party.leader}</td>
                                        <td>${party.email}</td>
                                        <td>${party.phoneNumber}</td>
                                        <td>${party.submittedDate}</td>

                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </table>
        </label>

    </div>
    <div class="footer">
        <button id="generate-csv-btn" class="f-row">Export CSV <i class="fa-regular fa-arrow-down-to-line"></i></button>
    </div>
</div>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/admin/assets/logo.png" alt="Parlimate" id="logo"/>
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Home/index.jsp" class="nav-item f-row">
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
            <div class="date">
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM, yyyy"/>
            </div>
        </div>
        <div class="content f-col">
            <div class="topS f-row">
                <div class="total-records f-row">
                    total <span> ${AllUsers.size()} </span> records
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
<%--                    <div class="filter">--%>
<%--                        <button class="filter-btn f-row" id="filter-btn">--%>
<%--                            <i class="fa-solid fa-filter"></i>--%>
<%--                            Filter--%>
<%--                        </button>--%>
<%--                    </div>--%>
                    <button class="party-req-btn f-row" id="party-req-btn">
                        Political Party Requests
                    </button>
                </div>
            </div>

            <div class="data f-col">
                <table class="users">
                    <thead>
                    <tr>
                        <td>User ID</td>
                        <td>User Name</td>
                        <td>Role</td>
                        <td class="head-row f-row">Joined on</td>
                        <td>Actions</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty AllUsers}">
                            <tr>
                                <td colspan="5">No users found.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="user" items="${AllUsers}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td class="profile f-row">
                                        <div class="p-img"></div>
                                        <div class="credentials f-col">
                                            <div class="name">${user.name}</div>
                                            <div class="email">${user.email}</div>
                                        </div>
                                    </td>
                                    <td class="role capitalize">
                                        <span class="${user.userType}">${user.userType}</span>
                                    </td>
                                    <td class="formatDate" data-date="${user.created_at}">${user.created_at}</td>
                                    <td class="actbtn">
                                        <button><i class="fa-regular fa-ellipsis-vertical"></i></button>
                                        <ul class="menu">
                                            <li class="f-row"><i class="fa-regular fa-user"></i>view profile</li>
<%--                                            <li class="f-row"><i class="fa-regular fa-pencil"></i>edit details</li>--%>
<%--                                            <li class="f-row"><i class="fa-regular fa-lock"></i>change permission</li>--%>
                                            <li class="f-row del-user"
                                                data-userid="${user.userId}"
                                                data-username="${user.name}"
                                                data-userType="${user.userType}">
                                                <i class="fa-regular fa-trash"></i>
                                                delete user
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    </tbody>
                </table>


<%--                <div class="pagination capitalize f-row">--%>
<%--                    <span>prev</span>--%>
<%--                    <span class="curr-page">1</span>--%>
<%--                    <span>next</span>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</div>
<script>

<%--    sending party request to servlet--%>
const partyApproveBtns = document.querySelectorAll(".btn-approve");
const partyRejectBtns = document.querySelectorAll(".btn-reject");
partyApproveBtns.forEach(approveBtn => {
    approveBtn.addEventListener("click", async () => {
        const partyData = {
            name: approveBtn.dataset.name,
            reqId: approveBtn.dataset.reqid,
            address: approveBtn.dataset.address,
            leader: approveBtn.dataset.leader,
            email: approveBtn.dataset.email,
            phone: approveBtn.dataset.phone,
            password: approveBtn.dataset.pswd
        };

        if (!confirm(`Are you sure you want to approve ${partyData.name}?`)) {
            return;
        }

        try {
            // CORRECT URL CONSTRUCTION
            const url = `${window.location.origin}/Parlimate/ProcessPartyRequestServlet`;
            console.log("Final request URL:", url); // Debugging

            const response = await fetch(url, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                },
                body: new URLSearchParams({
                    action: 'approve',
                    reqId: partyData.reqId,
                    name: partyData.name,
                    address: partyData.address,
                    leader: partyData.leader,
                    email: partyData.email,
                    phone: partyData.phone,
                    password: partyData.password
                }).toString()
            });

            const result = await response.text();

            if (!response.ok) {
                throw new Error(result || `Server returned ${response.status}`);
            }

            if (result === "success") {
                window.location.reload();
            } else {
                alert("Server response: " + result);
            }
        } catch (error) {
            console.error("Full error:", error);
            alert('Error approving party: ' + error.message);
        }
    });
});

// reject requests
partyRejectBtns.forEach(rejectBtn => {
    rejectBtn.addEventListener("click", async () => {
        const reqId = rejectBtn.dataset.reqid;
        const partyName = rejectBtn.dataset.name;

        if (!confirm(`Are you sure you want to reject ${partyName}'s request?`)) {
            return;
        }

        try {
            const url = `${window.location.origin}/Parlimate/ProcessPartyRequestServlet`;

            const response = await fetch(url, {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                },
                body: new URLSearchParams({
                    action: 'reject',
                    reqId: reqId
                }).toString()
            });

            const result = await response.text();

            if (!response.ok) {
                throw new Error(result || `Server returned ${response.status}`);
            }

            if (result === "success") {
                window.location.reload(); // Refresh to show updated status
            } else {
                alert("Server response: " + result);
            }
        } catch (error) {
            console.error("Error rejecting request:", error);
            alert('Error rejecting request: ' + error.message);
        }
    });
});


    document.addEventListener("DOMContentLoaded", function() {
        // Toggle action menus
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

        // close all action menu
        function closeActionMenus() {
            document.querySelectorAll('.actbtn button').forEach(button => {
                document.querySelectorAll('.actbtn .menu').forEach(menu => {
                    menu.classList.contains('nav-active') ? menu.classList.remove('nav-active'): null;
                })
            })
        }

        // Delete user popup logic
        const deleteModal = document.querySelector(".delete-user-popup");
        let selectedUserId = null; // Store selected user ID globally

        document.querySelectorAll(".del-user").forEach(button => {
            button.addEventListener("click", function() {
                const userNameElement = deleteModal.querySelector(".head .username");
                const userIdElement = deleteModal.querySelector(".head .userid");

                selectedUserId = button.dataset.userid; // Store the ID for later use
                userNameElement.textContent = button.dataset.username;
                userIdElement.textContent = selectedUserId;

                document.body.classList.add("popup-active");
                closeAllPopups();
                deleteModal.classList.add("popup-show");
            });
        });

        // Proceed with deletion
        document.querySelector("#proceed-delete-btn")?.addEventListener("click", () => {
            if (selectedUserId) {
                closeActionMenus();
                removeUserServlet(selectedUserId);
            }
        });

        // Close popups
        document.querySelectorAll(".close-btn, .proceed").forEach(button => {
            button.addEventListener("click", function() {
                document.body.classList.remove("popup-active");
                deleteModal.classList.remove("popup-show");
            });
        });
    });

    document.querySelectorAll(".close-btn").forEach(closeBtn => {
        closeAllPopups();
    })

    function closeAllPopups(){
        const partyReqModal = document.querySelector(".party-req-modal");
        const deleteUserModal = document.querySelector(".delete-user-popup");

        partyReqModal.classList.remove("popup-show");
        deleteUserModal.classList.remove("popup-show");
    }

    function removeUserServlet(userId) {
        const basePath = window.location.origin;
        fetch(basePath+"/Parlimate/DeleteUserFromUMServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: `userId=`+encodeURIComponent(userId)
        })
            .then(res => {
                if (!res.ok) throw new Error("Network response was not ok");
                return res.text();
            })
            .then(data => {
                console.log("User deleted:", data);
                location.reload();
            })
            .catch(err => {
                console.error("Delete failed:", err);
                alert("Failed to delete user. Please try again.");
            });
    }
</script>
<script>
    function formatDate(dateString) {
        const options = {
            year: 'numeric',
            month: 'short',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        };
        return new Date(dateString).toLocaleDateString('en-US', options);
    }

    document.querySelectorAll('.formatDate').forEach(el => {
        const rawDate = el.getAttribute('data-date');
        el.textContent = formatDate(rawDate);
    });
</script>
<script>
    const partyReqBtn = document.getElementById("party-req-btn");
    const partyModal = document.querySelector(".party-req-modal");

    partyReqBtn.addEventListener("click", ()=> {
        console.log(partyModal);
        document.querySelector("body").classList.add("popup-active")
        partyModal.classList.add("popup-show");
    })
</script>

</body>
</html>
