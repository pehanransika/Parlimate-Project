<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <link rel="stylesheet" href="./transfer.css" />

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
    <style>
        /* Transfer Popup Styles */
        .transfer-popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .transfer-popup .popup-content {
            background: white;
            width: 90%;
            max-width: 500px;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .transfer-popup .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .transfer-popup .close-btn {
            font-size: 24px;
            cursor: pointer;
            background: none;
            border: none;
        }

        .transfer-details .form-group {
            margin-bottom: 15px;
        }

        .transfer-details label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        .transfer-details input,
        .transfer-details select,
        .transfer-details textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .transfer-details .form-checkbox {
            margin: 15px 0;
            display: flex;
            align-items: center;
        }

        .transfer-details .form-checkbox input {
            margin-right: 10px;
        }

        /* Payment Popup Styles */
        .payment-popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .payment-popup .popup-content {
            background: white;
            width: 90%;
            max-width: 400px;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .payment-popup .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .payment-popup .close-popup {
            font-size: 24px;
            cursor: pointer;
            background: none;
            border: none;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .payment-method {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .payment-method:hover {
            background-color: #f5f5f5;
            border-color: #aaa;
        }

        .payment-method i {
            font-size: 24px;
        }
    </style>
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
                <a href="GetAllFundraisingApprovelServlet">
                    <button class="my-accept-fund">
                        <i class="fa-solid fa-wallet"></i>
                        <span>
                            my Approved fundraises
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
                                    <div class="target">
                                        <fmt:formatNumber value="${approveModel.targetamount}" type="number" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </div>

                            <div class="bottom">
                                <div class="donation-progress row">
                                    <div class="seperator top"></div>
                                </div>

                                <div class="donate-btn" onclick="showPaymentPopup('${approveModel.requestId}')">
                                    <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                                    <span>Donate</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Payment Popup -->
                <div id="paymentPopup" class="payment-popup" style="display: none;">
                    <div class="popup-content">
                        <div class="popup-header">
                            <h3>Select Payment Method</h3>
                            <span class="close-popup" onclick="closePaymentPopup()">&times;</span>
                        </div>
                        <div class="payment-options">
                            <div class="payment-method" onclick="selectPaymentMethod('card')">
                                <i class="fas fa-credit-card"></i>
                                <span>Credit/Debit Card</span>
                            </div>
                            <div class="payment-method" onclick="selectPaymentMethod('bank')">
                                <i class="fas fa-university"></i>
                                <span>Bank Transfer</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="banktransfer" class="transfer-popup" style="display:none;">
                    <div class="popup-content">
                        <div class="popup-header">
                            <h3>Bank Transfer Donation</h3>
                            <span class="close-btn" onclick="closeTransferPopup()">&times;</span>
                        </div>
                        <div class="transfer-details">
                            <h3>Bank Transfer Information</h3>

                            <div class="form-group">
                                <label for="bank-name">Bank Name*</label>
                                <select id="bank-name" name="bank_name" required>
                                    <option value="">Select your bank</option>
                                    <option value="Commercial Bank">Commercial Bank</option>
                                    <option value="People's Bank">People's Bank</option>
                                    <option value="Bank of Ceylon">Bank of Ceylon</option>
                                    <option value="Hatton National Bank">Hatton National Bank</option>
                                    <option value="Sampath Bank">Sampath Bank</option>
                                    <option value="other">Other Bank</option>
                                </select>
                                <input type="text" id="other-bank" name="other_bank" style="display:none; margin-top:5px;"
                                       placeholder="Please specify bank name">
                            </div>

                            <div class="form-group">
                                <label for="account-holder">Account Holder Name*</label>
                                <input type="text" id="account-holder" name="account_holder" required
                                       placeholder="As it appears in bank records">
                            </div>

                            <div class="form-group">
                                <label for="account-number">Account Number*</label>
                                <input type="text" id="account-number" name="account_number" required
                                       placeholder="Your bank account number">
                            </div>

                            <div class="form-group">
                                <label for="branch">Branch Name</label>
                                <input type="text" id="branch" name="branch"
                                       placeholder="Bank branch location">
                            </div>

                            <div class="form-group">
                                <label for="transfer-amount">Transfer Amount (LKR)*</label>
                                <input type="number" id="transfer-amount" name="amount" min="100" step="100" required
                                       placeholder="Minimum 100 LKR">
                            </div>

                            <div class="form-group">
                                <label for="receipt">Upload Transfer Receipt*</label>
                                <input type="file" id="receipt" name="receipt" accept="image/*,.pdf" required>
                                <small>Upload clear image/PDF of your bank transfer receipt</small>
                            </div>

                            <div class="form-group">
                                <label for="reference">Payment Reference*</label>
                                <input type="text" id="reference" name="reference" required readonly
                                       value="DON-<%= System.currentTimeMillis() %>">
                                <small>Include this code in your transfer description</small>
                            </div>

                            <div class="form-checkbox">
                                <input type="checkbox" id="confirm-terms" name="confirm_terms" required>
                                <label for="confirm-terms">I confirm this transfer is from my own account and complies with platform rules</label>
                            </div>
                            <div class="form-actions">
                                <button type="button" class="cancel-btn" onclick="closeTransferPopup()">Cancel</button>
                                <button type="submit" class="submit-btn">Submit Transfer</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="../loadSidebar.js"></script>
<script>
    // Sidebar and navigation functionality
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

    sideMenuBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            body.classList.toggle("sidebar-deactive");
        });
    });

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue;
            }
        });
    });

    // Payment and transfer popup functionality
    let currentRequestId = '';

    function showPaymentPopup(requestId) {
        currentRequestId = requestId;
        document.getElementById('paymentPopup').style.display = 'flex';
    }

    function closePaymentPopup() {
        document.getElementById('paymentPopup').style.display = 'none';
    }

    function selectPaymentMethod(method) {
        closePaymentPopup();
        if (method === 'card') {
            window.location.href = 'card-payment.jsp?requestId=' + currentRequestId;
        } else if (method === 'bank') {
            showTransferPopup(currentRequestId);
        }
    }

    function showTransferPopup(requestId) {
        currentRequestId = requestId;
        // Generate reference code
        document.getElementById('reference').value = 'DON-' + requestId + '-' + Math.floor(Math.random() * 10000);
        document.getElementById('banktransfer').style.display = 'flex';
    }

    function closeTransferPopup() {
        document.getElementById('banktransfer').style.display = 'none';
        document.getElementById('transfer-form').reset();
    }

    // Close popups when clicking outside
    document.getElementById('paymentPopup').addEventListener('click', function(e) {
        if (e.target === this) {
            closePaymentPopup();
        }
    });

    document.getElementById('banktransfer').addEventListener('click', function(e) {
        if (e.target === this) {
            closeTransferPopup();
        }
    });

    // Show other bank input if "Other Bank" is selected
    document.getElementById('bank-name').addEventListener('change', function() {
        const otherBankInput = document.getElementById('other-bank');
        otherBankInput.style.display = this.value === 'other' ? 'block' : 'none';
        if (this.value !== 'other') {
            otherBankInput.value = '';
        }
    });

    // Form submission handling
    document.getElementById('transfer-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        formData.append('request_id', currentRequestId);

        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Processing...';

        // Here you would typically send the data to your server
        fetch('/process-bank-transfer', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Bank transfer details submitted successfully!');
                    closeTransferPopup();
                } else {
                    alert('Error: ' + (data.message || 'Submission failed'));
                }
            })
            .catch(error => {
                alert('Network error. Please try again.');
            })
            .finally(() => {
                submitBtn.disabled = false;
                submitBtn.innerHTML = 'Submit Transfer';
            });
    });

</script>
<script src="./fund-pop.js"></script>

</html>