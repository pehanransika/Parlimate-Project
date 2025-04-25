<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bank Transfer Management | Admin Dashboard</title>

    <link rel="stylesheet" href="./BankTransferManagement.css" />

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
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row active">
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
            <div class="page-title capitalize">Bank Transfer Management</div>
            <div class="page-desc">Manage bank transfer requests and approvals.</div>
        </div>

        <div class="content">
            <!-- Tabs -->
            <div class="tabs f-row">
                <button class="tab-btn active" data-tab="requests">Bank Transfer Requests</button>
                <button class="tab-btn" data-tab="approved">Approved Bank Transfers</button>
            </div>

            <!-- Tab Content -->
            <div class="tab-content">
                <!-- Requests Tab -->
                <div id="requests" class="tab-pane active">
                    <div class="transfer-cards">
                        <c:forEach items="${pendingTransfers}" var="transfer">
                            <div class="transfer-card">
                                <div class="card-header f-row">
                                    <div class="transfer-id">Transfer ID: ${transfer.transfer_id}</div>
                                    <div class="transfer-date">${transfer.transfer_date}</div>
                                </div>
                                <div class="card-body">
                                    <div class="info-row f-row">
                                        <div class="info-label">User ID:</div>
                                        <div class="info-value">${transfer.user_id}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Fundraiser ID:</div>
                                        <div class="info-value">${transfer.fundraiser_id}</div>
                                    </div>



                                    <div class="info-row f-row">
                                        <div class="info-label">Amount:</div>
                                        <div class="info-value">${transfer.currency} ${transfer.amount}</div>
                                    </div>

                                    <div class="info-row f-row">
                                        <div class="info-label">Receipt:</div>
                                        <div class="info-value">

                                            <span>
        <c:if test="${not empty transfer.receipt_image_path}">
            <a href="${pageContext.request.contextPath}/${transfer.receipt_image_path}" target="_blank">
                View Receipt
            </a>
        </c:if>
        <c:if test="${empty transfer.receipt_image_path}">
            No Receipt available
        </c:if>
    </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-actions f-row">
                                    <form action="${pageContext.request.contextPath}/admin/BankTransferManagement/ApprovedTransferRequestServlet"
                                          method="POST"
                                          onsubmit="return confirm('Are you sure you want to approve this request?');">
                                        <input type="hidden" name="transfer_id" value="${transfer.transfer_id}"/>
                                        <button class="btn approve-btn" onclick="approveTransfer(${transfer.transfer_id})">
                                            <i class="fa-regular fa-check"></i> Approve
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/BankTransferManagement/DeleteBankTransferRequestServlet"
                                          method="post"
                                          onsubmit="return confirm('Are you sure you want to delete this request?');"
                                          style="display:inline;">
                                        <input type="hidden" name="transferId" value="${transfer.transfer_id}"/>
                                        <button class="btn reject-btn" onclick="rejectTransfer(${transfer.transfer_id})">
                                            <i class="fa-regular fa-xmark"></i> Reject
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Approved Tab -->
                <div id="approved" class="tab-pane">
                    <div class="transfer-cards">
                        <c:forEach items="${approvedTransfers}" var="transfer">
                            <div class="transfer-card approved">
                                <div class="card-header f-row">
                                    <div class="transfer-id">Transfer ID: ${transfer.transfer_id}</div>
                                    <div class="transfer-date">${transfer.transfer_date}</div>
                                    <div class="status-badge approved">
                                        <i class="fa-regular fa-check-circle"></i> Approved
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="info-row f-row">
                                        <div class="info-label">User ID:</div>
                                        <div class="info-value">${transfer.user_id}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Fundraiser ID:</div>
                                        <div class="info-value">${transfer.fundraiser_id}</div>
                                    </div>


                                    <div class="info-row f-row">
                                        <div class="info-label">Amount:</div>
                                        <div class="info-value">${transfer.currency} ${transfer.amount}</div>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Receipt Modal -->
<div id="receiptModal" class="modal">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <img id="modalReceiptImg" src="" alt="Receipt" class="modal-receipt-img">
    </div>
</div>
<script >
    // Tab functionality
    document.addEventListener('DOMContentLoaded', function() {
        const tabButtons = document.querySelectorAll('.tab-btn');
        const tabPanes = document.querySelectorAll('.tab-pane');

        tabButtons.forEach(button => {
            button.addEventListener('click', function() {
                const tabId = this.getAttribute('data-tab');

                // Remove active class from all buttons and panes
                tabButtons.forEach(btn => btn.classList.remove('active'));
                tabPanes.forEach(pane => pane.classList.remove('active'));

                // Add active class to clicked button and corresponding pane
                this.classList.add('active');
                document.getElementById(tabId).classList.add('active');
            });
        });
    });

    // Modal functions
    function showReceipt(imagePath) {
        const modal = document.getElementById('receiptModal');
        const modalImg = document.getElementById('modalReceiptImg');

        modalImg.src = imagePath;
        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('receiptModal').style.display = 'none';
    }

    // Close modal when clicking outside the image
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('receiptModal');
        if (event.target === modal) {
            closeModal();
        }
    });

    // Transfer approval functions



    /*function rejectTransfer(transferId) {
        const reason = prompt('Please enter the reason for rejection:');
        if (reason !== null) {
            // This assumes you have access to the reason in JSP context
            fetch(/rejectTransfer?transferId=${transferId}&reason=${fn:escapeXml(reason)}, {
                method: 'POST'
            })
                .then(response => {
                    if (response.ok) {
                        alert('Transfer rejected successfully!');
                        location.reload();
                    } else {
                        alert('Failed to reject transfer.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while rejecting the transfer.');
                });        }*/
    function deleteTransfer(transferId) {
        if (confirm('Are you sure you want to delete this request?')) {
            fetch('${pageContext.request.contextPath}/admin/BankTransferManagement/DeleteBankTransferRequestServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: transferId=${transferId}
            })
                .then(response => {
                    if (response.ok) {
                        // Show success message for 2 seconds before refreshing
                        const msg = document.createElement('div');
                        msg.className = 'delete-success-msg';
                        msg.textContent = 'Transfer deleted successfully!';
                        document.body.appendChild(msg);
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    } else {
                        alert('Failed to delete transfer.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while deleting the transfer.');
                });
        }
    }
</script>
</body>
</html>