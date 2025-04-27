<%@ page import="java.util.UUID" %>
<%

	HttpSession session1 = request.getSession(false);
	if (session1 == null || session.getAttribute("user") == null) {
		response.sendRedirect("../index.jsp");
		return;
	}


	String csrfToken = UUID.randomUUID().toString();
	session.setAttribute("csrfToken", csrfToken);
%>


<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Surveys</title>
		<link
			href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"
			rel="stylesheet"
		/>
		<link
			href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
			rel="stylesheet"
		/>
		<link href="survey.css" rel="stylesheet" />
		<link rel="stylesheet" href="../index.css" />
		<link rel="stylesheet" href="../index/sidebar1.css" />
		<link rel="stylesheet" href="../index/header/header.css" />

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
			href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
		/>

		<link rel="stylesheet" href="./surveys.css" />
		<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
	</head>
	<body class="">
		<%@ include file="../index/sidebar.jsp" %>
		<%@ include file="../index/header/header.jsp" %>

		<div class="container col">
			<div class="pageTitles">
				<h2 class="title">Surveys</h2>
				<div class="subTitle">Create and Vote Surveys</div>

				<div style="display: flex; justify-content: center; align-items: center;width:100%;">
					<input type="text" placeholder="Search Surveys" style="width: 500px; height: 35px; border-radius: 20px; font-size: 20px; padding: 0 10px; text-align: center;">
					<button style="width: 40px; height: 40px; border-radius: 20px; margin-left: 10px; background-color: #ccc; border: none; font-size: 20px; color: black; display: flex; justify-content: center; align-items: center;">
						<i class="far fa-search"></i>
					</button>
				</div>

				<div class="tab-container">
					<div class="tabs">
							<div class="tab"
								 id="parliament-tab"
								 onclick="window.location.href='../Surveys/GetParlimateSurveysServlet'">
								Parlimate surveys
							</div>

							<div
								class="tab"
								id="user-tab"
								onclick="window.location.href='../Surveys/GetUserSurveysServlet'"
							>
								User surveys
							</div>
							<div
								class="tab"
								id="your-tab"
								onclick="window.location.href='../Surveys/GetYourSurveysServlet'"
							>
								Your surveys
							</div>
					</div>
				</div>
			</div>
			<div class="contents">



                     <%@ include file="../Surveys/surveyPrototype.jsp" %>



			</div>
		</div>

	</body>
	<script src="../loadSidebar.js"></script>
	<script>
		let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
		const body = document.querySelector("body");
		const navRadios = document.querySelectorAll('input[name="nav"]');

		sideMenuBtns.forEach((btn) => {
			btn.addEventListener("click", () => {
				if (body.classList.contains("sidebar-deactive")) {
					body.classList.remove("sidebar-deactive");
				} else {
					body.classList.add("sidebar-deactive");
				}
			});
		});

		navRadios.forEach((radio) => {
			radio.addEventListener("change", (event) => {
				const selectedValue = event.target.value;
				if (selectedValue) {
					window.location.href = selectedValue;
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
			const currentPath = window.location.pathname;
			let activeTab;

			if (currentPath.includes("/GetParlimateSurveysServlet")) {
				activeTab = document.getElementById("parliament-tab");
			} else if (currentPath.includes("/GetUserSurveysServlet")) {
				activeTab = document.getElementById("user-tab");
			} else if (currentPath.includes("/GetYourSurveysServlet")) {
				activeTab = document.getElementById("your-tab");
			}

			if (!activeTab) {
				activeTab = document.getElementById("parliament-tab");
			}
			activeTab.classList.add("active");

			const slider = document.getElementById("slider");
			slider.style.width = activeTab.offsetWidth + "px";
			slider.style.left = activeTab.offsetLeft + "px";
		});
	</script>


</html>
