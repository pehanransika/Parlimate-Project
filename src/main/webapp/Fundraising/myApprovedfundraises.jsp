<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Approved Fundraisers</title>
    <link rel="stylesheet" href="./approved.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Additional inline styles as fallback */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        .status.approved {
            background: #e6f7ee;
            color: #28a745;
        }
    </style>
</head>
<body>

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<div class="container">
    <h1>My Approved Fundraisers</h1>

    <c:choose>
        <c:when test="${not empty fundraisingRequests}">
            <div class="fundraiser-list">
                <c:forEach var="fund" items="${fundraisingRequests}">
                    <div class="fundraiser-card">
                        <div class="fundraiser-image"
                             style="background-image: url('${not empty fund.photos ? fund.photos : pageContext.request.contextPath.concat('/images/default.jpg')}')">
                        </div>
                        <div class="fundraiser-details">
                            <h3><c:out value="${fund.title}"/></h3>
                            <p><c:out value="${fund.description}"/></p>
                            <div class="fundraiser-meta">
                                <span>$<fmt:formatNumber value="${fund.targetamount}" type="number"/></span>
                                <a href="ViewFundraiserDetails?id=${fund.requestId}" class="view-button">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <p>No approved fundraisers found.</p>
        </c:otherwise>
    </c:choose>
</div>
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
        })
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        })
    });
    <script src="../loadSidebar.js"></script>
<script src="./fund-pop.js"></script>


</script>
</body>

</html>