<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- Check for session and user --%>

<%
    HttpSession session1 = (HttpSession) request.getSession(false);
    if (session1 == null || session.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<jsp:include page="/load-politicians" />
<jsp:include page="/load-politicalParty" />
<jsp:include page="/ViewPoliticsPreference" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Profile | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="./profile.css">
    <!-- icons -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>

    <script src="../formatDate.js" ></script>
    <style>
        body {
            background: #f0f0f0;
            padding: 2rem;
        }

        .f-col {
            display: flex;
            flex-direction: column;
        }

        .f-row {
            display: flex;
            align-items: center;
        }

        .post-card {
            width: 100%;
        }

        .post-container {
            width: 100%;
        }
    </style>

    <script src="./profile.js" defer></script>
</head>
<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<%-- Display update messages --%>
<c:if test="${not empty updateSuccess}">
    <div class="alert alert-success">
            ${updateSuccess}
    </div>
</c:if>
<c:if test="${not empty updateError}">
    <div class="alert alert-danger">
            ${updateError}
    </div>
</c:if>
<div class="container">
    <div id="interestsModal" class="modal">
        <div class="modal-content">
            <div class="top f-row caps">
                <div class="title">Political interests</div>
                <div class="close-btn f-row">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <form action="SetPoliticsPreference" method="post" class="center f-col">
                <div class="desc">
                    These are the political topics and parties this
                    person has shown interest on Parlimate. This might
                    reflects their personal views and helps connect them
                    with relevant discussions and representatives
                </div>
                <div class="politicians-pref table-cont f-col">
                    <div class="title f-row">
                        <span>Top Supported Leaders</span>
                    </div>
                    <table>
                        <thead class="caps">
                        <tr>
                            <td>preference rank</td>
                            <td>politician name</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" begin="1" end="3">
                            <tr>
                                <td class="rank">${i}</td>
                                <td class="politician-cell" data-rank="${i}">
                <span class="display-value">
                    <c:choose>
                        <c:when test="${not empty prefferedPoliticians and fn:length(prefferedPoliticians) >= i}">
                            ${prefferedPoliticians[i-1].name}
                        </c:when>
                        <c:otherwise>
                            -- Select Politician --
                        </c:otherwise>
                    </c:choose>
                </span>
                                    <select class="politician-select" data-rank="${i}" style="display: none;">
                                        <option value="">-- Select Politician --</option>
                                        <c:forEach var="pol" items="${politicians}">
                                            <option value="${pol.politicianId}"
                                                    <c:if test="${not empty prefferedPoliticians and fn:length(prefferedPoliticians) >= i and prefferedPoliticians[i-1].politicianId == pol.politicianId}">selected</c:if>>
                                                    ${pol.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="party-pref table-cont f-col">
                    <div class="title f-row">
                        <span>Preferred Political Parties</span>
                    </div>
                    <table>
                        <thead class="caps">
                        <tr>
                            <td>preference rank</td>
                            <td>political party name</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach begin="1" end="3" var="Rank">
                            <tr>
                                <td class="rank">${Rank}</td>
                                <td data-options="<c:forEach var="party" items="${politicalParties}">${party.name},</c:forEach>">
                                    <c:if test="${not empty politicalParties}">${politicalParties[Rank].name}</c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </form>
            <div class="footer f-row caps">
                <div class="edit f-row">
                    <button id="pref-edit" class="pref-edit-btn f-row">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Edit
                    </button>
                </div>
                <div class="pref-action f-row">
                    <button class="pref-cancel">Cancel</button>
                    <input type="submit" value="Save changes" id="pref-save" class="save-btn">
                </div>
            </div>
        </div>
    </div>
    <form id="editModal" class="modal" action="../UserDetailUpdateServlet" method="post">
        <div class="modal-content f-col">
            <div class="top f-row caps">
                <div class="title">Account settings</div>
                <div class="close-btn f-row">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <div class="center f-row" >
                <div class="details f-col">
                    <div class="info f-col">
                        <div class="title">User information</div>
                        <div class="desc">
                            Here you can edit public information about
                            yourself. The changes will be displayed for
                            other users as well.
                        </div>
                    </div>
                    <div class="inputs f-row wrap">
                        <div class="email f-col">
                            <label for="email-input" class="input-head"
                            >Email address</label
                            >
                            <input
                                    type="email"
                                    name="email"
                                    id="email-input"
                                    value="${user.email}"
                                    disabled
                            />
                        </div>
                        <div class="full-name">
                            <label for="name-input" class="input-head"
                            >full name</label
                            >
                            <input
                                    type="text"
                                    name="full-name"
                                    id="name-input"
                                    value="${userProfile.name}"
                            />
                        </div>
                        <div class="phone-number">
                            <label for="phoneNumber" class="input-head">phone number</label>
                            <input type="text" name="phoneNumber" id="phoneNumber" value="${userProfile.phoneNumber}">
                        </div>
                        <div class="address-input max-width">
                            <label for="address" class="input-head">address</label>
                            <input type="text" name="address" id="address" value="${userProfile.address}">
                        </div>
                        <div class="city">
                            <label
                                    for="province-drop"
                                    class="input-head"
                            >location</label
                            >
                            <div class="dropdown f-row">
                                <select
                                        name="province"
                                        id="province-drop"
                                        onchange="updateCities()"
                                >
                                    <option value="" disabled selected>-- Select Province --</option>
                                    <option value="western" ${userProfile.province eq 'western' ? 'selected' : ''}>
                                        Western Province
                                    </option>
                                    <option value="central" ${userProfile.province eq 'central' ? 'selected' : ''}>
                                        Central Province
                                    </option>
                                    <option value="southern" ${userProfile.province eq 'southern' ? 'selected' : ''}>
                                        Southern Province
                                    </option>
                                    <option value="northern" ${userProfile.province eq 'northern' ? 'selected' : ''}>
                                        Northern Province
                                    </option>
                                    <option value="eastern" ${userProfile.province eq 'eastern' ? 'selected' : ''}>
                                        Eastern Province
                                    </option>
                                    <option value="north-western" ${userProfile.province eq 'north-western' ? 'selected' : ''}>
                                        North Western Province
                                    </option>
                                    <option value="north-central" ${userProfile.province eq 'north-central' ? 'selected' : ''}>
                                        North Central Province
                                    </option>
                                    <option value="uva" ${userProfile.province eq 'uva' ? 'selected' : ''}>
                                        Uva Province
                                    </option>
                                    <option value="sabaragamuwa" ${userProfile.province eq 'sabaragamuwa' ? 'selected' : ''}>
                                        Sabaragamuwa Province
                                    </option>
                                </select>
                                <select id="city" name="district" ${empty userProfile.province ? 'disabled' : ''}>
                                    <c:choose>
                                        <c:when test="${not empty userProfile.district}">
                                            <option value="${userProfile.district}" selected>${userProfile.district}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="">-- First select a province --</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="political-view-field max-width f-col">
                            <label for="political-view-field" class="input-head">Political view</label>
                            <textarea name="political_view" id="political-view-field">${(userProfile.politicalView)}</textarea>
                        </div>
                    </div>
                </div>
                <div class="profile-pic f-col">
                    <div class="banner">
                        <img src="./bg.jpg" alt="banner"/>
                    </div>
                    <div class="profile f-col">
                        <div class="image"></div>
                        <div class="btns f-row">
                            <button id="change-pp">Change profile</button>
                            <button id="change-banner">Change banner</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer f-row">
                <div class="change-pw">
                    <a href="#" target="_blank">change password</a>
                </div>
                <div class="action f-row">
                    <button id="cancel-btn">cancel
                    </button
                    >
                    <input type="submit" value="save changes" id="save-btn" class="caps"/>
                </div>
            </div>
        </div>
    </form>
    <div class="profile-container f-col" data-user-id="${user.userId}">
        <div class="profile-imgs">
            <div class="cover-photo">
                <img src="bg.jpg" alt="bg"/>
            </div>
            <div class="profile-photo">
                <img src="https://i.pravatar.cc/200" alt="" srcset=""/>
            </div>
        </div>
        <div class="profile-details f-col">
            <div class="user-basic f-row">
                <div class="name">${userProfile.name}</div>
                <span class="dot">·</span>
                <div class="joined-date">
                    Joined on <span class="date"><c:if test="${not empty user}">
                    ${user.created_at}
                </c:if></span>
                </div>
                <span class="dot">·</span>
                <div class="role caps"><c:if test="${not empty user}">
                    ${user.userType}
                </c:if>
                </div>
            </div>
            <div class="profession">Product Designer at Senica</div>
            <div class="city caps">
                ${userProfile.district}  , ${userProfile.province} province &#127473;&#127472;
            </div>
            <div class="political-view f-col">
                <span class="content">
                    ${userProfile.politicalView}
                </span>
            </div>
            <div class="buttons f-row">
                <div class="prmry-btns f-row">
                    <button class="intrst-btn">
                        About me
                    </button>
<%--                    <button class="message-btn">--%>
<%--                        <i class="fa-solid fa-messages"></i>message--%>
<%--                    </button>--%>
                </div>
                <div class="scndry-btns">
                    <button class="user-edit-btn">
                        <i class="fa-solid fa-pen-to-square"></i>edit
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="recent-posts f-col">

        <div class="title caps f-col">
            <span>recent posts</span>
            <span class="desc">recently added posts and insights.</span>
        </div>
        <div class="post-container" id="posts-container" data-user-id="${userProfile.userId}">
            <%--            sample Recent post--%>
            <div class="post-card">
                <div class="post-header">
                    <img
                            src="https://i.pravatar.cc/50"
                            alt="User Avatar"
                            class="post-avatar"
                    />
                    <div class="post-user-info">
                        <h4 class="username">${userProfile.name}</h4>
                        <span class="post-time">2 hours ago</span>
                    </div>
                    <div class="post-actions">
                        <button class="post-menu-btn">
                            <i class="fas fa-ellipsis-v"></i>
                        </button>
                    </div>
                </div>

                <div class="post-content">
                    <p>
                        Just attended the parliamentary debate on the
                        new education reforms. While the proposal has
                        good intentions, we need stronger provisions for
                        rural school infrastructure. What are your
                        thoughts? #EducationReform #SriLanka
                    </p>

                    <div class="post-image">
                        <img
                                src="debate-photo.jpg"
                                alt="Parliament debate"
                        />
                    </div>

                    <div class="post-tags">
                        <span class="tag">#EducationReform</span>
                        <span class="tag">#RuralDevelopment</span>
                        <span class="tag">#SriLanka</span>
                    </div>
                </div>

                <div class="post-footer">
                    <button class="action-btn like-btn">
                        <i class="fa-regular fa-thumbs-up"></i>
                        <span>124</span>
                    </button>
                    <button class="action-btn comment-btn">
                        <i class="far fa-comment"></i> <span>28</span>
                    </button>
                    <button class="action-btn share-btn">
                        <i class="fas fa-share"></i> <span>Share</span>
                    </button>
                </div>
            </div>

        </div
    </div>
</div>

</body>
<script src="../script.js"></script>
<script src="./popupModals.js"></script>
<script>
    const dateField = document.querySelector(".joined-date .date");
    const formatedDate = formatDate(dateField.innerHTML)
    dateField.innerHTML= formatedDate;


    if (typeof '${userProfile.userId}' === 'undefined' || '${userProfile.userId}' === '') {
        console.error("userProfile.userId is missing or empty");
        document.getElementById('posts-container').innerHTML =
            '<div class="error">User profile not loaded</div>';
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Initialize city dropdown if province is already selected
        const savedProvince = document.getElementById('province-drop').value;
        const savedDistrict = '${userProfile.district}'; // This comes from JSP

        if (savedProvince) {
            updateCities();
            // Set the saved district after a small delay to ensure dropdown is populated
            setTimeout(() => {
                const citySelect = document.getElementById("city");
                if (savedDistrict) {
                    citySelect.value = savedDistrict;
                }
            }, 100);
        }
    });

    function updateCities() {
        const provinceSelect = document.getElementById("province-drop");
        const citySelect = document.getElementById("city");
        const selectedProvince = provinceSelect.value;
        const savedDistrict = `${userProfile.district}`; // Get from JSP

        // Clear previous options but keep the first empty option if province not selected
        citySelect.innerHTML = selectedProvince ? "" : "<option value='' disabled>-- First select a province --</option>";

        if (selectedProvince) {
            citySelect.disabled = false;
            citySelect.add(new Option("-- Select City --", ""));

            // Add cities for selected province
            citiesByProvince[selectedProvince].forEach((city) => {
                const option = new Option(city, city);
                // Select the option if it matches the saved district
                if (city === savedDistrict) {
                    option.selected = true;
                }
                citySelect.add(option);
            });
        } else {
            citySelect.disabled = true;
        }
    }
    document.getElementById('save-btn').addEventListener('click', function(e) {
        const citySelect = document.getElementById("city");
        if (citySelect.value === "") {
            // If no district selected, keep the original value
            citySelect.value = '${userProfile.district}';
        }
        // Proceed with form submission
    });
</script>
</html>
