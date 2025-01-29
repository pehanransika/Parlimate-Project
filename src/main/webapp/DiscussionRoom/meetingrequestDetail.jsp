<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Meeting Requests</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./discussion-room.css" />
    <link rel="stylesheet" href="./reqPop.css" />
    <link rel="stylesheet" href="../postDetails.css" />
    <link href="../index/sidebar1.css" rel="stylesheet" />
    <link href="../index/header/header.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .top-bar { display: flex; justify-content: flex-end; margin-top: 80px; }
        .button-home { background-color: #007bff; color: white; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-size: 16px; transition: background-color 0.3s ease; }
        .button-home:hover { background-color: #0056b3; }
        .request-item { background-color: #ffffff; margin-bottom: 20px; border-radius: 10px; padding: 20px; position: relative; display: flex; flex-direction: column; gap: 15px; cursor: pointer; border-left: 0.75rem solid #75a8ec; transition: 0.25s ease;
        }
        .request-item:hover { outline: 1px solid rgb(185, 185, 185); border-left: 0.75rem solid #5490FF; }
        .request-header { display: flex; justify-content: space-between; }
        .request-info h3 { margin: 0; font-size: 18px; color: #333; }
        .request-info p { margin: 0; font-size: 14px; color: #888; }
        .request-content { margin-top: 10px; font-size: 16px; color: #555; }
        .request-actions { display: flex; justify-content: flex-end; gap: 10px; }
        .button { border: none; padding: 10px 0; font-size: 14px; border-radius: 5px; transition: background-color 0.3s ease; width: 100px; height: 40px; text-align: center; display: flex; align-items: center; justify-content: center; }
        .popup-modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; }
        .popup { background-color: white; padding: 20px; border-radius: 10px; width: 400px; position: relative; }
        .popup .close-btn { position: absolute; top: 10px; right: 10px; cursor: pointer; }
        .formSection { margin-bottom: 15px; }
        .formSection label { display: block; margin-bottom: 5px; }
        .formSection input, .formSection textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .popbtns { text-align: center; margin-top: 20px; }
        .post-btn { padding: 10px 20px; background-color: #6a5acd; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .post-btn:hover { background-color: #5b4ab5; }
    </style>
</head>

<body>
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<div class="container">
    <div class="pageTitles">
        <h2 class="title">My meeting requests</h2>
        <div class="subTitle">Your pending meeting requests</div>
    </div>

    <div class="search">
        <label for="searchInput" class="icon">
            <i class="fa-solid fa-magnifying-glass"></i>
        </label>
        <input type="text" id="searchInput" placeholder="Search requests..." onkeyup="filterRequests()">
    </div>


    <ul class="request-list">
        <c:forEach var="request" items="${allMeetingRequests}">
            <li class="request-item">
                <div class="request-header">
                    <h3>${fn:escapeXml(request.topic)}</h3>
                    <p>${fn:escapeXml(request.proposaldate)} ${fn:escapeXml(request.proposaltime)}</p>
                </div>
                <div class="request-content">
                    <p><strong>Purpose:</strong> ${fn:escapeXml(request.purposeofmeeting)}</p>
                    <p><strong>Opponents:</strong> ${fn:escapeXml(request.opponentname)}</p>
                    <p><strong>Host:</strong> ${fn:escapeXml(request.discussionformat)}</p>
                </div>
                <div class="request-actions">
                    <button
                            class="button button-update"
                            onclick="openEditPopup(
                                    '${fn:escapeXml(request.meetingrequestid)}',
                                    '${fn:escapeXml(request.topic)}',
                                    '${fn:escapeXml(request.purposeofmeeting)}',
                                    '${fn:escapeXml(request.proposaldate)}',
                                    '${fn:escapeXml(request.proposaltime)}',
                                    '${fn:escapeXml(request.opponentname)}',
                                    '${fn:escapeXml(request.discussionformat)}')">
                        Update
                    </button>
                    <form action="DeleteNewMeetingRequestServlet" method="post" onsubmit="return confirm('Are you sure?');">
                        <input type="hidden" name="meetingrequestid" value="${fn:escapeXml(request.meetingrequestid)}" />
                        <button type="submit" class="button button-delete">Delete</button>
                    </form>
                </div>
            </li>
        </c:forEach>
    </ul>

</div>




<div class="popup-modal" id="editPopup">
    <div class="popup">
        <span>Edit Request</span>
        <button class="close-btn" onclick="closeEditPopup()">X</button>
        <form action="UpdateMeetingRequestServlet" method="post">
            <input type="hidden" name="meetingrequestid" id="meetingRequestId" />
            <div class="formSection">
                <label for="editTopic">Topic</label>
                <input type="text" id="editTopic" name="topic" />
            </div>
            <div class="formSection">
                <label for="editPurpose">Purpose</label>
                <textarea id="editPurpose" name="purposeofmeeting"></textarea>
            </div>
            <div class="formSection">
                <label for="editDate">Date</label>
                <input type="date" id="editDate" name="proposaldate" />
            </div>
            <div class="formSection">
                <label for="editTime">Time</label>
                <input type="time" id="editTime" name="proposaltime" />
            </div>
            <div class="formSection">
                <label for="editOpponents">Opponents</label>
                <input type="text" id="editOpponents" name="opponentname" />
            </div>
            <div class="formSection">
                <label for="editHost">Host</label>
                <input type="text" id="editHost" name="preferredhost" />
            </div>
            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditPopup(meetingrequestid, topic, purposeofmeeting, proposaldate, proposaltime, opponentname, preferredhost) {
        document.getElementById('editPopup').style.display = 'flex';
        document.getElementById('meetingRequestId').value = meetingrequestid;
        document.getElementById('editTopic').value = topic;
        document.getElementById('editPurpose').value = purposeofmeeting;
        document.getElementById('editDate').value = proposaldate;
        document.getElementById('editTime').value = proposaltime;
        document.getElementById('editOpponents').value = opponentname;
        document.getElementById('editHost').value = preferredhost;
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }

    function filterRequests() {
        const input = document.getElementById('searchInput').value.toUpperCase();
        const items = document.querySelectorAll('.request-item');
        items.forEach(item => {
            const text = item.innerText.toUpperCase();
            item.style.display = text.includes(input) ? '' : 'none';
        });
    }
</script>
</body>
</html>
