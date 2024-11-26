<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Meeting Requests</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General styles reused from previous JSP */
        body { font-family: Arial, sans-serif; background-color: #f5f7fb; margin: 20px; padding: 20px; }
        .top-bar { display: flex; justify-content: flex-end; margin-top: 80px; }
        .button-home { background-color: #007bff; color: white; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-size: 16px; transition: background-color 0.3s ease; }
        .button-home:hover { background-color: #0056b3; }
        h2 { color: #3a3a3a; text-align: center; margin-bottom: 30px; }
        #searchInput { width: 100%; max-width: 200px; padding: 10px; margin-bottom: 20px; border: 1px solid #ccc; border-radius: 5px; outline: none; margin-left: 250px; }
        #searchInput:focus { border-color: #007bff; }
        .request-list { list-style-type: none; padding: 0; margin-left: 300px; margin-right: 20px; gap: 1.5rem; }
        .request-item { background-color: #ffffff; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 20px; position: relative; display: flex; flex-direction: column; gap: 15px; cursor: pointer; }
        .request-item:hover { outline: 1px solid rgb(185, 185, 185); border-left: 0.75rem solid #5490FF; }
        .request-header { display: flex; justify-content: space-between; }
        .request-info h3 { margin: 0; font-size: 18px; color: #333; }
        .request-info p { margin: 0; font-size: 14px; color: #888; }
        .request-content { margin-top: 10px; font-size: 16px; color: #555; }
        .request-actions { display: flex; justify-content: flex-end; gap: 10px; }
        .button { border: none; padding: 10px 0; font-size: 14px; border-radius: 5px; transition: background-color 0.3s ease; width: 100px; height: 40px; text-align: center; display: flex; align-items: center; justify-content: center; }
        .button-update { background-color: #6a5acd; color: white; }
        .button-update:hover { background-color: #5b4ab5; }
        .button-delete { background-color: #f44336; color: white; }
        .button-delete:hover { background-color: #e53935; }
        .popup-modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; }
        .popup { background-color: white; padding: 20px; border-radius: 10px; width: 400px; position: relative; }
        .popup .close-btn { position: absolute; top: 10px; right: 10px; cursor: pointer; }
        .formSection { margin-bottom: 15px; }
        .formSection label { display: block; margin-bottom: 5px; }
        .formSection input, .formSection textarea, .formSection select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .popbtns { text-align: center; margin-top: 20px; }
        .post-btn { padding: 10px 20px; background-color: #6a5acd; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .post-btn:hover { background-color: #5b4ab5; }
    </style>
</head>

<body>

<div class="top-bar">
    <a href="index.jsp" class="button-home">Go to Home</a>
</div>

<h2>My Meeting Requests</h2>

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
        <button class="close-btn" onclick="closeEditPopup()">×</button>
        <form action="UpdateMeetingRequestServlet" method="post">
            <!-- Hidden field for meeting request ID -->
            <input type="hidden" name="meetingrequestid" id="meetingrequestid" value="${meetingrequestid}" />

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

