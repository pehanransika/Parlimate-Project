<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.UserController" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <link rel="stylesheet" href="./emailpopup.css" />
    <link rel="stylesheet" href="../index.css" />

    <!-- icons -->
    <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
          href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d" />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css" />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css" />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css" />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css" />
    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/solid.css"
    />

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css" />
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
                <a href="../userManagement/UserManagementServlet" class="nav-item f-row">
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
            <div class="page-title capitalize">Fundraising Management</div>
            <div class="page-desc">Manage fundraising campaigns, approvals, and targets.</div>
        </div>

        <!-- Fundraising Tabs -->
        <div class="fundraising-tabs">
            <div class="fundraising-tab active" onclick="openFundraisingTab(event, 'fundraising-request')">Fundraising Request</div>
            <div class="fundraising-tab" onclick="openFundraisingTab(event, 'approval-fundraisers')">
                Approval Fundraisers
            </div>

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
                            <td>${fund.targetAmount != null ? fund.targetAmount : 'N/A'}</td>
                            <td><a href="${fund.attachmentUrl != null ? fund.attachmentUrl : '#'}" target="_blank">View</a></td>
                            <td><a href="${fund.photos != null ? fund.photos : '#'}" target="_blank">View</a></td>
                            <td class="actbtn">
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/ApproveFundraisingRequestServlet"
                                      method="POST"
                                      onsubmit="return confirm('Are you sure you want to approve this request?');">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                    <button type="submit" class="approve-btn">Approve</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/DeleteAdminRequestServlet"
                                      method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this request?');"
                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                <button class="reject-btn" data-fund-id="${fund.requestId}">Reject</button>
                                </form>
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
                        <td>Action</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="fund" items="${approvalrequests}">
                        <tr>
                            <td>${fund.title != null ? fund.title : 'N/A'}</td>
                            <td>${fund.description != null ? fund.description : 'N/A'}</td>
                            <td>${fund.contact_no != null ? fund.contact_no : 'N/A'}</td>
                            <td>${fund.category != null ? fund.category : 'N/A'}</td>
                            <td>${fund.targetamount != 0 ? fund.targetamount : 'N/A'}</td>
                            <td>
                                <a href="${fund.attachmentUrl != null ? fund.attachmentUrl : '#'}"
                                   target="_blank"
                                    ${fund.attachmentUrl == null ? 'style="pointer-events: none; color: gray;"' : ''}>
                                    View
                                </a>
                            </td>
                            <td>
                                <a href="${fund.photos != null ? fund.photos : '#'}"
                                   target="_blank"
                                    ${fund.photos == null ? 'style="pointer-events: none; color: gray;"' : ''}>
                                    View
                                </a>
                            </td>
                            <td class="actbtn">
                                <button class="edit-btn" data-fund-id="${fund.requestId}">Send Mail</button>
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/DeleteApproveRequestServlet"
                                      method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this request?');"
                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                <button class="suspend-btn" data-fund-id="${fund.requestId}">Suspend</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="emailModal" class="modal" style="display:none;">
            <div class="modal-content">
                <span class="close-btn">&times;</span>
                <h3>Send Email to User</h3>
                <form id="emailForm">
                    <input type="hidden" id="fundRequestId" name="requestId">
                    <div class="form-group">
                        <label for="userEmail">User Email:</label>
                        <input type="email" id="userEmail" name="userEmail" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="emailSubject">Subject:</label>
                        <input type="text" id="emailSubject" name="subject" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="emailMessage">Message:</label>
                        <textarea id="emailMessage" name="message" rows="5" required class="form-control"></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Email</button>
                </form>
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
        button.addEventListener("click", function () {
            let fundId = this.getAttribute("data-fund-id");
            alert("Approved Fundraising ID: " + requestId);
        });
    });

    document.querySelectorAll(".reject-btn").forEach(button => {
        button.addEventListener("click", function () {
            let fundId = this.getAttribute("data-fund-id");
            alert("Rejected Fundraising ID: " + fundId);
        });
    });

    // New button functionality for approval tab
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", function () {
            let fundId = this.getAttribute("data-fund-id");
            alert("Edit Fundraising ID: " + fundId);
        });
    });

    document.querySelectorAll(".suspend-btn").forEach(button => {
        button.addEventListener("click", function () {
            let fundId = this.getAttribute("data-fund-id");
            alert("Suspend Fundraising ID: " + fundId);
        });
    });
    function refreshFundraisingTable() {
        $.get('${pageContext.request.contextPath}/admin/Fundraising/GetApprovalFundraisingServlet',
            function(data) {
                $('#approval-fundraisers').html($(data).find('#approval-fundraisers').html());
            }
        );
    }
    document.addEventListener('DOMContentLoaded', function() {
        // Get modal elements
        const modal = document.getElementById('emailModal');
        const closeBtn = document.querySelector('.close-btn');

        // Handle edit button clicks
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function() {
                const requestId = this.getAttribute('data-fund-id');
                document.getElementById('fundRequestId').value = requestId;

                // Here you could fetch user email via AJAX if needed
                // fetchUserEmail(requestId);

                modal.style.display = 'block';
            });
        });

        // Close modal when X is clicked
        closeBtn.addEventListener('click', function() {
            modal.style.display = 'none';
        });

        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Handle form submission
        document.getElementById('emailForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const formData = new FormData(this);

            fetch('${pageContext.request.contextPath}/admin/Fundraising/SendEmailServlet', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Email sent successfully!');
                        modal.style.display = 'none';
                        this.reset();
                    } else {
                        alert('Error sending email: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to send email');
                });
        });
    });

    // Optional: Fetch user email via AJAX
    function fetchUserEmail(requestId) {
        fetch('${pageContext.request.contextPath}/admin/Fundraising/GetUserEmailServlet?requestId=' + requestId)
            .then(response => response.json())
            .then(data => {
                if (data.email) {
                    document.getElementById('userEmail').value = data.email;
                }
            })
            .catch(error => console.error('Error fetching email:', error));
    }

</script>
</body>
</html>