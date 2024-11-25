document.addEventListener("DOMContentLoaded", () => {
    const loginBtn = document.querySelector(".header-btns .primary");
    const regBtn = document.querySelector(".header-btns .secondary");
    const CTAReg = document.querySelector(".cta .primary");
    const body = document.querySelector("body");
    const closeBtns = document.querySelectorAll(".close-btn");
    const popup = document.querySelector(".popup");

    loginBtn.addEventListener("click", () => {
        if (!popup.classList.contains("login-on")) {
            popup.classList.add("login-on");
        }
        body.classList.toggle("popup-active");
    });
    regBtn.addEventListener("click", () => {
        if (popup.classList.contains("login-on")) {
            popup.classList.remove("login-on");
        }
        body.classList.toggle("popup-active");
    });
    CTAReg.addEventListener("click", () => {
        if (popup.classList.contains("login-on")) {
            popup.classList.remove("login-on");
        }
        body.classList.toggle("popup-active");
    });

    closeBtns.forEach((closeBtn) => {
        closeBtn.addEventListener("click", () => {
            body.classList.remove("popup-active");
        });
    });

    const togglePassword = document.querySelector("#toggle-password");
    const passwordField = document.querySelector("#login-pswd");

    togglePassword.addEventListener("click", () => {
        const type =
            passwordField.getAttribute("type") === "password"
                ? "text"
                : "password";
        passwordField.setAttribute("type", type);
        togglePassword.classList.toggle("fa-eye");
        togglePassword.classList.toggle("fa-eye-slash");
    });

    // login toggle
    const signupButton = document.querySelector("#signup-btn");

    signupButton.addEventListener("click", () => {
        popup.classList.toggle("login-on");
    });

    const loginLink = document.querySelector("#login-link");
    loginLink.addEventListener("click", () => {
        popup.classList.toggle("login-on");
    });

    const slider = document.querySelector(".signup-slider .slider");
    const tabs = document.querySelectorAll(".signup-slider .tab");
    const politicianInps =
        document.querySelectorAll(".politician-inputs");
    const partyFields = document.querySelectorAll(".polParty");
    const generalUser = document.querySelectorAll(".general-user");
    const signupBtn = document.getElementById("signup-submit-btn");

    tabs.forEach((tab) => {
        tab.addEventListener("click", () => {
            clearAllFields();
            // Remove active class from all tabs
            tabs.forEach((t) => t.classList.remove("active"));
            // Add active class to the clicked tab
            tab.classList.add("active");

            // Update slider position and width
            const tabRect = tab.getBoundingClientRect();
            const sliderRect =
                slider.parentElement.getBoundingClientRect();
            slider.style.width = `${tabRect.width}px`;
            slider.style.left = `${tabRect.left - sliderRect.left}px`;

            // politician inputs - show or hide
            const targetId = tab.getAttribute("data-target");

            if (targetId === "politician") {
                addGeneralFields();
                politicianInps.forEach((inp) =>
                    inp.classList.add("pol-active")
                );
                signupBtn.textContent = "Create account";
            } else if (targetId === "politicalParty") {
                clearGeneralFields();
                partyFields.forEach((inp) => {
                    inp.required = true;
                    inp.classList.add("party-active");
                });
                signupBtn.textContent = "Request Party Account";
            } else {
                addGeneralFields();
                signupBtn.textContent = "Create account";
            }
        });
    });

    function clearAllFields() {
        politicianInps.forEach((inp) =>
            inp.classList.remove("pol-active")
        );
        partyFields.forEach((inp) => {
            inp.required = false;
            inp.classList.remove("party-active");
        });
    }

    function clearGeneralFields() {
        generalUser.forEach((inp) => {
            inp.classList.add("inactive");
        });
    }

    function addGeneralFields() {
        generalUser.forEach((inp) => {
            inp.classList.remove("inactive");
        });
    }

    // Initialize slider position and width based on the active tab
    const activeTab = document.querySelector(".signup-slider .active");
    if (activeTab) {
        const tabRect = activeTab.getBoundingClientRect();
        const sliderRect = slider.parentElement.getBoundingClientRect();
        slider.style.width = `${tabRect.width}px`;
        slider.style.left = `${tabRect.left - sliderRect.left}px`;
    } else {
        // Set initial width to 6rem if no active tab is found
        slider.style.width = "6rem";
    }

    const togglePasswordIcons =
        document.querySelectorAll(".toggle-password");

    togglePasswordIcons.forEach((icon) => {
        icon.addEventListener("click", () => {
            const targetId = icon.getAttribute("data-target");
            const passwordField = document.getElementById(targetId);

            // Toggle the type attribute
            const type =
                passwordField.getAttribute("type") === "password"
                    ? "text"
                    : "password";
            passwordField.setAttribute("type", type);

            // Toggle the eye icon
            icon.classList.toggle("fa-eye");
            icon.classList.toggle("fa-eye-slash");
        });
    });

    const fileInput = document.getElementById("nic-front");
    const fileLabel = document.getElementById("nic-front-label");

    fileInput.addEventListener("change", (event) => {
        const fileName = event.target.files[0]
            ? event.target.files[0].name
            : "NIC front";
        fileLabel.textContent = fileName;
    });

    const fileInput_back = document.getElementById("nic-back");
    const fileLabel_back = document.getElementById("nic-back-label");

    fileInput_back.addEventListener("change", (event) => {
        const fileName = event.target.files[0]
            ? event.target.files[0].name
            : "NIC back";
        fileLabel_back.textContent = fileName;
    });

    const fileInputs = document.querySelectorAll(".image-upload-inp");
    fileInputs.forEach((fileInput) => {
        fileInput.addEventListener("change", (event) => {
            const fileName = event.target.files[0]
                ? event.target.files[0].name
                : "No file chosen";
            const labelId = `${fileInput.id}-name`;
            const fileLabel = document.getElementById(labelId);
            fileLabel.textContent = fileName;
        });
    });

    const sliderElement = document.querySelector("span.slider");
    if (sliderElement) {
        sliderElement.style.width = "";
        sliderElement.style.left = "";
    }
});