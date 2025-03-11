<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.UserController" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <style>


    </style>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Funraising Management | Admin Dashboard</title>

    <link rel="stylesheet" href="./fundraisingManagement.css" />
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
                <a href="../userManagment/userManagment.jsp" class="nav-item f-row active">
                    <i class="fa-regular fa-users"></i>
                    <span>user management</span>
                </a>
            </li>
            <li>
                <a href="fundraisingManagement.jsp" class="nav-item f-row">
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
            <div class="page-title capitalize">Fundraising Management</div>
            <div class="page-desc">Manage fundraising campaigns, approvals, and targets.</div>
        </div>

        <div class="actions f-row">
            <div class="search-bar">
                <label for="fundraising-search"><i class="fa-solid fa-magnifying-glass"></i></label>
                <input type="search" placeholder="Search by title/category" name="fundraising-search" id="fundraising-search" />
            </div>
            <button class="filter-btn f-row"><i class="fa-solid fa-filter"></i> Filter</button>
            <button class="add-btn f-row" id="openFundPopup"><i class="fa-sharp fa-solid fa-plus"></i> Add Fundraising</button>
        </div>

        <div class="data f-col">
            <table class="fundraising">
                <thead>
                <tr>
                    <td>Title</td>
                    <td>Description</td>
                    <td>Category</td>
                    <td>Fund Target</td>
                    <td>Attachment</td>
                    <td>Action</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="fund" items="${allFundraisings}">
                    <tr>
                        <td>${fund.title}</td>
                        <td>${fund.description}</td>
                        <td>${fund.category}</td>
                        <td>${fund.fundTarget}</td>
                        <td><a href="${fund.attachmentUrl}" target="_blank">View</a></td>
                        <td class="actbtn">
                            <button class="approve-btn" data-fund-id="${fund.fundId}">Approve</button>
                            <button class="reject-btn" data-fund-id="${fund.fundId}">Reject</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll(".approve-btn").forEach(button => {
        button.addEventListener("click", function() {
            let fundId = this.getAttribute("data-fund-id");
            alert("Approved Fundraising ID: " + fundId);
        });
    });

    document.querySelectorAll(".reject-btn").forEach(button => {
        button.addEventListener("click", function() {
            let fundId = this.getAttribute("data-fund-id");
            alert("Rejected Fundraising ID: " + fundId);
        });
    });
</script>
</body>
</html>

