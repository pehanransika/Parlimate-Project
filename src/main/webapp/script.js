let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
const body = document.querySelector("body");const navRadios = document.querySelectorAll('input[name="nav"]');
const notificationMsg = document.querySelector(".notification-msg");
const headerBtns = document.querySelectorAll(".headerBtn input[type='checkbox']")

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
headerBtns.forEach(selectedBtn => {
    selectedBtn.addEventListener('change', function() {
        if (this.checked) {
            headerBtns.forEach(otherBtn => {
                if (otherBtn !== this) {
                    otherBtn.checked = false;
                }
            });
        }
    });
});
