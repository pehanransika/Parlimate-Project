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
    </style>

    <script src="./profile.js" defer></script>
</head>
<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <div id="editModal" class="modal">
        <div class="modal-content f-col">
            <div class="top f-row caps">
                <div class="title">Account settings</div>
                <div class="close-btn f-row">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <div class="center f-row">
                <div class="details f-col">
                    <div class="info f-col">
                        <div class="title">User information</div>
                        <div class="desc">
                            Here you can edit public information about
                            yourself. The changes will be displayed for
                            other users as well.
                        </div>
                    </div>
                    <div class="inputs f-col">
                        <div class="email f-col">
                            <label for="email-input" class="input-head"
                            >Email address</label
                            >
                            <input
                                    type="email"
                                    name="email"
                                    id="email-input"
                                    placeholder="${user.email}"
                            />
                        </div>
                        <div class="full-name">
                            <label for="name-input" class="input-head"
                            >full name</label
                            >
                            <span>
                                ${posts.userId}
                            </span>
                            <input
                                    type="text"
                                    name="full-name"
                                    id="name-input"
                                    placeholder="${userProfile.name}"
                            />
                        </div>
                        <div class="city">
                            <label
                                    for="province-drop"
                                    class="input-head"
                            >city</label
                            >
                            <div class="dropdown f-row">
                                <select
                                        name="province"
                                        id="province-drop"
                                        onchange="updateCities()"
                                >
                                    <option value="" disabled selected>
                                        -- Select Province --
                                    </option>
                                    <option value="western">
                                        Western Province
                                    </option>
                                    <option value="central">
                                        Central Province
                                    </option>
                                    <option value="southern">
                                        Southern Province
                                    </option>
                                    <option value="northern">
                                        Northern Province
                                    </option>
                                    <option value="eastern">
                                        Eastern Province
                                    </option>
                                    <option value="north-western">
                                        North Western Province
                                    </option>
                                    <option value="north-central">
                                        North Central Province
                                    </option>
                                    <option value="uva">
                                        Uva Province
                                    </option>
                                    <option value="sabaragamuwa">
                                        Sabaragamuwa Province
                                    </option>
                                </select>
                                <select id="city" name="city" disabled>
                                    <option value="">
                                        -- First select a province --
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="profile-pic f-col">
                    <div class="image"></div>
                    <button id="change">Change image</button>
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
                    <button id="save-btn">save</button>
                </div>
            </div>
        </div>
    </div>
    <div class="profile-container f-col">
        <div class="profile-imgs">
            <div class="cover-photo">
                <img src="bg.png" alt="bg"/>
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
                Galle, Southern Province &#127473;&#127472;
            </div>
            <div class="buttons f-row">
                <div class="prmry-btns f-row">
                    <button class="follow-btn">
                        <i class="fa-solid fa-plus"></i>follow
                    </button>
                    <button class="message-btn">
                        <i class="fa-solid fa-messages"></i>message
                    </button>
                </div>
                <div class="scndry-btns">
                    <button class="edit-btn">
                        <i class="fa-solid fa-pen-to-square"></i>edit
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="recent-posts f-col">

        <div class="title caps f-row">
            <span>recent posts</span>
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
<script>
    const editBtn = document.querySelector(".edit-btn");
    const modal = document.getElementById("editModal");
    const closeBtn = document.querySelector(".close-btn");
    const modalCancelBtn = document.getElementById("cancel-btn");

    // Initially hide the modal
    modal.style.display = "none";

    // Open modal on button click
    editBtn.addEventListener("click", () => {
        modal.style.display = "flex";
    });

    // Close modal on close button click
    closeBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });
    modalCancelBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });

    // Close modal when clicking outside the modal content
    window.addEventListener("click", (event) => {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });

    const citiesByProvince = {
        western: [
            "Colombo",
            "Negombo",
            "Moratuwa",
            "Panadura",
            "Kalutara",
            "Gampaha",
            "Horana",
        ],
        central: [
            "Kandy",
            "Matale",
            "Nuwara Eliya",
            "Gampola",
            "Dambulla",
            "Hatton",
        ],
        southern: [
            "Galle",
            "Matara",
            "Hambantota",
            "Weligama",
            "Tangalle",
            "Ambalangoda",
        ],
        northern: [
            "Jaffna",
            "Vavuniya",
            "Kilinochchi",
            "Mullaitivu",
            "Mannar",
        ],
        eastern: [
            "Batticaloa",
            "Trincomalee",
            "Kalmunai",
            "Ampara",
            "Akkaraipattu",
        ],
        "north-western": [
            "Kurunegala",
            "Puttalam",
            "Chilaw",
            "Narammala",
            "Wariyapola",
        ],
        "north-central": [
            "Anuradhapura",
            "Polonnaruwa",
            "Medawachchiya",
            "Habarana",
            "Kekirawa",
        ],
        uva: [
            "Badulla",
            "Monaragala",
            "Bandarawela",
            "Haputale",
            "Welimada",
        ],
        sabaragamuwa: [
            "Ratnapura",
            "Kegalle",
            "Balangoda",
            "Embilipitiya",
            "Kuruwita",
        ],
    };

    function updateCities() {
        const provinceSelect = document.getElementById("province-drop");
        const citySelect = document.getElementById("city");
        const selectedProvince = provinceSelect.value;

        // Clear previous options
        citySelect.innerHTML = "";

        if (selectedProvince) {
            citySelect.disabled = false;
            citySelect.add(new Option("-- Select City --", ""));

            // Add cities for selected province
            citiesByProvince[selectedProvince].forEach((city) => {
                citySelect.add(
                    new Option(city, city.toLowerCase().replace(" ", "-"))
                );
            });
        } else {
            citySelect.disabled = true;
            citySelect.add(new Option("-- First select a province --", ""));
        }
    }
</script>
<%--<script>--%>
<%--    document.addEventListener('DOMContentLoaded', function() {--%>
<%--        console.log("DOM fully loaded and parsed");--%>

<%--        // Debug output--%>
<%--        console.log("UserProfile data:", {--%>
<%--            exists: ${not empty userProfile},--%>
<%--            userId: '${userProfile.userId}',--%>
<%--            name: '${userProfile.name}'--%>
<%--        });--%>

<%--        const userId = '${userProfile.userId}';--%>
<%--        if (!userId || userId === 'null' || userId === '') {--%>
<%--            console.error("Invalid user ID:", userId);--%>
<%--            showError("User profile not properly loaded");--%>
<%--            return;--%>
<%--        }--%>

<%--        // Show loading state--%>
<%--        document.getElementById('posts-container').innerHTML =--%>
<%--            '<div class="loading-spinner">Loading posts...</div>';--%>

<%--        fetchPosts(userId);--%>
<%--    });--%>

<%--    async function fetchPosts(userId) {--%>
<%--        try {--%>
<%--            console.log("Initiating fetch for user:", userId);--%>
<%--            const startTime = performance.now();--%>

<%--            const response = await fetch(`GetUserPostsServlet?userId=${encodeURIComponent(userId)}&t=${Date.now()}`);--%>
<%--            const responseTime = performance.now() - startTime;--%>

<%--            console.log(`Received response in ${responseTime.toFixed(2)}ms`, response);--%>

<%--            if (!response.ok) {--%>
<%--                const errorText = await response.text();--%>
<%--                throw new Error(`HTTP ${response.status}: ${errorText}`);--%>
<%--            }--%>

<%--            const responseData = await response.text();--%>
<%--            console.log("Raw response:", responseData);--%>

<%--            const posts = JSON.parse(responseData);--%>
<%--            console.log("Parsed posts:", posts);--%>

<%--            if (!Array.isArray(posts)) {--%>
<%--                throw new Error("Invalid response format");--%>
<%--            }--%>

<%--            if (posts.length === 0) {--%>
<%--                showMessage("No posts found for this user");--%>
<%--            } else {--%>
<%--                renderPosts(posts);--%>
<%--            }--%>

<%--        } catch (error) {--%>
<%--            console.error("Fetch error details:", {--%>
<%--                error: error.message,--%>
<%--                stack: error.stack--%>
<%--            });--%>
<%--            showError(`Failed to load posts. ${error.message}`);--%>
<%--        }--%>
<%--    }--%>

<%--    function renderPosts(posts) {--%>
<%--        const container = document.getElementById('posts-container');--%>
<%--        container.innerHTML = posts.map(post => `--%>
<%--            <div class="post-card">--%>
<%--                <div class="post-header">--%>
<%--                    <img src="https://i.pravatar.cc/50?u=${post.userId}"--%>
<%--                         class="post-avatar">--%>
<%--                    <div class="post-user-info">--%>
<%--                        <h4>${escapeHtml(post.name || 'Unknown User')}</h4>--%>
<%--                        <span>${formatDate(post.datetime)}</span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="post-content">--%>
<%--                    <p>${escapeHtml(post.content || '')}</p>--%>
<%--                </div>--%>
<%--                <div class="post-footer">--%>
<%--                    <button class="action-btn like-btn">--%>
<%--                        <i class="fa-regular fa-thumbs-up"></i>--%>
<%--                        <span>0</span>--%>
<%--                    </button>--%>
<%--                    <button class="action-btn comment-btn">--%>
<%--                        <i class="far fa-comment"></i> <span>0</span>--%>
<%--                    </button>--%>
<%--                    <button class="action-btn share-btn">--%>
<%--                        <i class="fas fa-share"></i> <span>Share</span>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        `).join('');--%>
<%--    }--%>

<%--    // Helper functions--%>
<%--    function escapeHtml(unsafe) {--%>
<%--        return unsafe ? unsafe.toString()--%>
<%--            .replace(/&/g, "&amp;")--%>
<%--            .replace(/</g, "&lt;")--%>
<%--            .replace(/>/g, "&gt;")--%>
<%--            .replace(/"/g, "&quot;")--%>
<%--            .replace(/'/g, "&#039;") : '';--%>
<%--    }--%>

<%--    function formatDate(timestamp) {--%>
<%--        if (!timestamp) return "Recently";--%>
<%--        try {--%>
<%--            const date = new Date(timestamp);--%>
<%--            return date.toLocaleString();--%>
<%--        } catch (e) {--%>
<%--            console.error("Error formatting date:", e);--%>
<%--            return "Recently";--%>
<%--        }--%>
<%--    }--%>

<%--    function showMessage(message) {--%>
<%--        document.getElementById('posts-container').innerHTML =--%>
<%--            `<div class="info-message">${message}</div>`;--%>
<%--    }--%>

<%--    function showError(message) {--%>
<%--        document.getElementById('posts-container').innerHTML = `--%>
<%--            <div class="error-message">--%>
<%--                ${message}--%>
<%--                <button onclick="window.location.reload()">Retry</button>--%>
<%--            </div>--%>
<%--        `;--%>
<%--    }--%>
<%--</script>--%>

<%--test script--%>
<script>
    console.log("UserProfile data:", {
        exists: ${not empty userProfile},
        userId: '${userProfile.userId}',
        typeUserId : typeof '${userProfile.userId}',
        name: '${userProfile.name}'
    });

    if (typeof '${userProfile.userId}' === 'undefined' || '${userProfile.userId}' === '') {
        console.error("userProfile.userId is missing or empty");
        document.getElementById('posts-container').innerHTML =
            '<div class="error">User profile not loaded</div>';
    }


</script>
</html>
