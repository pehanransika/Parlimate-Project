
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>Approved Bank Transfers</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="../index.css" />
  <link rel="stylesheet" href="../index/sidebar1.css" />
  <link rel="stylesheet" href="../index/header/header.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    #approved .transfer-cards {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin-top: 20px;
    }

    .transfer-card {
      background-color: #fff;
      border: 1px solid #ddd;
      border-left: 5px solid black;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
      padding: 20px;
      transition: all 0.3s ease;
    }

    .transfer-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

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

    .status-badge.approved {
      background-color: black;
      color: white;
      font-size: 14px;
      font-weight: 600;
      padding: 6px 12px;
      border-radius: 20px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .card-body {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

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

    .f-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

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
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">

    <h1>My Approved Bank Transfers</h1>


  <div class="search-filter">
    <div class="search-box">
      <i class="fas fa-search"></i>
      <input type="text" id="searchInput" placeholder="Search transfers...">
    </div>
  </div>

  <!-- DEBUG: show how many records were received -->
  <c:if test="${empty approvedTransferstouser}">
    <p>No approved transfers found.</p>
  </c:if>
  <c:if test="${not empty approvedTransferstouser}">
    <p>Total Transfers Found: <strong>${fn:length(approvedTransferstouser)}</strong></p>
  </c:if>

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
