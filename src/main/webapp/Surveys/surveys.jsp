<%@ page session="true" %>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        // User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SURVEYS | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./surveys.css" />
    <link rel="stylesheet" href="./surv-popup.css" />
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
                bars: 'horizontal',
                axes: {
                    x: {
                        0: { side: 'top', label: 'Percentage'}
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
<%@ include file="../index/header/header.jsp" %>

<div class="container col">
    <div class="pageTitles">
        <h2 class="title">Surveys</h2>
        <div class="subTitle">
            Surveys conducted by Parlimate
        </div>
    </div>
    <div class="row">
        <div class="announcements col">
            <div class="subTitle1">
                Ongoing Surveys
            </div>
            <div class="survey">
                <div style="display: flex; justify-content: space-between;margin-bottom: 4px;">
                    <span style="text-align: left;font-size: medium;">&nbsp;&nbsp;<strong>Survey Name : Who will be the next president of Sri Lanka?</strong></span>
                    <span style="text-align: right;font-size: medium;"><strong>
                        <button class="request-survey">
                            <span>+ Request Survey</span>
                        </button>
                        <br>

                        <!-- Survey Popup (Hidden by Default) -->
                    <form action="CreateSurveyRequestServlet" method="post" class="popup-f" id="popup-f">

    <div id="surveyPopup" class="survey-popup">
        <div class="popup-content">
            <div class="popup-header">
                <div class="title">Create Survey Question</div>
                <div id="closePopup" class="close-btn">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <div class="separator"></div>
            <div class="body col">
                <div class="survey-question field">
                    <label for="survey-question" class="title">Question</label>
                    <input type="text" required placeholder="Enter your question here" name="questiontext" id="survey-question">
                </div>
                <div class="survey-answer field">
                    <label for="answer01" class="title">Answer 1</label>
                    <input type="text" required placeholder="Enter first answer" name="answer01" id="answer01">
                </div>
                <div class="survey-answer field">
                    <label for="answer02" class="title">Answer 2</label>
                    <input type="text" required placeholder="Enter second answer" name="answer02" id="answer02">
                </div>
                <div class="survey-answer field">
                    <label for="answer03" class="title">Answer 3</label>
                    <input type="text" required placeholder="Enter third answer" name="answer03" id="answer03">
                </div>
                <div class="survey-answer field">
                    <label for="answer04" class="title">Answer 4</label>
                    <input type="text" required placeholder="Enter fourth answer" name="answer04" id="answer04">
                </div>
            </div>
            <div class="bottom row">
                <button type="button" id="cancelPopup" class="form-btn cancel-btn">Cancel</button>
                <button type="submit" id="submitSurvey" class="form-btn submit-btn">Submit</button>
            </div>
        </div>
    </div>
</form>

                        <!-- Request Survey Button -->


                        <div class="separator"></div>
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
                                weekly survey 1 - Who will be the next president of Sri Lanka?
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
<script src="./surv-pop.js"></script>
</body>
</html>
