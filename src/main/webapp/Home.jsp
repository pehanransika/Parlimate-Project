<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%
  HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
  if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
    response.sendRedirect("index.jsp");
    return;
  }
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Home | Parlimate</title>
  <link rel="stylesheet" href="index/sidebar1.css"/>
  <link rel="stylesheet" href="index/header/header.css"/>
  <link rel="stylesheet" href="container.css"/>
  <link rel="stylesheet" href="comment.css"/>
  <link rel="stylesheet" href="index.css"/>
  <link rel="stylesheet" href="edit.css"/>
  <link rel="stylesheet" href="fund-popup.css"/>
  <link rel="stylesheet" href="hashtag.css"/>


  <!-- icons -->
  <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
        href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"/>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"/>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"/>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"/>

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"/>
  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"/>

  <style>
    .logo-img {
      height: 1.3rem;
      margin-bottom: -0.25rem;
    }

    .container {
      margin-top: 2.5rem;
    }
  </style>
</head>

<body class>
<form action="CreateRequestServlet" method="post" class="popup-f" id="popup-f" enctype="multipart/form-data">
  <div class="bg"></div>
  <div class="fund-popup col">
    <div class="head row">
      <div class="close-btn">
        <i class="fa-solid fa-xmark"></i>
      </div>
      <div class="icon">
        <i class="fa-regular fa-briefcase"></i>
      </div>
      <div class="title">Request a fundraise</div>
      <div class="separator"></div>
    </div>
    <div class="body col">
      <div class="fund-title field">
        <label for="fundtitle" class="title">Title</label>
        <input type="text" required placeholder="Fundraise for the senior care house" name="title"
               id="fundtitle">
      </div>
      <input type="hidden" name="userid" id="useri" value="${user.userId}">
      <input type="hidden" name="username" id="usernam" value="${userProfile.name}">
      <div class="fund-decs field">
        <label for="fund-desc" class="title">Description</label>
        <textarea required name="description"
                  placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..."
                  id="fund-desc"></textarea>
      </div>
      <div class="fund-contact" style="margin-bottom: 20px; font-family: Arial, sans-serif;">
        <label class="title"
               style="display: block; font-weight: bold; margin-bottom: 8px; font-size: 14px; color: #333;">
          Contact Number
        </label>
        <input
                type="tel"
                name="contact_no"
                required
                pattern="[0-9]{10}"
                maxlength="10"
                placeholder="Enter your contact number"
                title="Contact number must be exactly 10 digits"
                style="width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px; box-sizing: border-box;"
        >
      </div>


      <div class="multi-fields row">
        <div class="fund-cat field">
          <label for="fund-categ" class="title">Category</label>
          <select required name="category" id="fund-categ">
            <option value="educational">Educational</option>
            <option value="social">Social</option>
            <option value="community-se">Community Service</option>
          </select>
        </div>
        <div class="fund-amount field col">
          <label class="title" for="fund-amount">Fund Target</label>
          <div class="content row">
            <div class="curr">
              <select required name="currency" id="fund-currency">
                <option value="lkr">LKR</option>
                <option value="usd">USD</option>
              </select>
            </div>
            <div class="amount">
              <input required type="number" name="targetamount" id="fund-amount" min="1"
                     placeholder="1,000,000.00">
            </div>

          </div>
        </div>
      </div>
      <div class="fund-attach field">
        <span for="" class="title">Upload Attachments</span>
        <div class="att-container">
          <div class="action row">
            <label for="fund-att" class="att-btn">Select File</label>
            <input type="file" name="attachmentUrl" id="fund-att" multiple>
            <div class="sep"></div>
          </div>
          <div class="att-content">
            <span class="no-of-files">No file attached</span>
            <ul id="att-list" class="col">
              <!-- uploaded files will be listed here -->
            </ul>
          </div>
        </div>
      </div>
      <div class="fund-photo field">
        <span for="" class="title">Upload Photos</span>
        <div class="att-container-photo">
          <div class="action row-photo">
            <label for="fund-photo" class="photo-btn">Select Photo</label>
            <input type="file" name="photos" id="fund-photo" multiple>
            <div class="sep"></div>
          </div>
          <div class="photo-content">
            <span class="no-of-files">No Photo attached</span>
            <ul id="photo-list" class="col">
              <!-- uploaded files will be listed here -->
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="bottom row">
      <button type="button" class="cancel-btn form-btn">Cancel</button>
      <button type="submit" class="submit-btn form-btn row">
        <i class="fa-duotone fa-solid fa-check"></i>
        Publish
      </button>
    </div>
  </div>
</form>
<div class="notification-msg capitalize"></div>
<div class="popup-modal popup">
  <form method="POST" action="PublishNewPostServlet" enctype="multipart/form-data" class="popup-content">
    <div class="close-btn" id="popup-close-btn">
      <i class="fa-solid fa-xmark"></i>
    </div>
    <div class="top">
      <div class="icon">
        <i class="fa-regular fa-sparkles"></i>
      </div>
      <div class="title">create new post</div>
    </div>
    <div class="content f-col" enctype="multipart/form-data">

      <div class="caption-box col content-pd">
        <div class="title capitalize">whats on your mind?</div>
        <input type="hidden" name="userid" id="userid" value="${user.userId}"/>
        <input type="hidden" name="username" id="username" value="${userProfile.name}"/>

        <textarea autocomplete="off" name="content" id="post-desc"
                  placeholder="Share your thoughts, questions, or political insights..."></textarea>
      </div>
      <div class="new-post-photo field">
        <span class="title">Add media</span>
        <div class="action f-col row-photo">
          <label for="post-photo" class="custom-photo-btn">Select Photo</label>
          <input type="file" name="images" id="post-photo">
          <div id="file-preview" class="file-preview"></div>
          <div id="image-preview" class="image-preview"></div>
        </div>
      </div>


    </div>
    <div class="popbtns footer capitalize f-row">
      <button type="button" class="clear-btn scndry-btn" id="popup-clear-btn">
        Clear
      </button>
      <button type class="post-btn prmry-btn" id="popup-post-btn" onclick="this.closest('form').submit();">
        post discussion
        <i class="fa-duotone fa-solid fa-check"></i>
      </button>
    </div>
  </form>
</div>

<div class="comment-popup">
  <div class="comment-container col-u">


    <div class="drop-cmnt"></div>
    <div class="post reactable reacted">
      <div class="top">
        <div class="post-details">
          <a href="#" class="img"></a>
          <div class="details">

            <a href="#" class="name">Himasha Chinthani</a>
            <div class="posted-date">
              <i class="fa-light fa-clock"></i>
              <div class="time">
                <span class="value" id="popup-time">30</span> <!-- Will be updated by JS -->
              </div>
            </div>
          </div>
        </div>
        <div>
          <input type="checkbox" name="post-menu" id="postMenu" class="menuBtn"/>
          <span class="tip">options</span>
          <label for="postMenu" class="btn-2">
            <i class="fa-regular fa-ellipsis-vertical"></i>
          </label>
          <div class="post-dropDownMenu">
            <ul>
              <li><a href="#">report</a></li>
              <li><a href="#">copy link</a></li>

            </ul>
          </div>
        </div>
      </div>
      <div class="content" id="popup-content">
        Sri Lankan politics is the gift that keeps on giving...
      </div> <!-- Will be updated by JS -->
      <div class="reactions">
        <button class="like btn">
                    <span class="reactIcon">
                        <i class="fa-solid fa-thumbs-up"></i>
                    </span>
          <span>like</span>
          <span class="count">0</span>
        </button>
        <button class="share btn">
                    <span class="reactIcon">
                        <i class="fa-duotone fa-solid fa-share-all"></i>
                    </span>
          <span>share</span>
        </button>

      </div>
    </div>

    <div class="add-cmnt row">
      <div class="curr-user row">
        <div class="prof-img"></div>
      </div>


    </div>
  </div>
</div>


<%@ include file="index/sidebar.jsp" %>

<div class="logoutBtn capitalize">
  <div class="cont">
    <input type="checkbox" name="logoutBtn" id="logoutBtn" onclick="logoutRedirect()"/>
    <label for="logoutBtn">
      <i class="fa-solid fa-sign-out"></i>
      <span>logout</span>
    </label>
  </div>
</div>


</div>

<%@ include file="./index/header/header.jsp" %>
<div class="comment-section">
  <div class="popup-container">
    <div class="top f-row">
      <div class="icon f-row">
        <i class="fa-regular fa-comments"></i>
      </div>
      <div class="title capitalize">comments</div>
      <div class="cls-btn">
        <i class="fa-regular fa-xmark"></i>
      </div>
    </div>
    <div class="content f-col">
      <div class="comment f-col">
        <div class="cmnt-head f-row">
          <div class="profile-img"></div>
          <div class="cmnt-details f-col">
            <div class="name">liam gregor</div>
            <div class="com-date formatDate f-row">
              <div class="date">2025-04-20 04:20</div>
              <%--                            date ek methnt daanda (format wenawa automa) in this format 2025-04-25 14:06:57.489--%>
            </div>
          </div>
        </div>
        <div class="cmnt-body hashtags">
          This polarization underscores the need for pragmatic solutions over ideological extremes. While
          healthy debate is essential, #the_erosion of compromise threatens functional governance. Electoral
          reforms, fact-based policymaking
        </div>
      </div>
      <div class="comment f-col">
        <div class="cmnt-head f-row">
          <div class="profile-img"></div>
          <div class="cmnt-details f-col">
            <div class="name">liam gregor</div>
            <div class="com-date formatDate f-row">
              <div class="date">2025-04-20 04:20</div>
              <%--                            date ek methnt daanda (format wenawa automa) in this format 2025-04-25 14:06:57.489--%>
            </div>
          </div>
        </div>
        <div class="cmnt-body">
          This polarization underscores the need for pragmatic solutions over ideological extremes. While
          healthy debate is essential, the erosion of compromise threatens functional governance. Electoral
          reforms, fact-based policymaking
        </div>
      </div>
      <div class="comment f-col">
        <div class="cmnt-head f-row">
          <div class="profile-img"></div>
          <div class="cmnt-details f-col">
            <div class="name">liam gregor</div>
            <div class="com-date formatDate f-row">
              <div class="date">2025-04-20 04:20</div>
              <%--                            date ek methnt daanda (format wenawa automa) in this format 2025-04-25 14:06:57.489--%>
            </div>
          </div>
        </div>
        <div class="cmnt-body">
          This polarization underscores the need for pragmatic solutions over ideological extremes. While
          healthy debate is essential, the erosion of compromise threatens functional governance. Electoral
          reforms, fact-based policymaking
        </div>
      </div>
      <div class="comment f-col">
        <div class="cmnt-head f-row">
          <div class="profile-img"></div>
          <div class="cmnt-details f-col">
            <div class="name">liam gregor</div>
            <div class="com-date formatDate f-row">
              <div class="date">2025-04-20 04:20</div>
              <%--                            date ek methnt daanda (format wenawa automa) in this format 2025-04-25 14:06:57.489--%>
            </div>
          </div>
        </div>
        <div class="cmnt-body">
          This polarization underscores the need for pragmatic solutions over ideological extremes. While
          healthy debate is essential, the erosion of compromise threatens functional governance. Electoral
          reforms, fact-based policymaking
        </div>
      </div>
      <div class="comment f-col">
        <div class="cmnt-head f-row">
          <div class="profile-img"></div>
          <div class="cmnt-details f-col">
            <div class="name">liam gregor</div>
            <div class="com-date formatDate f-row">
              <div class="date">2025-04-20 04:20</div>
              <%--                            date ek methnt daanda (format wenawa automa) in this format 2025-04-25 14:06:57.489--%>
            </div>
          </div>
        </div>
        <div class="cmnt-body">
          This polarization underscores the need for pragmatic solutions over ideological extremes. While
          healthy debate is essential, the erosion of compromise threatens functional governance. Electoral
          reforms, fact-based policymaking
        </div>
      </div>
    </div>
    <div class="footer">
      <div class="comment-input-field">
                <textarea autocomplete="off" required name="content" id="comment-input" rows="2" style="width: 100%; "
                          placeholder="Enter your comment"></textarea>
        <button class="send-btn" onclick="validateAndSubmitComment(this);">send</button>
      </div>
    </div>
  </div>
</div>
<div class="container">
  <div class="pageTitles">
    <h2 class="title">Home</h2>
    <div class="subTitle">Political activities and Discussions</div>

    <div class="topContent">
      <div class="social-btns col">
        <div class="addPost-btn">
          <div class="prof-img"><img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/images/user_${user.userId}/${userProfile.profileImg}"
                                     alt="User Profile Image" style="width: 100%; height: 100%; border-radius: 50%" onerror="this.src='${pageContext.request.contextPath}/images/Users/user.png'"/></div>
          <div class="content">
            <div class="greeting">
              Hello <span class="userName">${userProfile.name}</span>
            </div>
            <div>Got something to share?</div>
          </div>
        </div>
        <div class="req-fundraising col">
          <div class="title capitalize row">
            start a fundraise
          </div>
        </div>
      </div>
<%--      <div class="weeklySurvey post votelist reactable">--%>
<%--        <div class="post-head small-title">--%>
<%--          <div class="post-title">--%>
<%--            weekly survey--%>
<%--            <span class="btn round"><i class="fa-solid fa-info"></i></span>--%>
<%--          </div>--%>
<%--          <div class="survTime">--%>
<%--            survey ends in :--%>
<%--            <span class="time">--%>
<%--							<span class="sur-end-day">5</span> days--%>
<%--							<span class="sur-end-hour">12</span> hours--%>
<%--						</span>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="survey-title">--%>
<%--          Who will be the next president of Sri Lanka?--%>
<%--        </div>--%>
<%--        <div class="surveyContent capitalize">--%>
<%--					<span>--%>
<%--						<input type="radio" name="week-survey" id="survey-1"/>--%>
<%--						<label for="survey-1">mahinda rajapakse</label>--%>
<%--					</span>--%>
<%--          <span>--%>
<%--						<input type="radio" name="week-survey" id="survey-2"/>--%>
<%--						<label for="survey-2">ranil wickramasinghe</label>--%>
<%--					</span>--%>
<%--          <span>--%>
<%--						<input type="radio" name="week-survey" id="survey-3"/>--%>
<%--						<label for="survey-3">anura kumara dissanayake</label>--%>
<%--					</span>--%>
<%--          <span>--%>
<%--						<input type="radio" name="week-survey" id="survey-4"/>--%>
<%--						<label for="survey-4">sajith wickramasinghe</label>--%>
<%--					</span>--%>
<%--        </div>--%>
<%--        <div class="reactions">--%>
<%--          <button class="btn" id="vote-btn">--%>
<%--            submit my vote--%>
<%--          </button>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--      <div class="last-surveys">--%>
<%--        <div class="post-head medium-title">--%>
<%--          Last surevy results--%>
<%--        </div>--%>
<%--        <div class="content">--%>
<%--          fill this content with the last survey results--%>
<%--        </div>--%>
<%--        <a href="#" class="past-surv-link small-text">See past surevys</a>--%>
<%--      </div>--%>
    </div>

    <div class="posts-container f-col"
         style="list-style-type: none; padding: 0; margin-right: 20px; display: flex; flex-direction: column; gap: 1.5rem;">
      <%--            post here--%>


      <c:forEach var="post" items="${allposts}">
        <!-- Post Details -->
        <div class="post f-col">
          <input type="hidden" name="userid" value="${user.userId}">
          <input type="hidden" name="postId" value="${post.postId}">
          <input type="hidden" name="username" value="${userProfile.name}">
          <div class="content f-col">
            <div class="profile f-row">
              <div class="pro-img">
<%--                <img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/images/user_${post.userId}/${post.imgUrl}"--%>
<%--                     alt="User Profile Image"--%>
<%--                     style="width: 100%; height: 100%; border-radius: 50%"--%>
<%--                     onerror="this.src='${pageContext.request.contextPath}/images/Users/user.png'" />--%>
                <img src="${pageContext.request.contextPath}/GetUserImageServlet?userId=${post.userId}"
                     alt="User Profile Image"
                     style="width: 100%; height: 100%; border-radius: 50%"
                     onerror="this.src='${pageContext.request.contextPath}/images/Users/user.png'" />
              </div>
              <div class="post-details f-col">
                <div class="name capitalize">${post.name}</div>
                <div class="posted-date formatDate f-row">
                  <span class="date">${post.datetime}</span>
                </div>
              </div>
            </div>
            <div class="text-content hashtags">
                ${post.content}
            </div>
            <c:choose>
              <c:when test="${not empty post.images}">
                <div class="post-images">
                  <c:forEach var="img" items="${fn:split(post.images, ',')}">
                    <div class="img"
                         style="width: 300px; height: 250px; background-size: cover; background-position: center;
                                 border-radius: 10px; background-image: url('${pageContext.request.contextPath}/${img}')">
                    </div>
                  </c:forEach>
                </div>
              </c:when>
            </c:choose>

          </div>
          <div class="footer f-row">
            <div class="post-reactions f-row">
              <button class="like-btn">
                <i class="fa-regular fa-thumbs-up"></i>
              </button>
              <button class="comment-btn">
                <i class="fa-regular fa-comment"></i>
              </button>
              <button class="share-btn">
                <i class="fa-regular fa-share"></i>
              </button>
            </div>
<%--            <div class="react-amount f-row">--%>
<%--              234 reacts--%>
<%--              <span class="dot"></span>--%>
<%--              96 comments--%>
<%--            </div>--%>
          </div>
        </div>


      </c:forEach>
    </div>
  </div>


</div>
</body>
<script src="hashtag.js"></script>
<script src="formatDate.js"></script>
<script>
  const commentSection = document.querySelector('.comment-section');
  const commentBtns = document.querySelectorAll('.comment-btn');
  const commentCloseBtn = commentSection.querySelector('.cls-btn');

  commentBtns.forEach(commentBtn => {
    commentBtn.addEventListener("click", () => {
      commentSection.classList.add('popup-active');
    })
  })
  commentCloseBtn.addEventListener("click", () => {
    commentSection.classList.remove('popup-active');
  })

  document.addEventListener("DOMContentLoaded", processHashtags);

</script>
<script>
  function validateAndSubmitComment(button) {
    // Find the closest form
    const form = button.closest('form');

    // Find the comment input/textarea - adjust the selector based on your actual input field
    const commentInput = form.querySelector('textarea[name="commentText"]') ||
            form.querySelector('input[name="commentText"]');

    // Check if comment is empty
    if (!commentInput || commentInput.value.trim() === '') {

      commentInput.focus(); // Focus on the input field
      return false; // Prevent form submission
    }

    // If validation passes, submit the form
    form.submit();
  }

  // Function to handle the redirect when the logout button is clicked
  function logoutRedirect() {
    // Check if the checkbox is checked (logout button clicked)
    if (document.getElementById('logoutBtn').checked) {
      window.location.href = 'http://localhost:8080/Parlimate/';
    }
  }

  // Get the value of the hidden postId input
  function openCommentPopup(content, datetime, postId) {
    document.getElementById("popup-content").innerText = content;
    document.getElementById("popup-time").innerText = datetime;
    document.getElementById("postId").value = postId;  // this was missing or wrong
    document.querySelector(".comment-popup").style.display = "block";
  }

  function closeCommentPopup() {
    // Close the comment popup and remove the 'cmnt-visible' class
    document.querySelector(".comment-popup").style.display = "none";
    document.body.classList.remove("cmnt-visible");
  }

  document.addEventListener("DOMContentLoaded", function () {
    const popupOverlay = document.querySelector(".comment-popup");
    const popupContainer = document.querySelector(".comment-container");

    // Close popup when clicked outside of the container
    popupOverlay.addEventListener("click", function (e) {
      if (!popupContainer.contains(e.target)) {
        closeCommentPopup();
      }
    });
  });

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      closeCommentPopup();
    }
  });


  //     show selected images in new post
  document.getElementById('post-photo').addEventListener('change', function (e) {
    const fileNamesDiv = document.getElementById('file-preview');
    fileNamesDiv.innerHTML = '';

    if (this.files.length > 0) {
      const fileList = document.createElement('ul');
      fileList.style.listStyle = 'none';
      fileList.style.padding = '0';

      Array.from(this.files).forEach(file => {
        const listItem = document.createElement('li');
        listItem.textContent = file.name;
        fileList.appendChild(listItem);
      });

      fileNamesDiv.appendChild(fileList);
    }

    const previewDiv = document.getElementById('image-preview');
    previewDiv.innerHTML = '';

    if (this.files.length > 0) {
      Array.from(this.files).forEach(file => {
        if (file.type.startsWith('image/')) {
          const reader = new FileReader();
          reader.onload = function (e) {
            const img = document.createElement('img');
            img.src = e.target.result;
            previewDiv.appendChild(img);
          };
          reader.readAsDataURL(file);
        }
      });
    }
  });



</script>
<script src="script.js"></script>
<script src="home.js"></script>
<script src="fund-pop.js"></script>

</html>