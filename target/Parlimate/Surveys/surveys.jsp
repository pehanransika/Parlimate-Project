<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SURVEYS | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./surveys.css" />
    <!-- <link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css""
/> -->

    <!-- icons -->
    <link
            rel="stylesheet"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
    />


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
        google.charts.setOnLoadCallback(drawStuff);

        function drawStuff() {
            var data = new google.visualization.arrayToDataTable([
                ['Province', 'Percentage'],
                ["Western ", 40],
                ["Central", 20],
                ["Southern", 10],
                ["Northern", 2],
                ["Eastern", 3],
                ["Uva",5],
                ["Sabaragamuwa",8],
                ["North Western",3],
                ["North Central",9]
            ]);

            var options = {

                width: 500,
                legend: { position: 'none' },
                chart: {},
                bars: 'horizontal', // Required for Material Bar Charts.
                axes: {
                    x: {
                        0: { side: 'top', label: 'Percentage'} // Top x-axis.
                    }
                },
                bar: { groupWidth: "90%" },
                colors: ['#D8BFD8']
            };

            var chart = new google.charts.Bar(document.getElementById('top_x_div'));
            chart.draw(data, options);
        };
    </script>
</head>
<body class="">

<%@ include file="../index/sidebar.jsp" %>

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
                    <a href="../Profile/profile.html">
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

<div class="container col">
    <div class="pageTitles">
        <h2 class="title">Surveys</h2>
        <div class="subTitle">
            Surveys conducted by Parlimate
        </div>
    </div>
    <div class="row">

        <div class="announcements col">
            <!-- this is the area where content are in  -->
            <div class="subTitle1">
                Ongoing Surveys
            </div>
            <div class="survey">
                <div style="display: flex; justify-content: space-between;margin-bottom: 4px;">
								<span style="text-align: left;font-size: medium;">&nbsp;&nbsp;<strong>
									Survey Name : Who will be the next president of Sri Lanka?
								</strong></span>
                    <span style="text-align: right;font-size: medium;"><strong>
									Survey Number : #01AAAA
								</strong>&nbsp;&nbsp;</span>
                </div>

                <div class="weeklySurvey post votelist reactable">
                    <div class="post-head small-title">
                        <div class="post-title">
                            weekly survey 1
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

                <div class="current-results" style="margin-bottom: 15px;">
                    <div class="weeklySurvey post votelist reactable results">
                        <div class="post-head small-title">
                            <div class="post-title">
                                weekly survey 1 - current results
                                <span class="btn round"><i class="fa-solid fa-info"></i></span>
                            </div>

                        </div>
                        <div class="survey-title">
                            Who will be the next president of Sri Lanka?
                        </div>
                        <div class="surveyContent capitalize">
                            <div id="candidate">
                                <span id="percentage"><strong>45%</strong></span>
                                <span id="name">Mahinda Rajapakse</span>
                            </div>

                            <div id="candidate">
                                <span id="percentage"><strong>30%</strong></span>
                                <span id="name">Ranil Wickramasinghe</span>
                            </div>

                            <div id="candidate">
                                <span id="percentage"><strong>15%</strong></span>
                                <span id="name">Anura Kumara Dissanayake</span>
                            </div>

                            <div id="candidate">
                                <span id="percentage"><strong>10%</strong></span>
                                <span id="name">Sajith Wickramasinghe</span>
                            </div>
                        </div>
                        <div class="total-votes">
                            <strong>Total Votes:</strong> <span> 1000456 </span>
                        </div>
                        <button class="Analytics">See More Analytics</button>

                    </div>
                    <div class="weeklySurvey post votelist reactable province">

                        <div class="post-head small-title">
                            <div class="post-title">
                                weekly survey 1 -
                                Who will be the next president of Sri Lanka?
                            </div>

                        </div>
                        <div class="survey-title">
                            Provincial vote distribution as a percentage of the total
                        </div>
                        <div id="top_x_div" class="chart"></div>
                    </div>
                </div>


            </div>




        </div>
    </div>
</div>

<script src="../script.js"></script>
</body>
</html>
