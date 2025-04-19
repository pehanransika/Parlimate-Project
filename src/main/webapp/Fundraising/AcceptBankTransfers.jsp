<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title>Approved Bank Transfers</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    /* Container for transfer cards */
    #approved .transfer-cards {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin-top: 20px;
    }

    /* Individual transfer card */
    .transfer-card {
      background-color: #fff;
      border: 1px solid #ddd;
      border-left: 5px solid #4CAF50;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
      padding: 20px;
      transition: all 0.3s ease;
    }

    .transfer-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    /* Header section of the card */
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
      flex-wrap: wrap;
    }

    .transfer-id,
    .transfer-date {
      font-size: 16px;
      color: #333;
      font-weight: 500;
    }

    /* Status badge */
    .status-badge.approved {
      background-color: #e6ffed;
      color: #22863a;
      font-size: 14px;
      font-weight: 600;
      padding: 6px 12px;
      border-radius: 20px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    /* Card body */
    .card-body {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    /* Info rows */
    .info-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .info-label {
      font-weight: 600;
      color: #555;
      flex: 1;
    }

    .info-value {
      flex: 2;
      text-align: right;
      color: #222;
    }

    /* Utility Flex Row */
    .f-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    /* Responsive styling */
    @media (max-width: 768px) {
      .info-row {
        flex-direction: column;
        align-items: flex-start;
      }

      .info-value {
        text-align: left;
        margin-top: 4px;
      }

      .card-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
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

  <div id="approved" class="tab-pane">
    <div class="transfer-cards">
      <c:forEach items="${approvedTransferstouser}" var="transfer">
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

<script>

  document.getElementById('searchInput').addEventListener('input', function () {
    const searchTerm = this.value.toLowerCase();
    const cards = document.querySelectorAll('.transfer-card');

    cards.forEach(card => {
      const cardText = card.textContent.toLowerCase();
      card.style.display = cardText.includes(searchTerm) ? '' : 'none';
    });
  });

  function viewDetails(transferId) {
    window.location.href = `ViewTransferDetailsServlet?transferId=${transferId}`;
  }


</script>
</body>
</html>
