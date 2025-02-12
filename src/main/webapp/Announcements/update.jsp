<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
  if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
    response.sendRedirect("index.jsp");
    return;
  }%>

<html>
<head>
  <title>Announcement Details</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Popup Modal Styles */
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

    .formSection input, .formSection textarea {
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
<body>

<%
  // Get parameters from the URL for the selected announcement
  int announcementid = Integer.parseInt(request.getParameter("announcementid"));
  int politicianid = Integer.parseInt(request.getParameter("politicianid"));
  String title = request.getParameter("title");
  String content = request.getParameter("content");
  LocalDateTime datetime = LocalDateTime.parse(request.getParameter("datetime"));
%>

<!-- Update Announcement Form -->
<h2>Announcements</h2>
<!-- This button will open the modal for editing -->
<a href="#" onclick="openEditPopup('<%= announcementid %>', '<%= politicianid %>', '<%= title %>', '<%= content %>', '<%= datetime %>')">
  <button class="post-btn">Update Announcement</button>
</a>

<!-- The Popup Modal for Editing Announcement -->
<div class="popup-modal" id="editPopup">
  <div class="popup">
    <div class="title">
      <span>Edit Announcement</span>
      <button class="close-btn" onclick="closeEditPopup()">
        <i class="fa-solid fa-times"></i>
      </button>
    </div>

    <form action="UpdateServlet" method="post">
      <!-- Hidden fields for announcement ID and politician ID -->
      <input type="hidden" name="announcementid" id="announcementid" />
      <input type="hidden" name="politicianid" id="politicianid" />

      <!-- Title Section -->
      <div class="formSection">
        <label for="editTitle">Title</label>
        <input type="text" id="editTitle" name="title" placeholder="Edit title here..." required />
      </div>

      <!-- Content Section -->
      <div class="formSection">
        <label for="editContent">Content</label>
        <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
      </div>

      <!-- Date and Time Section -->
      <div class="formSection">
        <label for="editDatetime">Date and Time</label>
        <input type="datetime-local" id="editDatetime" name="datetime" required />
      </div>

      <!-- Save Button -->
      <div class="popbtns">
        <button type="submit" class="post-btn">Save Changes</button>
      </div>
    </form>
  </div>
</div>

<!-- JavaScript to handle the modal -->
<script>
  // Function to open the modal and populate the form
  function openEditPopup(announcementid, politicianid, title, content, datetime) {
    // Show the popup modal
    document.getElementById('editPopup').style.display = 'flex';

    // Remove milliseconds from the datetime value
    const formattedDatetime = datetime.substring(0, 16);

    // Populate the form with the current announcement data
    document.getElementById('announcementid').value = announcementid;
    document.getElementById('politicianid').value = politicianid;
    document.getElementById('editTitle').value = title;
    document.getElementById('editContent').value = content;
    document.getElementById('editDatetime').value = formattedDatetime;
  }


  // Function to close the popup modal
  function closeEditPopup() {
    // Hide the popup modal
    document.getElementById('editPopup').style.display = 'none';
  }
</script>

</body>
</html>
