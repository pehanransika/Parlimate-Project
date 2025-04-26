<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.UserController" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.AdminModel" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    UserModel user = (UserModel) session1.getAttribute("user");
    int userId = user.getUserId();

    AdminModel admin = new AdminModel();
    String adminName = admin.getAdminNameByUserId(userId);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Additional styles for tabbed interface */
        .fundraising-tabs {
            display: flex;
        }

        .fundraising-tab {
            padding: 10px 20px;
            background-color: #eee;
            margin-right: 10px;
            text-decoration: none;
            color: #333;
            border-radius: 5px 5px 0 0;
        }

        .fundraising-tab.active {
            background-color: #fff;
            border-bottom: 2px solid #fff;
            font-weight: bold;
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body class="">
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
                <a href="${pageContext.request.contextPath}/admin/CommentManagement/CommentManagementServlet" class="nav-item f-row active">
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
                <a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row">
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
                    <div class="p-img"><img src="<%= request.getContextPath() %>/images/Admin/admin.png"></div>
                    <div class="sUser f-col">
                        <div class="name"><%= adminName != null ? adminName : "Unknown Admin" %></div>
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
            <div class="page-title capitalize">Fundraising Management</div>
            <div class="page-desc">Manage fundraising campaigns, approvals, and targets.</div>
        </div>


        <!-- Fundraising Tabs -->
        <div class="fundraising-tabs">
            <div class="fundraising-tab " onclick="openFundraisingTab(event, 'fundraising-request')"><a class="fundraising-tab active" href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" >
                Fundraising Request</a></div>
            <div class="fundraising-tab" onclick="openFundraisingTab(event, 'approval-fundraisers')"><a class="fundraising-tab" href="${pageContext.request.contextPath}/admin/Fundraising/GetApprovalFundraisingServlet">

            Approval Fundraisers
            </a>   </div>

        </div>



        <!-- Fundraising Request Tab -->
        <div id="fundraising-request" class="fundraising-content active">
            <div class="actions f-row">

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
                    <c:forEach var="fund" items="${allFundraisings}">
                        <tr>
                            <td>${fund.title}</td>
                            <td><c:choose>
                                <c:when test="${fn:length(fund.description) > 12}">
                                    ${fn:substring(fund.description, 0, 12)}...
                                </c:when>
                                <c:otherwise>
                                    ${fund.description}
                                </c:otherwise>
                            </c:choose></td>
                            <td>${fund.contact_no}</td>
                            <td>${fund.category}</td>
                            <td>${fund.targetAmount != null ? fund.targetAmount : 'N/A'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty fund.attachmentUrl}">
                                        <a href="${pageContext.request.contextPath}/${fund.attachmentUrl}"
                                           target="_blank">View Attachment</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span>No attachment</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty fund.photos}">
                                        <a href="${pageContext.request.contextPath}/${fund.photos}"
                                           target="_blank">View Photo</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span>No photo</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${fund.status}</td>

                            <td class="actbtn">
                                <c:if test="${fund.status != 'DELETED'}">
                                <!-- Approve Button -->
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/ApproveFundraisingRequestServlet"
                                      method="POST"
                                      onsubmit="return confirm('Are you sure you want to approve this request?');"
                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>

                                    <button type="submit" class="approve-btn">Approve</button>
                                </form>
                                    <form action="${pageContext.request.contextPath}/admin/Fundraising/ViewAllFundraisingServlet" method="GET">
                                        <input type="hidden" name="requestId" value="${fund.requestId}" />
                                        <button type="submit" class="view-all-btn">View</button>
                                    </form>
                                <!-- Reject Button (will permanently delete) -->
                            <td class="actbtn">
                                <!-- Simple Delete Form with Confirmation -->
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/RejectRequestServlet"
                                      method="post"  onsubmit="return confirmDeleteWithReason(this)"
                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                    <input type="hidden" name="userId" value="${fund.userId}"/>
                                    <input type="hidden" name="title" value="${fund.title}"/>
                                    <button type="submit" class="delete-btn">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </form>

                            </td>
                            </td>
                            </c:if>
                            <c:if test="${fund.status == 'DELETED'}">
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/RestoreFundraisingRequestServlet"
                                      method="POST"
                                      onsubmit="return confirm('Are you sure you want to restore this request?');"
                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                    <button type="submit" class="approve-btn">Restore</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/FinalDeleteFundraisingRequestServlet"
                                      method="POST"

                                      style="display:inline;">
                                    <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                    <button type="submit" class="approve-btn"> delete</button>
                                </form>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <form action="RejectRequestServlet" method="post" onsubmit="return confirmDeleteWithReason(this)">
            <input type="hidden" name="requestId" value="${request.requestId}">


            <!-- The reason input will be added by JavaScript -->


        </form>

        <!-- Approval Fundraisers Tab -->
        <div id="approval-fundraisers" class="fundraising-content">
            <div class="actions f-row">


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

                    <c:forEach var="fund" items="${approvalrequests}">
                        <tr>
                            <td>${fund.title != null ? fund.title : 'N/A'}</td>
                            <td><c:choose>
                                <c:when test="${fn:length(fund.description) > 12}">
                                    ${fn:substring(fund.description, 0, 12)}...
                                </c:when>
                                <c:otherwise>
                                    ${fund.description}
                                </c:otherwise>
                            </c:choose></td>
                            <td>${fund.contact_no != null ? fund.contact_no : 'N/A'}</td>
                            <td>${fund.category != null ? fund.category : 'N/A'}</td>
                            <td>${fund.targetamount != 0 ? fund.targetamount : 'N/A'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty fund.attachmentUrl}">
                                        <a href="${pageContext.request.contextPath}/${fund.attachmentUrl}"
                                           target="_blank">View Attachment</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span>No attachment</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty fund.photos}">
                                        <a href="${pageContext.request.contextPath}/${fund.photos}"
                                           target="_blank">View Photo</a>
                                    </c:when>
                                    <c:otherwise>
                                        <span>No photo</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${fund.status != null ? fund.status : 'N/A'}</td>
                            <td class="actbtn">
                                <c:if test="${fund.status != 'HOLD'}">

                                    <form action="${pageContext.request.contextPath}/admin/Fundraising/HoldApprovedRequestServlet"
                                          method="post"
                                          style="display:inline;">
                                        <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                        <button class="suspend-btn" data-fund-id="${fund.requestId}">Hold</button>
                                    </form>
                                </c:if>
                                <c:if test="${fund.status == 'HOLD'}">
                                    <form action="${pageContext.request.contextPath}/admin/Fundraising/RestoreApprovedFundraisingRequestServlet"
                                          method="POST"
                                          onsubmit="return confirm('Are you sure you want to restore this request?');"
                                          style="display:inline;">
                                        <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                        <button type="submit" class="approve-btn">Restore</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/Fundraising/FinalDeleteApprovedFundraisingRequestServlet"
                                          method="POST"
                                          onsubmit="return confirm('Are you sure you want to Permenantly delete this request?');"
                                          style="display:inline;">
                                        <input type="hidden" name="requestId" value="${fund.requestId}"/>
                                        <button type="submit" class="approve-btn"> delete</button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/admin/Fundraising/ViewAllApproveFundraisingServlet" method="GET">
                                    <input type="hidden" name="requestId" value="${fund.requestId}" />
                                    <button type="submit" class="view-all-btn">View</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Email Modal -->
    <div id="emailModal" class="modal" style="display:none;">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h3>Send Email to User</h3>
            <form id="emailForm">
                <input type="hidden" id="fundRequestId" name="requestId">
                <div class="form-group">
                    <label for="userEmail">User Email:</label>
                    <input type="email" id="userEmail" name="userEmail" required class="form-control" readonly>
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


</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>


    function confirmDeleteWithReason(form) {
        // First confirmation
        if (!confirm('Are you sure you want to reject this request?')) {
            return false;
        }

        // Prompt for reason
        const reason = prompt('Please specify the reason for rejection (minimum 10 characters):');

        // Validate reason
        if (reason === null) {
            alert('Rejection cancelled.');
            return false;
        }

        if (reason.trim() === '') {
            alert('A reason is required for rejection.');
            return false;
        }

        if (reason.length < 10) {
            alert('Reason must be at least 10 characters long.');
            return false;
        }

        // Create hidden input for reason if it doesn't exist
        let reasonInput = form.querySelector('input[name="rejectionReason"]');
        if (!reasonInput) {
            reasonInput = document.createElement('input');
            reasonInput.type = 'hidden';
            reasonInput.name = 'rejectionReason';
            form.appendChild(reasonInput);
        }
        reasonInput.value = reason;

        return true;
    }


    // Create custom prompt for reason





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
            alert("Rejected Fundraising ID: " + requestId);
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
            function (data) {
                $('#approval-fundraisers').html($(data).find('#approval-fundraisers').html());
            }
        );
    }

    document.addEventListener('DOMContentLoaded', function () {
        // Get modal elements
        const modal = document.getElementById('emailModal');
        const closeBtn = document.querySelector('.close-btn');

        // Handle edit button clicks
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function () {
                const requestId = this.getAttribute('data-fund-id');
                document.getElementById('fundRequestId').value = requestId;

                // Here you could fetch user email via AJAX if needed
                // fetchUserEmail(requestId);

                modal.style.display = 'block';
            });
        });

        // Close modal when X is clicked
        closeBtn.addEventListener('click', function () {
            modal.style.display = 'none';
        });

        // Close modal when clicking outside
        window.addEventListener('click', function (event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Handle form submission
        document.getElementById('emailForm').addEventListener('submit', function (e) {
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

    const rejectModal = document.getElementById('rejectModal');
    const closeBtn = document.querySelector('.close');
    const rejectForm = document.getElementById('rejectForm');
    const rejectRequestId = document.getElementById('rejectRequestId');

    // Handle reject button clicks
    document.querySelectorAll('.reject-btn').forEach(button => {
        button.addEventListener('click', function () {
            const requestId = this.getAttribute('data-fund-id');
            rejectRequestId.value = requestId;
            rejectModal.style.display = 'block';
        });
    });

    // Close modal when X is clicked
    closeBtn.addEventListener('click', function () {
        rejectModal.style.display = 'none';
    });

    // Close modal when clicking outside
    window.addEventListener('click', function (event) {
        if (event.target === rejectModal) {
            rejectModal.style.display = 'none';
        }
    });

    // Handle form submission
    rejectForm.addEventListener('submit', function (e) {
        const reason = document.getElementById('rejectionReason').value;
        if (!reason) {
            e.preventDefault();
            alert('Please provide a reason for rejection');
            return false;
        }
        return confirm('Are you sure you want to reject this request?');
    });

    // Refresh the page after form submissions to see updated status
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function () {
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        });
    });
    let currentRejectRequestId = null;

    function showRejectionModal(requestId) {
        currentRejectRequestId = requestId;
        document.getElementById('rejectionModal').style.display = 'block';
        document.getElementById('rejectionReason').value = '';
    }

    function hideRejectionModal() {
        document.getElementById('rejectionModal').style.display = 'none';
        currentRejectRequestId = null;
    }

    function submitRejection() {
        const reason = document.getElementById('rejectionReason').value.trim();

        if (!reason) {
            alert('Please provide a reason for rejection');
            return;
        }

        if (confirm('Are you sure you want to reject this request?')) {
            // Create form data
            const formData = new FormData();
            formData.append('requestId', currentRejectRequestId);
            formData.append('rejectionReason', reason);
            formData.append('status', 'rejected');

            // Send to server
            fetch('${pageContext.request.contextPath}/admin/Fundraising/DeleteAdminRequestServlet', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        // Update UI
                        document.getElementById(`action-buttons-${requestId}`).style.display = 'none';
                        document.getElementById(`restore-form-${requestId}`).style.display = 'inline';
                        hideRejectionModal();
                        alert('Request has been rejected');
                    } else {
                        throw new Error('Rejection failed');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to reject the request');
                });
        }
    }

    function confirmRejection(requestId) {
        if (confirm('Are you sure you want to reject this request?')) {
            // Submit the rejection form
            document.getElementById(`reject-form-${requestId}`).submit();

            // Hide reject button and show restore button (will be fully applied after page reload)
            document.getElementById(`action-buttons-${requestId}`).style.display = 'none';
            document.getElementById(`restore-form-${requestId}`).style.display = 'inline';
        }
    }

    let currentDeleteForm = null;

    function handleDelete(event, requestId) {
        event.preventDefault();
        currentDeleteForm = document.getElementById(`delete-form-${requestId}`);
        document.getElementById('reasonInput').value = '';
        document.getElementById('reasonModal').style.display = 'block';
        return false;
    }

    function confirmReason() {
        const reason = document.getElementById('reasonInput').value.trim();
        if (!reason) {
            alert('Please provide a reason for deletion');
            return;
        }

        // Set the hidden reason field
        document.getElementById(`delete-reason-${currentDeleteForm.id.split('-')[2]}`).value = reason;

        // Submit the form
        if (confirm('Are you sure you want to permanently delete this request?')) {
            currentDeleteForm.submit();
        }

        // Hide modal
        document.getElementById('reasonModal').style.display = 'none';
    }


    $(document).ready(function() {
        // Replace form submission with AJAX
        $(document).on('click', '.suspend-btn', function(e) {
            e.preventDefault();
            var form = $(this).closest('form');
            var row = form.closest('tr');

            if(confirm('Are you sure you want to hold this request?')) {
                $.ajax({
                    type: 'POST',
                    url: form.attr('action'),
                    data: form.serialize(),
                    success: function(response) {
                        // Update the status cell in the same row
                        row.find('td:nth-child(8)').text('HOLD');

                        // Optional: Change button appearance
                        $(this).text('Held').prop('disabled', true);
                    },
                    error: function() {
                        alert('Error occurred while updating status');
                    }
                });
            }
        });
    });



</script>


</body>
</html>