<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
  if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
    response.sendRedirect("index.jsp");
    return;
  }%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Home | Parlimate</title>
  <link rel="stylesheet" href="index/sidebar1.css" />
  <link rel="stylesheet" href="index/header/header.css" />
  <link rel="stylesheet" href="container.css" />
  <link rel="stylesheet" href="popup.css" />
  <link rel="stylesheet" href="comment.css" />
  <link rel="stylesheet" href="index.css" />
  <link rel="stylesheet" href="edit.css" />
  <link rel="stylesheet" href="fund-popup.css"/>.

  <!-- icons -->
  <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
        href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d" />

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css" />

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css" />

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css" />

  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css" />
  <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css" />

  <style>
    .logo-img{
      height: 1.3rem;
      margin-bottom: -0.25rem;
    }
    .container{
      margin-top: 2.5rem;
    }
  </style>
</head>

<body class="">

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
        <input type="text" required placeholder="Fundraise for the senior care house" name="title" id="fundtitle">
      </div>
      <input type="hidden" name="userid" id="useri" value="${user.userId}" />
      <input type="hidden" name="username" id="usernam" value="${userProfile.name}" />
      <div class="fund-decs field">
        <label for="fund-desc" class="title">Description</label>
        <textarea required name="description" placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..." id="fund-desc"></textarea>
      </div>
      <div class="fund-contact" style="margin-bottom: 20px; font-family: Arial, sans-serif;">
        <label class="title" style="display: block; font-weight: bold; margin-bottom: 8px; font-size: 14px; color: #333;">
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
              <input required type="number" name="targetamount"  id="fund-amount" min="1" placeholder="1,000,000.00">
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
            <input type="file" name="photos" id="fund-photo" multiple >
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
<div class="popup-modal">
  <div class="popup">
    <div class="title">
      New Post
      <div class="close-btn btn" id="popup-close-btn">
        <i class="fa-solid fa-times"></i>
      </div>
      <div class="breakLine"></div>
    </div>
    <div class="content">
      <div class="account row">
        <div class="user-profile">
          <div class="prof-img"></div>
          <div class="user-name">${userProfile.name}</div>
        </div>
        <div class="switch-btn capitalize">
          <a href="#">switch account
            <i class="fa-regular fa-chevron-down"></i></a>
        </div>
      </div>
      <form method="POST" action="PublishNewPostServlet" enctype="multipart/form-data">

        <div class="caption-box col content-pd">
          <div class="title capitalize" >caption</div>
          <input type="hidden" name="userid" id="userid" value="${user.userId}" />
          <input type="hidden" name="username" id="username" value="${userProfile.name}" />

          <textarea autocomplete="off" name="content"  id="post-desc" placeholder="Enter the caption of the discussion"></textarea>
        </div>
        <div class="popbtns capitalize">
          <div class="clear-btn" id="popup-clear-btn">
            Clear
            <i class="fa-sharp fa-solid fa-rotate-left"></i>
          </div>

          <div class="fund-photo field">
            <span for="" class="title">Upload Photos</span>
            <div class="att-container-photo">
              <div class="action row-photo">
                <label for="fund-photo" class="photo-btn">Select Photo</label>
                <input type="file" name="images" id="fund-photo"  >
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

        <!-- Use a div or any other element with a click event to trigger form submission -->
        <div class="post-btn" id="popup-post-btn" onclick="this.closest('form').submit();">
          post discussion
        </div>
        <i class="fa-duotone fa-solid fa-check"></i>
      </form>
    </div>
  </div>
</div>
</div>
</div>
</div>


</div>
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
          <input type="checkbox" name="post-menu" id="postMenu" class="menuBtn" />
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
    <input type="checkbox" name="logoutBtn" id="logoutBtn" onclick="logoutRedirect()" />
    <label for="logoutBtn">
      <i class="fa-solid fa-sign-out"></i>
      <span>logout</span>
    </label>
  </div>
</div>


</div>

<%@ include file="./index/header/header.jsp" %>
<div class="container">
  <div class="pageTitles">
    <h2 class="title">Home</h2>
    <div class="subTitle">Political activities and Discussions</div>
  </div>
  <div class="topContent">
    <div class="social-btns col">
      <div class="addPost-btn">
        <div class="prof-img"></div>
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
    <div class="weeklySurvey post votelist reactable">
      <div class="post-head small-title">
        <div class="post-title">
          weekly survey
          <span class="btn round"><i class="fa-solid fa-info"></i></span>
        </div>
        <div class="survTime">
          survey ends in :
          <span class="time">
							<span class="sur-end-day">5</span> days
							<span class="sur-end-hour">12</span> hours
						</span>
        </div>
      </div>
      <div class="survey-title">
        Who will be the next president of Sri Lanka?
      </div>
      <div class="surveyContent capitalize">
					<span>
						<input type="radio" name="week-survey" id="survey-1" />
						<label for="survey-1">mahinda rajapakse</label>
					</span>
        <span>
						<input type="radio" name="week-survey" id="survey-2" />
						<label for="survey-2">ranil wickramasinghe</label>
					</span>
        <span>
						<input type="radio" name="week-survey" id="survey-3" />
						<label for="survey-3">anura kumara dissanayake</label>
					</span>
        <span>
						<input type="radio" name="week-survey" id="survey-4" />
						<label for="survey-4">sajith wickramasinghe</label>
					</span>
      </div>
      <div class="reactions">
        <button class="btn" id="vote-btn">
          submit my vote
        </button>
      </div>
    </div>
    <div class="last-surveys">
      <div class="post-head medium-title">
        Last surevy results
      </div>
      <div class="content">
        fill this content with the last survey results
      </div>
      <a href="#" class="past-surv-link small-text">See past surevys</a>
    </div>
  </div>




  <ul class="post-list" style="list-style-type: none; padding: 0; margin-right: 20px; display: flex; flex-direction: column; gap: 1.5rem;">
    <c:forEach var="post" items="${allposts}">

      <!-- Post Details -->
      <div class="post reactable reacted">
        <div class="top" style="display: flex; justify-content: space-between; align-items: center;">
          <div class="post-details" style="display: flex; align-items: center;">
            <a href="#" class="img" style="width: 40px; height: 40px; background: #ccc; border-radius: 50%; display: inline-block; margin-right: 10px;"></a>
            <div class="details">
              <a href="#" class="name" style="font-weight: bold; text-decoration: none; color: #333;">${post.name}</a>
              <div class="posted-date" style="font-size: 12px; color: #888;">
                <i class="fa-light fa-clock"></i>
                <span class="value">${post.datetime}</span>
              </div>
            </div>
          </div>
          <div>

            <div class="content" style="padding-top: 20px; padding-left: 20px; font-size: 14px; color: #333;">
                ${post.content}
            </div>
            <span class="tip" style="font-size: 12px; color: #aaa;">options</span>
            <label for="postMenu${post.postId}" class="btn-2" style="cursor: pointer;">
              <i class="fa-regular fa-ellipsis-vertical"></i>
            </label>
            <div class="post-dropDownMenu" style="display: none;">
              <ul style="margin: 0; padding: 0; list-style: none;">
                <li><a href="#">report</a></li>
                <li><a href="#">copy link</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 10px;">
          <c:forEach var="img" items="${fn:split(post.images, ',')}">
            <div class="img"
                 style="width: 300px; height: 250px; background-size: cover; background-position: center;
                         border-radius: 10px; background-image: url('${pageContext.request.contextPath}/${img}')">
            </div>
          </c:forEach>
        </div>

        <!-- Post Content -->





        <!-- Reactions -->
        <div class="reactions" style="margin-top: 15px; display: flex; gap: 10px;">
          <button class="like btn" style="background: #eee; padding: 6px 10px; border-radius: 6px; cursor: pointer;">
            <span class="reactIcon"><i class="fa-solid fa-thumbs-up"></i></span> like
            <span class="count" style="margin-left: 5px;">32k</span>
          </button>


          <!-- Make sure the postId is printed out -->


          <form method="POST" action="PublishCommentServlet" >
            <div class="caption-box col content-pd">

              <input type="hidden" name="userid" id="userid" value="${user.userId}" />  <!-- User ID -->
              <input type="hidden" name="postId" value="${post.postId}" />
              <input type="hidden" name="username" id="username" value="${userProfile.name}" />

              <br>
              <br>

              <textarea autocomplete="off"  name="content" required id="post-desc1" placeholder="Enter the caption of the discussion"></textarea>  <!-- Comment content -->
              <br>
            </div>
            <div class="popbtns capitalize">

              <br>
              <!-- Submit Button -->
              <button>
                <div class="post-btn" id="popup-post-btnn"
                     onclick="validateAndSubmitComment(this);"
                     style="background-color: black; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; border-radius: 5px; transition: background-color 0.3s ease;"
                     onmouseover="this.style.backgroundColor='#d3d3d3'; this.style.color='black';"
                     onmouseout="this.style.backgroundColor='black'; this.style.color='white';">
                  Publish Comment
                </div>

              </button>

            </div>
          </form>

          <!-- View Comments Link -->
          <a href="GetAllCommentServlet?postId=${post.postId}" class="btn view-comment"
             style="text-decoration: none; padding: 6px 14px; background-color: black; color: white; border-radius: 6px; display: inline-block; transition: background-color 0.3s ease;"
             onmouseover="this.style.backgroundColor='#d3d3d3'; this.style.color='black';"
             onmouseout="this.style.backgroundColor='black'; this.style.color='white';">
            <i class="fa-solid fa-comments"></i> View Comments
          </a>


          <button class="share btn" style="background: #eee; padding: 6px 10px; border-radius: 6px; cursor: pointer;">
            <span class="reactIcon"><i class="fa-duotone fa-solid fa-share-all"></i></span> share
          </button>
        </div>
      </div>

      </li>

    </c:forEach>
  </ul>

</div>
</body>
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
</script>
<script src="script.js"></script>
<script src="home.js"></script>
<script src="home.js"></script>
<script src="fund-pop.js"></script>

</html>