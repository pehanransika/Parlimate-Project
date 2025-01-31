// Function to open the chat popup
function openChatPopup() {
    const chatPopup = document.getElementById("chatPopup");
    chatPopup.style.display = "block"; // Display the chat popup
}
// Open a new chat page (chat.html)
function opennewchat() {
    window.location.href = "chat/chat.html"; // Redirect to chat.html page
}


// Function to close the chat popup
function closeChatPopup() {
    const chatPopup = document.getElementById("chatPopup");
    chatPopup.style.display = "none"; // Hide the chat popup
}

// Function to handle sending messages
function sendMessage(event) {
    event.preventDefault(); // Prevent form submission

    const chatInput = document.getElementById("chatInput");
    const chatMessages = document.getElementById("chatMessages");

    // Create new message element
    const newMessage = document.createElement("div");
    newMessage.classList.add("user-message");
    newMessage.textContent = chatInput.value;

    // Append message to the chat window
    chatMessages.appendChild(newMessage);

    // Clear input field
    chatInput.value = "";

    // Auto scroll to the latest message
    chatMessages.scrollTop = chatMessages.scrollHeight;

    // Simulate a bot response after a short delay
    setTimeout(() => {
        const botResponse = document.createElement("div");
        botResponse.classList.add("bot-message");
        botResponse.textContent = "Support is on the way!";

        chatMessages.appendChild(botResponse);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }, 1500);
}
