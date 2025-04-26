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

	<link rel="stylesheet" href="../index.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/admin/Home/home.css">

	<!-- Chart.js CDN -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<!-- Icons -->
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

		.card-icon i {
			font-size: 2rem;
			color: #007bff;
		}
		.chart-card canvas {
			max-width: 100%;
			max-height: 250px;
		}

		.button-card a {
			color: #ffffff;
			text-decoration: none;
			font-size: 1.2rem;
			font-weight: 500;
			padding: 15px 30px;
			border-radius: 8px;
			background: rgba(255, 255, 255, 0.1);
			transition: background 0.3s ease;
		}
		.button-card a:hover {
			background: rgba(255, 255, 255, 0.2);
		}

		/* Responsive Adjustments */
		@media (max-width: 768px) {
			.stats-grid {
				grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
				gap: 15px;
			}
			.stat-card, .chart-card, .button-card {
				padding: 15px;
			}
			.card-amount {
				font-size: 1.5rem;
			}
			.card-title {
				font-size: 0.9rem;
			}
			.button-card a {
				font-size: 1rem;
				padding: 10px 20px;
			}
		}

		* {
			padding: 0;
			margin: 0;
			box-sizing: border-box;
		}
		body {
			font-family: "poppins", sans-serif;
			position: relative;
		}
		.popup-modal {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			background: rgba(0, 0, 0, 0.5); /* Slightly darker for better contrast */
			z-index: 1000; /* Ensure popup is above other content */
			align-items: center;
			justify-content: center;
		}
		button {
			cursor: pointer;
			text-transform: capitalize;
			font-family: inherit;
		}
		body.popup-active .popup-modal {
			display: flex;
		}
		.popup-content {
			position: relative;
			min-width: 20rem;
			max-width: 90vw; /* Prevent overflow on small screens */
			min-height: 10rem;
			max-height: 80vh; /* Limit height to avoid overflow */
			background: #fff;
			border-radius: 1rem;
			border: 1px solid #e3e3e3;
			overflow-y: auto;
		}
		.popup-content > div {
			padding: 1rem 1.25rem;
		}
		.close-btn {
			display: flex;
			align-items: center;
			justify-content: center;
			position: absolute;
			cursor: pointer;
			top: 2rem;
			transform: translateY(-50%);
			padding: 0;
			border-radius: 50%;
			right: 1.5rem;
			width: 1.5rem;
			height: 1.5rem;
			background: #f0f0f0;
			transition: all 0.25s ease-in-out;
		}
		.close-btn:hover {
			background: #e0e0e0;
		}
		.top {
			display: flex;
			align-items: center;
			border-bottom: 1px solid #e3e3e3;
			gap: 1rem;
			text-transform: capitalize;
			font-weight: 500;
			font-size: 1.1rem;
		}
		.top .icon {
			display: flex;
			align-items: center;
			justify-content: center;
			width: 2rem;
			height: 2rem;
			background: #ffffff;
			border-radius: 50%;
			border: 1px solid rgb(215, 215, 215);
			color: rgb(74, 74, 74);
		}
		.content {
			border-bottom: 1px solid #e3e3e3;
			background: #f4f4f4;
			font-size: 0.9rem;
		}
		.footer {
			display: flex;
			padding-block: 0.75rem;
			align-items: center;
			gap: 0.5rem;
			justify-content: flex-end;
		}
		.footer button {
			padding: 0.35rem 0.75rem;
			font-size: 0.75rem;
			border-radius: 0.5rem;
			font-weight: 500;
			outline: 0;
			border: 1px solid #e3e3e3;
			transition: background 0.25s ease-in-out, color 0.25s ease-in-out, scale 0.1s ease-in-out;
		}
		.footer button:active {
			scale: 0.95;
		}
		.prmry-btn {
			background: #1e1e1e;
			color: white;
		}
		.prmry-btn:hover {
			background: #3b3b3b;
		}
		.scndry-btn:hover {
			background: #e8e8e8;
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
			<div class="user-eng engagement f-col" >
				<div class="title">User engagement</div>
				<div class="graph" style="background:white; display: flex; justify-content: center; align-items: center; height: 300px;">
					<canvas id="userTypePieChart"></canvas>
				</div>
			</div>
			<div class="surv-eng engagement f-col">
				<div class="title capitalize">surveys</div>
				<div class="graph" style="background:white; display: flex; justify-content: center; align-items: center; height: 300px;">
					<canvas id="userRegistrationBarChart"></canvas>
				</div>
			</div>
			<div class="surv-eng engagement f-col">
				<div class="title capitalize">posts</div>
				<div class="graph" style="background:white; display: flex; justify-content: center; align-items: center; height: 300px;">
					<canvas id="postsLineChart"></canvas>
				</div>
			</div>
		</div>
	</div>
</div>

<input hidden="hidden" name="">

<!-- Popup Modal -->
<div class="popup-modal" id="popup-modal">
	<div class="popup-content">
		<div class="close-btn" id="popup-close-btn">
			<i class="fa-solid fa-xmark"></i>
		</div>
		<div class="top">
			<div class="icon">
				<i class="fa-regular fa-bullhorn"></i>
			</div>
			<div class="title">New Announcement</div>
		</div>
		<div class="content">
			<!-- Announcement Form -->
			<form action="PublishAnnouncementAdminServlet" method="post">
				<!-- User ID (hidden field) -->
				<input type="hidden" name="userId" id="userId" value="<%= userId %>" />

				<!-- Announcement Title -->
				<div class="formSection">
					<label for="add-post-title">Title</label>
					<input
							autocomplete="off"
							type="text"
							name="title"
							id="add-post-title"
							placeholder="Enter the title of the announcement"
							required
					/>
				</div>

				<!-- Announcement Content -->
				<div class="formSection">
					<label for="add-post-caption">Content</label>
					<textarea
							autocomplete="off"
							name="content"
							id="add-post-caption"
							placeholder="Enter the content of the announcement"
							required
					></textarea>
				</div>

				<!-- Form Buttons -->
				<div class="footer">
					<button type="reset" class="scndry-btn" id="popup-clear-btn">Clear</button>
					<button type="submit" class="prmry-btn" id="popup-post-btn">Post Announcement</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	function logoutUser() {
		window.location.href = "../../index.jsp";
	}

	// Popup Modal Handling
	const popupModal = document.getElementById('popup-modal');
	const addAnnouncementBtn = document.getElementById('add-announcement-btn');
	const closeBtn = document.getElementById('popup-close-btn');
	const clearBtn = document.getElementById('popup-clear-btn');


	const userCount = ${userCount};
	const politicianCount = ${politicianCount};
	const politicalPartyCount = ${politicalPartyCount};


	// Open popup when Add Announcement button is clicked
	addAnnouncementBtn.addEventListener('click', (e) => {
		e.preventDefault(); // Prevent default link behavior
		popupModal.style.display = 'flex';
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
				data: [userCount, politicianCount, politicalPartyCount], // Data from stat cards
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

	const day1Registrations = ${day1Registrations};
	const day2Registrations = ${day2Registrations};
	const day3Registrations = ${day3Registrations};
	const day4Registrations = ${day4Registrations};
	const day5Registrations = ${day5Registrations};

	// Bar Chart for User Registrations Over Past 5 Days
	// Function to get the last 5 days in 'MMM DD' format
	function getLastFiveDays() {
		const labels = [];
		const today = new Date();

		for (let i = 4; i >= 0; i--) {
			const date = new Date(today);
			date.setDate(today.getDate() - i);
			// Format as 'Apr 19'
			const formattedDate = date.toLocaleDateString('en-US', {
				month: 'short',
				day: 'numeric'
			});
			labels.push(formattedDate);
		}

		return labels;
	}

	// Your Chart.js code with dynamic labels
	const userRegistrationBarChart = new Chart(document.getElementById('userRegistrationBarChart'), {
		type: 'bar',
		data: {
			labels: getLastFiveDays(), // Use dynamic labels
			datasets: [{
				label: 'New Users',
				data: [day1Registrations, day2Registrations, day3Registrations, day4Registrations, day5Registrations], // Replace with actual data
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
</body>
</html>