<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home | Parlimate</title>
        <link rel="stylesheet" href="index/sidebar1.css" />
        <link rel="stylesheet" href="header.css" />
        <link rel="stylesheet" href="container.css" />
        <link rel="stylesheet" href="popup.css" />
        <link rel="stylesheet" href="comment.css" />
        <link rel="stylesheet" href="index.css" />
        <link rel="stylesheet" href="edit.css" />

        <!-- icons -->
        <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
              href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css" />

        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css" />
    </head>

    <body class="">

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
                        <div class="user-name">Naleeka Kumarasinghe</div>
                    </div>
                    <div class="switch-btn capitalize">
                        <a href="#">switch account
                            <i class="fa-regular fa-chevron-down"></i></a>
                    </div>
                </div>
                <div class="discussion-title col">
                    <div class="title capitalize">title</div>
                    <input autocomplete="off" type="text" name="add-post-title" id="add-post-title"
                           placeholder="Enter the title of the discussion" />
                </div>
                <div class="caption-box col content-pd">
                    <div class="title capitalize">caption</div>
                    <textarea autocomplete="off" name="add-post-caption" id="add-post-caption"
                              placeholder="Enter the caption of the discussion"></textarea>
                </div>

                <div class="tags-box col content-pd">
                    <div class="title capitalize">tags</div>
                    <input type="text" name="hashtags" id="addost-hashtags" />
                    <div class="recomended-tags">
                        Try :
                        <span>
                                <input type="checkbox" name="hashtags" id="hashtag-1" />
                                <label for="hashtag-1">GoHomeGota</label>
                            </span>
                        <span>
                                <input type="checkbox" name="hashtags" id="hashtag-2" />
                                <label for="hashtag-2">PresidentialElection2024</label>
                            </span>
                        <span>
                                <input type="checkbox" name="hashtags" id="hashtag-3" />
                                <label for="hashtag-3">PoliticalNews</label>
                            </span>
                    </div>
                </div>
                <div class="popbtns capitalize">
                    <div class="clear-btn" id="popup-clear-btn">
                        Clear
                        <i class="fa-sharp fa-solid fa-rotate-left"></i>
                    </div>
                    <div class="post-btn" id="popup-post-btn">
                        post discussion
                        <i class="fa-duotone fa-solid fa-check"></i>
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
            <input type="checkbox" name="logoutBtn" id="logoutBtn" />
            <label for="logoutBtn">
                <i class="fa-solid fa-sign-out"></i>
                <span>logout</span>
            </label>
        </div>
    </div>
</div>
<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="./index.html">
                PARLIMATE
            </a>
        </div>
    </div>
    <div class="headerSearchBar row">
        <input type="search" name="mainSearch" id="headerSearchBar"
               placeholder="Search politicians, Political parties...." />
        <label for="headerSearchBar">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
    </div>
    <div class="headerBtns">
        <div class="headerBtn">
            <input type="checkbox" name="notifi" id="notificationBtn" />
            <label for="notificationBtn" class="btn">
                <i class="fa-solid fa-bell"></i>
            </label>
            <span class="tip">notifications</span>
            <div class="dropDownMenu">
                <ul>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
										consectetur adipisicing elit. Qui,
										ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
										consectetur adipisicing elit. Qui,
										ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="notification">
                            <div class="noti-img"></div>
                            <div class="noti-title">
                                <div class="notification-from">
                                    Ranil wickramasinghe
                                </div>
                                <span>Lorem, ipsum dolor sit amet
										consectetur adipisicing elit. Qui,
										ullam. Quos aperiam in re</span>
                            </div>
                        </a>
                    </li>
                </ul>
                <a href="./Announcements/announcements.html" class="bottom-btn small-text capitalize">
                    see all notifications
                </a>
            </div>
        </div>
        <div class="headerBtn">
            <input type="checkbox" name="profile" id="profileBtn" />
            <label for="profileBtn" class="btn">
                <i class="fa-solid fa-user"></i>
            </label>
            <span class="tip">profile</span>
            <div class="dropDownMenu">
                <div class="profile">
                    <a href="./Profile/profile.jsp">
                        <div class="img"></div>
                        <div class="details">
                            <div class="name medium-text bold">
                                Naleeka Kumarasinghe
                            </div>
                            <div class="email small-text">
                                knaleeka845@gmail.com
                            </div>
                        </div>
                    </a>
                </div>
                <ul class="capitalize">
                    <li>
                        <a href="#">
								<span>
									<i class="fa-regular fa-gear"></i>
								</span>
                            <span> account settings </span>
                        </a>
                    </li>
                    <div class="sep-line"></div>
                    <li>
                        <a href="#">
								<span>
									<i class="fa-regular fa-circle-question"></i>
								</span>
                            <span> help center </span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
								<span>
									<i class="fa-regular fa-star"></i>
								</span>
                            <span> upgrade plan </span>
                        </a>
                    </li>
                    <div class="sep-line"></div>

                    <li>
                        <div class="logoutBtn capitalize">
                            <div class="cont">
                                <input type="checkbox" name="logoutBtn" id="logoutBtn" />
                                <label for="logoutBtn">
                                    <i class="fa-solid fa-sign-out"></i>
                                    <span>logout</span>
                                </label>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
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
                        Hello <span class="userName">Naleeka</span>
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

</html>