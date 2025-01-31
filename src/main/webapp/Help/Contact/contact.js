// Function to open the support popup
function openSupportPopup() {
  const popup = document.getElementById("supportPopup");
  if (popup) {
      popup.style.display = "flex"; // Show the popup
  }
}

// Function to close the support popup
function closeSupportPopup() {
  const popup = document.getElementById("supportPopup");
  if (popup) {
      popup.style.display = "none"; // Hide the popup
  }
}

// Function to handle form submission
function submitSupportForm(event) {
  event.preventDefault(); // Prevent the form from refreshing the page

  const formMessage = document.getElementById("formMessage");
  formMessage.textContent = "Your message has been sent successfully!";
  formMessage.style.color = "green";

  // Clear the form fields after submission
  document.getElementById("contactForm").reset();

  // Hide the form message after a delay (optional)
  setTimeout(() => {
      formMessage.textContent = "";
      closeSupportPopup();
  }, 2000); // Close popup after 2 seconds
}

// Function to clear the form
function clearSupportForm() {
  document.getElementById("contactForm").reset(); // Reset the form fields
  const formMessage = document.getElementById("formMessage");
  formMessage.textContent = ""; // Clear any existing message
}
