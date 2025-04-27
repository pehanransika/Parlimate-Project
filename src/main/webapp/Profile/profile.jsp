<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- Check for session and user --%>
<%
    HttpSession session1 = (HttpSession) request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
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
<jsp:include page="/load-parties" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Profile | Parlimate</title>
    <link rel="stylesheet" href="../index/sidebar1.css"/>
    <link rel="stylesheet" href="../index/header/header.css"/>
    <link rel="stylesheet" href="../index.css"/>
    <link rel="stylesheet" href="./profile.css"/>
    <!-- icons -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"/>
    <link rel="stylesheet" href="hashtag.css"/>
    <script src="../formatDate.js"></script>
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
        .post-card, .post-container {
            width: 100%;
        }
        .password-input {
            margin-bottom: 1rem;
        }
        .password-input label {
            font-weight: bold;
            margin-bottom: 0.5rem;
            display: block;
        }
        .password-input input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .error-message, .error {
            color: red;
            margin-bottom: 1rem;
            display: none;
        }
        .success {
            color: green;
            margin-bottom: 1rem;
            display: none;
        }
        .error.active, .success.active {
            display: block;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 8px;
        }
    </style>
    <script src="./profile.js" defer></script>
</head>
<body>
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>


<div class="container">
    <div id="interestsModal" class="modal">
        <div class="modal-content">
            <div class="top f-row caps">
                <div class="title">Political interests</div>
                <div class="close-btn f-row">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/SetPoliticsPreference" method="post" class="center f-col">
                <div class="desc">
                    These are the political topics and parties this
                    person has shown interest on Parlimate. This might
                    reflect their personal views and helps connect them
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
                        <c:forEach begin="1" end="3" var="rank">
                            <tr>
                                <td class="rank">${rank}</td>
                                <td class="party-cell" data-rank="${rank}">
                                    <span class="display-value">
                                        <c:choose>
                                            <c:when test="${not empty preferredParties and fn:length(preferredParties) >= rank}">
                                                ${preferredParties[rank-1].name}
                                            </c:when>
                                            <c:otherwise>
                                                -- Select Party --
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <select class="party-select" data-rank="${rank}" style="display: none;">
                                        <option value="">-- Select Party --</option>
                                        <c:forEach var="party" items="${politicalPartyList}">
                                            <option value="${party.politicalPartyId}"
                                                    <c:if test="${not empty preferredParties and fn:length(preferredParties) >= rank and preferredParties[rank-1].politicalPartyId == party.politicalPartyId}">selected</c:if>>
                                                    ${party.name}
                                            </option>
                                        </c:forEach>
                                    </select>
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
                        Edit preferences
                    </button>
                </div>
                <div class="pref-action f-row">
                    <button class="pref-cancel">Cancel</button>
                    <input type="submit" value="Save changes" id="pref-save" class="save-btn">
                </div>
            </div>
        </div>
    </div>
    <form id="editModal" class="modal" action="${pageContext.request.contextPath}/UserDetailUpdateServlet" method="post">
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
                    <div class="inputs f-row wrap">
                        <div class="email f-col">
                            <label for="email-input" class="input-head">Email address</label>
                            <input type="email" name="email" id="email-input" value="${user.email}" disabled />
                        </div>
                        <div class="full-name">
                            <label for="name-input" class="input-head">full name</label>
                            <input type="text" name="full-name" id="name-input" value="${userProfile.name}" />
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
                            <label for="province-drop" class="input-head">location</label>
                            <div class="dropdown f-row">
                                <select name="province" id="province-drop" onchange="updateCities()">
                                    <option value="" disabled selected>-- Select Province --</option>
                                    <option value="western" ${userProfile.province eq 'western' ? 'selected' : ''}>Western Province</option>
                                    <option value="central" ${userProfile.province eq 'central' ? 'selected' : ''}>Central Province</option>
                                    <option value="southern" ${userProfile.province eq 'southern' ? 'selected' : ''}>Southern Province</option>
                                    <option value="northern" ${userProfile.province eq 'northern' ? 'selected' : ''}>Northern Province</option>
                                    <option value="eastern" ${userProfile.province eq 'eastern' ? 'selected' : ''}>Eastern Province</option>
                                    <option value="north-western" ${userProfile.province eq 'north-western' ? 'selected' : ''}>North Western Province</option>
                                    <option value="north-central" ${userProfile.province eq 'north-central' ? 'selected' : ''}>North Central Province</option>
                                    <option value="uva" ${userProfile.province eq 'uva' ? 'selected' : ''}>Uva Province</option>
                                    <option value="sabaragamuwa" ${userProfile.province eq 'sabaragamuwa' ? 'selected' : ''}>Sabaragamuwa Province</option>
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
                    <button type="button" id="change-password-btn">change password</button>
                </div>
                <div class="action f-row">
                    <button id="cancel-btn">cancel</button>
                    <input type="submit" value="save changes" id="save-btn" class="caps"/>
                </div>
            </div>
        </div>
    </form>

    <!-- Password Change Modal -->
    <form id="passwordModal" class="modal" action="${pageContext.request.contextPath}/Profile/ChangePasswordServlet" method="post">
        <div class="modal-content f-col">
            <div class="top f-row caps">
                <div class="title">Change Password</div>
                <div class="close-btn f-row">
                    <i class="fa-solid fa-xmark"></i>
                </div>
            </div>
            <div class="center f-col">
                <c:if test="${not empty errorMessage}">
                    <div class="error active">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="success active">${successMessage}</div>
                </c:if>
                <div class="info f-col">
                    <div class="title">Update Your Password</div>
                    <div class="desc">
                        Enter your current password and your new password below.
                        Make sure the new password is strong and secure.
                    </div>
                </div>
                <div class="error-message" id="password-error"></div>
                <div class="password-input f-col">
                    <label for="current-password">Current Password</label>
                    <input type="password" id="current-password" name="currentPassword" required />
                </div>
                <div class="password-input f-col">
                    <label for="new-password">New Password</label>
                    <input type="password" id="new-password" name="newPassword" required />
                </div>
                <div class="password-input f-col">
                    <label for="confirm-password">Confirm New Password</label>
                    <input type="password" id="confirm-password" name="confirmPassword" required />
                </div>
                <input type="hidden" name="userId" value="${user.userId}" />
            </div>
            <div class="footer f-row caps">
                <div class="action f-row">
                    <button type="button" class="cancel-password-btn">Cancel</button>
                    <input type="submit" value="Save Changes" id="save-password-btn" class="save-btn" />
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
            <img src="${pageContext.request.contextPath}/GetUserImageServlet?userId=${userProfile.userId}" alt="User Profile Image" />
        </div>
        </div>
        <div class="profile-details f-col">
            <div class="user-basic f-row">
                <div class="name">${userProfile.name}</div>
                <span class="dot">·</span>
                <div class="joined-date">
                    Joined on <span class="date"><c:if test="${not empty user}">${user.created_at}</c:if></span>
                </div>
                <span class="dot">·</span>
                <div class="role caps"><c:if test="${not empty user}">${user.userType}</c:if></div>
            </div>
            <div class="profession">Product Designer at Senica</div>
            <div class="city caps">${userProfile.district}, ${userProfile.province} province 🇱🇰</div>
            <div class="political-view f-col">
                <span class="content">${userProfile.politicalView}</span>
            </div>
            <div class="buttons f-row">
                <div class="prmry-btns f-row">
                    <button class="intrst-btn">political interests</button>
                </div>
                <div class="scndry-btns">
                    <button class="user-edit-btn">
                        <i class="fa-solid fa-pen-to-square"></i>edit
                    </button>
                </div>
                <button class="user-image-btn">
                    <i class="fa-solid fa-pen-to-square"></i>Image Upload
                </button>
            </div>
        </div>
    </div>
    <div class="recent-posts f-col">
        <div class="title caps f-col">
            <span>recent posts</span>
            <span class="desc">recently added posts and insights.</span>
        </div>
        <div class="post-container" id="posts-container" data-user-id="${userProfile.userId}">
            <div class="post-card">
                <div class="post-header">
                    <img src="<%= request.getContextPath() %>/Profile/GetUserImageServlet?userId=${userProfile.userId}"/>
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
                        Just attended the parliamentary debate on the new education reforms. While the proposal has
                        good intentions, we need stronger provisions for rural school infrastructure. What are your
                        thoughts? #EducationReform #SriLanka
                    </p>
                    <div class="post-image">
                        <img src="debate-photo.jpg" alt="Parliament debate"/>
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
        </div>
    </div>
</div>

<!-- Image Upload Modal -->
<form id="imageUploadModal" class="modal" action="${pageContext.request.contextPath}/Profile/ImageUploadServlet" method="post" enctype="multipart/form-data">
    <div class="modal-content f-col">
        <div class="top f-row caps">
            <div class="title">Upload Profile Image</div>
            <div class="close-btn f-row">
                <i class="fa-solid fa-xmark"></i>
            </div>
        </div>
        <div class="center f-col">
            <div class="info f-col">
                <div class="title">Select an Image</div>
                <div class="desc">
                    Upload a new profile picture. Supported formats: JPG, PNG. Maximum size: 5MB.
                </div>
            </div>
            <div class="error-message" id="image-error"></div>
            <div class="image-input f-col">
                <label for="profile-image">Choose Image</label>
                <input type="file" id="profile-image" name="profileImage" accept="image/jpeg, image/png" required />
            </div>
            <input type="hidden" name="userId" value="${user.userId}" />
        </div>
        <div class="footer f-row caps">
            <div class="action f-row">
                <button type="button" class="cancel-image-btn">Cancel</button>
                <input type="submit" value="Upload Image" id="upload-image-btn" class="save-btn" />
            </div>
        </div>
    </div>
</form>

</body>
<script src="../script.js"></script>
<script src="./popupModals.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imageUploadBtn = document.querySelector('.user-image-btn');
        const imageUploadModal = document.getElementById('imageUploadModal');
        const cancelImageBtn = document.querySelector('.cancel-image-btn');
        const closeImageBtn = imageUploadModal.querySelector('.close-btn');
        const imageForm = imageUploadModal.querySelector('form');
        const imageError = document.getElementById('image-error');

        // Open the image upload modal
        imageUploadBtn.addEventListener('click', function(e) {
            e.preventDefault();
            imageUploadModal.style.display = 'block';
            imageError.style.display = 'none';
        });

        // Close the modal when cancel is clicked
        cancelImageBtn.addEventListener('click', function(e) {
            e.preventDefault();
            imageUploadModal.style.display = 'none';
            imageForm.reset();
            imageError.style.display = 'none';
        });

        // Close the modal when the close button (x) is clicked
        closeImageBtn.addEventListener('click', function(e) {
            e.preventDefault();
            imageUploadModal.style.display = 'none';
            imageForm.reset();
            imageError.style.display = 'none';
        });

        // Close modal when clicking outside of it
        window.addEventListener('click', function(event) {
            if (event.target === imageUploadModal) {
                imageUploadModal.style.display = 'none';
                imageForm.reset();
                imageError.style.display = 'none';
            }
        });

        // Validate file input on form submission
        imageForm.addEventListener('submit', function(e) {
            const fileInput = document.getElementById('profile-image');
            const file = fileInput.files[0];

            if (file) {
                const validTypes = ['image/jpeg', 'image/png'];
                const maxSize = 5 * 1024 * 1024; // 5MB in bytes

                if (!validTypes.includes(file.type)) {
                    e.preventDefault();
                    imageError.textContent = 'Please upload a valid image (JPG or PNG).';
                    imageError.style.display = 'block';
                    alert('Error: Please upload a valid image (JPG or PNG).');
                } else if (file.size > maxSize) {
                    e.preventDefault();
                    imageError.textContent = 'Image size exceeds 5MB.';
                    imageError.style.display = 'block';
                    alert('Error: Image size exceeds 5MB.');
                }
            } else {
                e.preventDefault();
                imageError.textContent = 'Please select an image to upload.';
                imageError.style.display = 'block';
                alert('Error: Please select an image to upload.');
            }
        });
    });

    const dateField = document.querySelector(".joined-date .date");
    const formatedDate = formatDate(dateField.innerHTML);
    dateField.innerHTML = formatedDate;

    if (typeof '${userProfile.userId}' === 'undefined' || '${userProfile.userId}' === '') {
        console.error("userProfile.userId is missing or empty");
        document.getElementById('posts-container').innerHTML =
            '<div class="error">User profile not loaded</div>';
    }

    document.addEventListener('DOMContentLoaded', function() {
        const savedProvince = document.getElementById('province-drop').value;
        const savedDistrict = '${userProfile.district}';

        if (savedProvince) {
            updateCities();
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
        const savedDistrict = `${userProfile.district}`;

        citySelect.innerHTML = selectedProvince ? "" : "<option value='' disabled>-- First select a province --</option>";

        if (selectedProvince) {
            citySelect.disabled = false;
            citySelect.add(new Option("-- Select City --", ""));
            citiesByProvince[selectedProvince].forEach((city) => {
                const option = new Option(city, city);
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
            citySelect.value = '${userProfile.district}';
        }
    });
</script>
<script>
    // Password Modal Handling
    document.addEventListener('DOMContentLoaded', function() {
        const changePasswordBtn = document.getElementById('change-password-btn');
        const passwordModal = document.getElementById('passwordModal');
        const cancelPasswordBtn = document.querySelector('.cancel-password-btn');
        const closePasswordBtn = passwordModal.querySelector('.close-btn');
        const passwordForm = passwordModal.querySelector('form');
        const errorMessage = document.getElementById('password-error');
        const serverError = document.querySelector('.error');
        const serverSuccess = document.querySelector('.success');

        // Show alerts for server messages
        <c:if test="${not empty successMessage}">
        alert("Success: ${successMessage}");
        <% session.removeAttribute("successMessage"); %>
        </c:if>
        <c:if test="${not empty errorMessage}">
        alert("Error: ${errorMessage}");
        <% session.removeAttribute("errorMessage"); %>
        </c:if>

        // Open the password modal
        changePasswordBtn.addEventListener('click', function(e) {
            e.preventDefault();
            passwordModal.style.display = 'block';
            // Clear client-side error message
            errorMessage.style.display = 'none';
        });

        // Close the modal when cancel is clicked
        cancelPasswordBtn.addEventListener('click', function(e) {
            e.preventDefault();
            passwordModal.style.display = 'none';
            passwordForm.reset();
            errorMessage.style.display = 'none';
        });

        // Close the modal when the close button (x) is clicked
        closePasswordBtn.addEventListener('click', function(e) {
            e.preventDefault();
            passwordModal.style.display = 'none';
            passwordForm.reset();
            errorMessage.style.display = 'none';
        });

        // Validate new password and confirm password on form submission
        passwordForm.addEventListener('submit', function(e) {
            const newPassword = document.getElementById('new-password').value;
            const confirmPassword = document.getElementById('confirm-password').value;

            if (newPassword !== confirmPassword) {
                e.preventDefault();
                errorMessage.textContent = 'New password and confirm password do not match.';
                errorMessage.style.display = 'block';
                alert("Error: New password and confirm password do not match.");
            } else {
                errorMessage.style.display = 'none';
            }
        });

        // Prevent form resubmission on page refresh
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        // Close modal when clicking outside of it
        window.addEventListener('click', function(event) {
            if (event.target === passwordModal) {
                passwordModal.style.display = 'none';
                passwordForm.reset();
                errorMessage.style.display = 'none';
            }
        });

        // Automatically open modal after submission to allow further attempts
        if (serverError && serverError.classList.contains('active') ||
            serverSuccess && serverSuccess.classList.contains('active')) {
            passwordModal.style.display = 'block';
        }
    });
</script>
<script src="hashtag.js"></script>
</html>