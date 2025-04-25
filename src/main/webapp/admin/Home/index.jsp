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

	<link rel="stylesheet" href="./dashboard.css">
	<link rel="stylesheet" href="../index.css">

	<!-- Chart.js CDN -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
		/* Enhanced Grid Layout */
		.stats-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
			gap: 20px;
			width: 100%;
			padding: 20px 0;
			max-width: 1400px;
			margin: 0 auto;
		}

		/* Stat Card Styling */
		.stat-card {
			background: #ffffff;
			border-radius: 12px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
			padding: 20px;
			display: flex;
			align-items: center;
			justify-content: space-between;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			text-decoration: none;
			color: #333;
		}
		.stat-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
		}
		.card-icon i {
			font-size: 2rem;
			color: #007bff;
		}
		.card-data {
			text-align: right;
		}
		.card-amount {
			font-size: 1.8rem;
			font-weight: 600;
			color: #333;
		}
		.card-title {
			font-size: 1rem;
			color: #666;
			margin-top: 5px;
		}

		/* Chart Card Styling */
		.chart-card {
			background: #ffffff;
			border-radius: 12px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
			padding: 20px;
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			min-height: 300px;
		}
		.chart-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
		}
		.chart-card canvas {
			max-width: 100%;
			max-height: 250px;
		}

		/* Button Card Styling */
		.button-card {
			background: linear-gradient(135deg, #007bff, #0056b3);
			border-radius: 12px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
			padding: 20px;
			display: flex;
			align-items: center;
			justify-content: center;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			min-height: 150px;
		}
		.button-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
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

		/* Popup Modal Styles */
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

		.popup {
			background-color: white;
			padding: 20px;
			border-radius: 10px;
			width: 400px;
			position: relative;
		}

		.popup .close-btn {
			position: absolute;
			top: 10px;
			right: 10px;
			cursor: pointer;
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

<div class="pageContent">
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
					Monitor platform statistics
				</div>
			</div>
			<div class="date">
				24 Apr, 2025
			</div>
		</div>
		<div class="stats-grid">
			<a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-users"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">66.6k</div>
					<div class="card-title">Total Users</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-user-tie"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">1.2k</div>
					<div class="card-title">Politicians</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-flag"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">45</div>
					<div class="card-title">Political Parties</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class-builder>
				<div class="card-icon">
					<i class="fa-regular fa-user"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">65.3k</div>
					<div class="card-title">Citizens</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/GetAllMeetingRequestAdminServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-calendar-check"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">320</div>
					<div class="card-title">Meetings</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-briefcase"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">85</div>
					<div class="card-title">Fundraisers</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-check-to-slot"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">150</div>
					<div class="card-title">Surveys</div>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/GetProfileListServlet" class="stat-card">
				<div class="card-icon">
					<i class="fa-regular fa-id-card"></i>
				</div>
				<div class="card-data">
					<div class="card-amount">2.5k</div>
					<div class="card-title">Public Profiles</div>
				</div>
			</a>
			<div class="chart-card">
				<canvas id="userTypePieChart"></canvas>
			</div>
			<div class="chart-card">
				<canvas id="userRegistrationBarChart"></canvas>
			</div>
			<div class="chart-card">
				<canvas id="postsLineChart"></canvas>
			</div>
			<div class="chart-card">
				<canvas id="fundraisersLineChart"></canvas>
			</div>
			<div class="button-card">
				<a href="#" id="add-announcement-btn">Add Announcement</a>
			</div>
			<div class="button-card">
				<a href="${pageContext.request.contextPath}/admin/UserSupport/GetSupportMesssageServlet">View User Support</a>
			</div>
		</div>
	</div>
</div>

<div class="popup-modal" id="popup-modal">
	<div class="popup">
		<!-- Announcement Form -->
		<form action="PublishAnnouncementAdminServlet" method="post">
			<div class="title">
				New Announcement
				<div class="close-btn btn" id="popup-close-btn">
					<i class="fa-solid fa-times"></i>
				</div>
				<div class="breakLine"></div>
			</div>
			<div class="content">
				<!-- User ID (hidden field) -->
				<input type="hidden" name="userId" id="userId" value="<%= userId %>" />

				<!-- Announcement Title -->
				<div class="discussion-title col">
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
				<div class="caption-box col content-pd">
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
				<div class="popbtns capitalize">
					<button type="reset" class="clear-btn" id="popup-clear-btn">
						Clear <i class="fa-solid fa-rotate-left"></i>
					</button>
					<button type="submit" class="post-btn" id="popup-post-btn">
						Post Announcement <i class="fa-solid fa-check"></i>
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

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