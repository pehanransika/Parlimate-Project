<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="UserPackage.UserModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        .section-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1rem;
            font-family: "Poppins", sans-serif;
            color: #1e1e1e;
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
                    <div class="p-img"></div>
                    <div class="sUser f-col">
                        <div class="name">Naleeka Kumarasinghe</div>
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
            <button onclick="window.location.href='<%= request.getContextPath() %>/admin/ProfileManagement/profileManagement.jsp'"
                    style="padding: 0.25rem 0.55rem; border: 1px solid #b8b8b8; border-radius: 0.7rem; font-size: 0.75rem; font-family: 'Poppins', sans-serif; font-weight: 500; background: transparent; color: #1e1e1e; cursor: pointer; transition: background 0.25s ease, color 0.25s ease, scale 0.25s ease;"
                    onmouseover="this.style.background='#1e1e1e'; this.style.color='white'; this.style.border='1px solid #1e1e1e';"
                    onmouseout="this.style.background='transparent'; this.style.color='#1e1e1e'; this.style.border='1px solid #b8b8b8';"
                    onmousedown="this.style.transform='scale(0.95)'"
                    onmouseup="this.style.transform='scale(1)'">Search for Full Details</button>
        </div>

        <div class="content f-col">
            <h2 class="section-title">Profile List</h2>
            <div class="profile-table-container">
                <table class="profile-table">
                    <thead>
                    <tr>
                        <th>Profile ID</th>
                        <th>Name</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="profile" items="${profilesList}">
                        <tr>
                            <td>${profile.profileId}</td>
                            <td>${profile.fullName}</td>
                            <td>
                                <form action="GetPoliticianProfileDetailsAdminServlet" method="get">
                                    <input type="hidden" name="politicianName1" value="${profile.fullName}" />
                                    <button type="submit" name="view" value="1" class="btn btn-info" style="padding: 0.25rem 0.55rem; border: 1px solid #b8b8b8; border-radius: 0.7rem; font-size: 0.75rem; font-family: 'Poppins', sans-serif; font-weight: 500; background: transparent; color: #1e1e1e; cursor: pointer; transition: background 0.25s ease, color 0.25s ease, scale 0.25s ease;"
                                            onmouseover="this.style.background='#1e1e1e'; this.style.color='white'; this.style.border='1px solid #1e1e1e';"
                                            onmouseout="this.style.background='transparent'; this.style.color='#1e1e1e'; this.style.border='1px solid #b8b8b8';"
                                            onmousedown="this.style.transform='scale(0.95)'"
                                            onmouseup="this.style.transform='scale(1)'">View</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
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