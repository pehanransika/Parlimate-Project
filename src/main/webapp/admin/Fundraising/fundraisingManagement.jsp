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
        /* Additional styles for tabbed interface */
        .fundraising-tabs {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        .fundraising-tab {
            padding: 10px 20px;
            cursor: pointer;
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            border-bottom: none;
            border-radius: 5px 5px 0 0;
            margin-right: 5px;
            transition: all 0.3s;
        }

        .fundraising-tab.active {
            background-color: #2c3e50;
            color: white;
            border-color: #2c3e50;
        }

        .fundraising-content {
            display: none;
            padding: 20px;
            border: 1px solid #ddd;
            border-top: none;
            border-radius: 0 0 5px 5px;
            background: white;
        }

        .fundraising-content.active {
            display: block;
        }

        .fundraising-list {
            list-style-type: none;
            padding: 0;
        }

        .fundraising-list li {
            padding: 12px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
    </style>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Fundraising Management | Admin Dashboard</title>

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
                <a href="../userManagment/userManagment.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>user management</span>
                </a>
            </li>
            <li>
                <a href="fundraisingManagement.jsp" class="nav-item f-row active">
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

        <!-- Fundraising Tabs -->
        <div class="fundraising-tabs">
            <div class="fundraising-tab active" onclick="openFundraisingTab(event, 'fundraising-request')">Fundraising Request</div>
            <div class="fundraising-tab" onclick="openFundraisingTab(event, 'approval-fundraisers')">Approval Fundraisers</div>
        </div>

        <!-- Fundraising Request Tab -->
        <div id="fundraising-request" class="fundraising-content active">
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
                        <td>Contact Number</td>
                        <td>Category</td>
                        <td>Fund Target</td>
                        <td>Attachment</td>
                        <td>Photos</td>
                        <td>Action</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="fund" items="${allFundraisings}">
                        <tr>
                            <td>${fund.title}</td>
                            <td>${fund.description}</td>
                            <td>${fund.contact_no}</td>
                            <td>${fund.category}</td>
                            <td>${fund.fundTarget}</td>
                            <td><a href="${fund.attachmentUrl}" target="_blank">View</a></td>
                            <td><a href="${fund.photos}" target="_blank">View</a></td>
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

        <!-- Approval Fundraisers Tab -->
        <div id="approval-fundraisers" class="fundraising-content">
            <div class="actions f-row">
                <div class="search-bar">
                    <label for="approval-search"><i class="fa-solid fa-magnifying-glass"></i></label>
                    <input type="search" placeholder="Search approved fundraisers" name="approval-search" id="approval-search" />
                </div>
                <button class="filter-btn f-row"><i class="fa-solid fa-filter"></i> Filter</button>
            </div>

            <div class="data f-col">
                <table class="fundraising">
                    <thead>
                    <tr>
                        <td>Title</td>
                        <td>Description</td>
                        <td>Contact Number</td>
                        <td>Category</td>
                        <td>Fund Target</td>
                        <td>Attachment</td>
                        <td>Photos</td>
                        <td>Status</td>
                        <td>Action</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="fund" items="${approvedFundraisings}">
                        <tr>
                            <td>${fund.title}</td>
                            <td>${fund.description}</td>
                            <td>${fund.contact_no}</td>
                            <td>${fund.category}</td>
                            <td>${fund.fundTarget}</td>
                            <td>${fund.attachment}</td>
                            <td>${photos}</td>
                            <td>${fund.status}</td>
                            <td class="actbtn">
                                <button class="edit-btn" data-fund-id="${fund.fundId}">Edit</button>
                                <button class="suspend-btn" data-fund-id="${fund.fundId}">Suspend</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Tab switching functionality
    function openFundraisingTab(evt, tabName) {
        // Hide all tab content
        var tabcontent = document.getElementsByClassName("fundraising-content");
        for (var i = 0; i < tabcontent.length; i++) {
            tabcontent[i].classList.remove("active");
        }

        // Remove active class from all tabs
        var tabs = document.getElementsByClassName("fundraising-tab");
        for (var i = 0; i < tabs.length; i++) {
            tabs[i].classList.remove("active");
        }

        // Show the current tab and add active class
        document.getElementById(tabName).classList.add("active");
        evt.currentTarget.classList.add("active");
    }

    // Existing button functionality
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

    // New button functionality for approval tab
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", function() {
            let fundId = this.getAttribute("data-fund-id");
            alert("Edit Fundraising ID: " + fundId);
        });
    });

    document.querySelectorAll(".suspend-btn").forEach(button => {
        button.addEventListener("click", function() {
            let fundId = this.getAttribute("data-fund-id");
            alert("Suspend Fundraising ID: " + fundId);
        });
    });
</script>
</body>
</html>
