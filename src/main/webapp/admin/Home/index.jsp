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
%>

<%
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Home | Admin Dashboard</title>

<%--	<link rel="stylesheet" href="./dashboard.css">--%>
	<link rel="stylesheet" href="../index.css">
	<link rel="stylesheet" href="home.css">


	<!-- Chart.js CDN -->
<%--	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>--%>

	<!-- icons -->
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
	<link
			rel="stylesheet"
			data-purpose="Layout StyleSheet"
			title="Web Awesome"
			href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
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
			href="https://site-assets.fontawesome.com/releases/v6.6.0/css/solid.css"
	/>
	<link
			rel="stylesheet"
			href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
	/>
	<style>
<%--		/* Enhanced Grid Layout */--%>
<%--		.stats-grid {--%>
<%--			display: grid;--%>
<%--			grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));--%>
<%--			gap: 20px;--%>
<%--			width: 100%;--%>
<%--			padding: 20px 0;--%>
<%--			max-width: 1400px;--%>
<%--			margin: 0 auto;--%>
<%--		}--%>

<%--		/* Stat Card Styling */--%>
<%--		.stat-card {--%>
<%--			background: #ffffff;--%>
<%--			border-radius: 12px;--%>
<%--			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);--%>
<%--			padding: 20px;--%>
<%--			display: flex;--%>
<%--			align-items: center;--%>
<%--			justify-content: space-between;--%>
<%--			transition: transform 0.3s ease, box-shadow 0.3s ease;--%>
<%--			text-decoration: none;--%>
<%--			color: #333;--%>
<%--		}--%>
<%--		.stat-card:hover {--%>
<%--			transform: translateY(-5px);--%>
<%--			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);--%>
<%--		}--%>
<%--		.card-icon i {--%>
<%--			font-size: 2rem;--%>
<%--			color: #007bff;--%>
<%--		}--%>
<%--		.card-data {--%>
<%--			text-align: right;--%>
<%--		}--%>
<%--		.card-amount {--%>
<%--			font-size: 1.8rem;--%>
<%--			font-weight: 600;--%>
<%--			color: #333;--%>
<%--		}--%>
<%--		.card-title {--%>
<%--			font-size: 1rem;--%>
<%--			color: #666;--%>
<%--			margin-top: 5px;--%>
<%--		}--%>

<%--		/* Chart Card Styling */--%>
<%--		.chart-card {--%>
<%--			background: #ffffff;--%>
<%--			border-radius: 12px;--%>
<%--			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);--%>
<%--			padding: 20px;--%>
<%--			display: flex;--%>
<%--			flex-direction: column;--%>
<%--			align-items: center;--%>
<%--			justify-content: center;--%>
<%--			transition: transform 0.3s ease, box-shadow 0.3s ease;--%>
<%--			min-height: 300px;--%>
<%--		}--%>
<%--		.chart-card:hover {--%>
<%--			transform: translateY(-5px);--%>
<%--			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);--%>
<%--		}--%>
<%--		.chart-card canvas {--%>
<%--			max-width: 100%;--%>
<%--			max-height: 250px;--%>
<%--		}--%>

<%--		/* Button Card Styling */--%>
<%--		.button-card {--%>
<%--			background: linear-gradient(135deg, #007bff, #0056b3);--%>
<%--			border-radius: 12px;--%>
<%--			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);--%>
<%--			padding: 20px;--%>
<%--			display: flex;--%>
<%--			align-items: center;--%>
<%--			justify-content: center;--%>
<%--			transition: transform 0.3s ease, box-shadow 0.3s ease;--%>
<%--			min-height: 150px;--%>
<%--		}--%>
<%--		.button-card:hover {--%>
<%--			transform: translateY(-5px);--%>
<%--			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);--%>
<%--		}--%>
<%--		.button-card a {--%>
<%--			color: #ffffff;--%>
<%--			text-decoration: none;--%>
<%--			font-size: 1.2rem;--%>
<%--			font-weight: 500;--%>
<%--			padding: 15px 30px;--%>
<%--			border-radius: 8px;--%>
<%--			background: rgba(255, 255, 255, 0.1);--%>
<%--			transition: background 0.3s ease;--%>
<%--		}--%>
<%--		.button-card a:hover {--%>
<%--			background: rgba(255, 255, 255, 0.2);--%>
<%--		}--%>

<%--		/* Responsive Adjustments */--%>
<%--		@media (max-width: 768px) {--%>
<%--			.stats-grid {--%>
<%--				grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));--%>
<%--				gap: 15px;--%>
<%--			}--%>
<%--			.stat-card, .chart-card, .button-card {--%>
<%--				padding: 15px;--%>
<%--			}--%>
<%--			.card-amount {--%>
<%--				font-size: 1.5rem;--%>
<%--			}--%>
<%--			.card-title {--%>
<%--				font-size: 0.9rem;--%>
<%--			}--%>
<%--			.button-card a {--%>
<%--				font-size: 1rem;--%>
<%--				padding: 10px 20px;--%>
<%--			}--%>
<%--		}--%>

		 /*Popup Modal Styles*/
		.popup-modal {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background: rgba(0, 0, 0, 0.5);
			justify-content: center;
			align-items: center;
		}

		.title{
			font-weight: 600;
			color:black;
			font-size: 1.25rem;
			gap: 1rem;

			&& .icon{
				width: 2.5rem;
				height: 2.5rem;
				border: 1px solid grey;
				border-radius: 50%;
				display: flex;
				align-content: center;
				justify-content: center;
				font-size: 1rem;

				&& i{
					margin-top: 0.7rem;
				}
			}
		}

		.popup {
			background-color: white;
			z-index: 1;
			padding: 1rem 1.5rem;
			border-radius: 1.5rem;
			width: 400px;
			position: relative;
		}

		.popup .close-btn {
			position: absolute;
			top: 1rem;
			right: 1.5rem;
			cursor: pointer;
			width: 1.75rem;
			height: 1.75rem;
			border-radius: 50%;
			display: flex;
			align-content: center;
			justify-content: center;
			background: #cfcfcf;

			&& i {
				line-height: normal;
				margin-top: 0.25rem;
			}
		}

		.formSection {
			margin-bottom: 15px;
		}

		.formSection label {
			display: block;
			margin-bottom: 5px;
		}

		.formSection input, .formSection textarea {
			width: 100%;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 5px;
		}

		.popbtns {
			text-align: center;
			margin-top: 20px;
		}

		.post-btn {
			background-color: #6a5acd;
			color: white;
			border: none;
			border-radius: 5px;
			cursor: pointer;
		}

		.post-btn:hover {
			background-color: #5b4ab5;
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
				<a href="${pageContext.request.contextPath}/admin/Home/index.jsp" class="nav-item f-row active">
					<i class="fa-regular fa-house"></i>
					<span>home</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/admin/userManagement" class="nav-item f-row">
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
				<a href="${pageContext.request.contextPath}/admin/PostManagement/PostManagementServlet" class="nav-item f-row ">
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
				<a href="<%= request.getContextPath() %>/GetProfileListServlet" class="nav-item f-row">
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

<div class="pageContent" style="width: 100%">
	<div class="container f-col">
		<div class="top f-row">

			<div class="page f-col">
				<div class="sUser">
					<div class="greet">
						Welcome,
						<span>Naleeka</span>
					</div>
				</div>
				<div class="page-desc">
					Track the platform progress here
				</div>
			</div>
			<div class="date">
				18 Jan, 2025
			</div>
		</div>
		<div class="action-btns f-row">
			<button id="add-announcement-btn" class="f-row"> <i class="fa-solid fa-bullhorn"></i> Add announcement</button>
			<button id="view-user-support" onclick="window.location.href='<%= request.getContextPath() %>/admin/UserSupport/GetSupportMesssageServlet'">view user support</button>
		</div>
		<div class="analytics f-col">
			<div class="row-1 f-row">
				<div class="an-sec sec-1 f-row">
					<div class="icon">
						<i class="fa-regular fa-user"></i>
					</div>
					<div class="data f-col">
						<div class="title">total users</div>
						<div class="amount">${userCount}</div>
					</div>
				</div>
				<div class="an-sec sec-2 f-row">
					<div class="icon">
						<i class="fa-solid fa-podium-star"></i>
					</div>
					<div class="data f-col">
						<div class="title">Politicains</div>
						<div class="amount">${politicianCount}</div>
					</div>
				</div>
				<div class="an-sec sec-3 f-row">
					<div class="icon">
						<i class="fa-solid fa-people-group"></i>
					</div>
					<div class="data f-col">
						<div class="title">political party</div>
						<div class="amount">${politicalPartyCount}</div>
					</div>
				</div>
				<div class="an-sec sec-4 f-row">
					<div class="icon">
						<i class="fa-solid fa-person"></i>
					</div>
					<div class="data f-col">
						<div class="title">Citizens</div>
						<div class="amount">${citizenCount}</div>
					</div>
				</div>
			</div>
			<div class="row-1 f-row">
				<div class="an-sec sec-1 f-row">
					<div class="icon">
						<i class="fa-regular fa-video"></i>
					</div>
					<div class="data f-col">
						<div class="title">Meetings</div>
						<div class="amount">${meetingCount}</div>
					</div>
				</div>
				<div class="an-sec sec-2 f-row">
					<div class="icon">
						<i class="fa-regular fa-sack-dollar"></i>
					</div>
					<div class="data f-col">
						<div class="title">Fundraisers</div>
						<div class="amount">40</div>
					</div>
				</div>
				<div class="an-sec sec-3 f-row">
					<div class="icon">
						<i class="fa-regular fa-clipboard-check"></i>
					</div>
					<div class="data f-col">
						<div class="title">Posts</div>
						<div class="amount">${postCount}</div>
					</div>
				</div>
				<div class="an-sec sec-4 f-row">
					<div class="icon">
						<i class="fa-regular fa-clipboard-check"></i>
					</div>
					<div class="data f-col">
						<div class="title">surveys</div>
						<div class="amount">40</div>
					</div>
				</div>
			</div>
		</div>
		<div class="engagements f-row">
			<div class="user-eng engagement f-col">
				<div class="title">User engagement</div>

				<div class="graph"></div>
			</div>
			<div class="surv-eng engagement f-col">
				<div class="title capitalize">surveys</div>
				<div class="graph"></div>
			</div>
			<div class="surv-eng engagement f-col">
				<div class="title capitalize">surveys</div>

				<div class="graph"></div>
			</div>
		</div>
	</div>
</div>

<%--<div class="fund-popup col">--%>
<%--	<div class="head row">--%>
<%--		<div class="close-btn">--%>
<%--			<i class="fa-solid fa-xmark"></i>--%>
<%--		</div>--%>
<%--		<div class="icon">--%>
<%--			<i class="fa-regular fa-briefcase"></i>--%>
<%--		</div>--%>
<%--		<div class="title">Publish an announcement</div>--%>
<%--		<div class="separator"></div>--%>
<%--	</div>--%>
<%--	<input type="hidden" name="userId" id="userId" value="<%= userId %>" />--%>
<%--	<div class="body col">--%>
<%--		<div class="fund-title field">--%>
<%--			<label for="add-post-title" class="title">Title</label>--%>
<%--			<input type="text" autocapitalize="off" required placeholder="Enter the title of the announcement" name="title" id="add-post-title">--%>
<%--		</div>--%>
<%--		<input type="hidden" name="userid" id="useri" value="${user.userId}" />--%>
<%--		<input type="hidden" name="username" id="usernam" value="${userProfile.name}" />--%>
<%--		<div class="fund-decs field">--%>
<%--			<label for="fund-desc" class="title">Description</label>--%>
<%--			<textarea required name="description" placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..." id="fund-desc"></textarea>--%>
<%--		</div>--%>
<%--		<div class="fund-contact" style="margin-bottom: 20px; font-family: Arial, sans-serif;">--%>
<%--			<label class="title" style="display: block; font-weight: bold; margin-bottom: 8px; font-size: 14px; color: #333;">--%>
<%--				Contact Number--%>
<%--			</label>--%>
<%--			<input--%>
<%--					type="tel"--%>
<%--					name="contact_no"--%>
<%--					required--%>
<%--					pattern="[0-9]{10}"--%>
<%--					maxlength="10"--%>
<%--					placeholder="Enter your contact number"--%>
<%--					title="Contact number must be exactly 10 digits"--%>
<%--					style="width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px; box-sizing: border-box;"--%>
<%--			>--%>
<%--		</div>--%>
<%--		<div class="multi-fields row">--%>
<%--			<div class="fund-cat field">--%>
<%--				<label for="fund-categ" class="title">Category</label>--%>
<%--				<select required name="category" id="fund-categ">--%>
<%--					<option value="educational">Educational</option>--%>
<%--					<option value="social">Social</option>--%>
<%--					<option value="community-se">Community Service</option>--%>
<%--				</select>--%>
<%--			</div>--%>
<%--			<div class="fund-amount field col">--%>
<%--				<label class="title" for="fund-amount">Fund Target</label>--%>
<%--				<div class="content row">--%>
<%--					<div class="curr">--%>
<%--						<select required name="currency" id="fund-currency">--%>
<%--							<option value="lkr">LKR</option>--%>
<%--							<option value="usd">USD</option>--%>
<%--						</select>--%>
<%--					</div>--%>
<%--					<div class="amount">--%>
<%--						<input required type="number" name="targetamount" id="fund-amount" min="1" placeholder="1,000,000.00">--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="fund-attach field">--%>
<%--			<span for="" class="title">Upload Attachments</span>--%>
<%--			<div class="att-container">--%>
<%--				<div class="action row">--%>
<%--					<label for="fund-att" class="att-btn">Select File</label>--%>
<%--					<input type="file" required name="attachmentUrl" id="fund-att" multiple>--%>
<%--					<div class="sep"></div>--%>
<%--				</div>--%>
<%--				<div class="att-content">--%>
<%--					<span class="no-of-files">No file attached</span>--%>
<%--					<ul id="att-list" class="col">--%>
<%--						<!-- uploaded files will be listed here -->--%>
<%--					</ul>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="fund-photo field">--%>
<%--			<span for="" class="title">Upload Photos</span>--%>
<%--			<div class="att-container-photo">--%>
<%--				<div class="action row-photo">--%>
<%--					<label for="fund-photo" class="photo-btn">Select Photo</label>--%>
<%--					<input type="file" name="photos" id="fund-photo" multiple>--%>
<%--					<div class="sep"></div>--%>
<%--				</div>--%>
<%--				<div class="photo-content">--%>
<%--					<span class="no-of-files">No Photo attached</span>--%>
<%--					<ul id="photo-list" class="col">--%>
<%--						<!-- uploaded files will be listed here -->--%>
<%--					</ul>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</div>--%>
<%--	<div class="bottom row">--%>
<%--		<button type="button" class="cancel-btn form-btn">Cancel</button>--%>
<%--		<button type="submit" class="submit-btn form-btn row">--%>
<%--			<i class="fa-duotone fa-solid fa-check"></i>--%>
<%--			Publish--%>
<%--		</button>--%>
<%--	</div>--%>
<%--</div>--%>

<%--<div class="popup-modal" id="popup-modal" style="display: flex">--%>
<%--	<div class="popup">--%>
<%--		<!-- Announcement Form -->--%>
<%--		<form action="PublishAnnouncementAdminServlet" method="post">--%>
<%--			<div class="title f-row">--%>
<%--				<div class="icon">--%>
<%--					<i class="fa-solid fa-megaphone"></i>--%>
<%--				</div>--%>
<%--				New Announcement--%>
<%--				<div class="close-btn btn" id="popup-close-btn">--%>
<%--					<i class="fa-solid fa-xmark"></i>--%>
<%--				</div>--%>
<%--				<div class="breakLine"></div>--%>
<%--			</div>--%>
<%--			<div class="content">--%>
<%--				<!-- User ID (hidden field) -->--%>
<%--				<input type="hidden" name="userId" id="userId" value="<%= userId %>" />--%>

<%--				<!-- Announcement Title -->--%>
<%--				<div class="discussion-title col">--%>
<%--					<label for="add-post-title">Title</label>--%>
<%--					<input--%>
<%--							autocomplete="off"--%>
<%--							type="text"--%>
<%--							name="title"--%>
<%--							id="add-post-title"--%>
<%--							placeholder="Enter the title of the announcement"--%>
<%--							required--%>
<%--					/>--%>
<%--				</div>--%>

<%--				<!-- Announcement Content -->--%>
<%--				<div class="caption-box col content-pd">--%>
<%--					<label for="add-post-caption">Content</label>--%>
<%--					<textarea--%>
<%--							autocomplete="off"--%>
<%--							name="content"--%>
<%--							id="add-post-caption"--%>
<%--							placeholder="Enter the content of the announcement"--%>
<%--							required--%>
<%--					></textarea>--%>
<%--				</div>--%>

<%--				<!-- Form Buttons -->--%>
<%--				<div class="popbtns capitalize">--%>
<%--					<button type="reset" class="clear-btn" id="popup-clear-btn">--%>
<%--						Clear <i class="fa-solid fa-rotate-left"></i>--%>
<%--					</button>--%>
<%--					<button type="submit" class="post-btn" id="popup-post-btn">--%>
<%--						Post Announcement <i class="fa-solid fa-check"></i>--%>
<%--					</button>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</form>--%>
<%--	</div>--%>
<%--</div>--%>

</body>
<script>
	function logoutUser() {
		window.location.href = "../../index.jsp";
	}

	// Popup Modal Handling
	const popupModal = document.getElementById('popup-modal');
	const addAnnouncementBtn = document.getElementById('add-announcement-btn');
	const closeBtn = document.getElementById('popup-close-btn');
	const clearBtn = document.getElementById('popup-clear-btn');

	// Open popup when Add Announcement button is clicked
	addAnnouncementBtn.addEventListener('click', (e) => {
		e.preventDefault(); // Prevent default link behavior
		popupModal.style.display = 'flex';
		console.log("clicked")
	});

	// Close popup when close button is clicked
	closeBtn.addEventListener('click', () => {
		popupModal.style.display = 'none';
	});

	// Clear form when clear button is clicked
	clearBtn.addEventListener('click', () => {
		document.querySelector('form').reset();
	});

	// Close popup when clicking outside the popup content
	popupModal.addEventListener('click', (e) => {
		if (e.target === popupModal) {
			popupModal.style.display = 'none';
		}
	});

	// Pie Chart for User Types
	const userTypePieChart = new Chart(document.getElementById('userTypePieChart'), {
		type: 'pie',
		data: {
			labels: ['Citizens', 'Politicians', 'Political Parties'],
			datasets: [{
				data: [65300, 1200, 45], // Data from stat cards
				backgroundColor: ['#36A2EB', '#FF6384', '#FFCE56'],
				hoverOffset: 20
			}]
		},
		options: {
			responsive: true,
			plugins: {
				legend: {
					position: 'bottom'
				},
				title: {
					display: true,
					text: 'User Type Distribution'
				}
			}
		}
	});

	// Bar Chart for User Registrations Over Past 5 Days
	const userRegistrationBarChart = new Chart(document.getElementById('userRegistrationBarChart'), {
		type: 'bar',
		data: {
			labels: ['Apr 19', 'Apr 20', 'Apr 21', 'Apr 22', 'Apr 23'], // Past 5 days
			datasets: [{
				label: 'New Users',
				data: [120, 150, 100, 180, 130], // Placeholder data
				backgroundColor: '#36A2EB',
				borderColor: '#36A2EB',
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			scales: {
				y: {
					beginAtZero: true,
					title: {
						display: true,
						text: 'Number of Users'
					}
				},
				x: {
					title: {
						display: true,
						text: 'Date'
					}
				}
			},
			plugins: {
				legend: {
					display: false
				},
				title: {
					display: true,
					text: 'User Registrations (Past 5 Days)'
				}
			}
		}
	});

	// Line Chart for Posts Over Past 5 Days
	const postsLineChart = new Chart(document.getElementById('postsLineChart'), {
		type: 'line',
		data: {
			labels: ['Apr 19', 'Apr 20', 'Apr 21', 'Apr 22', 'Apr 23'], // Past 5 days
			datasets: [{
				label: 'Posts',
				data: [50, 70, 60, 80, 55], // Placeholder data
				borderColor: '#FF6384',
				backgroundColor: 'rgba(255, 99, 132, 0.2)',
				fill: true,
				tension: 0.4
			}]
		},
		options: {
			responsive: true,
			scales: {
				y: {
					beginAtZero: true,
					title: {
						display: true,
						text: 'Number of Posts'
					}
				},
				x: {
					title: {
						display: true,
						text: 'Date'
					}
				}
			},
			plugins: {
				legend: {
					position: 'bottom'
				},
				title: {
					display: true,
					text: 'Posts (Past 5 Days)'
				}
			}
		}
	});

	// Line Chart for Fundraisers Over Past 5 Days
	const fundraisersLineChart = new Chart(document.getElementById('fundraisersLineChart'), {
		type: 'line',
		data: {
			labels: ['Apr 19', 'Apr 20', 'Apr 21', 'Apr 22', 'Apr 23'], // Past 5 days
			datasets: [{
				label: 'Fundraisers',
				data: [10, 15, 12, 20, 18], // Placeholder data
				borderColor: '#36A2EB',
				backgroundColor: 'rgba(54, 162, 235, 0.2)',
				fill: true,
				tension: 0.4
			}]
		},
		options: {
			responsive: true,
			scales: {
				y: {
					beginAtZero: true,
					title: {
						display: true,
						text: 'Number of Fundraisers'
					}
				},
				x: {
					title: {
						display: true,
						text: 'Date'
					}
				}
			},
			plugins: {
				legend: {
					position: 'bottom'
				},
				title: {
					display: true,
					text: 'Fundraisers (Past 5 Days)'
				}
			}
		}
	});
</script>
</html>