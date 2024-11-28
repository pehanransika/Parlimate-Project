<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Meeting Requests</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
</head>

<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <div class="pageTitles">
        <h2 class="title">My Meetings</h2>
        <div class="subTitle">
            Fueling Change Through Collective Action
        </div>
    </div>
</div>
<input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">

<ul class="request-list">
    <c:forEach var="request" items="${allMeetingRequests}">
        <li class="request-item">
            <div class="request-header">
                <h3>${request.topic}</h3>
                <p>${request.proposaldate} ${request.proposaltime}</p>
            </div>
            <div class="request-content">
                <p><strong>Purpose:</strong> ${request.purposeofmeeting}</p>
                <p><strong>Opponents:</strong> ${request.opponentname}</p>
                <p><strong>Host:</strong> ${request.preferredhost}</p>
            </div>
            <div class="request-actions">
                <button
                        class="button button-update"
                        onclick="openEditPopup(
                                '${request.meetingrequestid}',
                                '${request.topic}',
                                '${fn:escapeXml(request.purposeofmeeting)}',
                                '${request.proposaldate}',
                                '${request.proposaltime}',
                                '${request.opponentname}',
                                '${request.preferredhost}')">
                    Update
                </button>
                <form action="DeleteNewMeetingRequestServlet" method="post" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="meetingrequestid" value="${request.meetingrequestid}" />
                    <button type="submit" class="button button-delete">Delete</button>
                </form>
            </div>
        </li>
    </c:forEach>
</ul>

<div class="popup-modal" id="editPopup">
    <div class="popup">
        <span>Edit Request</span>
        <button class="close-btn" onclick="closeEditPopup()"></button>
        <form action="UpdateMeetingRequestServlet" method="post" enctype="multipart/form-data">
            <!-- Hidden field for meeting request ID -->
            <input type="text" name="meetingrequestid" id="meetingrequestid" value="3" />

            <!-- Input fields for other parameters -->
            <div class="formSection">
                <label for="editTopic">Topic</label>
                <input type="text" id="editTopic" name="topic" value="${topic}" />
            </div>
            <div class="formSection">
                <label for="editPurpose">Purpose</label>
                <textarea id="editPurpose" name="purposeofmeeting">${purposeofmeeting}</textarea>
            </div>
            <div class="formSection">
                <label for="editDate">Date</label>
                <input type="date" id="editDate" name="proposaldate" value="${proposaldate}" />
            </div>
            <div class="formSection">
                <label for="editTime">Time</label>
                <input type="time" id="editTime" name="proposaltime" value="${proposaltime}" />
            </div>
            <div class="formSection">
                <label for="editOpponents">Opponents</label>
                <input type="text" id="editOpponents" name="opponentname" value="${opponentname}" />
            </div>
            <div class="formSection">
                <label for="editHost">Host</label>
                <input type="text" id="editHost" name="preferredhost" value="${preferredhost}" />
            </div>
            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>


    </div>
</div>

<script>
    function openEditPopup(
        meetingrequestid, topic, purposeofmeeting, proposaldate,
        proposaltime, opponentname, preferredhost, estimatedduration,
        discussionformat, partyaffiliation
    ) {
        // Ensure the popup is displayed
        const editPopup = document.getElementById('editPopup');
        if (editPopup) {
            editPopup.style.display = 'flex';
        } else {
            console.error("Edit popup element not found.");
            return;
        }

        // Set the meeting request ID
        const meetingRequestIdField = document.getElementById('meetingRequestId');
        if (meetingRequestIdField) {
            meetingRequestIdField.value = meetingrequestid || '';
        } else {
            console.error("Meeting Request ID field not found.");
        }

        // Set the topic
        const topicField = document.getElementById('editTopic');
        if (topicField) {
            topicField.value = topic || '';
        } else {
            console.error("Topic field not found.");
        }

        // Set the purpose of meeting
        const purposeField = document.getElementById('editPurpose');
        if (purposeField) {
            purposeField.value = purposeofmeeting || '';
        } else {
            console.error("Purpose of Meeting field not found.");
        }

        // Set the proposal date
        const dateField = document.getElementById('editDate');
        if (dateField) {
            dateField.value = proposaldate || '';
        } else {
            console.error("Proposal Date field not found.");
        }

        // Set the proposal time
        const timeField = document.getElementById('editTime');
        if (timeField) {
            timeField.value = proposaltime || '';
        } else {
            console.error("Proposal Time field not found.");
        }

        // Set the opponent name
        const opponentField = document.getElementById('editOpponents');
        if (opponentField) {
            opponentField.value = opponentname || '';
        } else {
            console.error("Opponent Name field not found.");
        }

        // Set the preferred host
        const hostField = document.getElementById('editHost');
        if (hostField) {
            hostField.value = preferredhost || '';
        } else {
            console.error("Preferred Host field not found.");
        }

        // Set the estimated duration
        const durationField = document.getElementById('editduration');
        if (durationField) {
            durationField.value = estimatedduration || '';
        } else {
            console.error("Estimated Duration field not found.");
        }

        // Optionally handle discussion format and party affiliation
        const discussionFormatField = document.getElementById('editDiscussionFormat');
        if (discussionFormatField) {
            discussionFormatField.value = discussionformat || '';
        } else {
            console.warn("Discussion Format field not found.");
        }

        const partyAffiliationField = document.getElementById('editPartyAffiliation');
        if (partyAffiliationField) {
            partyAffiliationField.value = partyaffiliation || '';
        } else {
            console.warn("Party Affiliation field not found.");
        }
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }
    function filterRequests() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const requests = document.querySelectorAll('.request-item');
        requests.forEach(req => {
            const text = req.textContent.toLowerCase();
            req.style.display = text.includes(input) ? '' : 'none';
        });
    }
</script>

</body>
</html>

