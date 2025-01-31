// Chatbot Popup Management
window.onload = function () {
    document.getElementById("chatbot-popup").style.display = "block";
  };
  
  function openChat() {
    window.location.href = "Contact/contact.html"; // Redirect to contact page
  }
  
  function opennewChat() {
    window.location.href = "chat/chat.html"; // Open the new chat
  }
  
  function closeChat() {
    document.getElementById("chatbot-popup").style.display = "none"; // Hide chatbot popup
  }
  
  function toggleFaq(index) {
    const answers = document.querySelectorAll(".faq-answer");
    answers[index].style.display = answers[index].style.display === "block" ? "none" : "block"; // Toggle FAQ visibility
  }
  
  function searchHelp() {
    const query = document.getElementById("searchInput").value;
    alert("Searching for: " + query); // Placeholder for search functionality
  }
  