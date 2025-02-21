<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
  <title>My Survey Requests</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../index.css" />
  <link rel="stylesheet" href="../index/sidebar1.css" />
  <link rel="stylesheet" href="../index/header/header.css" />
  <link rel="stylesheet" href="../container.css" />
  <link rel="stylesheet" href="./details.css">
</head>

<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
  <div class="pageTitles">
    <h2 class="title">My Survey Requests</h2>
    <div class="subTitle">Manage your survey requests</div>
  </div>

  <div class="search">
    <label for="searchInput" class="icon">
      <i class="fa-solid fa-magnifying-glass"></i>
    </label>
    <input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">
  </div>

  <ul class="request-list">
    <c:forEach var="request" items="${allRequests}">
      <li class="request-item col">
        <div class="request-header">
          <span class="title">Request ID: ${request.suerveyrequestid}</span>
          <p class="date">Requested on: ${request.requesttime}</p>
        </div>
        <div class="request-content col">
          <p>User ID: <span>${request.userid}</span></p>
          <p>Question Type: <span>${request.questiontype}</span></p>
          <p>Question Text: <span>${request.questiontext}</span></p>
          <div class="seperator"></div>
        </div>
        <div class="request-actions row">
          <button class="button button-update"
                  onclick="openEditPopup(
                          '${request.suerveyrequestid}',
                          '${request.userid}',
                          '${request.questiontype}',
                          '${fn:escapeXml(request.questiontext)}',
                          '${request.requesttime}')">
            <i class="fa-solid fa-pen-to-square"></i>
            Edit
          </button>

          <!-- Delete Button -->
          <form action="DeleteSurveyRequestServlet" method="post"
                onsubmit="return confirm('Are you sure you want to delete this request?');"
                style="display:inline;">
            <input type="hidden" name="suerveyrequestid" value="${request.suerveyrequestid}" />
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

<!-- Update Request Popup Modal -->
<div class="popup-modal" id="editPopup">
  <div class="popup">
    <div class="title">
      <span>Edit Survey Request</span>
      <button class="close-btn" onclick="closeEditPopup()">
        <i class="fa-solid fa-times"></i>
      </button>
    </div>
    <form action="UpdateSurveyRequestServlet" method="post">
      <!-- Hidden field for request ID -->
      <input type="hidden" name="suerveyrequestid" id="suerveyrequestid" />

      <div class="formSection">
        <label for="editUserid">User ID</label>
        <input type="text" id="editUserid" name="userid" required />
      </div>

      <div class="formSection">
        <label for="editQuestionType">Question Type</label>
        <input type="text" id="editQuestionType" name="questiontype" required />
      </div>

      <div class="formSection">
        <label for="editQuestionText">Question Text</label>
        <textarea id="editQuestionText" name="questiontext" required></textarea>
      </div>

      <div class="formSection">
        <label for="editRequestTime">Request Time</label>
        <input type="datetime-local" id="editRequestTime" name="requesttime" required />
      </div>

      <div class="popbtns">
        <button type="submit" class="post-btn">Save Changes</button>
      </div>
    </form>
  </div>
</div>

<script>
  function openEditPopup(suerveyrequestid, userid, questiontype, questiontext, requesttime) {
    document.getElementById('editPopup').style.display = 'flex';
    document.getElementById('suerveyrequestid').value = suerveyrequestid;
    document.getElementById('editUserid').value = userid;
    document.getElementById('editQuestionType').value = questiontype;
    document.getElementById('editQuestionText').value = questiontext;
    document.getElementById('editRequestTime').value = requesttime;
  }

  function closeEditPopup() {
    document.getElementById('editPopup').style.display = 'none';
  }

  function filterRequests() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const items = document.querySelectorAll('.request-item');

    items.forEach(item => {
      const text = item.textContent.toLowerCase();
      if (text.includes(input)) {
        item.style.display = 'block';
      } else {
        item.style.display = 'none';
      }
    });
  }
</script>

</body>
</html>
