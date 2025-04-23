<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/23/2025
  Time: 7:33 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="UserPackage.UserModel" %>

<%
    HttpSession session1 = request.getSession(false); // Don't create a new session if one doesn't exist
    if (session1 == null || session1.getAttribute("user") == null) {
        // User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }

    // Session exists and user is logged in
    UserModel user = (UserModel) session1.getAttribute("user");
    int userId = user.getUserId();

    // You can now use this userId as needed
%>

<% response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Search & Compare</title>

    <link rel="stylesheet" href="profileManagement.css" />
    <link rel="stylesheet" href="index/sidebar1.css" />
    <link rel="stylesheet" href="index/header/header.css" />
    <link rel="stylesheet" href="../index.css"/>
    <link href="http://localhost:8080/Parlimate/index/sidebar1.css" rel="stylesheet" />
    <link href="http://localhost:8080/Parlimate/index/header/header.css" rel="stylesheet" />

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
</head>
<body>
<div class="navMenu f-col center">
    <div class="logo">
        <img src="<%= request.getContextPath() %>/admin/assets/logo.png" alt="Parlimate" id="logo" />
    </div>
    <div class="navigation">
        <ul>
            <li>
                <a href="<%= request.getContextPath() %>/admin/Home/index.jsp" class="nav-item f-row">
                    <i class="fa-regular fa-house"></i>
                    <span>Home</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/admin/userManagement/UserManagementServlet" class="nav-item f-row">
                    <i class="fa-regular fa-users"></i>
                    <span>User Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-briefcase"></i>
                    <span>Fundraise Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-check-to-slot"></i>
                    <span>Survey Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-cards-blank"></i>
                    <span>Post Management</span>
                </a>
            </li>
            <li>
                <a href="<%= request.getContextPath() %>/meetingManagement/meetingManagement.jsp" class="nav-item f-row active">
                    <i class="fa-regular fa-circle-check"></i>
                    <span>Meeting Management</span>
                </a>
            </li>
            <li>
                <a href="#" class="nav-item f-row">
                    <i class="fa-regular fa-sliders-up"></i>
                    <span>Platform Settings</span>
                </a>
            </li>
        </ul>
        <ul>
            <li>
                <a href="#" class="f-row profile">
                    <div class="p-img"></div>
                    <div class="sUser f-col">
                        <div class="name"><%= user.getEmail() %></div>
                        <div class="role">Admin</div>
                    </div>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="f-row log-out">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Log out
                </a>
            </li>
        </ul>
    </div>
</div>

<div class="pageContent">
    <div class="container">
        <div class="pageTitles">
            <h2 class="title">Search and Compare</h2>
            <div class="subTitle">
                Fueling Change Through Collective Action
            </div>
        </div>
        <div class="scContainer">
            <select name="role" id="roleSelect" class="roleType caps">
                <option value="politician">Politician</option>
                <option value="political-party">Political Party</option>
            </select>

            <div id="politicianSection">
                <table>
                    <form action="GetPoliticianProfileDetailsAdminServlet" method="get">
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
                                    <%--              <div class="image">--%>
                                    <%--                <!-- Displaying Image 1 -->--%>
                                    <%--                <c:forEach var="politician" items="${profiles}">--%>
                                    <%--                  <img--%>
                                    <%--                          id="img1"--%>
                                    <%--                          src="../images/${politician.imagePath != null && politician.imagePath.split(',')[0] != '' ? politician.imagePath.split(',')[0] : ''}"--%>
                                    <%--                          style="max-width: 100px; ${politician.imagePath != null && politician.imagePath.split(',')[0] != '' ? 'display:block;' : 'display:none;'}"--%>
                                    <%--                  />--%>
                                    <%--                </c:forEach>--%>
                                    <%--              </div>--%>
                                    <div class="name-shown">Politician 1</div>
                                </div>
                            </td>

                            <!-- Submit button row -->
                        <tr>
                            <td colspan="3" style="text-align: center; padding-top: 10px;">
                                <button type="submit" name="view" value="1" class="btn btn-info">View Profile 1</button>
                            </td>
                        </tr>
                    </form>

                    <form action="UpdatePolitcianDetailsServlet" method="POST" >
                        <tr>
                            <td class="row-head">Photo</td>
                            <!-- Assuming 'politician' is the object holding the single politician profile -->
                            <td>
                                <div class="image">
                                    <!-- Check if the politician has an image path and display it -->
                                    <img src="<%= request.getContextPath() %>/images/${profiles1.imagePath}" alt="Photo" style="max-width: 100px; height: auto;">
                                    <br>
                                    <br>
                                    <label style="display: inline-block; padding: 8px 16px; background-color: #007bff; color: white; border-radius: 4px; cursor: pointer;">
                                        Upload Image
                                        <input type="file" name="photo" accept="image/*" style="display: none;" />
                                    </label>
                                    <script>
                                        // Log the image URL to the console to test
                                        console.log('Image URL:', '<%= request.getContextPath() %>/images/${profiles1.imagePath}');
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

                        <!-- from here we will update details :) -->
                        <div class="gen-inf detail-section">
                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="general-info">General Information</div>
                                </td>
                            </tr>

                            <tr>
                                <td class="row-head">Profile ID</td>
                                <td><input type="text" name="profile_id" value="${profiles1.profileId}" /></td>
                            </tr>
                            <tr>
                                <td><input name="politician_id" value="${profiles1.politicianId}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">Full Name</td>
                                <td><input type="text" name="full_name" value="${profiles1.fullName}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Age</td>
                                <td><input type="number" name="age" value="${profiles1.age}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Gender</td>
                                <td><input type="text" name="gender" value="${profiles1.gender}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Public Contact Number</td>
                                <td><input type="tel" name="public_contact_number" value="${profiles1.publicContactNumber}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Public Email Address</td>
                                <td><input type="email" name="public_email_address" value="${profiles1.publicEmailAddress}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">District</td>
                                <td><input type="text" name="district" value="${profiles1.district}" /></td>
                            </tr>

                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="educational-background">Background</div>
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
                                <td><input type="text" name="highest_education_qualification" value="${profiles1.highestEducationQualification}" /></td>
                            </tr>

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
                                <td><input type="text" name="electoral_level" value="${profiles1.electoralLevel}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Electoral Province</td>
                                <td><input type="text" name="electoral_province" value="${profiles1.electoralProvince}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Electoral District</td>
                                <td><input type="text" name="electoral_district" value="${profiles1.electoralDistrict}" /></td>
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
                                <td><input type="number" name="years_active_in_politics" value="${profiles1.yearsActiveInPolitics}" /></td>
                            </tr>

                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="election-results">Latest Election Results</div>
                                </td>
                            </tr>

                            <tr>
                                <td class="row-head">Year</td>
                                <td><input type="text" name="election_year" value="${profiles1.electionYear}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Type of Election</td>
                                <td><input type="text" name="type_of_election" value="${profiles1.typeOfElection}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">No of Votes</td>
                                <td><input type="number" name="number_of_votes" value="${profiles1.numberOfVotes}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Result</td>
                                <td><input type="text" name="election_result" value="${profiles1.electionResult}" /></td>
                            </tr>

                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="key-policies">Policies</div>
                                </td>
                            </tr>

                            <tr>
                                <td class="row-head">Vision / Slogan</td>
                                <td><input type="text" name="vision_or_slogan" value="${profiles1.visionOrSlogan}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Economic</td>
                                <td><input type="text" name="economic_policy" value="${profiles1.economicPolicy}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Healthcare</td>
                                <td><input type="text" name="healthcare_policy" value="${profiles1.healthcarePolicy}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Infrastructure</td>
                                <td><input type="text" name="infrastructure_policy" value="${profiles1.infrastructurePolicy}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Education</td>
                                <td><input type="text" name="education_policy" value="${profiles1.educationPolicy}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Youth Development</td>
                                <td><input type="text" name="youth_development_policy" value="${profiles1.youthDevelopmentPolicy}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">Agriculture</td>
                                <td><input type="text" name="agriculture_policy" value="${profiles1.agriculturePolicy}" /></td>
                            </tr>

                            <tr class="detail-begin row-title">
                                <td colspan="3">
                                    <div class="details-title" id="social-media">Social Media</div>
                                </td>
                            </tr>

                            <tr>
                                <td class="row-head">Facebook</td>
                                <td><input type="url" name="facebook" value="${profiles1.facebook}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">X</td>
                                <td><input type="url" name="x" value="${profiles1.x}" /></td>
                            </tr>

                            <tr>
                                <td class="row-head">LinkedIn</td>
                                <td><input type="url" name="linkedin" value="${profiles1.linkedin}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">LinkedIn</td>
                                <td><input type="url" name="instagram" value="${profiles1.instagram}" /></td>
                            </tr>
                            <tr>
                                <td class="row-head">LinkedIn</td>
                                <td><button type="submit">Submit</button></td>
                            </tr>
                        </div>
                    </form>
                </table>
            </div>



            <div id="partySection" style="display: none;">
                <table>
                    <form action="GetPartyProfileDetailsServlet" method="get">
                        <tr>
                            <!-- Politician 1 -->
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
                                    <%--              <div class="image">--%>
                                    <%--                <!-- Displaying Image 1 -->--%>
                                    <%--                <c:forEach var="politician" items="${profiles}">--%>
                                    <%--                  <img--%>
                                    <%--                          id="img1"--%>
                                    <%--                          src="../images/${politician.imagePath != null && politician.imagePath.split(',')[0] != '' ? politician.imagePath.split(',')[0] : ''}"--%>
                                    <%--                          style="max-width: 100px; ${politician.imagePath != null && politician.imagePath.split(',')[0] != '' ? 'display:block;' : 'display:none;'}"--%>
                                    <%--                  />--%>
                                    <%--                </c:forEach>--%>
                                    <%--              </div>--%>
                                    <div class="name-shown">Party 1</div>
                                </div>
                            </td>

                            <!-- Politician 2 -->
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
                                    <%--              <div class="image">--%>
                                    <%--                <!-- Displaying Image 2 -->--%>
                                    <%--                <c:forEach var="politician" items="${profiles}">--%>
                                    <%--                  <img--%>
                                    <%--                          id="img2"--%>
                                    <%--                          src="../images/${politician.imagePath != null && politician.imagePath.split(',')[1] != '' ? politician.imagePath.split(',')[1] : ''}"--%>
                                    <%--                          style="max-width: 100px; ${politician.imagePath != null && politician.imagePath.split(',')[1] != '' ? 'display:block;' : 'display:none;'}"--%>
                                    <%--                  />--%>
                                    <%--                </c:forEach>--%>
                                    <%--              </div>--%>
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
                            </td>
                        </tr>
                    </form>

                    <tr>
                        <td class="row-head">Logo</td>
                        <c:forEach var="party" items="${party}">
                            <td>
                                <div class="image">
                                    <!-- Check if the politician has an image path and display it -->
                                    <img src="../images/${party.imagePath}" alt="Photo" style="max-width: 100px; height: auto;">
                                    <script>
                                        // Log the image URL to the console to test
                                        console.log('Image URL:', '../image${party.imagePath}');
                                    </script>
                                </div>
                            </td>
                        </c:forEach>
                    </tr>

                    <tr style="border: 0">
                        <td colspan="3">
                            <div class="select-attributes f-row">
                                <input type="radio" name="select-attr" id="all-attr-party" data-target="" checked />
                                <label for="all-attr">All</label>

                                <input type="radio" name="select-attr" id="gen-info-attr-party" data-target="general-info" />
                                <label for="gen-info-attr">General Information</label>


                                <input type="radio" name="select-attr" id="pol-details-attr-party" data-target="political-details" />
                                <label for="pol-details-attr">Political Details</label>

                                <input type="radio" name="select-attr" id="key-attr-party" data-target="key-policies" />
                                <label for="key-attr">Key Policies</label>

                                <input type="radio" name="select-attr" id="socialmedia-attr-party" data-target="social-media" />
                                <label for="socialmedia-attr">Social Media</label>

                                <input type="radio" name="select-attr" id="election-results-attr-party" data-target="election-results" />
                                <label for="election-results-attr">Latest Election Results</label>
                            </div>
                        </td>
                    </tr>

                    <!-- from here we will update details :) -->
                    <div class="gen-inf detail-section">
                        <tr class="detail-begin row-title">
                            <td colspan="3">
                                <div class="details-title" id="general-info-party">General Information</div>
                            </td>
                        </tr>

                        <tr>
                            <td class="row-head">Party Name</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.name}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Founder</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.founder}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Founding Year</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.foundYear}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Leader</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.leader}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">General Secretary</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.generalSecretary}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Public Contact Number</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.publicContactNumber}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Public Email Address</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.publicEmailAddress}</td>
                            </c:forEach>
                        </tr>


                        <tr class="detail-begin row-title">
                            <td colspan="3">
                                <div class="details-title" id="political-details-party">Political Details</div>
                            </td>
                        </tr>

                        <tr>
                            <td class="row-head">Party Ideology</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.ideology}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Coalitions</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.coalitions}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Membership</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.membership}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Head Office</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.address}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Years active in Politics</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.yearsActiveInPolitics}</td>
                            </c:forEach>
                        </tr>

                        <tr class="detail-begin row-title">
                            <td colspan="3">
                                <div class="details-title" id="election-results-party">Latest Election Results</div>
                            </td>
                        </tr>

                        <tr>
                            <td class="row-head">Seats in Parliament</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.seatsParliament}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Year</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.electionYear}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Type of Election</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.typeOfElection}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">No of Votes</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.numberOfVotes}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Result</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.electionResult}</td>
                            </c:forEach>
                        </tr>

                        <tr class="detail-begin row-title">
                            <td colspan="3">
                                <div class="details-title" id="key-policies-party">Policies</div>
                            </td>
                        </tr>

                        <tr>
                            <td class="row-head">Vision / Slogan </td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.visionOrSlogan}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Economic</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.economicPolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">healthcare</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.healthcarePolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Infrastructure</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.infrastructurePolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Education</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.educationPolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Youth Development</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.youthDevelopmentPolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Agriculture</td>
                            <c:forEach var="party" items="${party}">
                                <td>${party.agriculturePolicy}</td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Other</td>
                            <td>-</td>
                            <td>-</td>
                        </tr>

                        <tr class="detail-begin row-title">
                            <td colspan="3">
                                <div class="details-title" id="social-media-party">Social Media</div>
                            </td>
                        </tr>

                        <tr>
                            <td class="row-head">Website</td>
                            <c:forEach var="party" items="${party}">
                                <td>
                                    <a href="${party.website}" target="_blank">${party.website}</a>
                                </td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Facebook</td>
                            <c:forEach var="party" items="${party}">
                                <td>
                                    <a href="${party.facebook}" target="_blank">${party.facebook}</a>
                                </td>
                            </c:forEach>
                        </tr>

                        <%--          <tr>--%>
                        <%--            <td class="row-head">X</td>--%>
                        <%--            <c:forEach var="party" items="${party}">--%>
                        <%--              <td>--%>
                        <%--                <a href="${party.xLink}" target="_blank">${party.xLink}</a>--%>
                        <%--              </td>--%>
                        <%--            </c:forEach>--%>
                        <%--          </tr>--%>

                        <tr>
                            <td class="row-head">LinkedIn</td>
                            <c:forEach var="party" items="${party}">
                                <td>
                                    <a href="${party.linkedin}" target="_blank">${party.linkedin}</a>
                                </td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <td class="row-head">Instagram</td>
                            <c:forEach var="party" items="${party}">
                                <td>
                                    <a href="${party.instagram}" target="_blank">${party.instagram}</a>
                                </td>
                            </c:forEach>
                        </tr>

                    </div>
                </table>
            </div>
        </div>
    </div>
</div>
</body>

<script src="http://localhost:8080/Parlimate/script.js"></script>

<script>
    // document.addEventListener("DOMContentLoaded", function () {
    //     const fileInput = document.getElementById("imageUploadInput");
    //     const imagePathInput = document.querySelector("input[name='image_path']");
    //
    //     fileInput.addEventListener("change", function () {
    //         if (fileInput.files.length > 0) {
    //             const fileName = fileInput.files[0].name;
    //             // Set the new relative path, same format as what the backend saves
    //             imagePathInput.value = "/Politician/" + fileName;
    //         }
    //     });
    // });
    // Sample politician data (replace with your actual data source)
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

    // Optional: Set correct view on load
    document.addEventListener("DOMContentLoaded", () => {
        roleSelect.dispatchEvent(new Event("change"));
    });


    const searchInput = document.getElementById("col1-search");
    const suggestionsContainer = document.getElementById("suggestions");

    const searchInputParty = document.getElementById("col1-search-party");
    const suggestionsContainerParty = document.getElementById("col1-suggestions-party")

    searchInput.addEventListener("input", function () {
        const searchTerm = this.value.toLowerCase();
        suggestionsContainer.innerHTML = "";

        if (searchTerm.length < 1) {
            suggestionsContainer.style.display = "none";
            return;
        }

        const filteredPoliticians = politicians.filter(
            (politician) =>
                politician.name.toLowerCase().includes(searchTerm) ||
                politician.party.toLowerCase().includes(searchTerm)
        );

        if (filteredPoliticians.length > 0) {
            filteredPoliticians.forEach((politician) => {
                const suggestionItem = document.createElement("div");
                suggestionItem.className = "suggestion-item";
                suggestionItem.innerHTML = `
      <img src="https://i.pravatar.cc/50" alt="${politician.name}">
      <div>
        <div class="politician-name">${politician.name}</div>
        <div class="politician-party">${politician.party}</div>
      </div>
    `;
                suggestionItem.addEventListener("click", () => {
                    searchInput.value = politician.name;
                    suggestionsContainer.style.display = "none";
                    // You can trigger search or selection action here
                });
                suggestionsContainer.appendChild(suggestionItem);
            });
            suggestionsContainer.style.display = "block";
        } else {
            suggestionsContainer.style.display = "none";
        }
    });

    searchInputParty.addEventListener("input", function () {
        const searchTermParty = this.value.toLowerCase();
        suggestionsContainerParty.innerHTML = "";

        if (searchTermParty.length < 1) {
            suggestionsContainerParty.style.display = "none";
            return;
        }

        const filteredParties = party.filter(
            (politician) =>
                party.name.toLowerCase().includes(searchTerm) ||
                party.party.toLowerCase().includes(searchTerm)
        );

        if (filteredParties.length > 0) {
            filteredParties.forEach((party) => {
                const suggestionItemParty = document.createElement("div");
                suggestionItemParty.className = "suggestion-item-Party";
                suggestionItemParty.innerHTML = `
      <img src="https://i.pravatar.cc/50" alt="${party.name}">
      <div>
        <div class="politician-name">${party.name}</div>
        <div class="politician-party">${party.party}</div>
      </div>
    `;
                suggestionItemParty.addEventListener("click", () => {
                    searchInputParty.value = party.name;
                    suggestionsContainerParty.style.display = "none";
                    // You can trigger search or selection action here
                });
                suggestionsContainerParty.appendChild(suggestionItemParty);
            });
            suggestionsContainerParty.style.display = "block";
        } else {
            suggestionsContainerParty.style.display = "none";
        }
    });

    // Close suggestions when clicking outside
    document.addEventListener("click", function (e) {
        if (
            !searchInput.contains(e.target) &&
            !suggestionsContainer.contains(e.target)
        ) {
            suggestionsContainer.style.display = "none";
        }
    });

    document.addEventListener("click", function (e) {
        if (
            !searchInputParty.contains(e.target) &&
            !suggestionsContainerParty.contains(e.target)
        ) {
            suggestionsContainerParty.style.display = "none";
        }
    });

    document.querySelectorAll('input[name="select-attr"]').forEach(radio => {
        radio.addEventListener('change', () => {
            const targetId = radio.getAttribute('data-target');
            if (targetId) {
                const section = document.getElementById(targetId);
                if (section) {
                    const yOffset = -70; // adjust based on your header height
                    const y = section.getBoundingClientRect().top + window.pageYOffset + yOffset;
                    window.scrollTo({ top: y, behavior: 'smooth' });

                }
            } else {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });
    });

    function setupAutoSuggest(inputId, suggestionBoxId) {
        const input = document.getElementById(inputId);
        const suggestionBox = document.getElementById(suggestionBoxId);

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
                        };
                        suggestionBox.appendChild(option);
                    });
                })
                .catch(err => {
                    console.error("Error fetching suggestions:", err);
                });
        });

        // Optional: hide suggestions when clicking outside
        document.addEventListener("click", function (e) {
            if (!suggestionBox.contains(e.target) && e.target !== input) {
                suggestionBox.innerHTML = "";
            }
        });
    }

    function setupAutoSuggestParty(inputId, suggestionBoxId) {
        const inputParty = document.getElementById(inputId);
        const suggestionBoxParty = document.getElementById(suggestionBoxId);

        input.addEventListener("inputParty", function () {
            const query = inputParty.value.trim();

            if (query.length === 0) {
                suggestionBoxParty.innerHTML = "";
                return;
            }

            fetch("PartySearchServlet?query=" + encodeURIComponent(query))
                .then(response => response.text())
                .then(text => {
                    const names = text.trim().split("\n");
                    suggestionBoxParty.innerHTML = "";
                    names.forEach(name => {
                        const option = document.createElement("div");
                        option.className = "suggestion-item-Party";
                        option.textContent = name;
                        option.onclick = function () {
                            inputParty.value = name;
                            suggestionBoxParty.innerHTML = "";
                        };
                        suggestionBoxParty.appendChild(option);
                    });
                })
                .catch(err => {
                    console.error("Error fetching suggestions:", err);
                });
        });

        // Optional: hide suggestions when clicking outside
        document.addEventListener("click", function (e) {
            if (!suggestionBoxParty.contains(e.target) && e.target !== input) {
                suggestionBoxParty.innerHTML = "";
            }
        });
    }

    // Initialize for both input fields
    setupAutoSuggest("col1-search", "col1-suggestions");
    setupAutoSuggest("col1-search-party", "col1-suggestions-party");
    setupAutoSuggest("col2-search-party", "col2-suggestions-party");

</script>

<body>

</body>
</html>