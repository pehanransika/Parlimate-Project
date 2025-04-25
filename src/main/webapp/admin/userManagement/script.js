document.addEventListener("DOMContentLoaded", function () {
    console.log("JavaScript Loaded!"); // Debugging log

    let popup = document.getElementById("signupPopup");
    let openBtn = document.getElementById("openPopup");
    let closeBtn = document.querySelector(".close-btn");

    console.log("Popup:", popup); // Check if elements are found
    console.log("Open Button:", openBtn);
    console.log("Close Button:", closeBtn);

    if (!popup || !openBtn || !closeBtn) {
        console.error("Popup or buttons not found! Check your IDs.");
        return;
    }

    openBtn.addEventListener("click", function () {
        console.log("Open button clicked!"); // Log when button is clicked
        popup.style.display = "flex";
    });

    closeBtn.addEventListener("click", function () {
        console.log("Close button clicked!"); // Log when close button is clicked
        popup.style.display = "none";
    });

    window.addEventListener("click", function (event) {
        if (event.target === popup) {
            console.log("Clicked outside popup! Closing...");
            popup.style.display = "none";
        }
    });
});

