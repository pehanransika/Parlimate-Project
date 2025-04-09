<%@ page import="java.util.UUID" %>
<%
	// Session check
	HttpSession session1 = request.getSession(false);
	if (session1 == null || session.getAttribute("user") == null) {
		response.sendRedirect("../index.jsp");
		return;
	}

	// Generate CSRF token
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
		<link rel="stylesheet" href="../container.css" />
		<link rel="stylesheet" href="./fund-popup.css" />

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
	</head>
	<body class="">
		<%@ include file="../index/sidebar.jsp" %>
		<%@ include file="../index/header/header.jsp" %>

		<div class="container col">
			<div class="pageTitles">
				<h2 class="title">Surveys</h2>
				<div class="subTitle">Create and Vote Surveys</div>

				<div class="tab-container">
					<div class="tab"
						 id="parliament-tab"
						 onclick="window.location.href='../Surveys/surveys.jsp'">
						Parlimate surveys
					</div>

					<div
						class="tab"
						id="user-tab"
						onclick="window.location.href='../Surveys/userSurveys.jsp'"
					>
						User surveys
					</div>
					<div
						class="tab"
						id="your-tab"
						onclick="window.location.href='../Surveys/yourSurveys.jsp'"
					>
						Your surveys
					</div>
					<div class="slider" id="slider"></div>
				</div>
			</div>

			<div class="content">
				<div class="survey-card f-col">
					<div class="top f-row">
						<div class="profile f-row">
							<div class="p-img"></div>
							<div class="surv-details f-col">
								<div class="name">Manuja ransara</div>
								<div class="date">April 1</div>
							</div>
						</div>
						<button id="share-btn" class="f-row">
							Share <i class="fa-solid fa-share"></i>
						</button>
					</div>
					<div class="content f-col">
						<div class="current-question">
							<div class="pg-no f-row">
								<div class="cur-pg">1</div>
								of
								<div class="all-pgs">3</div>
							</div>
							<div class="question">
								Should Sri Lanka adopt a new constitution?
							</div>
						</div>
						<div class="responses f-col">
							<div class="response">
								<input
									type="radio"
									name="response-1"
									id="response-1"
								/>
								<label for="response-1"
									>Yes, we need a completely new
									constitution</label
								>
							</div>
						</div>
						<div class="survey-details caps f-row">
							<div class="tot-votes">
								total votes
								<span>42</span>
							</div>
							<span>·</span>
							<div class="deadline">
								<span class="count">7</span>
								days left
							</div>
						</div>
						<div class="surv-btns caps f-row">
							<button id="analytics-btn" class="analytics-btn">
								View analytics
							</button>
							<div class="navigate-btns f-row">
								<button id="prev-btn" class="prev">
									<i class="fa-solid fa-chevron-left"></i>
								</button>
								<button id="next-btn" class="next">
									Next
									<i class="fa-solid fa-arrow-right-long"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
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
					window.location.href = selectedValue; // Redirect to the selected page
				}
			});
		});
	</script>
	<script>
		document.addEventListener("DOMContentLoaded", function () {
			const currentPath = window.location.pathname;
			let activeTab;

			if (currentPath.includes("/surveys")) {
				activeTab = document.getElementById("parliament-tab");
			} else if (currentPath.includes("/userSurveys")) {
				activeTab = document.getElementById("user-tab");
			} else if (currentPath.includes("/yourSurveys")) {
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

	<script>
		const surveyData = [
			{
				question: "Should Sri Lanka adopt a new constitution?",
				answers: [
					"Yes, we need a completely new constitution",
					"No, the current constitution is sufficient",
					"We should amend the existing constitution instead",
					"I'm not sure/don't have an opinion",
				],
				totalVotes: 42,
				daysLeft: 7,
			},
			{
				question: "What should be the priority for economic recovery?",
				answers: [
					"Foreign investment and exports",
					"Local industry development",
					"Tourism sector revival",
					"Agriculture modernization",
				],
				totalVotes: 35,
				daysLeft: 5,
			},
			{
				question:
					"How should the government address the energy crisis?",
				answers: [
					"Invest more in renewable energy",
					"Continue with current fossil fuel solutions",
					"Privatize the energy sector",
					"Increase nuclear power options",
				],
				totalVotes: 28,
				daysLeft: 3,
			},
		];

		let currentQuestionIndex = 0;
		let isAnimating = false;

		// Add CSS for transitions
		const style = document.createElement("style");
		style.textContent = `
			.animated-section {
				transition: opacity 0.3s ease, transform 0.3s ease;
			}
			.slide-out-left {
				opacity: 0;
				transform: translateX(-0.25rem);
			}
			.slide-out-right {
				opacity: 0;
				transform: translateX(0.25rem);
			}
			.slide-in-left {
				opacity: 0;
				transform: translateX(0.25rem);
			}
			.slide-in-right {
				opacity: 0;
				transform: translateX(-0.25rem);
			}
			.slide-in-active {
				opacity: 1;
				transform: translateX(0);
			}
			`;
		document.head.appendChild(style);

		function loadQuestion(index, direction) {
			if (isAnimating) return;
			isAnimating = true;

			const questionElement = document.querySelector(".question");
			const responsesElement = document.querySelector(".responses");
			const animatedElements = [questionElement, responsesElement];

			animatedElements.forEach((el) =>
				el.classList.add("animated-section")
			);

			animatedElements.forEach((el) => {
				el.classList.add(
					direction === "next" ? "slide-out-left" : "slide-out-right"
				);
			});

			setTimeout(() => {
				const question = surveyData[index];

				document.querySelector(".cur-pg").textContent = index + 1;
				document.querySelector(".all-pgs").textContent =
					surveyData.length;

				questionElement.textContent = question.question;

				document.querySelector(".tot-votes span").textContent =
					question.totalVotes;
				document.querySelector(".deadline .count").textContent =
					question.daysLeft;

				responsesElement.innerHTML = "";
				question.answers.forEach((answer, i) => {
					const responseDiv = document.createElement("div");
					responseDiv.className = "response";

					const inputId = `response-${i + 1}`;

					responseDiv.innerHTML = `
            <input type="radio" name="response" id="${inputId}">
            <label for="${inputId}">${answer}</label>
        `;
					responsesElement.appendChild(responseDiv);
				});

				document.getElementById("prev-btn").disabled = index === 0;
				document.getElementById("next-btn").innerHTML =
					index === surveyData.length - 1 ? `Finish <i class="fa-solid fa-check"></i>` : `Next <i class="fa-solid fa-arrow-right-long"></i>`;

				animatedElements.forEach((el) => {
					el.classList.remove("slide-out-left", "slide-out-right");
					el.classList.add(
						direction === "next"
							? "slide-in-right"
							: "slide-in-left"
					);
					el.style.display = "block"; 
				});

				void questionElement.offsetWidth;

				animatedElements.forEach((el) => {
					el.classList.add("slide-in-active");
					el.classList.remove("slide-in-left", "slide-in-right");
				});

				setTimeout(() => {
					animatedElements.forEach((el) => {
						el.classList.remove("slide-in-active");
					});
					isAnimating = false;
				}, 300);
			}, 300);
		}

		document
			.getElementById("next-btn")
			.addEventListener("click", function () {
				if (currentQuestionIndex < surveyData.length - 1) {
					currentQuestionIndex++;
					loadQuestion(currentQuestionIndex, "next");
				} else {
					alert("Survey completed! Thank you for your responses.");
				}
			});

		document
			.getElementById("prev-btn")
			.addEventListener("click", function () {
				if (currentQuestionIndex > 0) {
					currentQuestionIndex--;
					loadQuestion(currentQuestionIndex, "prev");
				}
			});

		document.addEventListener("DOMContentLoaded", function () {
			loadQuestion(currentQuestionIndex, "next");
		});
	</script>
</html>
