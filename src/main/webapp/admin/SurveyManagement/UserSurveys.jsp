<%--
  Created by IntelliJ IDEA.
  User: Manuja Ransara
  Date: 4/13/2025
  Time: 11:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Survey Management | Parlimate Surveys</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/admin/index.css"
          type="text/css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/admin/SurveyManagement/surveys.css"
          type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

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
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/solid.css"
    />
    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
    />
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/admin/assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="index.jsp" class="nav-item f-row ">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="../userManagement/UserManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>user management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>fundraise management</span>
                </a>
            </li>
            <li>
                <a href="ParlimateSurveys.jsp" class="nav-item f-row active">
                    <i class="fa-regular fa-check-to-slot"></i>
                    <span>survey management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-cards-blank"></i>
                    <span>post management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>requests</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-money-bill-transfer"></i>
                    <span>bank transfer management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>platform settings</span>
                </a>
            </li>
        </ul>
        <ul>
            <li>
                <a href="#" class="f-row profile">
                    <div class="p-img"></div>
                    <div class="sUser f-col">
                        <div class="name">Naleeka Kumarasinghe</div>
                        <div class="role">Admin</div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#" class="f-row log-out">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    log out
                </a>
            </li>
        </ul>
    </div>
</div>
<div class = "contentpage">
    <div class="container col">
        <div class="pageTitles">
            <h2 class="title">Surveys</h2>
            <div class="subTitle">Create and Vote Surveys</div><br>
            <div style="display: flex; justify-content: center; align-items: center;width:100%;">
                <input type="text" placeholder="Search Surveys" style="width: 600px; height: 40px; border-radius: 20px; font-size: 20px; padding: 0 10px; text-align: center;">
                <button style="width: 40px; height: 40px; border-radius: 20px; margin-left: 10px; background-color: #ccc; border: none; font-size: 20px; color: black; display: flex; justify-content: center; align-items: center;">
                    <i class="far fa-search"></i>
                </button>
            </div>

            <div class="tab-container">
                <div class="tabs">
                    <div class="tab "
                         id="parliament-tab"
                         onclick="window.location.href='${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet'">
                        Parlimate surveys
                    </div>

                    <div
                            class="tab active"
                            id="user-tab"
                            onclick="window.location.href='${pageContext.request.contextPath}/Surveys/GetUserSurveysServlet'"
                    >
                        User surveys
                    </div>


                </div>
            </div>
        </div>
        <div class="contents">
            <%--	                 content loop begin                       --%>


            <%@ include file="../SurveyManagement/surveyPrototype.jsp" %>


            <%--	                 content loop finish                        --%>
        </div>
    </div>
</div>
</body>
</html>
