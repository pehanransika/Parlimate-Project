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
    <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
          href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css" />
    <link rel="stylesheet" href="Contact/contact.css">
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
        <input type="text" id="searchInput" placeholder="Search for help topics..." oninput="searchHelp()">
        <button>
            <i class="fas fa-search"></i> <!-- Font Awesome Search Icon -->
        </button>
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
        <!-- Additional FAQs -->
        <div class="faq-card" onclick="toggleFaq(3)">
            <h3>How do I create a political survey?</h3>
            <p class="faq-answer">To create a survey, go to the "Surveys" section and click "Create New Survey". You will be guided through the steps to design your survey and launch it to your audience.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(4)">
            <h3>How can I join a political party?</h3>
            <p class="faq-answer">To join a political party, navigate to the "Political Parties" section, choose the party you are interested in, and follow the instructions to register or apply for membership.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(5)">
            <h3>How do I schedule a meeting with a politician?</h3>
            <p class="faq-answer">To schedule a meeting with a politician, visit their profile and click "Schedule a Meeting". You can choose between physical, phone, or online meetings based on availability.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(6)">
            <h3>How do I update my political profile?</h3>
            <p class="faq-answer">To update your profile, log into your account, go to the "Profile" section, and click "Edit". You can update your contact information, policies, and other relevant details.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(7)">
            <h3>What are the benefits of subscribing to Parlimate?</h3>
            <p class="faq-answer">Subscribing to Parlimate gives you access to exclusive features, such as enhanced political engagement tools, advanced analytics for surveys and fundraising, and direct access to politicians and political parties.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(8)">
            <h3>How do I donate to a fundraiser?</h3>
            <p class="faq-answer">To donate to a fundraiser, navigate to the fundraiser page and click the "Donate Now" button. You can choose your preferred payment method and the amount you'd like to contribute.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(9)">
            <h3>Can I track my donation history?</h3>
            <p class="faq-answer">Yes, you can track your donation history by visiting the "Donation History" section in your account. Here, you will find details of all past contributions made through Parlimate.</p>
        </div>
        <div class="faq-card" onclick="toggleFaq(10)">
            <h3>How can I access political discussion rooms?</h3>
            <p class="faq-answer">To access discussion rooms, go to the "Discussions" section in the app. You can join active discussions or create a new room for a topic you're interested in.</p>
        </div>
    </section>


    <section class="contact-section">
        <h2>Still Need Help?</h2>
        <p>If you couldn't find the answer you're looking for, feel free to start a chat with our support team.</p>
        <button onclick="openChat()">Contact Support</button>
    </section>
</div>

<!-- Support Popup -->
<div id="supportPopup" class="popup-overlay">
    <div class="popup-content">
        <span class="close-btn" onclick="closeSupportPopup()">&times;</span>
        <h2>Contact Support</h2>
        <p>Our support team is here to help you with any questions or issues you may have.</p>

        <!-- Contact Form -->
        <form id="contactForm" action="SupportMessageServlet" method="POST">
            <label for="name">Your Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your name" required>

            <label for="email">Your Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="message">Your Message</label>
            <textarea id="message" name="message" placeholder="Enter your message" rows="4" required></textarea>

            <div class="form-buttons">
                <button type="button" onclick="clearSupportForm()" class="clear-btn">Clear</button>
                <button type="submit" class="submit-btn">Submit</button>
            </div>

            <p id="formMessage" class="form-message"></p>
        </form>
    </div>
</div>

<script src="help.js"></script>
<script>
    function searchHelp() {
        // Get the search query
        const query = document.getElementById('searchInput').value.toLowerCase();

        // Get all the FAQ cards
        const faqCards = document.querySelectorAll('.faq-card');

        // Loop through each card and check if the title or the answer contains the search query
        faqCards.forEach(card => {
            const title = card.querySelector('h3').innerText.toLowerCase();
            const answer = card.querySelector('.faq-answer').innerText.toLowerCase();

            // If the query matches the title or the answer, display the card; otherwise, hide it
            if (title.includes(query) || answer.includes(query)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }
    // Show the popup
    function showSupportPopup() {
        document.getElementById("supportPopup").style.display = "flex";
    }

    // Close the popup
    function closeSupportPopup() {
        document.getElementById("supportPopup").style.display = "none";
    }

    // Clear the form fields
    function clearSupportForm() {
        document.getElementById("contactForm").reset();
        document.getElementById("formMessage").textContent = '';
    }

    // Handle form submission and send data to the servlet

    // Show/hide the support popup on button click
    function openChat() {
        document.getElementById("supportPopup").style.display = "block";
    }

    function closeSupportPopup() {
        document.getElementById("supportPopup").style.display = "none";
    }
</script>
</body>

</html>
