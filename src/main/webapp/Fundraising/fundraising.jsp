<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundraisers</title>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="fundraising.css" rel="stylesheet">
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./fund-popup.css" />
    <link rel="stylesheet" href="./payment.css" />
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

</head>
<body class="">

<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>
<form action="CreateRequestServlet" method="post" class="popup-f" id="popup-f" enctype="multipart/form-data">
    <div class="bg"></div>
    <div class="fund-popup col">
        <div class="head row">
            <div class="close-btn">
                <i class="fa-solid fa-xmark"></i>
            </div>
            <div class="icon">
                <i class="fa-regular fa-briefcase"></i>
            </div>
            <div class="title">Request a fundraise</div>
            <div class="separator"></div>
        </div>
        <div class="body col">
            <div class="fund-title field">
                <label for="fundtitle" class="title">Title</label>
                <input type="text" required placeholder="Fundraise for the senior care house" name="title" id="fundtitle">
            </div>
            <input type="hidden" name="userid" id="useri" value="${user.userId}" />
            <input type="hidden" name="username" id="usernam" value="${userProfile.name}" />
            <div class="fund-decs field">
                <label for="fund-desc" class="title">Description</label>
                <textarea required name="description" placeholder="Every elderly person deserves a life filled with dignity, care, and comfort..." id="fund-desc"></textarea>
            </div>
            <div class="fund-popup">
                <!-- other elements -->
                <div class="fund-contact">
                    <label class="title">Contact Number</label>
                    <input type="tel" placeholder="Enter your contact number" name="contact_no">
                </div>
                <!-- other elements -->
            </div>
            <div class="multi-fields row">
                <div class="fund-cat field">
                    <label for="fund-categ" class="title">Category</label>
                    <select required name="category" id="fund-categ">
                        <option value="educational">Educational</option>
                        <option value="social">Social</option>
                        <option value="community-se">Community Service</option>
                    </select>
                </div>
                <div class="fund-amount field col">
                    <label class="title" for="fund-amount">Fund Target</label>
                    <div class="content row">
                        <div class="curr">
                            <select required name="currency" id="fund-currency">
                                <option value="lkr">LKR</option>
                                <option value="usd">USD</option>
                            </select>
                        </div>
                        <div class="amount">
                            <input required type="number" name="targetamount" step="1000" id="fund-amount" placeholder="1,000,000.00">
                        </div>
                    </div>
                </div>
            </div>

            <div class="fund-attach field">
                <span for="" class="title">Upload Attachments</span>
                <div class="att-container">
                    <div class="action row">
                        <label for="fund-att" class="att-btn">Select File</label>
                        <input type="file" name="attachmentUrl" id="fund-att" multiple>
                        <div class="sep"></div>
                    </div>
                    <div class="att-content">
                        <span class="no-of-files">No file attached</span>
                        <ul id="att-list" class="col">
                            <!-- uploaded files will be listed here -->
                        </ul>
                    </div>
                </div>
            </div>
            <div class="fund-photo field">
                <span for="" class="title">Upload Photos</span>
                <div class="att-container-photo">
                    <div class="action row-photo">
                        <label for="fund-photo" class="photo-btn">Select Photo</label>
                        <input type="file" name="photoUrl" id="fund-photo" multiple>
                        <div class="sep"></div>
                    </div>
                    <div class="photo-content">
                        <span class="no-of-files">No Photo attached</span>
                        <ul id="photo-list" class="col">
                            <!-- uploaded files will be listed here -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="bottom row">
            <button class="cancel-btn form-btn">Cancel</button>
            <button type="submit" class="submit-btn form-btn row">
                <i class="fa-duotone fa-solid fa-check"></i>
                Publish
            </button>
        </div>
    </div>
</form>

<div class="container">
    <div class="fundraisers-container">
        <div id="fundraisers" class="section">
            <div class="pageTitles">
                <h2 class="title">Fundraisers</h2>
                <div class="subTitle">
                    Fueling Change Through Collective Action
                </div>
            </div>
            <div class="fund-btns row">
                <a href="GetAllRequestServlet">
                <button class="my-funds row">
                    <i class="fa-solid fa-wallet"></i>
                    <span>
                        my fundraises
                    </span>
                </button>
                </a>
                <button class="req-funds row">
                    <i class="fa-sharp fa-solid fa-plus"></i>
                    <span>
                        Request fundraise
                    </span>
                </button>
            </div>





            <div class="fundraising-container">
                <h1>My Fundraises</h1>



                <div class="funds-container">
                    <c:forEach var="approveModel" items="${fundraisingRequests}">
                        <div class="fund col">
                            <div class="top col">
                                <div class="head row">
                                    <div class="title">${approveModel.title}</div>
                                </div>
                                <div class="category">${approveModel.category}</div>
                            </div>

                            <div class="content col">
                                <div class="imgs row">
                                    <c:if test="${not empty approveModel.photos}">
                                        <div class="img" style="background-image: url('${approveModel.photos}')"></div>
                                    </c:if>
                                </div>

                                <div class="desc">${approveModel.description}</div>

                                <div class="donations row">
                                    <!-- Simplified currency display - no need for empty check now -->

                                    <div class="target">
                                        <fmt:formatNumber value="${approveModel.targetamount}" type="number" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </div>

                            <div class="bottom">
                                <div class="donation-progress row">
                                    <div class="seperator top"></div>
                                </div>

                                <div class="donate-btn">
                                    <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                                    <span>Donate</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <!-- Add this modal/popup structure at the bottom of your page -->
                <div id="paymentPopup" class="payment-popup">
                    <div class="popup-content">
                        <div class="popup-header">
                            <h3>Select Payment Method</h3>
                            <span class="close-popup">&times;</span>
                        </div>
                        <div class="payment-options">
                            <div class="payment-method" data-method="card">
                                <i class="fas fa-credit-card"></i>
                                <span>Credit/Debit Card</span>
                            </div>
                            <div class="payment-method" data-method="bank">
                                <i class="fas fa-university"></i>
                                <span>Bank Transfer</span>
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

    // Get the modal and button elements

        // Get elements
        const donateBtn = document.getElementById('donateButton');
        const paymentPopup = document.getElementById('paymentPopup');
        const closePopup = document.querySelector('.close-popup');
        const paymentMethods = document.querySelectorAll('.payment-method');

        // Show popup when donate button is clicked
        donateBtn.addEventListener('click', function() {
        paymentPopup.style.display = 'flex';
    });

        // Close popup when X is clicked
        closePopup.addEventListener('click', function() {
        paymentPopup.style.display = 'none';
    });

        // Close popup when clicking outside content
        paymentPopup.addEventListener('click', function(e) {
        if (e.target === paymentPopup) {
        paymentPopup.style.display = 'none';
    }
    });

        // Handle payment method selection
        paymentMethods.forEach(method => {
        method.addEventListener('click', function () {
            const paymentType = this.getAttribute('data-method');
            paymentPopup.style.display = 'none';

            // Handle the selected payment method
            if (paymentType === 'card') {
                // Redirect to card payment page or show card form
                alert('Redirecting to card payment...');
                // window.location.href = 'card-payment.jsp';
            } else if (paymentType === 'bank') {
                // Show bank transfer details
                alert('Bank transfer details:\nBank: MyBank\nAccount: 1234567890\nIFSC: ABCD1234567');
            }
        });
    });

</script>
<script src="./fund-pop.js"></script>

</html>
