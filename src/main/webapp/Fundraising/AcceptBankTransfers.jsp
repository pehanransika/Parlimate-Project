<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>Approved Bank Transfers</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #4CAF50;
      --hover-color: #45a049;
      --text-color: #333;
      --light-bg: #f8f9fa;
      --border-color: #ddd;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      color: var(--text-color);
    }

    .container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 20px;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }

    .page-title {
      font-size: 28px;
      color: var(--primary-color);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .transfer-table {
      width: 100%;
      border-collapse: collapse;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }

    .transfer-table th,
    .transfer-table td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid var(--border-color);
    }

    .transfer-table th {
      background-color: var(--primary-color);
      color: white;
      font-weight: 500;
    }

    .transfer-table tr:nth-child(even) {
      background-color: #f2f2f2;
    }

    .transfer-table tr:hover {
      background-color: #e9e9e9;
    }

    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 500;
    }

    .status-approved {
      background-color: #e6ffed;
      color: #22863a;
    }

    .action-btn {
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.3s;
      display: inline-flex;
      align-items: center;
      gap: 5px;
    }

    .view-btn {
      background-color: #2196F3;
      color: white;
    }

    .download-btn {
      background-color: #FF9800;
      color: white;
    }

    .action-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }

    .search-filter {
      display: flex;
      gap: 15px;
      margin-bottom: 20px;
    }

    .search-box {
      flex-grow: 1;
      position: relative;
    }

    .search-box input {
      width: 100%;
      padding: 10px 15px 10px 40px;
      border: 1px solid var(--border-color);
      border-radius: 4px;
      font-size: 16px;
    }

    .search-box i {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #777;
    }

    @media (max-width: 768px) {
      .transfer-table {
        display: block;
        overflow-x: auto;
      }

      .search-filter {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h1 class="page-title">
      <i class="fa-solid fa-wallet"></i>
      Approved Bank Transfers
    </h1>
  </div>

  <div class="search-filter">
    <div class="search-box">
      <i class="fas fa-search"></i>
      <input type="text" id="searchInput" placeholder="Search transfers...">
    </div>
  </div>

  <table class="transfer-table">
    <thead>
    <tr>
      <th>Transfer ID</th>
      <th>Date</th>
      <th>Account Holder</th>
      <th>Bank</th>
      <th>Amount</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
      <c:when test="${empty approvedTransferstouser}">
        <tr><td colspan="7">No approved transfers found.</td></tr>
      </c:when>
      <c:otherwise>
        <c:forEach items="${approvedTransferstouser}" var="transfer">
          <tr>
            <td>${transfer.transfer_id}</td>
            <td><fmt:formatDate value="${transfer.transfer_date}" pattern="MMM dd, yyyy hh:mm a"/></td>
            <td>${transfer.account_holder_name}</td>
            <td>${transfer.bank_name}</td>
            <td><fmt:formatNumber value="${transfer.amount}" type="currency" currencySymbol="${transfer.currency}"/></td>
            <td><span class="status-badge status-approved">Approved</span></td>
            <td>
              <button class="action-btn view-btn" onclick="viewDetails(${transfer.transfer_id})">
                <i class="fas fa-eye"></i> View
              </button>
              <button class="action-btn download-btn" onclick="downloadReceipt('${transfer.receipt_image_path}')">
                <i class="fas fa-download"></i> Receipt
              </button>
            </td>
          </tr>
        </c:forEach>
      </c:otherwise>
    </c:choose>
    </tbody>
  </table>
</div>

<script>
  // Search functionality
  document.getElementById('searchInput').addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('.transfer-table tbody tr');

    rows.forEach(row => {
      const rowText = row.textContent.toLowerCase();
      row.style.display = rowText.includes(searchTerm) ? '' : 'none';
    });
  });

  function viewDetails(transferId) {
    window.location.href = `ViewTransferDetailsServlet?transferId=${transferId}`;
  }

  function downloadReceipt(receiptPath) {
    window.location.href = `DownloadReceiptServlet?receiptPath=${encodeURIComponent(receiptPath)}`;
  }
</script>
</body>
</html>
