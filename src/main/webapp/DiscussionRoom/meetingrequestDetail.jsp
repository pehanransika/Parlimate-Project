<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Meeting Requests</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/DiscussionRoom/reqPop.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/index.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/DiscussionRoom/discussion-room.css" />
    <link rel="stylesheet" href="../postDetails.css" />
    <link href="../index/sidebar1.css" rel="stylesheet" />
    <link href="../index/header/header.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .top-bar { display: flex; justify-content: flex-end; margin-top: 80px; }
        .button-home { background-color: #007bff; color: white; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-size: 16px; transition: background-color 0.3s ease; }
        .button-home:hover { background-color: #0056b3; }
        .request-item { background-color: #ffffff; margin-bottom: 20px; border-radius: 10px; padding: 20px; position: relative; display: flex; flex-direction: column; gap: 15px; cursor: pointer; border-left: 0.75rem solid #75a8ec; transition: 0.25s ease; }
        .request-item:hover { outline: 1px solid rgb(185, 185, 185); border-left: 0.75rem solid #5490FF; }
        .request-header { display: flex; justify-content: space-between; }
        .request-info h3 { margin: 0; font-size: 18px; color: #333; }
        .request-info p { margin: 0; font-size: 14px; color: #888; }
        .request-content { margin-top: 10px; font-size: 16px; color: #555; }
        .request-actions { display: flex; justify-content: flex-end; gap: 10px; }
        .button { border: none; padding: 10px 0; font-size: 14px; border-radius: 5px; transition: background-color 0.3s ease; width: 100px; height: 40px; text-align: center; display: flex; align-items: center; justify-content: center; }
        .reqPop { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; justify-content: center; align-items: center; z-index: 1000; }
        .reqPop .bg { position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); }
        .reqPop form { background-color: white; padding: 20px; border-radius: 10px; width: 500px; position: relative; }
        .input-group { display: none; }
        .input-group.form-active { display: block; }
        .progress .item { cursor: pointer; }
        .progress .item-active { font-weight: bold; color: #007bff; }
        .bottom { display: flex; justify-content: space-between; }
        .btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        .cancel-btn { background-color: #ccc; }
        .next-btn, .prev-btn { background-color: #6a5acd; color: white; }
        .next-btn:hover, .prev-btn:hover { background-color: #5b4ab5; }
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
        <c:forEach var="request" items="${myMeetingRequests}">
            <li class="request-item">
                <div class="request-header">
                    <h3>${request.topic}  <c:if test="${request.rejectstatus == true}"><h3 style="color: red">Meeting was Rejected because of ${request.rejectreason} </c:if></h3></h3>
                </div>
                <div class="request-content">
                    <p><strong>Purpose:</strong> ${request.purposeofmeeting}</p>
                    <p><strong>Opponent Name:</strong> ${request.opponentname}</p>
                    <p><strong>Party Affiliation:</strong> ${request.partyaffiliation}</p>
                    <p><strong>Proposed Date:</strong> ${request.proposaldate}</p>
                    <p><strong>Proposed Time:</strong> ${request.proposaltime}</p>
                    <p><strong>Estimated Duration:</strong> ${request.estimatedduration} hours</p>
                    <p><strong>Discussion Format:</strong> ${request.discussionformat}</p>
                    <p><strong>Preferred Host:</strong> ${request.preferredhost}</p>
                    <p><strong>Participant Count:</strong> ${request.participantcount}</p>
                    <p><strong>Status:</strong> ${request.status ? 'Active' : 'Inactive'}</p>
                    <p><strong>Reject Status:</strong> ${request.rejectstatus ? 'Rejected' : 'Not Rejected'}</p>
                    <p><strong>Reject Reason:</strong> ${request.rejectreason}</p>
                </div>
                <c:if test="${request.rejectstatus == false}">
                <div class="request-actions">
                    <button
                            class="button button-update"
                            onclick="openEditPopup(
                                    '${request.meetingrequestid}',
                                    '${request.topic}',
                                    '${request.purposeofmeeting}',
                                    '${request.proposaldate}',
                                    '${request.proposaltime}',
                                    '${request.opponentname}',
                                    '${request.partyaffiliation}',
                                    '${request.discussionformat}',
                                    '${request.preferredhost}',
                                    '${request.estimatedduration}',
                                    '${request.participantcount}',
                                    '${request.status}',
                                    '${request.rejectstatus}',
                                    '${request.rejectreason}'
                                    )">
                        Update
                    </button>
                    <form action="DeleteNewMeetingRequestServlet" method="post" onsubmit="return confirm('Are you sure?');">
                        <input type="hidden" name="meetingrequestid" value="${request.meetingrequestid}" />
                        <button type="submit" class="button button-delete">Delete</button>
                    </form>
                </div>
                </c:if>
            </li>

        </c:forEach>
    </ul>
</div>

<div class="reqPop" id="editPopup">
    <div class="bg"></div>
    <form action="UpdateMeetingRequestServlet" method="post">
        <div class="head">
            <div id="meetClsBtn" onclick="closeEditPopup()">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="icon">
                <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="24"
                        height="24"
                        viewBox="0 0 24 24"
                        fill="none"
                >
                    <path
                            d="M12 21C13.78 21 15.5201 20.4722 17.0001 19.4832C18.4802 18.4943 19.6337 17.0887 20.3149 15.4442C20.9961 13.7996 21.1743 11.99 20.8271 10.2442C20.4798 8.49836 19.6226 6.89472 18.364 5.63604C17.1053 4.37737 15.5016 3.5202 13.7558 3.17294C12.01 2.82567 10.2004 3.0039 8.55585 3.68509C6.91131 4.36628 5.50571 5.51983 4.51677 6.99987C3.52784 8.47991 3 10.22 3 12C3 13.44 3.338 14.8 3.94 16.007C4.393 16.918 3.763 18.147 3.523 19.044C3.46983 19.2424 3.46982 19.4513 3.52297 19.6497C3.57613 19.8481 3.68057 20.029 3.8258 20.1742C3.97103 20.3194 4.15194 20.4239 4.35033 20.477C4.54872 20.5302 4.75761 20.5302 4.956 20.477C5.853 20.237 7.082 19.607 7.993 20.061C9.23821 20.6793 10.6097 21.0007 12 21Z"
                            stroke="#292929"
                            stroke-width="1.5"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                    />
                </svg>
            </div>
            <div class="title">Edit Discussion Request</div>
            <div class="separator"></div>
        </div>
        <div class="body">
            <div id="progress" class="progress row">
                <div class="item item-active" data-title="DebDetails">Debate Details</div>
                <div class="item" data-title="AddDetails">Additional Information</div>
                <div class="separator"></div>
            </div>

            <div class="input-container">
                <div class="input-group form-active">
                    <input type="hidden" name="meetingrequestid" id="meetingRequestId" />
                    <input type="hidden" name="politicianid" id="politicianid" value="${userProfile.politicianId}" />
                    <div class="field">
                        <label class="title" for="editTopic">Proposed Title</label>
                        <input
                                type="text"
                                name="topic"
                                id="editTopic"
                                required
                                minlength="5"
                                maxlength="100"
                                pattern="[A-Za-z0-9\s.,'-]+"
                                title="Title must be 5-100 characters long and contain only letters, numbers, spaces, or basic punctuation."
                                placeholder="Education reform policies"
                        />
                    </div>
                    <div class="field">
                        <label class="title" for="editPurpose">Purpose of the debate</label>
                        <textarea
                                name="purposeofmeeting"
                                id="editPurpose"
                                required
                                minlength="10"
                                maxlength="500"
                                placeholder="To discuss proposed funding strategies"
                                aria-required="true"
                        ></textarea>
                    </div>
                    <div class="multi-fields">
                        <div class="field">
                            <label class="title" for="editDate">Proposed Date</label>
                            <input
                                    type="date"
                                    name="proposaldate"
                                    id="editDate"
                                    required
                                    min="<%= LocalDate.now().toString() %>"
                            />
                        </div>
                        <div class="field">
                            <label class="title" for="editTime">Time</label>
                            <select
                                    name="proposaltime"
                                    id="editTime"
                                    required
                            >
                                <option value="" disabled>Select a time</option>
                                <option value="07:00">7:00 AM</option>
                                <option value="07:30">7:30 AM</option>
                                <option value="08:00">8:00 AM</option>
                                <option value="08:30">8:30 AM</option>
                                <option value="09:00">9:00 AM</option>
                                <option value="09:30">9:30 AM</option>
                                <option value="10:00">10:00 AM</option>
                                <option value="10:30">10:30 AM</option>
                                <option value="11:00">11:00 AM</option>
                                <option value="11:30">11:30 AM</option>
                                <option value="12:00">12:00 PM</option>
                                <option value="12:30">12:30 PM</option>
                                <option value="13:00">1:00 PM</option>
                                <option value="13:30">1:30 PM</option>
                                <option value="14:00">2:00 PM</option>
                                <option value="14:30">2:30 PM</option>
                                <option value="15:00">3:00 PM</option>
                                <option value="15:30">3:30 PM</option>
                                <option value="16:00">4:00 PM</option>
                                <option value="16:30">4:30 PM</option>
                                <option value="17:00">5:00 PM</option>
                                <option value="17:30">5:30 PM</option>
                                <option value="18:00">6:00 PM</option>
                                <option value="18:30">6:30 PM</option>
                                <option value="19:00">7:00 PM</option>
                                <option value="19:30">7:30 PM</option>
                                <option value="20:00">8:00 PM</option>
                                <option value="20:30">8:30 PM</option>
                                <option value="21:00">9:00 PM</option>
                                <option value="21:30">9:30 PM</option>
                                <option value="22:00">10:00 PM</option>
                                <option value="22:30">10:30 PM</option>
                                <option value="23:00">11:00 PM</option>
                            </select>
                        </div>
                    </div>
                    <div class="field">
                        <label class="title" for="editDuration">Estimated duration (hours)</label>
                        <div class="drop-type">
                            <input
                                    type="number"
                                    name="estimatedduration"
                                    id="editDuration"
                                    placeholder="2"
                                    required
                                    min="0.5"
                                    max="8"
                                    step="0.5"
                                    title="Duration must be between 0.5 and 8 hours."
                            />
                        </div>
                        <div class="separator"></div>
                    </div>
                    <div class="bottom">
                        <button type="button" class="cancel-btn btn" onclick="closeEditPopup()">Cancel</button>
                        <button type="button" class="next-btn btn" onclick="showNextStep()">
                            Next <i class="fa-solid fa-arrow-right"></i>
                        </button>
                    </div>
                </div>
                <div class="input-group">
                    <div class="field">
                        <label class="title" for="editDiscussionFormat">Preferred Discussion Format</label>
                        <select name="discussionformat" id="editDiscussionFormat" required>
                            <option value="" disabled>Select a format</option>
                            <option value="Open-debate">Open debate</option>
                            <option value="Moderated-discussion">Moderated Discussion</option>
                            <option value="QA">Q&A</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div id="opponent-fields">
                        <div class="field">
                            <label class="title" for="editOpponentName">Opponent Name</label>
                            <input
                                    type="text"
                                    id="editOpponentName"
                                    name="opponentname"
                                    placeholder="Enter opponent name"
                                    pattern="[A-Za-z\s'-]+"
                                    title="Name must contain only letters, spaces, or hyphens."
                            />
                        </div>
                        <div class="field">
                            <label class="title" for="editPartyAffiliation">Opponent's Party</label>
                            <input
                                    type="text"
                                    id="editPartyAffiliation"
                                    name="partyaffiliation"
                                    placeholder="Enter opponent's party"
                                    pattern="[A-Za-z\s'-]+"
                                    title="Party name must contain only letters, spaces, or hyphens."
                            />
                        </div>
                    </div>
                    <div class="field">
                        <label class="title">
                            <input type="checkbox" id="allow-participants" name="allowParticipants" onchange="toggleParticipantFields()">
                            Allow Live Participants
                            <i class="fa-solid fa-circle-info" title="Ticking this will allow participants to join the meeting and interact"></i>
                        </label>
                    </div>
                    <div id="participant-fields" style="display: none;">
                        <div class="field">
                            <label class="title" for="editParticipantCount">Number of Participants Allowed</label>
                            <input
                                    type="number"
                                    id="editParticipantCount"
                                    name="participantcount"
                                    min="1"
                                    max="100"
                                    placeholder="Enter number of participants"
                                    title="Number of participants must be between 1 and 100."
                            />
                        </div>
                    </div>
                    <div class="field">
                        <label class="title" for="editPreferredHost">Preferred Host <span>(Optional)</span></label>
                        <select id="editPreferredHost" name="preferredhost">
                            <option value="">Select a host (optional)</option>
                            <option value="Hashan Perera">Hashan Perera</option>
                            <option value="Gayan Fernando">Gayan Fernando</option>
                            <option value="Jiranthan Rasamanikkam">Jiranthan Rasamanikkam</option>
                        </select>
                    </div>
                    <div class="field">
                        <label class="title" for="editStatus">Status</label>
                        <select id="editStatus" name="status" required>
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                    <div class="field">
                        <label class="title" for="editRejectStatus">Reject Status</label>
                        <select id="editRejectStatus" name="rejectstatus" required>
                            <option value="true">Rejected</option>
                            <option value="false">Not Rejected</option>
                        </select>
                    </div>
                    <div class="field">
                        <label class="title" for="editRejectReason">Reject Reason</label>
                        <textarea
                                id="editRejectReason"
                                name="rejectreason"
                                placeholder="Enter reject reason (if applicable)"
                                maxlength="500"
                        ></textarea>
                    </div>
                    <div class="separator"></div>
                    <div class="bottom">
                        <button type="button" class="prev-btn btn" onclick="showPrevStep()">Back</button>

                        <button type="submit" class="next-btn btn">
                            Save Changes <i class="fa-solid fa-check"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    function openEditPopup(meetingrequestid, topic, purposeofmeeting, proposaldate, proposaltime, opponentname, partyaffiliation, discussionformat, preferredhost, estimatedduration, participantcount, status, rejectstatus, rejectreason) {
        document.getElementById('editPopup').style.display = 'flex';
        document.getElementById('meetingRequestId').value = meetingrequestid;
        document.getElementById('editTopic').value = topic;
        document.getElementById('editPurpose').value = purposeofmeeting;
        document.getElementById('editDate').value = proposaldate;
        document.getElementById('editTime').value = proposaltime;
        document.getElementById('editDuration').value = estimatedduration;
        document.getElementById('editOpponentName').value = opponentname;
        document.getElementById('editPartyAffiliation').value = partyaffiliation;
        document.getElementById('editDiscussionFormat').value = discussionformat;
        document.getElementById('editPreferredHost').value = preferredhost;
        document.getElementById('editParticipantCount').value = participantcount;
        document.getElementById('editStatus').value = status;
        document.getElementById('editRejectStatus').value = rejectstatus;
        document.getElementById('editRejectReason').value = rejectreason;

        // Show opponent fields if opponentname or partyaffiliation exists
        const opponentFields = document.getElementById('opponent-fields');
        opponentFields.style.display = (opponentname || partyaffiliation) ? 'block' : 'none';

        // Handle participant fields visibility
        const allowParticipants = participantcount > 0;
        document.getElementById('allow-participants').checked = allowParticipants;
        document.getElementById('participant-fields').style.display = allowParticipants ? 'block' : 'none';

        // Reset to first step
        showStep(0);
    }

    function closeEditPopup() {
        document.getElementById('editPopup').style.display = 'none';
    }

    function showStep(stepIndex) {
        const groups = document.querySelectorAll('.input-group');
        const progressItems = document.querySelectorAll('.progress .item');
        groups.forEach((group, index) => {
            group.classList.toggle('form-active', index === stepIndex);
        });
        progressItems.forEach((item, index) => {
            item.classList.toggle('item-active', index === stepIndex);
        });
    }

    function showNextStep() {
        showStep(1);
    }

    function showPrevStep() {
        showStep(0);
    }

    function toggleParticipantFields() {
        const checkbox = document.getElementById('allow-participants');
        const participantFields = document.getElementById('participant-fields');
        participantFields.style.display = checkbox.checked ? 'block' : 'none';
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