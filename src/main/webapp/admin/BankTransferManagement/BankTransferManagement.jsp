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
                    <i class="fa-regular fa-circle-check"></i>
                    <span>requests</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}BankTransferManagementServlet" class="nav-item f-row">
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
                                        <div class="info-label">Bank:</div>
                                        <div class="info-value">${transfer.bank_name}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Account Holder:</div>
                                        <div class="info-value">${transfer.account_holder_name}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Account Number:</div>
                                        <div class="info-value">${transfer.account_number}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Amount:</div>
                                        <div class="info-value">${transfer.currency} ${transfer.amount}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Reference Code:</div>
                                        <div class="info-value">${transfer.reference_code}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Receipt:</div>
                                        <div class="info-value">
                                            <img src="${transfer.receipt_image_path}" alt="Receipt" class="receipt-img" onclick="showReceipt('${transfer.receipt_image_path}')">
                                        </div>
                                    </div>
                                </div>
                                <div class="card-actions f-row">
                                    <button class="btn approve-btn" onclick="approveTransfer(${transfer.transfer_id})">
                                        <i class="fa-regular fa-check"></i> Approve
                                    </button>
                                    <button class="btn reject-btn" onclick="rejectTransfer(${transfer.transfer_id})">
                                        <i class="fa-regular fa-xmark"></i> Reject
                                    </button>
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
                                        <div class="info-label">Bank:</div>
                                        <div class="info-value">${transfer.bank_name}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Account Holder:</div>
                                        <div class="info-value">${transfer.account_holder_name}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Amount:</div>
                                        <div class="info-value">${transfer.currency} ${transfer.amount}</div>
                                    </div>
                                    <div class="info-row f-row">
                                        <div class="info-label">Reference Code:</div>
                                        <div class="info-value">${transfer.reference_code}</div>
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
    function approveTransfer(transferId) {
        if (confirm('Are you sure you want to approve this transfer?')) {
            // Send AJAX request to approve the transfer
            fetch(`/approveTransfer?transferId=${transferId}`, {
                method: 'POST'
            })
                .then(response => {
                    if (response.ok) {
                        alert('Transfer approved successfully!');
                        location.reload();
                    } else {
                        alert('Failed to approve transfer.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while approving the transfer.');
                });
        }
    }

    function rejectTransfer(transferId) {
        const reason = prompt('Please enter the reason for rejection:');
        if (reason !== null) {
            // This assumes you have access to the reason in JSP context
            fetch(`/rejectTransfer?transferId=${transferId}&reason=${fn:escapeXml(reason)}`, {
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
                });
        }
    }
</script>
</body>
</html>