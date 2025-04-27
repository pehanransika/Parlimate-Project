<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- Check for session and user --%>
<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./profile.css" />
    <!-- icons -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />
</head>
<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container col">
    <div class="pro-imgs">
        <div class="cover-bg"></div>
        <div class="profile-pic"></div>
    </div>

    <div class="profile-container">
        <div class="profile-details col">
            <div class="user-ac row jc-sb">
                <div class="content-1 col">
                    <div class="name capitalize">
                        ${userProfile.name}
                        <span class="verified">verified</span>
                    </div>
                    <div class="row">
                        <div class="jDate">
                            <i class="fa-solid fa-calendar"></i>
                            Joined on
                            <span>
                                <c:if test="${not empty user}">
                                    ${user.created_at}
                                </c:if>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="content-2 row">
                    <div class="btn message capitalize row">
                        message
                    </div>
                    <div class="options btn">
                        <i class="fa-solid fa-ellipsis"></i>
                    </div>
                </div>
            </div>

            <!-- Bio Section -->
            <div class="bio col">
                  <span class="bio-content">
                    <h2>
                        <strong>User ID:</strong>
                        <c:if test="${not empty user}">
                            ${user.userId}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>

                <span class="bio-content">
                    <h2>
                        <strong>User Type:</strong>
                        <c:if test="${not empty user}">
                            ${user.userType}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
                <span class="bio-content">
                    <h2>
                        <strong>Email:</strong>
                        <c:if test="${not empty user}">
                            ${user.email}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>

            </div>

            <div class="profile-container-right">
               <span class="bio-content">
<c:choose>
    <c:when test="${not empty user && user.userType eq 'Citizen'}">
        <span class="bio-content">
                    <h2>
                        <strong>Citizen ID:</strong>
                        <c:if test="${not empty citizen}">
                            ${citizen.citizenId}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Full Name:</strong>
                        <c:if test="${not empty citizen}">
                            ${citizen.name}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Phone Number:</strong>
                        <c:if test="${not empty citizen}">
                            ${citizen.phoneNumber}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Address:</strong>
                        <c:if test="${not empty citizen}">
                            ${citizen.address}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>District:</strong>
                        <c:if test="${not empty citizen}">
                            ${citizen.district}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
    </c:when>
    <c:when test="${not empty user && user.userType eq 'Politician'}">
       <span class="bio-content">
                    <h2>
                        <strong>Politician ID:</strong>
                        <c:if test="${not empty politician}">
                            ${politician.politicianId}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Full Name:</strong>
                        <c:if test="${not empty politician}">
                            ${politician.name}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Phone Number:</strong>
                        <c:if test="${not empty politician}">
                            ${politician.phoneNumber}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
        <span class="bio-content">
                    <h2>
                        <strong>Address:</strong>
                        <c:if test="${not empty politician}">
                            ${politician.address}
                        </c:if>
                    </h2>
                    <br>
                    <br>

                </span>
    </c:when>
    <c:otherwise>
        <p>User type is unknown.</p>
    </c:otherwise>
</c:choose>

               </span>
            </div>


            <!-- Additional Info for Citizens -->


            <!-- Political Interests -->
            <div class="pol-interest">
                <div class="title"><i class="fa-solid fa-landmark"></i> Political Interests</div>
                <div class="tags capitalize">
                    <a href="#">Anura Kumara Dissanayake <span>AKD</span></a>
                    <a href="#">Sunil Hadunhetti <span>HadunhettiSunil</span></a>
                    <a href="#">Vijitha Rajapakse <span>VijithaR</span></a>
                    <a href="#">Harini Amarasuriya <span>HariniA</span></a>
                    <a href="#">Mahinda Rajapakse <span>MahindaR</span></a>
                    <a href="#">Ranil Wickramasinghe <span>RanilW</span></a>
                </div>
            </div>
        </div>

        <!-- Edit Profile Button -->
        <a href="./editProfile/edit.jsp" class="edit-btn btn row capitalize">
            <i class="fa-solid fa-pen-to-square"></i>
            Edit Profile
        </a>

        <!-- View My Posts -->
        <div class="bottom">
            <form action="GetPostAllServlet" method="post">
                <input type="hidden" name="user_id" value="${user.userId}" />
                <button type="submit" class="view-my-post row">
                    <span>View My Posts</span>
                    <i class="fa-classic fa-solid fa-angles-right fa-fw"></i>
                </button>
            </form>
        </div>
    </div>
</div>

</body>
<script src="../script.js"></script>
</html>
