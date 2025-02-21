document.addEventListener("DOMContentLoaded", function() {
    const surveyPopup = document.getElementById("surveyPopup");
    const requestSurveyBtn = document.querySelector(".request-survey"); // Button to open popup
    const closePopup = document.getElementById("closePopup");
    const cancelPopup = document.getElementById("cancelPopup");

    // Ensure popup is hidden when the page loads
    surveyPopup.style.display = "none";

    // Check if the 'request-survey' button exists
    if (requestSurveyBtn) {
        // Show Popup when clicking the button
        requestSurveyBtn.addEventListener("click", function() {
            surveyPopup.style.display = "flex";
        });
    } else {
        console.error("The 'request-survey' button is missing in the HTML.");
    }

    // Close Popup when clicking the close button or cancel button
    [closePopup, cancelPopup].forEach(btn => {
        btn.addEventListener("click", function() {
            surveyPopup.style.display = "none";
        });
    });
});
