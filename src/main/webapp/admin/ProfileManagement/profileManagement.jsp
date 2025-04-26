<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/23/2025
  Time: 7:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="UserPackage.UserModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.AdminModel" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    UserModel user = (UserModel) session1.getAttribute("user");
    int userId = user.getUserId();

    AdminModel admin = new AdminModel();
    String adminName = admin.getAdminNameByUserId(userId);
%>

<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Search & Compare</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/ProfileManagement/profileManagement.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/index.css"/>
    <link
            rel="stylesheet"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
            font-family: "Satoshi", sans-serif;
            font-weight: 500;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-info {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
            font-family: "Satoshi", sans-serif;
            font-weight: 500;
        }
        .btn-info:hover {
            background-color: #0056b3;
        }
        .btn-primary {
            background-color: #2C2C2C;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
            font-family: "Satoshi", sans-serif;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #1a1a1a;
        }
        .profile-table-container {
            margin-bottom: 20px;
            width: 100%;
        }
        .profile-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .profile-table th, .profile-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .profile-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .profile-table tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<div class="navMenu f-col center">
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Home/GetAnalyticsCountServlet" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>home</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>users</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>fundraise management</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet" class="nav-item f-row">
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
                <a href="${pageContext.request.contextPath}/admin/CommentManagement/CommentManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-comments"></i>
                    <span>Comment Management</span>
                </a>
            </li>
            <%--				<li>--%>
            <%--					<a href="#" class="nav-item f-row">--%>
            <%--						<i class="fa-regular fa-circle-check"></i>--%>
            <%--						<span>requests</span>--%>
            <%--					</a>--%>
            <%--				</li>--%>
            <li>
                <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-money-bill-transfer"></i>
                    <span>bank transfer management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>Meeting Management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/GetProfileListServlet" class="nav-item f-row active">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>Profile Management</span>
                </a>
            </li>
        </ul>
        <ul>
            <li>
                <a href="#" class="f-row profile">
                    <div class="p-img"><img src="<%= request.getContextPath() %>/images/Admin/admin.png"></div>
                    <div class="sUser f-col">
                        <div class="name"><%= adminName != null ? adminName : "Unknown Admin" %></div>
                        <div class="role">Admin</div>
                    </div>
                </a>
            </li>
            <li>
                <a href="#" class="f-row log-out" onclick="logoutUser()">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    log out
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="pageContent">
    <div class="container">
        <div class="pageTitles" style="display: flex; align-items: center; gap: 1rem;">
            <h2 class="title">Search and Compare</h2>
            <div class="subTitle">
                Fueling Change Through Collective Action
            </div>
            <button onclick="window.location.href='<%= request.getContextPath() %>/GetProfileListServlet'"
                    style="padding: 0.25rem 0.55rem; border: 1px solid #b8b8b8; border-radius: 0.7rem; font-size: 0.75rem; font-family: 'Poppins', sans-serif; font-weight: 500; background: transparent; color: #1e1e1e; cursor: pointer; transition: background 0.25s ease, color 0.25s ease, scale 0.25s ease;"
                    onmouseover="this.style.background='#1e1e1e'; this.style.color='white'; this.style.border='1px solid #1e1e1e';"
                    onmouseout="this.style.background='transparent'; this.style.color='#1e1e1e'; this.style.border='1px solid #b8b8b8';"
                    onmousedown="this.style.transform='scale(0.95)'"
                    onmouseup="this.style.transform='scale(1)'">View all Profiles</button>
        </div>

        <div class="scContainer">
            <select hidden="hidden" name="role" id="roleSelect" class="roleType caps">
                <option value="politician">Politician</option>
                <option value="political-party">Political Party</option>
            </select>

            <div id="politicianSection">
                <table>
                    <form id="politicianForm" action="GetPoliticianProfileDetailsAdminServlet" method="get">
                        <tr>
                            <!-- Politician 1 -->
                            <td class="column-head f-col">
                                <div class="content f-col">
                                    <div class="search">
                                        <input
                                                type="text"
                                                name="politicianName1"
                                                placeholder="Enter Politician Name"
                                                class="search-2"
                                                id="col1-search"
                                                autocomplete="off"
                                                required
                                        />
                                        <ul id="col1-suggestions" class="suggestion-box"></ul>
                                        <label for="col1-search">
                                            <i class="fa-regular fa-magnifying-glass"></i>
                                        </label>
                                    </div>
                                    <div class="name-shown">Politician Name</div>
                                </div>
                            </td>
                        </tr>

                        <!-- Submit button row -->
                        <tr>
                            <td colspan="3" style="text-align: center; padding-top: 10px;">
                                <button type="submit" name="view" value="1" class="btn btn-info"
                                        style="padding: 0.25rem 0.55rem; border: 1px solid #b8b8b8; border-radius: 0.7rem; font-size: 0.75rem; font-family: 'Poppins', sans-serif; font-weight: 500; background: #000000; color: #ffffff; cursor: pointer; transition: background 0.25s ease, color 0.25s ease, scale 0.25s ease;"
                                        onmouseover="this.style.background='#d3d3d3'; this.style.color='#000000'; this.style.border='1px solid #b8b8b8';"
                                        onmouseout="this.style.background='#000000'; this.style.color='#ffffff'; this.style.border='1px solid #b8b8b8';"
                                        onmousedown="this.style.transform='scale(0.95)'"
                                        onmouseup="this.style.transform='scale(1)'">View Profile</button>

                                <button type="button" onclick="clearForm('politicianForm')" class="btn btn-secondary" style="padding: 0.25rem 0.55rem; border: 1px solid #b8b8b8; border-radius: 0.7rem; font-size: 0.75rem; font-family: 'Poppins', sans-serif; font-weight: 500; background: #000000; color: #ffffff; cursor: pointer; transition: background 0.25s ease, color 0.25s ease, scale 0.25s ease;"
                                        onmouseover="this.style.background='#d3d3d3'; this.style.color='#000000'; this.style.border='1px solid #b8b8b8';"
                                        onmouseout="this.style.background='#000000'; this.style.color='#ffffff'; this.style.border='1px solid #b8b8b8';"
                                        onmousedown="this.style.transform='scale(0.95)'"
                                        onmouseup="this.style.transform='scale(1)'">Clear</button>
                            </td>
                        </tr>
                    </form>

                    <form id="updatePoliticianForm" action="UpdatePolitcianDetailsServlet" method="POST" enctype="multipart/form-data">
                        <tr>
                            <td class="row-head">Photo</td>
                            <td>
                                <div class="image">
                                    <img id="imagePreview" src="<%= request.getContextPath() %>/images/${profiles1.imagePath}" alt="Photo" style="max-width: 100px; height: auto; ${profiles1.imagePath != null && profiles1.imagePath != '' ? 'display:block;' : 'display:none;'}">
                                    <br>
                                    <br>
                                    <div class="form-group">
                                        <label for="photo">Upload Image</label>
                                        <input type="file" id="photo" name="photo" accept="image/*"/>
                                    </div>
                                    <script>
                                        // Log the initial image URL
                                        console.log('Image URL:', '<%= request.getContextPath() %>/images/${profiles1.imagePath}');

                                        // Add event listener for file input change
                                        document.getElementById('photo').addEventListener('change', function(event) {
                                            const file = event.target.files[0];
                                            if (file) {
                                                const reader = new FileReader();
                                                reader.onload = function(e) {
                                                    const imgElement = document.getElementById('imagePreview');
                                                    imgElement.src = e.target.result; // Set the image source to the file's data URL
                                                    imgElement.style.display = 'block'; // Ensure the image is visible
                                                };
                                                reader.readAsDataURL(file); // Read the file as a data URL
                                            }
                                        });
                                    </script>
                                </div>
                            </td>
                        </tr>

                        <input type="hidden" name="image_path" value="${profiles1.imagePath}" />

                        <tr style="border: 0">
                            <td colspan="3">
                                <div class="select-attributes f-row">
                                    <input type="radio" name="select-attr" id="all-attr" data-target="" checked />
                                    <label for="all-attr">All</label>
                                    <input type="radio" name="select-attr" id="gen-info-attr" data-target="general-info" />
                                    <label for="gen-info-attr">General Information</label>
                                    <input type="radio" name="select-attr" id="edu-attr" data-target="educational-background" />
                                    <label for="edu-attr">Educational Background</label>
                                    <input type="radio" name="select-attr" id="prof-attr" data-target="professional-background" />
                                    <label for="prof-attr">Professional Background</label>
                                    <input type="radio" name="select-attr" id="pol-details-attr" data-target="political-details" />
                                    <label for="pol-details-attr">Political Details</label>
                                    <input type="radio" name="select-attr" id="key-attr" data-target="key-policies" />
                                    <label for="key-attr">Key Policies</label>
                                    <input type="radio" name="select-attr" id="socialmedia-attr" data-target="social-media" />
                                    <label for="socialmedia-attr">Social Media</label>
                                    <input type="radio" name="select-attr" id="election-results-attr" data-target="election-results" />
                                    <label for="election-results-attr">Latest Election Results</label>
                                </div>
                            </td>
                        </tr>

                        <div class="gen-inf detail-section">
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="general-info">General Information</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Profile ID</td>
                                <td>
                                    <span style="width: 10rem; display: inline-block;">${profiles1.profileId}</span>
                                    <input type="hidden" name="profile_id" value="${profiles1.profileId}" />
                                </td>
                            </tr>
                            <tr>
                                <td><input type="hidden" name="politician_id" value="${profiles1.politicianId}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Full Name</td>
                                <td><input type="text" name="full_name" value="${profiles1.fullName}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Age</td>
                                <td><input type="number" name="age" value="${profiles1.age}" min="18"/></td>
                            </tr>
                            <tr>
                                <td class="row-head">Gender</td>
                                <td>
                                    <label>
                                        <input type="radio" name="gender" value="Male" ${profiles1.gender == 'Male' ? 'checked' : ''}> Male
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="Female" ${profiles1.gender == 'Female' ? 'checked' : ''}> Female
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="Other" ${profiles1.gender == 'Other' ? 'checked' : ''}> Other
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Public Contact Number</td>
                                <td>
                                    <input
                                            type="tel"
                                            name="public_contact_number"
                                            value="${profiles1.publicContactNumber}"
                                            pattern="0[0-9]{9}"
                                            minlength="10"
                                            maxlength="10"
                                            title="Enter a valid 10-digit Sri Lankan phone number starting with 0"
                                    />
                                </td>
                            </tr>

                            <tr>
                                <td class="row-head">Public Email Address</td>
                                <td><input type="email" name="public_email_address" value="${profiles1.publicEmailAddress}" title="Enter a valid email address like example@example.com"/></td>
                            </tr>
                            <tr>
                                <td class="row-head">District</td>
                                <td>
                                    <select name="district" class="uniform-text-input">
                                        <option value="" ${profiles1.district == '' ? 'selected' : ''}>Select District</option>
                                        <option value="Ampara" ${profiles1.district == 'Ampara' ? 'selected' : ''}>Ampara</option>
                                        <option value="Anuradhapura" ${profiles1.district == 'Anuradhapura' ? 'selected' : ''}>Anuradhapura</option>
                                        <option value="Badulla" ${profiles1.district == 'Badulla' ? 'selected' : ''}>Badulla</option>
                                        <option value="Batticaloa" ${profiles1.district == 'Batticaloa' ? 'selected' : ''}>Batticaloa</option>
                                        <option value="Colombo" ${profiles1.district == 'Colombo' ? 'selected' : ''}>Colombo</option>
                                        <option value="Galle" ${profiles1.district == 'Galle' ? 'selected' : ''}>Galle</option>
                                        <option value="Gampaha" ${profiles1.district == 'Gampaha' ? 'selected' : ''}>Gampaha</option>
                                        <option value="Hambantota" ${profiles1.district == 'Hambantota' ? 'selected' : ''}>Hambantota</option>
                                        <option value="Jaffna" ${profiles1.district == 'Jaffna' ? 'selected' : ''}>Jaffna</option>
                                        <option value="Kalutara" ${profiles1.district == 'Kalutara' ? 'selected' : ''}>Kalutara</option>
                                        <option value="Kandy" ${profiles1.district == 'Kandy' ? 'selected' : ''}>Kandy</option>
                                        <option value="Kegalle" ${profiles1.district == 'Kegalle' ? 'selected' : ''}>Kegalle</option>
                                        <option value="Kilinochchi" ${profiles1.district == 'Kilinochchi' ? 'selected' : ''}>Kilinochchi</option>
                                        <option value="Kurunegala" ${profiles1.district == 'Kurunegala' ? 'selected' : ''}>Kurunegala</option>
                                        <option value="Mannar" ${profiles1.district == 'Mannar' ? 'selected' : ''}>Mannar</option>
                                        <option value="Matale" ${profiles1.district == 'Matale' ? 'selected' : ''}>Matale</option>
                                        <option value="Matara" ${profiles1.district == 'Matara' ? 'selected' : ''}>Matara</option>
                                        <option value="Monaragala" ${profiles1.district == 'Monaragala' ? 'selected' : ''}>Monaragala</option>
                                        <option value="Mullaitivu" ${profiles1.district == 'Mullaitivu' ? 'selected' : ''}>Mullaitivu</option>
                                        <option value="Nuwara Eliya" ${profiles1.district == 'Nuwara Eliya' ? 'selected' : ''}>Nuwara Eliya</option>
                                        <option value="Polonnaruwa" ${profiles1.district == 'Polonnaruwa' ? 'selected' : ''}>Polonnaruwa</option>
                                        <option value="Puttalam" ${profiles1.district == 'Puttalam' ? 'selected' : ''}>Puttalam</option>
                                        <option value="Ratnapura" ${profiles1.district == 'Ratnapura' ? 'selected' : ''}>Ratnapura</option>
                                        <option value="Trincomalee" ${profiles1.district == 'Trincomalee' ? 'selected' : ''}>Trincomalee</option>
                                        <option value="Vavuniya" ${profiles1.district == 'Vavuniya' ? 'selected' : ''}>Vavuniya</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="educational-background">Educational Background</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Schools Attended</td>
                                <td><input type="text" name="schools_attended" value="${profiles1.schoolsAttended}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">University</td>
                                <td><input type="text" name="university" value="${profiles1.university}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Highest Educational Qualification</td>
                                <td>
                                    <select name="highest_education_qualification" id="educationSelect" class="uniform-text-input">
                                        <option value="" ${profiles1.highestEducationQualification == '' ? 'selected' : ''}>Select Qualification</option>
                                        <option value="PhD" ${profiles1.highestEducationQualification == 'PhD' ? 'selected' : ''}>PhD</option>
                                        <option value="Master's" ${profiles1.highestEducationQualification == 'Master\'s' ? 'selected' : ''}>Master's</option>
                                        <option value="Bachelor's" ${profiles1.highestEducationQualification == 'Bachelor\'s' ? 'selected' : ''}>Bachelor's</option>
                                        <option value="Diploma" ${profiles1.highestEducationQualification == 'Diploma' ? 'selected' : ''}>Diploma</option>
                                        <option value="Certificate" ${profiles1.highestEducationQualification == 'Certificate' ? 'selected' : ''}>Certificate</option>
                                        <option value="A/L" ${profiles1.highestEducationQualification == 'A/L' ? 'selected' : ''}>A/L</option>
                                        <option value="O/L" ${profiles1.highestEducationQualification == 'O/L' ? 'selected' : ''}>O/L</option>
                                        <option value="Other" ${profiles1.highestEducationQualification != '' && profiles1.highestEducationQualification != 'PhD' && profiles1.highestEducationQualification != 'Master\'s' && profiles1.highestEducationQualification != 'Bachelor\'s' && profiles1.highestEducationQualification != 'Diploma' && profiles1.highestEducationQualification != 'Certificate' && profiles1.highestEducationQualification != 'A/L' && profiles1.highestEducationQualification != 'O/L' ? 'selected' : ''}>Other</option>
                                    </select>
                                    <input type="text"
                                           id="otherEducation"
                                           name="highest_education_qualification_other"
                                           value="${profiles1.highestEducationQualification != '' && profiles1.highestEducationQualification != 'PhD' && profiles1.highestEducationQualification != 'Master\'s' && profiles1.highestEducationQualification != 'Bachelor\'s' && profiles1.highestEducationQualification != 'Diploma' && profiles1.highestEducationQualification != 'Certificate' && profiles1.highestEducationQualification != 'A/L' && profiles1.highestEducationQualification != 'O/L' ? profiles1.highestEducationQualification : ''}"
                                           class="uniform-text-input"
                                           style="display: none; margin-top: 8px;"
                                           placeholder="Specify qualification" />
                                </td>
                            </tr>
                            <script>
                                document.getElementById('educationSelect').addEventListener('change', function() {
                                    const otherInput = document.getElementById('otherEducation');
                                    if (this.value === 'Other') {
                                        otherInput.style.display = 'block';
                                        otherInput.name = 'highest_education_qualification'; // Use the main name for submission
                                        this.name = 'highest_education_qualification_select'; // Avoid submitting select value
                                    } else {
                                        otherInput.style.display = 'none';
                                        otherInput.name = 'highest_education_qualification_other'; // Reset to avoid submission
                                        this.name = 'highest_education_qualification'; // Use select for submission
                                    }
                                });

                                // Initialize visibility and names on page load
                                window.addEventListener('load', function() {
                                    const select = document.getElementById('educationSelect');
                                    const otherInput = document.getElementById('otherEducation');
                                    if (select.value === 'Other') {
                                        otherInput.style.display = 'block';
                                        otherInput.name = 'highest_education_qualification';
                                        select.name = 'highest_education_qualification_select';
                                    } else {
                                        otherInput.style.display = 'none';
                                        otherInput.name = 'highest_education_qualification_other';
                                        select.name = 'highest_education_qualification';
                                    }
                                });
                            </script>
                            <tr>
                                <td class="row-head">Field of Study</td>
                                <td><input type="text" name="field_of_study" value="${profiles1.fieldOfStudy}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Educational Qualifications</td>
                                <td><input type="text" name="educational_qualifications" value="${profiles1.educationalQualifications}" /></td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="professional-background">Professional Background</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Profession</td>
                                <td><input type="text" name="profession" value="${profiles1.profession}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Work Experience Summary</td>
                                <td><input type="text" name="work_experience_summary" value="${profiles1.workExperienceSummary}" /></td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="political-details">Political Details</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Party</td>
                                <td><input type="text" name="party" value="${profiles1.party}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Electoral Level</td>
                                <td>
                                    <select name="electoral_level" class="uniform-text-input">
                                        <option value="" ${profiles1.electoralLevel == '' ? 'selected' : ''}>None</option>
                                        <option value="National" ${profiles1.electoralLevel == 'National' ? 'selected' : ''}>National</option>
                                        <option value="Provincial" ${profiles1.electoralLevel == 'Provincial' ? 'selected' : ''}>Provincial</option>
                                        <option value="Local" ${profiles1.electoralLevel == 'Local' ? 'selected' : ''}>Local</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Electoral Province</td>
                                <td>
                                    <select name="electoral_province" class="uniform-text-input">
                                        <option value="" ${profiles1.electoralProvince == '' ? 'selected' : ''}>Select Province</option>
                                        <option value="Central" ${profiles1.electoralProvince == 'Central' ? 'selected' : ''}>Central</option>
                                        <option value="Eastern" ${profiles1.electoralProvince == 'Eastern' ? 'selected' : ''}>Eastern</option>
                                        <option value="North Central" ${profiles1.electoralProvince == 'North Central' ? 'selected' : ''}>North Central</option>
                                        <option value="Northern" ${profiles1.electoralProvince == 'Northern' ? 'selected' : ''}>Northern</option>
                                        <option value="North Western" ${profiles1.electoralProvince == 'North Western' ? 'selected' : ''}>North Western</option>
                                        <option value="Sabaragamuwa" ${profiles1.electoralProvince == 'Sabaragamuwa' ? 'selected' : ''}>Sabaragamuwa</option>
                                        <option value="Southern" ${profiles1.electoralProvince == 'Southern' ? 'selected' : ''}>Southern</option>
                                        <option value="Uva" ${profiles1.electoralProvince == 'Uva' ? 'selected' : ''}>Uva</option>
                                        <option value="Western" ${profiles1.electoralProvince == 'Western' ? 'selected' : ''}>Western</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Electoral District</td>
                                <td>
                                    <select name="electoral_district" class="uniform-text-input">
                                        <option value="" ${profiles1.electoralDistrict == '' ? 'selected' : ''}>Select Electoral District</option>
                                        <option value="Ampara" ${profiles1.electoralDistrict == 'Ampara' ? 'selected' : ''}>Ampara</option>
                                        <option value="Anuradhapura" ${profiles1.electoralDistrict == 'Anuradhapura' ? 'selected' : ''}>Anuradhapura</option>
                                        <option value="Badulla" ${profiles1.electoralDistrict == 'Badulla' ? 'selected' : ''}>Badulla</option>
                                        <option value="Batticaloa" ${profiles1.electoralDistrict == 'Batticaloa' ? 'selected' : ''}>Batticaloa</option>
                                        <option value="Colombo" ${profiles1.electoralDistrict == 'Colombo' ? 'selected' : ''}>Colombo</option>
                                        <option value="Galle" ${profiles1.electoralDistrict == 'Galle' ? 'selected' : ''}>Galle</option>
                                        <option value="Gampaha" ${profiles1.electoralDistrict == 'Gampaha' ? 'selected' : ''}>Gampaha</option>
                                        <option value="Hambantota" ${profiles1.electoralDistrict == 'Hambantota' ? 'selected' : ''}>Hambantota</option>
                                        <option value="Jaffna" ${profiles1.electoralDistrict == 'Jaffna' ? 'selected' : ''}>Jaffna</option>
                                        <option value="Kalutara" ${profiles1.electoralDistrict == 'Kalutara' ? 'selected' : ''}>Kalutara</option>
                                        <option value="Kandy" ${profiles1.electoralDistrict == 'Kandy' ? 'selected' : ''}>Kandy</option>
                                        <option value="Kegalle" ${profiles1.electoralDistrict == 'Kegalle' ? 'selected' : ''}>Kegalle</option>
                                        <option value="Kurunegala" ${profiles1.electoralDistrict == 'Kurunegala' ? 'selected' : ''}>Kurunegala</option>
                                        <option value="Matale" ${profiles1.electoralDistrict == 'Matale' ? 'selected' : ''}>Matale</option>
                                        <option value="Matara" ${profiles1.electoralDistrict == 'Matara' ? 'selected' : ''}>Matara</option>
                                        <option value="Monaragala" ${profiles1.electoralDistrict == 'Monaragala' ? 'selected' : ''}>Monaragala</option>
                                        <option value="Nuwara Eliya" ${profiles1.electoralDistrict == 'Nuwara Eliya' ? 'selected' : ''}>Nuwara Eliya</option>
                                        <option value="Polonnaruwa" ${profiles1.electoralDistrict == 'Polonnaruwa' ? 'selected' : ''}>Polonnaruwa</option>
                                        <option value="Puttalam" ${profiles1.electoralDistrict == 'Puttalam' ? 'selected' : ''}>Puttalam</option>
                                        <option value="Ratnapura" ${profiles1.electoralDistrict == 'Ratnapura' ? 'selected' : ''}>Ratnapura</option>
                                        <option value="Trincomalee" ${profiles1.electoralDistrict == 'Trincomalee' ? 'selected' : ''}>Trincomalee</option>
                                        <option value="Vanni" ${profiles1.electoralDistrict == 'Vanni' ? 'selected' : ''}>Vanni</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Electoral Division</td>
                                <td><input type="text" name="electoral_division" value="${profiles1.electoralDivision}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Current Position</td>
                                <td><input type="text" name="current_position" value="${profiles1.currentPosition}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Current Position Held in Party</td>
                                <td><input type="text" name="current_position_in_party" value="${profiles1.currentPositionInParty}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Years Active in Politics</td>
                                <td><input type="number" name="years_active_in_politics" value="${profiles1.yearsActiveInPolitics}" min="0" /></td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="election-results">Latest Election Results</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Year</td>
                                <td>
                                    <input type="number"
                                           name="election_year"
                                           value="${profiles1.electionYear}"
                                           min="1947"
                                           max="2025"
                                           placeholder="Enter year"
                                           class="uniform-text-input"
                                           title="Year must be between 1947 and the current year"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Type of Election</td>
                                <td><input type="text" name="type_of_election" value="${profiles1.typeOfElection}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">No of Votes</td>
                                <td><input type="number" name="number_of_votes" value="${profiles1.numberOfVotes}" min="0"/></td>
                            </tr>
                            <tr>
                                <td class="row-head">Result</td>
                                <td><input type="text" name="election_result" value="${profiles1.electionResult}" /></td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="key-policies">Key Policies</div>
                                </td>
                            </tr>
                            <tr>
                            <td class="row-head"> Vision / Slogan</td>
                            <td><textarea name="vision_or_slogan">${profiles1.visionOrSlogan}</textarea></td>
                        </tr>
                            <tr>
                                <td class="row-head">Economic</td>
                                <td><textarea name="economic_policy">${profiles1.economicPolicy}</textarea></td>
                            </tr>
                            <tr>
                                <td class="row-head">Healthcare</td>
                                <td><textarea name="healthcare_policy">${profiles1.healthcarePolicy}</textarea></td>
                            </tr>
                            <tr>
                                <td class="row-head">Infrastructure</td>
                                <td><textarea name="infrastructure_policy">${profiles1.infrastructurePolicy}</textarea></td>
                            </tr>
                            <tr>
                                <td class="row-head">Education</td>
                                <td><textarea name="education_policy">${profiles1.educationPolicy}</textarea></td>
                            </tr>
                            <tr>
                                <td class="row-head">Youth Development</td>
                                <td><textarea name="youth_development_policy">${profiles1.youthDevelopmentPolicy}</textarea></td>
                            </tr>
                            <tr>
                                <td class="row-head">Agriculture</td>
                                <td><textarea name="agriculture_policy">${profiles1.agriculturePolicy}</textarea></td>
                            </tr>

                            <tr class="detail-begin row-title">
                                <td colspan="3"/>
                                    <div class="details-title" id="social-media">Social Media</div>
                                    </td>
                            </tr>
                            <tr>
                                <td class="row-head">Facebook</td>
                                <td><input type="url" name="facebook" value="${profiles1.facebook}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head"/> X </td>
                                <td><input type="url" name="x" value="${profiles1.x}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">LinkedIn</td>
                                <td><input type="url" name="linkedin" value="${profiles1.linkedin}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Instagram</td>
                                <td><input type="url" name="instagram" value="${profiles1.instagram}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head"></td>
                                <td><button type="submit" class="btn btn-primary">Submit</button></td>
                            </tr>
                        </div>
                    </form>
                </table>
            </div>

            <div id="partySection" style="display: none;">
                <table>
                    <form id="partyForm" action="GetPartyProfileDetailsServlet" method="get">
                        <tr>
                            <!-- Party 1 -->
                            <td class="column-head f-col">
                                <div class="content f-col">
                                    <div class="search">
                                        <input
                                                type="text"
                                                name="partyName1"
                                                placeholder="Enter Party Name"
                                                class="search-2"
                                                id="col1-search-party"
                                                autocomplete="off"
                                                required
                                        />
                                        <ul id="col1-suggestions-party" class="suggestion-box"></ul>
                                        <label for="col1-search-party">
                                            <i class="fa-regular fa-magnifying-glass"></i>
                                        </label>
                                    </div>
                                    <div class="name-shown">Party 1</div>
                                </div>
                            </td>
                            <!-- Party 2 -->
                            <td class="column-head f-col">
                                <div class="content f-col">
                                    <div class="search">
                                        <input
                                                type="text"
                                                name="partyName2"
                                                placeholder="Enter Party Name (optional)"
                                                class="search-2"
                                                id="col2-search-party"
                                                autocomplete="off"
                                        />
                                        <ul id="col2-suggestions-party" class="suggestion-box"></ul>
                                        <label for="col2-search-party">
                                            <i class="fa-regular fa-magnifying-glass"></i>
                                        </label>
                                    </div>
                                    <div class="name-shown">Party 2</div>
                                </div>
                            </td>
                        </tr>

                        <!-- Submit button row -->
                        <tr>
                            <td colspan="3" style="text-align: center; padding-top: 10px;">
                                <button type="submit" name="view" value="1" class="btn btn-info">View Party 1</button>
                                <button type="submit" name="view" value="2" class="btn btn-info">View Party 2</button>
                                <button type="submit" name="view" value="compare" class="btn btn-primary">Compare Parties</button>
                                <button type="button" onclick="clearForm('partyForm')" class="btn btn-secondary">Clear</button>
                            </td>
                        </tr>
                    </form>

                    <c:if test="${not empty party}">
                        <tr>
                            <td class="row-head">Logo</td>
                            <td>
                                <div class="image">
                                    <img src="<%= request.getContextPath() %>/images/${party.imagePath}" alt="Party Logo" style="max-width: 100px; height: auto; ${party.imagePath != null && party.imagePath != '' ? 'display:block;' : 'display:none;'}">
                                    <script>
                                        console.log('Image URL:', '<%= request.getContextPath() %>/images/${party.imagePath}');
                                    </script>
                                </div>
                            </td>
                        </tr>

                        <tr style="border: 0">
                            <td colspan="3">
                                <div class="select-attributes f-row">
                                    <input type="radio" name="select-attr" id="all-attr-party" data-target="" checked />
                                    <label for="all-attr-party">All</label>
                                    <input type="radio" name="select-attr" id="gen-info-attr-party" data-target="general-info-party" />
                                    <label for="gen-info-attr-party">General Information</label>
                                    <input type="radio" name="select-attr" id="pol-details-attr-party" data-target="political-details-party" />
                                    <label for="pol-details-attr-party">Political Details</label>
                                    <input type="radio" name="select-attr" id="key-attr-party" data-target="key-policies-party" />
                                    <label for="key-attr-party">Key Policies</label>
                                    <input type="radio" name="select-attr" id="socialmedia-attr-party" data-target="social-media-party" />
                                    <label for="socialmedia-attr-party">Social Media</label>
                                    <input type="radio" name="select-attr" id="election-results-attr-party" data-target="election-results-party" />
                                    <label for="election-results-attr-party">Latest Election Results</label>
                                </div>
                            </td>
                        </tr>

                        <div class="gen-inf detail-section">
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="general-info-party">General Information</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Party Name</td>
                                <td>${party.name}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Founder</td>
                                <td>${party.founder}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Founding Year</td>
                                <td>${party.foundYear}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Leader</td>
                                <td>${party.leader}</td>
                            </tr>
                            <tr>
                                <td class="row-head">General Secretary</td>
                                <td>${party.generalSecretary}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Public Contact Number</td>
                                <td>${party.publicContactNumber}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Public Email Address</td>
                                <td>${party.publicEmailAddress}</td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="political-details-party">Political Details</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Party Ideology</td>
                                <td>${party.ideology}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Coalitions</td>
                                <td>${party.coalitions}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Membership</td>
                                <td>${party.membership}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Head Office</td>
                                <td>${party.address}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Years Active in Politics</td>
                                <td>${party.yearsActiveInPolitics}</td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="election-results-party">Latest Election Results</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Seats in Parliament</td>
                                <td>${party.seatsParliament}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Year</td>
                                <td>${party.electionYear}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Type of Election</td>
                                <td>${party.typeOfElection}</td>
                            </tr>
                            <tr>
                                <td class="row-head">No of Votes</td>
                                <td>${party.numberOfVotes}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Result</td>
                                <td>${party.electionResult}</td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="key-policies-party">Policies</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Vision / Slogan</td>
                                <td>${party.visionOrSlogan}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Economic</td>
                                <td>${party.economicPolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Healthcare</td>
                                <td>${party.healthcarePolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Infrastructure</td>
                                <td>${party.infrastructurePolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Education</td>
                                <td>${party.educationPolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Youth Development</td>
                                <td>${party.youthDevelopmentPolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Agriculture</td>
                                <td>${party.agriculturePolicy}</td>
                            </tr>
                            <tr>
                                <td class="row-head">Other</td>
                                <td>-</td>
                            </tr>
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="social-media-party">Social Media</div>
                                </td>
                            </tr>
                            <tr>
                                <td class="row-head">Website</td>
                                <td><a href="${party.website}" target="_blank">${party.website}</a></td>
                            </tr>
                            <tr>
                                <td class="row-head">Facebook</td>
                                <td><a href="${party.facebook}" target="_blank">${party.facebook}</a></td>
                            </tr>
                            <tr>
                                <td class="row-head">LinkedIn</td>
                                <td><a href="${party.linkedin}" target="_blank">${party.linkedin}</a></td>
                            </tr>
                            <tr>
                                <td class="row-head">Instagram</td>
                                <td><a href="${party.instagram}" target="_blank">${party.instagram}</a></td>
                            </tr>
                        </div>
                    </c:if>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Switch between politician and party sections
    const roleSelect = document.getElementById("roleSelect");
    const politicianSection = document.getElementById("politicianSection");
    const partySection = document.getElementById("partySection");

    roleSelect.addEventListener("change", function () {
        if (this.value === "political-party") {
            politicianSection.style.display = "none";
            partySection.style.display = "block";
        } else {
            politicianSection.style.display = "block";
            partySection.style.display = "none";
        }
    });

    // Set correct view on load
    document.addEventListener("DOMContentLoaded", () => {
        roleSelect.dispatchEvent(new Event("change"));
    });

    // Function to clear all input fields in a form
    function clearForm(formId) {
        const form = document.getElementById(formId);
        if (form) {
            // Reset all input fields
            form.querySelectorAll('input').forEach(input => {
                if (input.type === 'text' || input.type === 'number' || input.type === 'tel' || input.type === 'email' || input.type === 'url') {
                    input.value = '';
                } else if (input.type === 'file') {
                    input.value = ''; // Clear file input
                } else if (input.type === 'radio') {
                    input.checked = input.id === 'all-attr' || input.id === 'all-attr-party'; // Reset to default radio
                }
            });
            // Reset select elements if any
            form.querySelectorAll('select').forEach(select => {
                select.selectedIndex = 0;
            });
            // Clear image preview if applicable
            const img = form.querySelector('img');
            if (img) {
                img.src = '';
                img.style.display = 'none';
            }
        }
    }

    // Auto-suggest for politicians
    function setupAutoSuggest(inputId, suggestionBoxId, formId) {
        const input = document.getElementById(inputId);
        const suggestionBox = document.getElementById(suggestionBoxId);
        const form = document.getElementById(formId);

        input.addEventListener("input", function () {
            const query = input.value.trim();

            if (query.length === 0) {
                suggestionBox.innerHTML = "";
                return;
            }

            fetch("NameSuggestionsServlet?query=" + encodeURIComponent(query))
                .then(response => response.text())
                .then(text => {
                    const names = text.trim().split("\n");
                    suggestionBox.innerHTML = "";
                    names.forEach(name => {
                        const option = document.createElement("div");
                        option.className = "suggestion-item";
                        option.textContent = name;
                        option.onclick = function () {
                            input.value = name;
                            suggestionBox.innerHTML = "";
                            // Programmatically submit the form
                            if (form) {
                                form.submit();
                            }
                        };
                        suggestionBox.appendChild(option);
                    });
                })
                .catch(err => {
                    console.error("Error fetching suggestions:", err);
                });
        });

        // Hide suggestions when clicking outside
        document.addEventListener("click", function (e) {
            if (!suggestionBox.contains(e.target) && e.target !== input) {
                suggestionBox.innerHTML = "";
            }
        });
    }

    // Auto-suggest for parties
    function setupAutoSuggestParty(inputId, suggestionBoxId, formId) {
        const input = document.getElementById(inputId);
        const suggestionBox = document.getElementById(suggestionBoxId);
        const form = document.getElementById(formId);

        input.addEventListener("input", function () {
            const query = input.value.trim();

            if (query.length === 0) {
                suggestionBox.innerHTML = "";
                return;
            }

            fetch("PartySearchServlet?query=" + encodeURIComponent(query))
                .then(response => response.text())
                .then(text => {
                    const names = text.trim().split("\n");
                    suggestionBox.innerHTML = "";
                    names.forEach(name => {
                        const option = document.createElement("div");
                        option.className = "suggestion-item-Party";
                        option.textContent = name;
                        option.onclick = function () {
                            input.value = name;
                            suggestionBox.innerHTML = "";
                            // Programmatically submit the form
                            if (form) {
                                form.submit();
                            }
                        };
                        suggestionBox.appendChild(option);
                    });
                })
                .catch(err => {
                    console.error("Error fetching suggestions:", err);
                });
        });

        // Hide suggestions when clicking outside
        document.addEventListener("click", function (e) {
            if (!suggestionBox.contains(e.target) && e.target !== input) {
                suggestionBox.innerHTML = "";
            }
        });
    }

    // Initialize auto-suggest for both input fields
    setupAutoSuggest("col1-search", "col1-suggestions", "politicianForm");
    setupAutoSuggestParty("col1-search-party", "col1-suggestions-party", "partyForm");
    setupAutoSuggestParty("col2-search-party", "col2-suggestions-party", "partyForm");

    // Handle radio button scrolling
    document.querySelectorAll('input[name="select-attr"]').forEach(radio => {
        radio.addEventListener('change', () => {
            const targetId = radio.getAttribute('data-target');
            if (targetId) {
                const section = document.getElementById(targetId);
                if (section) {
                    const yOffset = -70; // Adjust based on header height
                    const y = section.getBoundingClientRect().top + window.pageYOffset + yOffset;
                    window.scrollTo({ top: y, behavior: 'smooth' });
                }
            } else {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });
    });
</script>
</body>
</html>