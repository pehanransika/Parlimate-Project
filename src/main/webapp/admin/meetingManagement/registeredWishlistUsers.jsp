<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/22/2025
  Time: 7:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Meeting Management | Admin Dashboard</title>

    <link rel="stylesheet" href="admin/meetingManagement/meetingManagement.css" />
    <link rel="stylesheet" href="admin/index.css" />

    <%--    <link rel="stylesheet" href="<c:url value='/admin/meetingManagement/meetingManagement.css' />">--%>
    <%--    <link rel="stylesheet" href="<c:url value='/admin/meetingManagement/sidebar.css' />">--%>


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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Home/GetAnalyticsCountServlet" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>users</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>fundraise management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet" class="nav-item f-row">
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
                <a href="${pageContext.request.contextPath}/admin/CommentManagement/CommentManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-comments"></i>
                    <span>Comment Management</span>
                </a>
            </li>
            <%--				<li>--%>
            <%--					<a href="#" class="nav-item f-row">--%>
            <%--						<i class="fa-regular fa-circle-check"></i>--%>
            <%--						<span>requests</span>--%>
            <%--					</a>--%>
            <%--				</li>--%>
            <li>
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-money-bill-transfer"></i>
                    <span>bank transfer management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row active">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>Meeting Management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetProfileListServlet" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>Profile Management</span>
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
                <a href="#" class="f-row log-out" onclick="logoutUser()">
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
                <div class="page-title capitalize">Manage Registrations</div>
                <div class="page-desc">
                    View Registered Users , Send Invitations
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
                    <%--                    <div class="search-bar">--%>
                    <%--                        <label for="user-search">--%>
                    <%--                            <i class="fa-solid fa-magnifying-glass"></i>--%>
                    <%--                        </label>--%>
                    <%--                        <input--%>
                    <%--                                type="search"--%>
                    <%--                                placeholder="Search by name/userId"--%>
                    <%--                                name="user-search"--%>
                    <%--                                id="user-search"--%>
                    <%--                        />--%>
                    <%--                    </div>--%>
                    <div class="scheduled-meeting">
                        <button class="filter-btn f-row" id="request-btn">
                            <i class="fa-solid fa-filter"></i>
                            Scheduled Meetings
                        </button>
                    </div>
                    <button class="add-btn f-row" onclick="openPopup()">
                        <i class="fa-sharp fa-solid fa-link"></i>
                        Provide Meeting Link
                    </button>
                </div>
            </div>

            <h2 class="section-title">Registere Wishlist Users for Meeting ID : ${meetingId} </h2>
            <div class="total-records f-row">
                Total <span>560</span> records
            </div>
            <div class="data f-col">
                <table class="users">
                    <thead>
                    <tr>
                        <td>User ID</td>
                        <td>Email</td>
                        <td>Action</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="registeredWishlistUsers" items="${registeredWishlistUsers}">
                        <tr>
                            <td>${registeredWishlistUsers.userId}</td>
                            <td>${registeredWishlistUsers.email}</td>
                            <td><button>View</button></td>
                        </tr>
                    </c:forEach>
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

<div id="popup-container" style="display: none;">
    <div class="popup-box">
        <h2>Provide Meeting Link</h2>

        <p><strong>Meeting Link:</strong><br>
            <input type="url" id="meeting-link" name="meeting-link" placeholder="https://example.com/meeting" required style="width: 100%;" />
        </p>

        <div style="margin-top: 20px;">
            <button onclick="sendEmail()">Send Email</button>
            <button onclick="closePopup()">Close</button>
        </div>
    </div>
</div>

<script>
    const allEmails = [
        <c:forEach var="user" items="${registeredWishlistUsers}" varStatus="status">
        '${user.email}'<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    function openPopup() {
        document.getElementById("meeting-link").value = "";
        document.getElementById("popup-container").style.display = "block";
    }

    function closePopup() {
        document.getElementById("popup-container").style.display = "none";
    }

    function sendEmail() {
        const meetingLink = document.getElementById("meeting-link").value;

        if (!meetingLink) {
            alert("Please enter the meeting link.");
            return;
        }

        // Convert email array to comma-separated string
        const emailString = allEmails.join(",");

        // Create form-encoded data
        const formData = new URLSearchParams();
        formData.append("emails", emailString);
        formData.append("meetingLink", meetingLink);

        // Send POST request
        fetch("SendBulkEmailServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: formData.toString()
        })
            .then(response => {
                if (response.ok) {
                    alert("Emails sent successfully!");
                    closePopup();
                } else {
                    return response.text().then(text => { throw new Error(text); });
                }
            })
            .catch(error => {
                alert("Failed to send emails: " + error.message);
            });
    }

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
        document.getElementById("request-btn").addEventListener("click", function() {
            window.location.href = "<%= request.getContextPath() %>/GetAllMeetingServlet";
        });


        // Close popup when close button is clicked
        document.querySelectorAll(".close-btn").forEach(button => {
            button.addEventListener("click", function() {
                document.body.classList.remove("popup-active");
                document.querySelector(".filter-user-popup").classList.remove("popup-show");
            });
        });
    });
</script>
</body>
</html>

