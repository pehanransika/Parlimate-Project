<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>My Survey Requests</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Survey Requests | Parlimate</title>
  <link rel="stylesheet" href="../index.css" />
  <link rel="stylesheet" href="../index/sidebar1.css" />
  <link rel="stylesheet" href="../index/header/header.css" />
  <link rel="stylesheet" href="../container.css" />
  <link rel="stylesheet" href="./details.css">

  <style>
    .popup-modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      justify-content: center;
      align-items: center;
    }

    .popup {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      width: 400px;
      position: relative;
    }

    .popup .close-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      cursor: pointer;
    }

    .formSection {
      margin-bottom: 15px;
    }

    .formSection label {
      display: block;
      margin-bottom: 5px;
    }

    .formSection input, .formSection textarea, .formSection select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .popbtns {
      text-align: center;
      margin-top: 20px;
    }

    .post-btn {
      padding: 10px 20px;
      background-color: #6a5acd;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .post-btn:hover {
      background-color: #5b4ab5;
    }
  </style>
</head>

<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
  <div class="pageTitles">
    <h2 class="title">My Survey Requests</h2>
    <div class="subTitle">
      Manage your survey requests
    </div>
  </div>

  <div class="search">
    <label for="searchInput" class="icon">
      <i class="fa-solid fa-magnifying-glass"></i>
    </label>
    <input type="text" id="searchInput" placeholder="Search survey requests..." onkeyup="filterRequests()">
  </div>
  <ul class="request-list">
    <c:forEach var="request" items="${allSurveyRequests}">
      <li class="request-item col">
        <div class="request-header">
          <span class="title">Survey ID: ${request.surveyRequestId}</span>
          <p class="date">Requested on: ${request.requestTime}</p>
        </div>
        <div class="request-content col">
          <p>User ID: <span>${request.userId}</span></p>
          <p>Question Text: <span>${request.questionText}</span></p>
          <p>Answer 1: <span>${request.answer01}</span></p>
          <p>Answer 2: <span>${request.answer02}</span></p>
          <p>Answer 3: <span>${request.answer03}</span></p>
          <p>Answer 4: <span>${request.answer04}</span></p>
        </div>
        <div class="request-actions row">
          <button
                  class="button button-update"
                  onclick="openEditPopup(
                          '${request.surveyRequestId}',
                          '${request.userId}',
                          '${fn:escapeXml(request.questionText)}',
                          '${request.answer01}',
                          '${request.answer02}',
                          '${request.answer03}',
                          '${request.answer04}',
                          '${request.requestTime}')">
            <i class="fa-solid fa-pen-to-square"></i>
            Edit
          </button>

          <!-- Delete Button -->
          <form action="DeleteSurveyRequestServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this survey request?');" style="display:inline;">
            <input type="hidden" name="surveyRequestId" value="${request.surveyRequestId}" />
            <button type="submit" class="button button-delete">
              <i class="fa-classic fa-solid fa-trash fa-fw"></i>
              Delete
            </button>
          </form>
        </div>
      </li>
    </c:forEach>
  </ul>
</div>

<!-- Update Survey Request Popup Modal -->
<div class="popup-modal" id="editPopup">
  <div class="popup">
    <div class="title">
      <span>Edit Survey Request</span>
      <button class="close-btn" onclick="closeEditPopup()">
        <i class="fa-solid fa-times"></i>
      </button>
    </div>
    <form action="UpdateSurveyRequestServlet" method="post">
      <!-- Hidden field for survey request ID -->
      <input type="hidden" name="surveyRequestId" id="surveyRequestId" />

      <div class="formSection">
        <label for="editUserId">User ID</label>
        <input type="text" id="editUserId" name="userId" required />
      </div>

      <div class="formSection">
        <label for="editQuestionText">Question Text</label>
        <textarea id="editQuestionText" name="questionText" required></textarea>
      </div>

      <div class="formSection">
        <label for="editAnswer01">Answer 1</label>
        <input type="text" id="editAnswer01" name="answer01" required />
      </div>

      <div class="formSection">
        <label for="editAnswer02">Answer 2</label>
        <input type="text" id="editAnswer02" name="answer02" required />
      </div>

      <div class="formSection">
        <label for="editAnswer03">Answer 3</label>
        <input type="text" id="editAnswer03" name="answer03" required />
      </div>

      <div class="formSection">
        <label for="editAnswer04">Answer 4</label>
        <input type="text" id="editAnswer04" name="answer04" required />
      </div>

      <div class="formSection">
        <label for="editRequestTime">Request Time</label>
        <input type="datetime-local" id="editRequestTime" name="requestTime" required />
      </div>

      <div class="popbtns">
        <button type="submit" class="post-btn">Save Changes</button>
      </div>
    </form>
  </div>
</div>

<script>
  function openEditPopup(surveyRequestId, userId, questionText, answer01, answer02, answer03, answer04, requestTime) {
    document.getElementById('editPopup').style.display = 'flex';

    document.getElementById('surveyRequestId').value = surveyRequestId;
    document.getElementById('editUserId').value = userId;
    document.getElementById('editQuestionText').value = questionText;
    document.getElementById('editAnswer01').value = answer01;
    document.getElementById('editAnswer02').value = answer02;
    document.getElementById('editAnswer03').value = answer03;
    document.getElementById('editAnswer04').value = answer04;
    document.getElementById('editRequestTime').value = requestTime;
  }

  function closeEditPopup() {
    document.getElementById('editPopup').style.display = 'none';
  }

  function filterRequests() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const items = document.querySelectorAll('.request-item');

    items.forEach(item => {
      const title = item.querySelector('.title').textContent.toLowerCase();
      const description = item.querySelector('.request-content').textContent.toLowerCase();
      if (title.includes(input) || description.includes(input)) {
        item.style.display = 'block';
      } else {
        item.style.display = 'none';
      }
    });
  }
</script>

</body>
<script src="../loadSidebar.js"></script>
<script>
  let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
  const body = document.querySelector("body");
  const navRadios = document.querySelectorAll('input[name="nav"]');

  sideMenuBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
      if (body.classList.contains("sidebar-deactive")) {
        body.classList.remove("sidebar-deactive");
      } else {
        body.classList.add("sidebar-deactive");
      }
    })
  });

  navRadios.forEach(radio => {
    radio.addEventListener('change', (event) => {
      const selectedValue = event.target.value;
      if (selectedValue) {
        window.location.href = selectedValue; // Redirect to the selected page
      }
    })
  });
</script>
</html>