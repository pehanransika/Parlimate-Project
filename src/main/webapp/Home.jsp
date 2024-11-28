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
    <input type="hidden" name="userid" id="useri" value="${user.userId}" />
    <input type="hidden" name="username" id="usernam" value="${userProfile.name}" />
    <div class="body col">
      <div class="fund-title field">
        <label for="fundtitle" class="title">Title</label>
        <input type="text" required placeholder="Fundraise for the senior care house" name="title" id="fundtitle">
      </div>
      <div class="fund-decs field">
        <label for="fund-desc" class="title">Description</label>
        <textarea required name="description" placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..." id="fund-desc"></textarea>
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
              <input required step="1000" type="number" name="targetamount" id="fund-amount" placeholder="1,000,000.00">
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
    </div>
    <div class="bottom row">
      <button class="cancel-btn form-btn">Cancel</button>
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
      <form method="POST" action="PublishPostServlet">
        <div class="caption-box col content-pd">
          <div class="title capitalize">caption</div>
          <input type="hidden" name="userid" id="userid" value="${user.userId}" />
          <input type="hidden" name="username" id="username" value="${userProfile.name}" />

          <textarea autocomplete="off" name="content" id="post-desc" placeholder="Enter the caption of the discussion"></textarea>
        </div>
        <div class="popbtns capitalize">
          <div class="clear-btn" id="popup-clear-btn">
            Clear
            <i class="fa-sharp fa-solid fa-rotate-left"></i>
          </div>

          <!-- Use a div or any other element with a click event to trigger form submission -->
          <div class="post-btn" id="popup-post-btn" onclick="this.closest('form').submit();">
            post discussion
          </div>
          <i class="fa-duotone fa-solid fa-check"></i>
        </div>
      </form>

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
                <span class="value">30</span>
                <span class="unit">minutes ago</span>
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
      <div class="content">
        Sri Lankan politics is the gift that keeps on giving—if
        by "gift" you mean a never-ending circus of
        incompetence, corruption, and sheer absurdity. As a
        university student, it's genuinely inspiring to watch
        our leaders navigate the complexities of mismanagement
        with such ease. I mean, who needs to study political
        science when you can just observe the daily antics of
        our elected officials? From budget proposals that defy
        logic to development projects that never see the light
        of day, it's a masterclass in how to turn a
        resource-rich nation into a hotbed of inefficiency. And
        let's not forget the high-octane drama of party
        defections, last-minute coalitions, and the occasional
        parliamentary brawl—because what's governance without a
        little theatrics? Honestly, if there was a degree in
        Political Satire, I'd be graduating with honors thanks
        to the endless content provided by our esteemed
        politicians.
        <div class="hashtags">
          <span>#PoliticalCircus</span>
          <span>#LearnFromTheWorst </span>
          <span>#IslandOfIrony </span>
          <span>#UniLife </span>
          <span>#SriLankaRealityShow </span>
        </div>
      </div>
      <div class="reactions">
        <button class="like btn">
						<span class="reactIcon">
							<i class="fa-solid fa-thumbs-up"></i>
						</span>
          <span>like</span>
          <span class="count"> 32k </span>
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
        <div class="button-container">
          <!-- Button styled link, now it triggers the ViewCommentServlet -->
          <a href="ViewCommentListServlet" class="see-comments-button">
            <button class="see-comments-button">
              <i class="fa-solid fa-comment"></i>
              <span>See Comments</span>
            </button>
          </a>
        </div>
      </div>


      <form action="PublishNewCommentServlet" method="POST">
        <textarea name="content" id="add-cmnt" placeholder="Comment here" required></textarea>
        <button type="submit" class="post-btn row btn capitalize">
          Post
          <i class="fa-sharp fa-regular fa-paper-plane-top"></i>
        </button>
      </form>
      <a href="ViewCommentServlet" class="see-my-comments-button">
        <button class="see-my-comments-button">
          <i class="fa-solid fa-comment"></i>
          <span>See my Comments</span>
        </button>
      </a>

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

<script>
  // Function to handle the redirect when the logout button is clicked
  function logoutRedirect() {
    // Check if the checkbox is checked (logout button clicked)
    if (document.getElementById('logoutBtn').checked) {
      window.location.href = 'http://localhost:8080/Parlimate/';
    }
  }
</script>

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
  <div class="post reactable reacted">
    <div class="top">
      <div class="post-details">
        <a href="#" class="img"></a>
        <div class="details">
          <a href="#" class="name">Himasha Chinthani</a>
          <div class="posted-date">
            <i class="fa-light fa-clock"></i>
            <div class="time">
              <span class="value">30</span>
              <span class="unit">minutes ago</span>
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
    <div class="content">
      Sri Lankan politics is the gift that keeps on giving—if by
      "gift" you mean a never-ending circus of incompetence,
      corruption, and sheer absurdity. As a university student,
      it's genuinely inspiring to watch our leaders navigate the
      complexities of mismanagement with such ease. I mean, who
      needs to study political science when you can just observe
      the daily antics of our elected officials? From budget
      proposals that defy logic to development projects that never
      see the light of day, it's a masterclass in how to turn a
      resource-rich nation into a hotbed of inefficiency. And
      let's not forget the high-octane drama of party defections,
      last-minute coalitions, and the occasional parliamentary
      brawl—because what's governance without a little theatrics?
      Honestly, if there was a degree in Political Satire, I'd be
      graduating with honors thanks to the endless content
      provided by our esteemed politicians.
      <div class="hashtags">
        <span>#PoliticalCircus</span>
        <span>#LearnFromTheWorst </span>
        <span>#IslandOfIrony </span>
        <span>#UniLife </span>
        <span>#SriLankaRealityShow </span>
      </div>
    </div>
    <div class="reactions">
      <button class="like btn">
					<span class="reactIcon">
						<i class="fa-solid fa-thumbs-up"></i>
					</span>
        <span>like</span>
        <span class="count"> 32k </span>
      </button>
      <button class="comment btn">
					<span class="reactIcon">
						<i class="fa-solid fa-message"></i>
					</span>
        <span>comment</span>
        <span class="count">1k</span>
      </button>
      <button class="share btn">
					<span class="reactIcon">
						<i class="fa-duotone fa-solid fa-share-all"></i>
					</span>
        <span>share</span>
      </button>
    </div>
  </div>
</div>
</body>
<script src="script.js"></script>
<script src="home.js"></script>
<script src="home.js"></script>
<script src="fund-pop.js"></script>

</html>