<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Support Popup</title>
    <link rel="stylesheet" href="contact.css">
</head>
<body>
<!-- Section asking if the user wants to contact support -->
<section class="contact-prompt">
    <h2>Need Help?</h2>
    <p>Our support team is here to assist you. Do you want to contact us?</p>
    <button onclick="openSupportPopup()" class="open-support-btn">Contact Support</button>
</section>

<!-- Contact Support Popup Overlay -->
<div id="supportPopup" class="popup-overlay">
    <div class="popup-content">
        <span class="close-btn" onclick="closeSupportPopup()">&times;</span>
        <h2>Contact Support</h2>
        <p>Our support team is here to help you with any questions or issues you may have.</p>

        <!-- Contact Form -->
        <form id="contactForm" onsubmit="submitSupportForm(event)">
            <label for="name">Your Name</label>
            <input type="text" id="name" placeholder="Enter your name" required>

            <label for="email">Your Email</label>
            <input type="email" id="email" placeholder="Enter your email" required>

            <label for="message">Your Message</label>
            <textarea id="message" placeholder="Enter your message" rows="4" required></textarea>

            <div class="form-buttons">
                <button type="button" onclick="clearSupportForm()" class="clear-btn">Clear</button>
                <button type="submit" class="submit-btn">Submit</button>
            </div>

            <p id="formMessage" class="form-message"></p>
        </form>
    </div>
</div>

<script src="contact.js"></script>
</body>
</html>
