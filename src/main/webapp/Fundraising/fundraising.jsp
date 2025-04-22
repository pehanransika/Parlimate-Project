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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundraisers</title>

    <!-- CSS Links -->
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
    <link rel="stylesheet" href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d" data-purpose="Layout StyleSheet" title="Web Awesome" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css" />

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
<body>
<%@ include file="../index/sidebar.jsp" %>
<%@ include file="../index/header/header.jsp" %>

<!-- Fundraise Request Form -->
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
            <div class="fund-contact" style="margin-bottom: 20px; font-family: Arial, sans-serif;">
                <label class="title" style="display: block; font-weight: bold; margin-bottom: 8px; font-size: 14px; color: #333;">
                    Contact Number
                </label>
                <input
                        type="tel"
                        name="contact_no"
                        required
                        pattern="[0-9]{10}"
                        maxlength="10"
                        placeholder="Enter your contact number"
                        title="Contact number must be exactly 10 digits"
                        style="width: 100%; padding: 10px 12px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px; box-sizing: border-box;"
                >
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
                            <input required type="number" name="targetamount"  id="fund-amount" min="1" placeholder="1,000,000.00">
                        </div>

                    </div>
                </div>
            </div>
            <div class="fund-attach field">
                <span for="" class="title">Upload Attachments</span>
                <div class="att-container">
                    <div class="action row">
                        <label for="fund-att" class="att-btn">Select File</label>
                        <input type="file" required name="attachmentUrl" id="fund-att" multiple>
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
                        <input type="file" name="photos" id="fund-photo" multiple >
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
            <button type="button" class="cancel-btn form-btn">Cancel</button>
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
                <a href="GetApprovedTransfersToUserServlet?userId=${userProfile.userId}">
                    <button class="my-accept-trans">
                        <i class="fa-solid fa-wallet"></i>
                        <span>My Approved Bank Transfers</span>
                    </button>
                </a>

                <a href="GetAllRequestServlet?userId=${userProfile.userId}">
                    <button class="my-funds row">
                        <i class="fa-solid fa-wallet"></i>
                        <span>my fundraises</span>
                    </button>
                </a>

                <a href="GetApprovedFundraisersByUser?userid=${userProfile.userId}">
                    <button class="my-accept-fund">
                        <i class="fa-solid fa-wallet"></i>
                        <span> Approved fundraises</span>
                    </button>
                </a>
                <a href="GetAllRejectedRequestServlet?userId=${userProfile.userId}">
                    <button class="my-funds row">
                        <i class="fa-solid fa-wallet"></i>
                        <span>Rejected Fundraisers</span>
                    </button>
                </a>
                <button class="req-funds row">
                    <i class="fa-sharp fa-solid fa-plus"></i>
                    <span>Request fundraise</span>
                </button>
            </div>

            <div class="fundraising-container">

                <div class="filter-container">

                    <div class="filter-dropdown">
                        <button class="filter-toggle" aria-expanded="false" aria-controls="dropdownMenu">
                            <span id="filter-label">All Categories</span>
                            <i class="fas fa-chevron-down"></i>
                        </button>
                        <div class="dropdown-menu" id="dropdownMenu" aria-labelledby="filter-label">
                            <div class="filter-option">
                                <input type="checkbox" id="all-categories" checked>
                                <label for="all-categories">All Categories</label>
                            </div>
                            <div class="filter-option">
                                <input type="checkbox" id="education" class="category-checkbox" checked>
                                <label for="education">Education</label>
                            </div>
                            <div class="filter-option">
                                <input type="checkbox" id="social" class="category-checkbox" checked>
                                <label for="social">Social</label>
                            </div>
                            <div class="filter-option">
                                <input type="checkbox" id="community" class="category-checkbox" checked>
                                <label for="community">Community Service</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="funds-container">
                    <c:forEach var="approveModel" items="${fundraisingRequests}">
                        <div class="fund col">
                            <div class="top col">
                                <div class="head row">
                                    <div class="title">${approveModel.title}</div>
                                </div>
                                <div class="username">
                                    Owner- <c:out value="${not empty approveModel.name ? approveModel.name : 'Anonymous'}" />
                                </div>
                                <div class="category">${approveModel.category}</div>
                            </div>

                            <div class="content col">
                                <div class="imgs row">
                                    <c:if test="${not empty approveModel.photos}">
                                        <div class="img"
                                             style="background-image: url('${pageContext.request.contextPath}/${approveModel.photos}')">
                                        </div>
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

                                    <!-- Display total_lkr -->
                                    <div class="total-lkr">
                                        Total Raised:
                                        <fmt:formatNumber value="${approveModel.totalLkr}" type="number" maxFractionDigits="0"/> LKR
                                    </div>

                                    <!-- Calculate and display percentage -->
                                    <div class="progress-bar-container">
                                        <div class="progress-bar" style="width: ${approveModel.targetamount > 0 ? (approveModel.totalLkr / approveModel.targetamount) * 100 : 0}%">
                                        </div>
                                    </div>

                                    <div class="percentage">
                                            ${approveModel.targetamount > 0 ?
                                                    (approveModel.totalLkr / approveModel.targetamount) * 100 : 0}% Raised
                                    </div>
                                </div>
                                <c:if test="${approveModel.status != 'HOLD'}">
                                    <div class="donate-btn" onclick="showPaymentPopup('${approveModel.requestId}')">
                                        <i class="fa-sharp fa-solid fa-dollar-sign"></i>
                                        <span>Donate</span>
                                    </div>
                                </c:if>


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

                <!-- Bank Transfer Form -->
                <form id="transfer-form" action="CreateTransferServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="fundraiser_id" name="fundraiser_id" value="">
                    <input type="hidden" name="user_id" value="${user.userId}">
                    <input type="hidden" name="csrfToken" value="${csrfToken}">

                    <div id="banktransfer" class="transfer-popup" style="display:none;">
                        <div class="popup-content">
                            <div class="popup-header">
                                <h3>Bank Transfer Donation</h3>
                                <span class="close-btn" onclick="closeTransferPopup()">&times;</span>
                            </div>
                            <div class="transfer-details">
                                <h3>Bank Transfer Information</h3>

                                <!-- Bank Information -->
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
                                    <input type="text" id="other-bank" name="bank_name" style="display:none; margin-top:5px;"
                                           placeholder="Please specify bank name">
                                </div>

                                <!-- Account Details -->
                                <div class="form-group">
                                    <label for="account-holder">Account Holder Name*</label>
                                    <input type="text" id="account-holder" name="account_holder_name" required
                                           placeholder="As it appears in bank records">
                                </div>

                                <div class="form-group">
                                    <label for="account_number">Account Number*</label>
                                    <input type="text" id="account_number" name="account_number" required
                                           placeholder="Your bank account number">
                                </div>

                                <div class="form-group">
                                    <label for="branch">Branch Name</label>
                                    <input type="text" id="branch" name="branch"
                                           placeholder="Bank branch location">
                                </div>

                                <!-- Transfer Details -->
                                <div class="form-group">
                                    <label for="transfer-amount">Transfer Amount (LKR)*</label>
                                    <input type="number" id="transfer-amount" name="amount" min="100" step="100" required
                                           placeholder="Minimum 100 LKR">
                                </div>

                                <div class="form-group">
                                    <label for="currency">Currency*</label>
                                    <select id="currency" name="currency" required>
                                        <option value="LKR">LKR</option>
                                        <option value="USD">USD</option>
                                    </select>
                                </div>

                                <!-- Receipt Upload -->
                                <div class="form-group">
                                    <label for="receipt">Upload Transfer Receipt*</label>


                                    <input type="file" name="receipt_image_path" id="receipt" multiple >
                                    <small>Upload clear image/PDF of your bank transfer receipt</small>
                                </div>

                                <!-- Reference Code -->
                                <div class="form-group">
                                    <label for="reference">Payment Reference*</label>
                                    <input type="text" id="reference" name="reference_code" required readonly>
                                    <small>Include this code in your transfer description</small>
                                </div>

                                <!-- Confirmation -->
                                <div class="form-checkbox">
                                    <input type="checkbox" id="confirm-terms" name="confirm_terms" required>
                                    <label for="confirm-terms">I confirm this transfer is from my own account</label>
                                </div>

                                <!-- Form Actions -->
                                <div class="form-actions">
                                    <button type="button" class="cancel-btn" onclick="closeTransferPopup()">Cancel</button>
                                    <button type="submit" class="submit-btn">Submit Transfer</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript Files -->
<script src="../loadSidebar.js"></script>
<script src="./fund-pop.js"></script>

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
        document.getElementById('fundraiser_id').value = requestId;
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

    document.addEventListener('DOMContentLoaded', function() {
        // UI Elements
        const filterToggle = document.querySelector('.filter-toggle');
        const dropdownMenu = document.getElementById('dropdownMenu');
        const allCategoriesCheckbox = document.getElementById('all-categories');
        const categoryCheckboxes = document.querySelectorAll('.category-checkbox');

        // Toggle dropdown
        filterToggle.addEventListener('click', function(e) {
            e.stopPropagation();
            const isExpanded = this.getAttribute('aria-expanded') === 'true';
            this.setAttribute('aria-expanded', !isExpanded);
            dropdownMenu.classList.toggle('show', !isExpanded);
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function() {
            filterToggle.setAttribute('aria-expanded', 'false');
            dropdownMenu.classList.remove('show');
        });

        // Prevent dropdown close when clicking inside
        dropdownMenu.addEventListener('click', function(e) {
            e.stopPropagation();
        });

        // Handle "All Categories" checkbox
        allCategoriesCheckbox.addEventListener('change', function() {
            const isChecked = this.checked;
            categoryCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            filterProjects();
        });

        // Handle individual category checkboxes
        categoryCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                if (!this.checked) {
                    allCategoriesCheckbox.checked = false;
                } else if (Array.from(categoryCheckboxes).every(cb => cb.checked)) {
                    allCategoriesCheckbox.checked = true;
                }
                filterProjects();
            });
        });

        // Keyboard navigation
        filterToggle.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                this.click();
            }
        });

        // Main filtering function
        function filterProjects() {
            const allChecked = allCategoriesCheckbox.checked;
            const selectedCategories = getSelectedCategories();

            updateFilterLabel(selectedCategories, allChecked);
            filterProjectElements(selectedCategories, allChecked);
        }

        // Get selected categories
        function getSelectedCategories() {
            if (allCategoriesCheckbox.checked) return [];

            return Array.from(categoryCheckboxes)
                .filter(cb => cb.checked)
                .map(cb => {
                    switch(cb.id) {
                        case 'education': return 'Education';
                        case 'social': return 'Social';
                        case 'community': return 'Community Service';
                        default: return '';
                    }
                })
                .filter(Boolean);
        }

        // Update the filter label
        function updateFilterLabel(selectedCategories, allChecked) {
            const filterLabel = document.getElementById('filter-label');
            filterLabel.textContent = allChecked ? 'All Categories' :
                selectedCategories.length ? selectedCategories.join(', ') : 'Select Categories';
        }

        // Filter project elements
        function filterProjectElements(selectedCategories, allChecked) {
            document.querySelectorAll('.fund').forEach(project => {
                const categoryElement = project.querySelector('.category');
                const category = categoryElement ? categoryElement.textContent.trim() : '';

                const shouldShow = allChecked || selectedCategories.includes(category);
                project.style.display = shouldShow ? 'flex' : 'none';
            });
        }

        // Initial filter on page load
        filterProjects();
    });
</script>
</body>
</html>