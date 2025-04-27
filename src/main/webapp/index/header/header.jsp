<link rel="stylesheet" href="./header.css">
<style>
    .header .logo a img {
        height: 20px;
        transform: translateY(2px);
    }
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="header pd-2">
    <div class="start row">
        <div class="sidebar-toggle-btn sideMenuBtn btn">
            <i class="fa-sharp fa-solid fa-bars"></i>
        </div>

        <div class="logo">
            <a href="<c:url value='http://localhost:8080/Parlimate/GetPostListServlet' />">
                <img src="<c:url value='/assets/images/logo.png' />" alt="ParlimateLogo">
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
<%--            <input type="checkbox" name="notifi" id="notificationBtn" />--%>
<%--            <label for="notificationBtn" class="btn">--%>
<%--                <i class="fa-solid fa-bell"></i>--%>
<%--            </label>--%>
<%--            <span class="tip">notifications</span>--%>
<%--            <div class="dropDownMenu">--%>
<%--                <ul>--%>
<%--                    <li>--%>
<%--                        <a href="#" class="notification">--%>
<%--                            <div class="noti-img"></div>--%>
<%--                            <div class="noti-title">--%>
<%--                                <div class="notification-from">--%>
<%--                                    Ranil wickramasinghe--%>
<%--                                </div>--%>
<%--                                <span>Lorem, ipsum dolor sit amet--%>
<%--											consectetur adipisicing elit. Qui,--%>
<%--											ullam. Quos aperiam in re</span>--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="#" class="notification">--%>
<%--                            <div class="noti-img"></div>--%>
<%--                            <div class="noti-title">--%>
<%--                                <div class="notification-from">--%>
<%--                                    Ranil wickramasinghe--%>
<%--                                </div>--%>
<%--                                <span>Lorem, ipsum dolor sit amet--%>
<%--											consectetur adipisicing elit. Qui,--%>
<%--											ullam. Quos aperiam in re</span>--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="#" class="notification">--%>
<%--                            <div class="noti-img"></div>--%>
<%--                            <div class="noti-title">--%>
<%--                                <div class="notification-from">--%>
<%--                                    Ranil wickramasinghe--%>
<%--                                </div>--%>
<%--                                <span>Lorem, ipsum dolor sit amet--%>
<%--											consectetur adipisicing elit. Qui,--%>
<%--											ullam. Quos aperiam in re</span>--%>
<%--                            </div>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--                <a href="./Announcements/announcements.html" class="bottom-btn small-text capitalize">--%>
<%--                    see all notifications--%>
<%--                </a>--%>
<%--            </div>--%>
        </div>
        <div class="headerBtn">
            <input type="checkbox" name="profile" id="profileBtn" />
            <label for="profileBtn" class="btn">
                <i class="fa-solid fa-user"></i>
            </label>
            <span class="tip">profile</span>
            <div class="dropDownMenu">
                <div class="profile">
                    <a href="http://localhost:8080/Parlimate/Profile/profile.jsp">
                        <div class="img"><img src="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/images/user_${user.userId}/${userProfile.profileImg}"
                                              alt="User Profile Image" style="width: 100%; height: 100%; border-radius: 50%" onerror="this.src='${pageContext.request.contextPath}/images/Users/user.png'" /></div>
                        <div class="details">
                            <div class="name medium-text bold">
                                ${userProfile.name}
                            </div>
                            <div class="email small-text">
                                ${user.email}
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
