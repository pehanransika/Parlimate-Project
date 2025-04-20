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
    <link rel="stylesheet" href="./editPublicDetails/editPoliticianPublicDetails.css">

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

        <div class="edit-buttons-wrapper">
            <c:if test="${not empty user && user.userType eq 'Politician'}">
                <div class="container">
                    <button id="open-details-popup">edit details</button>
                </div>
            </c:if>
            <a href="./editProfile/edit.jsp" class="btn edit-btn capitalize row">
                <i class="fa-solid fa-pen-to-square"></i>&nbsp;Edit Profile
            </a>
        </div>


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
<div class="modal">
    <div class="details-modal">
        <div class="top f-row">
            <div class="title caps">personal details</div>
            <button id="close-modal">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <div class="center f-col">
            <div class="detail-group f-col">
                <div class="details f-col">
                    <table class="detail" id="political-detail-table">
                        <tr class="title caps">
                            <td colspan="2">political</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                    <table class="detail" id="latest-elec-table">
                        <tr class="title caps">
                            <td colspan="2">latest election</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                    <table class="detail" id="policy-table">
                        <tr class="title caps">
                            <td colspan="2">policies</td>
                        </tr>
                        <tr>
                            <td class="label">party</td>
                            <td class="value">progressive party</td>
                        </tr>
                        <tr>
                            <td class="label">electorial level</td>
                            <td class="value">1</td>
                        </tr>
                        <tr>
                            <td class="label">electorial province</td>
                            <td class="value">western province</td>
                        </tr>
                        <tr>
                            <td class="label">current position</td>
                            <td class="value">parliment minister</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="footer f-row">
            <div class="edit caps">
                <button id="edit-btn">edit</button>
            </div>
            <div class="action f-row">
                <button id="cancel-btn">cancel</button>
                <button id="save-btn">save</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // Get DOM elements
        const modal = document.querySelector('.modal');
        const openPopupBtn = document.getElementById('open-details-popup');
        const closeModalBtn = document.getElementById('close-modal');
        const editBtn = document.getElementById('edit-btn');
        const cancelBtn = document.getElementById('cancel-btn');
        const saveBtn = document.getElementById('save-btn');
        const actionDiv = document.querySelector('.action');

        // Political data options
        const politicalData = {
            parties: ['Progressive Party', 'Conservative Alliance', 'Liberal Democrats', 'Green Movement', 'Socialist Front'],
            electoralLevels: ['1 - National', '2 - Regional', '3 - District', '4 - Local'],
            electoralProvinces: ['Western Province', 'Eastern Province', 'Northern Territory', 'Southern Region', 'Central District'],
            positions: ['Parliament Minister', 'Party Leader', 'Opposition Member', 'Committee Chair', 'Backbencher']
        };

        // Store original values
        let originalValues = {};

        // Open modal when edit details button is clicked
        openPopupBtn.addEventListener('click', function() {
            modal.style.display = 'flex';
            resetToViewMode();
        });

        // Close modal when X is clicked
        closeModalBtn.addEventListener('click', function() {
            modal.style.display = 'none';
            // Reset to non-edit mode when closing
            resetToViewMode();
        });

        // Edit button functionality
        editBtn.addEventListener('click', function() {
            enterEditMode();
        });

        // Cancel button functionality
        cancelBtn.addEventListener('click', function() {
            resetToViewMode();
        });

        // Save button functionality
        saveBtn.addEventListener('click', function() {
            saveChanges();
        });

        // Close modal when clicking outside the modal content
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                modal.style.display = 'none';
                resetToViewMode();
            }
        });

        function enterEditMode() {
            // Hide edit button and show action buttons
            editBtn.style.display = 'none';
            actionDiv.style.display = 'flex';

            // Convert all value cells to dropdowns and store original values
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                // Store original value
                originalValues[`cell${index}`] = cell.textContent.trim();

                // Get the label from previous cell to determine what dropdown to show
                const label = cell.previousElementSibling.textContent.trim().toLowerCase();

                // Create select element
                const select = document.createElement('select');

                // Populate options based on label
                if (label.includes('party')) {
                    politicalData.parties.forEach(party => {
                        const option = document.createElement('option');
                        option.value = party;
                        option.textContent = party;
                        option.selected = (party.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }
                else if (label.includes('level')) {
                    politicalData.electoralLevels.forEach(level => {
                        const option = document.createElement('option');
                        option.value = level;
                        option.textContent = level;
                        option.selected = (level.includes(cell.textContent.trim()));
                        select.appendChild(option);
                    });
                }
                else if (label.includes('province')) {
                    politicalData.electoralProvinces.forEach(province => {
                        const option = document.createElement('option');
                        option.value = province;
                        option.textContent = province;
                        option.selected = (province.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }
                else if (label.includes('position')) {
                    politicalData.positions.forEach(position => {
                        const option = document.createElement('option');
                        option.value = position;
                        option.textContent = position;
                        option.selected = (position.toLowerCase() === cell.textContent.trim().toLowerCase());
                        select.appendChild(option);
                    });
                }

                // Replace cell content with select
                cell.textContent = '';
                cell.appendChild(select);
            });
        }

        function resetToViewMode() {
            // Show edit button and hide action buttons
            editBtn.style.display = 'block';
            actionDiv.style.display = 'none';

            // Revert all changes back to original values
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                // Remove any select elements
                if (cell.querySelector('select')) {
                    cell.removeChild(cell.querySelector('select'));
                }
                // Restore original value
                cell.textContent = originalValues[`cell${index}`] || cell.textContent;
            });
        }

        function saveChanges() {
            // Update all values from dropdowns
            const valueCells = document.querySelectorAll('td.value');
            valueCells.forEach((cell, index) => {
                if (cell.querySelector('select')) {
                    const select = cell.querySelector('select');
                    // Update the originalValues with the new selected value
                    originalValues[`cell${index}`] = select.value;
                    // Update the cell content
                    cell.textContent = select.value;
                }
            });

            // Now reset to view mode
            resetToViewMode();

            // Here you would typically send the updated data to your server
            console.log("Saved changes:", originalValues);
        }
    });
</script>
</body>
<script src="../script.js"></script>

</html>
