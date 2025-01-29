<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications | Parlimate</title>
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="../index/sidebar1.css" />
    <link rel="stylesheet" href="../index/header/header.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="./help1.css" />


    <!-- icons -->
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

<body>
<!-- Chatbot Popup -->
<div id="chatbot-popup" class="chatbot-popup">
    <h2>Need Help?</h2>
    <p>Hi there! How can I assist you today?</p>
    <button onclick="opennewChat()">Start Chat</button>
    <button onclick="closeChat()">Close</button>
</div>

<div class="container">
    <header>
        <h1>Welcome to Parlimate Support</h1>
        <p>Your go-to place for assistance and guidance.</p>
    </header>

    <section class="search-section">
        <input type="text" id="searchInput" placeholder="Search for help topics...">
        <button onclick="searchHelp()">🔍</button>
    </section>

    <section class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-card" onclick="toggleFaq(0)">
            <h3>How do I create a fundraiser?</h3>
            <p class="faq-answer">To start a fundraiser, navigate to the "Fundraisers" section and click "Start A Fundraise". Follow the steps provided to set up your fundraiser.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(1)">
            <h3>How do I reset my password?</h3>
            <p class="faq-answer">To reset your password, click on "Forgot Password" on the login screen and follow the instructions sent to your registered email.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(2)">
            <h3>How do I contact customer support?</h3>
            <p class="faq-answer">You can reach us via email at <a href="mailto:support@parlimate.com">support@parlimate.com</a> or use the chat feature to get in touch with a support agent.</p>
        </div>
    </section>

    <section class="contact-section">
        <h2>Still Need Help?</h2>
        <p>If you couldn't find the answer you're looking for, feel free to start a chat with our support team.</p>
        <button onclick="openChat()">Contact Support</button>
    </section>
</div>

<script src="help.js"></script>
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

    navRadios.forEach(radio => {
        radio.addEventListener('change', (event) => {
            const selectedValue = event.target.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected page
            }
        });
    });
</script>
</body>
</html>