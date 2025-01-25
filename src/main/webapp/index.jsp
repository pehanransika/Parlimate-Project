<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
<<<<<<< HEAD
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Parlimate</title>
    <link rel="stylesheet" href="welcome.css"/>
</head>
<body class="">
<div class="bg">
    <img src="./BG line.png" alt="background"/>
</div>
<div class="bg-hand">
    <img src="./view-3d-hand 1.png"/>
=======

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
    </head>

    <body class="">
    <form action="CreateRequestServlet" method="post" class="popup-f" enctype="multipart/form-data">
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
                                <input required type="number" name="targetamount" id="fund-amount" placeholder="1,000,000.00">
                            </div>
                        </div>
                    </div>
                </div>
                <label for="datetime">Date and Time:</label>
                <input type="datetime-local" id="datetime" name="datetime" required>

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
            <form method="POST" action="PublishPostServlet">
                <label for="content">Content:</label>
                <textarea id="content" name="content"></textarea>
                <button type="submit">Publish</button>
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
            <div class="add-cmnt row">
                <div class="curr-user row">
                    <div class="prof-img"></div>
                    <div class="button-container">

                        <form action="PublishNewCommentServlet" method="POST">
                            <textarea name="content" id="add-cmnt" placeholder="Comment here" required></textarea>
                            <button type="submit" class="post-btn row btn capitalize">
                                Post
                                <i class="fa-sharp fa-regular fa-paper-plane-top"></i>
                            </button>
                        </form>
                        <!-- Button styled link, now it triggers the ViewCommentServlet -->
                        <a href="ViewCommentListServlet" class="see-comments-button">
                            <button class="see-comments-button">
                                <i class="fa-solid fa-comment"></i>
                                <span>See Comments</span>
                            </button>
                        </a>
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
        </div>
    </div>
</div>
    </div>
        </div>
    </div>
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
</div>
<div class="container col">
    <div class="header row">
        <div class="logo">
            <img src="logo 2.png" alt="Parlimate"/>
        </div>
        <div class="navs">
            <ul class="row">
                <li><a href="#" class="nav">Rules & Regulations</a></li>
                <li><a href="#" class="nav">About us</a></li>
                <li><a href="#" class="nav">FAQ</a></li>
            </ul>
        </div>
        <div class="header-btns row">
            <div class="btn primary">Login</div>
            <div class="btn secondary">Register</div>
        </div>
    </div>
    <div class="hero col">
        <h1 class="title">Welcome to <span> Parlimate </span></h1>
        <p>
            A place where citizens and politicians come together to
            communicate, share ideas, and shape a better future for
            country.
        </p>
        <div class="cta row">
            <div class="primary btn">Create account</div>
            <a class="secondary btn row" href="./Home.jsp">
                Sneak View
                <img src="./lucide_move-right.svg" alt=""/>
            </a>
        </div>
    </div>
</div>
<div class="bg-popup"></div>
<div class="popup login-on col">
    <form action="LoginServlet" method="post">
        <div class="login-cont col">
            <div class="btn close-btn">
                <svg
                        width="16"
                        height="16"
                        viewBox="0 0 16 16"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                >
                    <path
                            d="M1.90039 2.00043L13.9004 14.0004"
                            stroke="#1E1E1E"
                            stroke-width="3"
                            stroke-linecap="round"
                    />
                    <path
                            d="M13.9004 2.00043L1.90039 14.0004"
                            stroke="#1E1E1E"
                            stroke-width="3"
                            stroke-linecap="round"
                    />
                </svg>
            </div>
            <div class="head col">
                <h2 class="title">Welcome to Parlimate</h2>
                <p>Please sign in or signup below</p>
            </div>
            <div class="content col">
                <!-- <button class="google-login btn row">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    x="0px"
                    y="0px"
                    width="100"
                    height="100"
                    viewBox="0 0 48 48"
                >
                    <path
                        fill="#FFC107"
                        d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"
                    ></path>
                    <path
                        fill="#FF3D00"
                        d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"
                    ></path>
                    <path
                        fill="#4CAF50"
                        d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"
                    ></path>
                    <path
                        fill="#1976D2"
                        d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"
                    ></path>
                </svg>
                Sign in with Google
            </button> -->
                <div class="email-section col">
                    <div class="input-fields col">
                        <input
                                type="email"
                                name="email"
                                id="login-email"
                                placeholder="Email address"
                                required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}"
                        />
                        <div class="pswrd">
                            <input
                                    type="password"
                                    name="password"
                                    id="login-pswd"
                                    placeholder="Password"
                            />
                            <i
                                    class="fa-solid fa-eye"
                                    id="toggle-password"
                            ></i>
                        </div>
                    </div>
                    <div class="ops row">
                        <div class="remember row">
                            <input
                                    type="checkbox"
                                    name="remember-device"
                                    id="remember-device"
                            />
                            <label for="remember-device"
                            >Remember me on this device</label
                            >
                        </div>
                        <a href="forgotPassword.jsp">Forgot password?</a>
                    </div>
                    <button class="btn login-btn">Login</button>
                    <div class="signup-section col">
                        <div class="divider"></div>
                        <span>
									Not a member?
									<button type="button" id="signup-btn">Signup now</button>
								</span>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <form action="UserInsertServlet" method="post" onsubmit="return validateForm()">
        <div class="signup-cont col">
            <div class="login-container col">
                <div class="btn close-btn">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.90039 2.00043L13.9004 14.0004" stroke="#1E1E1E" stroke-width="3" stroke-linecap="round" />
                        <path d="M13.9004 2.00043L1.90039 14.0004" stroke="#1E1E1E" stroke-width="3" stroke-linecap="round" />
                    </svg>
                </div>

                <div class="head col">
                    <h2 class="title">Welcome to Parlimate</h2>
                    <p>Create your parlimate account</p>
                </div>
                <div class="content col">

                    <input type="radio" name="userType" id="userType-select-cit" value="Citizen" checked hidden />
                    <input type="radio" name="userType" id="userType-select-pol" value="Politician" hidden />
                    <input type="radio" name="userType" id="userType-select-part" value="Political Party" hidden />

                    <div class="signup-slider row">
                        <label id="citizen-set" class="active tab" data-target="citizen" for="userType-select-cit">citizen</label>
                        <label id="politician-set" class="tab" data-target="politician" for="userType-select-pol">politician</label>
                        <label class="tab" id="politicalParty-set" data-target="politicalParty" for="userType-select-part">political party</label>
                        <span class="slider"></span>
                    </div>

                    <div class="signup-content col">
                        <div class="row-fields general-user row">
                            <input type="text" class="inp-field" placeholder="Full name" name="name" required pattern="^[A-Za-z]+([ ]?[A-Za-z]+)*$" title="Please Check the Name" />
                        </div>
                        <input type="email" name="email" id="singup-email" class="inp-field general-user" placeholder="Email address" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}" />
                        <div class="general-user row-fields row">
                            <div class="pswrd">
                                <input
                                        type="password"
                                        class="inp-field"
                                        placeholder="Password"
                                        id="password"
                                        name="Password"
                                        required
                                        minlength="6"
                                        pattern="^(?=.[A-Z])(?=.[!@#$%^&*()_+={}\[\]:;,.<>?/-]).{6,}$"
                                />

                                <i class="fa-solid fa-eye toggle-password" data-target="password"></i>
                            </div>
                            <div class="tel">
                                <input type="tel" class="general-user inp-field" placeholder="Contact number" name="phoneNumber" id="telNumber-signup" minlength="10" maxlength="10" required pattern="^0\d*$" />
                            </div>
                        </div>
<<<<<<< HEAD
                        <input type="text" name="address" id="singup-address" class="inp-field general-user" placeholder="Address" required />
                        <select name="district" class="general-user" id="district" required>
                            <option value="invalid" disabled="disabled" selected>District</option>
                            <option value="colombo">Colombo</option>
                            <option value="gampaha">Gampaha</option>
                            <option value="kalutara">Kalutara</option>
                            <option value="kandy">Kandy</option>
                            <option value="matale">Matale</option>
                            <option value="nuwaraeliya">Nuwara Eliya</option>
                            <option value="ratnapura">Ratnapura</option>
                            <option value="kegalle">Kegalle</option>
                            <option value="anuradhapura">Anuradhapura</option>
                            <option value="polonnaruwa">Polonnaruwa</option>
                            <option value="badulla">Badulla</option>
                            <option value="moneragala">Moneragala</option>
                            <option value="matara">Matara</option>
                            <option value="hambantota">Hambantota</option>
                            <option value="galle">Galle</option>
                            <option value="kurunegala">Kurunegala</option>
                            <option value="puttalam">Puttalam</option>
                            <option value="jaffna">Jaffna</option>
                            <option value="mannar">Mannar</option>
                            <option value="vavuniya">Vavuniya</option>
                            <option value="mulaitivu">Mulaitivu</option>
                            <option value="kilinochchi">Kilinochchi</option>
                            <option value="trincomalee">Trincomalee</option>
                            <option value="batticaloa">Batticaloa</option>
                            <option value="ampara">Ampara</option>
                        </select>


                        <!-- Validation for Politician and Party -->
                        <div class="nic-field row-fields general-user politician-inputs">
                            <label for="nic-front">
                                <input type="file" class="image-upload-inp" name="img_url" id="nic-front" hidden accept="image/png, image/jpg, image/jpeg" />
                                <div class="img-view row">
                                    <i class="fa-duotone fa-solid fa-cloud-arrow-up" style="--fa-secondary-color: #a2aec3;"></i>
                                    <span id="nic-front-label">NIC front</span>
                                </div>
                            </label>
                            <label for="nic-back">
                                <input type="file" class="image-upload-inp" name="nic-back" id="nic-back" accept="image/png, image/jpg, image/jpeg" hidden />
                                <div class="img-view row">
                                    <i class="fa-duotone fa-solid fa-cloud-arrow-up" style="--fa-secondary-color: #a2aec3;"></i>
                                    <span id="nic-back-label">NIC back</span>
                                </div>
                            </label>
                        </div>

                        <!-- Political Party Info -->
                        <input type="text" class="inp-field polParty" placeholder="Party Name" id="partyName-signup" name="name" pattern="^[A-Za-z ]+$" />
                        <input type="text" class="inp-field polParty" placeholder="Party Leader's Name" id="partyLeaderName-signup" pattern="^[A-Za-z ]+$" />
                        <div class="row-fields row">
                            <input type="text" class="inp-field polParty" name="phoneNumber" placeholder="Contact number" id="partyLeader-signup" />
                            <input type="number" class="inp-field polParty" name="noOfMembers" placeholder="Number of members" id="no_of_members" min="1" />
                        </div>
                        <input type="text" class="inp-field polParty" name="address" placeholder="Address" id="addressn" />
                        <div class="party-imgs col row-fields">
                            <label for="party-logo">
                                <input type="file" class="image-upload-inp" accept="image/png, image/jpg, image/jpeg" name="logoImg" id="party-logo" hidden />
                                <div class="img-view row polParty" id="party-logo-bg">
                                    <i class="fa-duotone fa-solid fa-cloud-arrow-up" style="--fa-secondary-color: #a2aec3;"></i>
                                    <span id="party-logo-name polParty">Party Logo</span>
                                </div>
                            </label>
=======
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
    <a href="/Parlimate/GetPostListServlet?postId=${post.postId}">
        <button class="view-list-post">
            <i class="fa-solid fa-eye"></i>
            <span>View  Post</span>
        </button>
    </a>
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
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
                        </div>
                    </div>

                    <div class="remember row">
                        <input type="checkbox" name="agreement-signup" id="agreement-signup" required />
                        <label for="agreement-signup">I hereby agree to the policies of Parlimate</label>
                    </div>
                    <button class="btn login-btn" id="signup-submit-btn">Create account</button>
                    <div class="signup-section col">
                        <div class="divider"></div>
                        <span>Already have an account?
                        <button id="login-link" type="button">Login</button>
                    </span>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<<<<<<< HEAD
<script>
    function validateForm() {
        // Get the form inputs
        const email = document.getElementById("singup-email");
        const password = document.getElementById("password");
        const phoneNumber = document.getElementById("telNumber-signup");

        // Define the email pattern
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        // Check if fields are filled out
        if (!email.value || !password.value || !phoneNumber.value) {
            alert("Please fill out all required fields.");
            return false;
        }

        // Check if the email matches the pattern
        if (!emailPattern.test(email.value)) {
            alert("Please enter a valid email address.");
            return false;
        }

        return true; // If all checks pass, return true to submit the form
    }
</script>
<ul class="items row">
    <li class="item row">
        <svg
                width="32"
                height="32"
                viewBox="0 0 32 32"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
        >
            <path
                    d="M4 14.6667V17.3333C4 23.96 9.37333 29.3333 16 29.3333C22.6267 29.3333 28 23.96 28 17.3333V14.6667M12.1467 9.97333C14.52 9.10667 17.1067 9.10667 19.48 9.97333M13.3733 13.9733C14.9733 13.5333 16.6667 13.5333 18.2667 13.9733M16 25.3333C20.4133 25.3333 24 21.7467 24 17.3333V10.6667C24 6.25333 20.4133 2.66667 16 2.66667C11.5867 2.66667 8 6.25333 8 10.6667V17.3333C8 21.7467 11.5867 25.3333 16 25.3333Z"
                    stroke="#3A3A3A"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
            />
        </svg>
        open dialogue
    </li>
    <li class="item row">
        <svg
                width="32"
                height="32"
                viewBox="0 0 32 32"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
        >
            <path
                    d="M11.5628 19.1065C11.5628 20.8265 12.8828 22.2131 14.5228 22.2131H17.8695C19.2962 22.2131 20.4562 20.9998 20.4562 19.5065C20.4562 17.8798 19.7495 17.3065 18.6962 16.9331L13.3228 15.0665C12.2695 14.6931 11.5628 14.1198 11.5628 12.4931C11.5628 10.9998 12.7228 9.78646 14.1495 9.78646H17.4962C19.1362 9.78646 20.4562 11.1731 20.4562 12.8931M16.0003 8V24M20.0003 29.3333H12.0003C5.33366 29.3333 2.66699 26.6667 2.66699 20V12C2.66699 5.33333 5.33366 2.66667 12.0003 2.66667H20.0003C26.667 2.66667 29.3337 5.33333 29.3337 12V20C29.3337 26.6667 26.667 29.3333 20.0003 29.3333Z"
                    stroke="#3A3A3A"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
            />
        </svg>
        Fundraise for Change
    </li>
    <li class="item row">
        <svg
                width="34"
                height="32"
                viewBox="0 0 34 32"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
        >
            <path
                    d="M12.0837 24.06C12.0223 22.552 11.025 21.1347 9.67967 19.82C8.25742 18.4311 7.2814 16.6498 6.87624 14.7036C6.47108 12.7574 6.65517 10.7347 7.405 8.89357C8.15484 7.05249 9.43639 5.47668 11.086 4.36735C12.7356 3.25802 14.6784 2.66553 16.6663 2.66553C18.6543 2.66553 20.5971 3.25802 22.2467 4.36735C23.8963 5.47668 25.1778 7.05249 25.9277 8.89357C26.6775 10.7347 26.8616 12.7574 26.4564 14.7036C26.0513 16.6498 25.0753 18.4311 23.653 19.82C22.265 21.176 21.2463 22.6427 21.2463 24.2067V26.3333C21.2463 27.129 20.9303 27.892 20.3677 28.4547C19.8051 29.0173 19.042 29.3333 18.2463 29.3333H15.0823C14.2867 29.3333 13.5236 29.0173 12.961 28.4547C12.3984 27.892 12.0823 27.129 12.0823 26.3333L12.0837 24.06ZM8.66634 12.6667C8.66478 13.7335 8.87734 14.7898 9.29142 15.773C9.7055 16.7563 10.3127 17.6464 11.077 18.3907C12.065 19.356 13.093 20.568 13.6543 22H19.6783C20.2397 20.568 21.2677 19.3547 22.2557 18.3907C23.1998 17.4687 23.9012 16.3275 24.2973 15.0688C24.6935 13.81 24.7721 12.4729 24.5262 11.1764C24.2803 9.87987 23.7175 8.66433 22.888 7.63807C22.0585 6.6118 20.9879 5.80668 19.7718 5.29443C18.5557 4.78218 17.2317 4.57872 15.9179 4.70218C14.6041 4.82563 13.3412 5.27217 12.2418 6.002C11.1424 6.73183 10.2406 7.72229 9.61675 8.88513C8.99291 10.048 8.66641 11.3471 8.66634 12.6667ZM14.0837 24.284V26.3333C14.0837 26.8853 14.5303 27.3333 15.0837 27.3333H18.2463C18.5116 27.3333 18.7659 27.228 18.9534 27.0404C19.141 26.8529 19.2463 26.5986 19.2463 26.3333V24H14.0823V24.0227C14.0845 24.1098 14.0858 24.1969 14.0837 24.284ZM2.33301 12.6667C2.33301 12.4015 2.43836 12.1471 2.6259 11.9596C2.81344 11.772 3.06779 11.6667 3.33301 11.6667H4.66634C4.93156 11.6667 5.18591 11.772 5.37345 11.9596C5.56098 12.1471 5.66634 12.4015 5.66634 12.6667C5.66634 12.9319 5.56098 13.1862 5.37345 13.3738C5.18591 13.5613 4.93156 13.6667 4.66634 13.6667H3.33301C3.06779 13.6667 2.81344 13.5613 2.6259 13.3738C2.43836 13.1862 2.33301 12.9319 2.33301 12.6667ZM5.61967 5.13333C5.50586 5.06767 5.38023 5.02507 5.24995 5.00796C5.11968 4.99085 4.98731 4.99957 4.8604 5.03362C4.7335 5.06767 4.61454 5.12638 4.51032 5.2064C4.4061 5.28642 4.31867 5.38619 4.25301 5.5C4.18735 5.61381 4.14475 5.73944 4.12764 5.86972C4.11053 6 4.11925 6.13237 4.1533 6.25927C4.22206 6.51557 4.38982 6.73406 4.61967 6.86667L5.77434 7.53333C6.00419 7.66594 6.27731 7.70181 6.53361 7.63305C6.78991 7.56428 7.0084 7.39652 7.14101 7.16667C7.27362 6.93681 7.30948 6.66369 7.24072 6.4074C7.17196 6.1511 7.00419 5.93261 6.77434 5.8L5.61967 5.13333ZM4.25301 19.8333C4.12067 19.6036 4.08496 19.3308 4.15371 19.0748C4.22247 18.8187 4.39007 18.6005 4.61967 18.468L5.77434 17.8013C6.00314 17.6795 6.27032 17.6513 6.51954 17.7226C6.76875 17.7939 6.98053 17.9592 7.11022 18.1837C7.23991 18.4081 7.27737 18.6742 7.21471 18.9257C7.15205 19.1772 6.99417 19.3946 6.77434 19.532L5.61967 20.1987C5.50596 20.2645 5.3804 20.3072 5.25016 20.3244C5.11992 20.3417 4.98756 20.3331 4.86064 20.2992C4.73373 20.2652 4.61474 20.2066 4.51048 20.1267C4.40622 20.0468 4.31873 19.9471 4.25301 19.8333ZM28.6663 11.6667C28.4011 11.6667 28.1468 11.772 27.9592 11.9596C27.7717 12.1471 27.6663 12.4015 27.6663 12.6667C27.6663 12.9319 27.7717 13.1862 27.9592 13.3738C28.1468 13.5613 28.4011 13.6667 28.6663 13.6667H29.9997C30.2649 13.6667 30.5192 13.5613 30.7068 13.3738C30.8943 13.1862 30.9997 12.9319 30.9997 12.6667C30.9997 12.4015 30.8943 12.1471 30.7068 11.9596C30.5192 11.772 30.2649 11.6667 29.9997 11.6667H28.6663ZM26.193 18.1667C26.2587 18.0529 26.3462 17.9532 26.4505 17.8733C26.5547 17.7934 26.6737 17.7348 26.8006 17.7008C26.9276 17.6669 27.0599 17.6583 27.1902 17.6756C27.3204 17.6928 27.446 17.7355 27.5597 17.8013L28.7143 18.468C28.8328 18.5311 28.9374 18.6174 29.0218 18.7218C29.1062 18.8261 29.1688 18.9464 29.2057 19.0755C29.2426 19.2045 29.2532 19.3397 29.2368 19.4729C29.2204 19.6062 29.1773 19.7347 29.1102 19.851C29.043 19.9672 28.9531 20.0687 28.8459 20.1495C28.7387 20.2302 28.6163 20.2885 28.486 20.321C28.3558 20.3534 28.2203 20.3593 28.0877 20.3383C27.9552 20.3173 27.8282 20.2698 27.7143 20.1987L26.5597 19.532C26.3301 19.3995 26.1625 19.1813 26.0937 18.9252C26.025 18.6692 26.0607 18.3964 26.193 18.1667ZM26.5597 5.8C26.3298 5.93261 26.1621 6.1511 26.0933 6.4074C26.0245 6.66369 26.0604 6.93681 26.193 7.16667C26.3256 7.39652 26.5441 7.56428 26.8004 7.63305C27.0567 7.70181 27.3298 7.66594 27.5597 7.53333L28.7143 6.86667C28.9442 6.73406 29.112 6.51557 29.1807 6.25927C29.2495 6.00297 29.2136 5.72986 29.081 5.5C28.9484 5.27015 28.7299 5.10238 28.4736 5.03362C28.2173 4.96486 27.9442 5.00073 27.7143 5.13333L26.5597 5.8Z"
                    fill="#3A3A3A"
            />
        </svg>
        Raise Awareness
    </li>
</ul>
<script src="./welcome.js">
</script>
</body>
</html>
=======

</body>
<script>
    function openPopup() {
        document.getElementById('comment-popup').style.display = 'block';
    }

    function closePopup() {
        document.getElementById('comment-popup').style.display = 'none';
    }
    document.querySelector('.see-comments-button').addEventListener('click', function (e) {
        e.preventDefault(); // Prevent link navigation if using `<a>` tags
        const commentPopup = document.getElementById('comment-popup'); // Ensure you have an ID for the popup
        if (commentPopup) {
            commentPopup.style.display = commentPopup.style.display === 'block' ? 'none' : 'block';
        }
    });

</script>
<script src="script.js"></script>
<script src="home.js"></script>
<script src="fund-pop.js"></script>

</html>
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
