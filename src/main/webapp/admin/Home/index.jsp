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

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Home | Admin Dashboard</title>

		<link rel="stylesheet" href="./home.css">
		<link rel="stylesheet" href="../index.css">

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
	</head>
	<body>
	<div class="navMenu f-col center">
		<div class="logo">
			<img src="../assets/logo.png" alt="Parlimate" id="logo" />
		</div>
		<div class="navigation">
			<ul>
				<li>
					<a href="index.jsp" class="nav-item f-row active">
						<i class="fa-regular fa-house"></i>
						<span>home</span>
					</a>
				</li>
				<li>
					<a href="../userManagment/userManagment.jsp" class="nav-item f-row">
						<i class="fa-regular fa-users"></i>
						<span>user management</span>
					</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
						<i class="fa-regular fa-briefcase"></i>
						<span>fundraise management</span>
					</a>
				</li>
				<li>
					<a href="#" class="nav-item f-row">
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
					<a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row">
<i class="fa-regular fa-circle-check"></i>
						<span>Meeting Management</span>
					</a>
				</li>
				<li>
					<a href="#" class="nav-item f-row">
						<i class="fa-regular fa-sliders-up"></i>
						<span>platform settings</span>
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
							Track the platform progress here
						</div>
					</div>
					<div class="date">
						18 Jan, 2025
					</div>
				</div>
				<div class="analytics f-row">
					<div class="an-sec sec-1 f-row">
						<div class="icon">
							<i class="fa-regular fa-user"></i>
						</div>
						<div class="data f-col">
							<div class="title">users</div>
							<div class="amount">66.6k</div>
						</div>
					</div>
					<div class="an-sec sec-2 f-row">
						<div class="icon">
							<i class="fa-regular fa-circle-exclamation"></i>
						</div>
						<div class="data f-col">
							<div class="title">Reports/flags</div>
							<div class="amount">12</div>
						</div>
					</div>
					<div class="an-sec sec-3 f-row">
						<div class="icon">
							<i class="fa-regular fa-briefcase"></i>
						</div>
						<div class="data f-col">
							<div class="title">pending approvals</div>
							<div class="amount">40</div>
						</div>
					</div>
				</div>
				<div class="engagements f-col">
					<div class="user-eng engagement f-col">
						<div class="title">User engagement</div>
						<div class="filters f-row">
							<div class="tabs f-row capitalize">
								<div class="tab">
									<input type="radio" name="user-tabs" id="user-all" checked>
									<label for="user-all">all</label>
								</div>
								<div class="tab">
									<input type="radio" name="user-tabs" id="user-users" >
									<label for="user-users">users</label>
								</div>
								<div class="tab">
									<input type="radio" name="user-tabs" id="user-pol" >
									<label for="user-pol">politicians</label>
								</div>
								<div class="tab">
									<input type="radio" name="user-tabs" id="user-party" >
									<label for="user-party">political parties</label>
								</div>
							</div>
							<div class="drops">
								<select name="user-province" id="user-province" class="prov-drop capitalize">
									<option value="" disabled selected>province</option>
									<option value="central">central</option>
									<option value="north">north</option>
									<option value="western">western</option>
									<option value="eastern">eastern</option>
									<option value="southern">southern</option>
								</select>
								<select name="user-time" id="user-time" class="time-drop capitalize">
									<option value="daily">daily</option>
									<option value="monthly">monthly</option>
									<option value="annualy">annualy</option>
								</select>
							</div>
						</div>
						<div class="graph"></div>
					</div>
					<div class="surv-eng engagement f-col">
						<div class="title capitalize">surveys</div>
						<div class="filters f-row">
							<div class="tabs f-row capitalize">
								<div class="tab">
									<input type="radio" name="surv-tabs" id="surv-all" checked>
									<label for="surv-all">all</label>
								</div>
								<div class="tab">
									<input type="radio" name="surv-tabs" id="surv-users" >
									<label for="surv-users">users</label>
								</div>
								<div class="tab">
									<input type="radio" name="surv-tabs" id="surv-pol" >
									<label for="surv-pol">politicians</label>
								</div>
								<div class="tab">
									<input type="radio" name="surv-tabs" id="surv-party" >
									<label for="surv-party">political parties</label>
								</div>
							</div>
							<div class="drops">
								<select name="user-province" id="user-province" class="prov-drop capitalize">
									<option value="central">central</option>
									<option value="north">north</option>
									<option value="western">western</option>
									<option value="eastern">eastern</option>
									<option value="southern">southern</option>
								</select>
								<select name="user-time" id="user-time" class="time-drop capitalize">
									<option value="daily">daily</option>
									<option value="monthly">monthly</option>
									<option value="annualy">annualy</option>
								</select>
							</div>
						</div>
						<div class="graph"></div>
					</div>
				</div>
			</div>
			<div class="side-container">
				<div class="cur-sUsers">
					<div class="title f-row">
						<span class="capitalize">admins & moderators</span>
						<span class="line"></span>
					</div>
					<div class="placeholder"></div>
				</div>
				<div class="activities">
					<div class="title f-row">
						<span class="line-c"></span>
						<span>Activities</span>
						<span class="line-c"></span>
					</div>
					<div class="content f-col">
						<ul class="f-col">
							<li class="green">
								<span class="high sUser">Manuja Ransara</span>
								approved
								<span class="high act">LLP</span>
								as a Political Party
							</li>
							<li class="red">
								<span class="high sUser">Manuja Ransara</span>
								deleted
								<span class="high act">pehan ransika's post</span>
								due to innapropriate language usage
							</li>
							<li class="red">
								<span class="high sUser">himasha chinthani</span>
								deleted
								<span class="high act">Ransika charith's post</span>
								due to not following community guideline
							</li>
							<li class="blue">
								<span class="high sUser">himasha chinthani</span>
								posted an announcement
							</li>
							<li class="green">
								<span class="high sUser">Manuja Ransara</span>
								fundraising request by
								<span class="high act">Palitha</span>
							</li>
							<div class="wGradient"></div>
						</ul>
						<a href="#" class="capitalize view-btn">
							view all
						</a>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script>
		function logoutUser() {
			window.location.href = "../../index.jsp"; // Redirect to index.js
		}
	</script>
</html>

