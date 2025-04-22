let disCloseBtn = document.querySelector(".live-meeting-popup .cls-btn");
const livePopCls = document.querySelector(".live-meeting-popup .btns .close");
const livePopConfirm = document.querySelector(".live-meeting-popup .btns .confirm");
let notificationMsgContent = "Your invitation will be sent via email";
const popupInfo = document.querySelector(".live-meeting-popup .content");
const body = document.querySelector("body"); // Make sure this is defined

// Event listener to open the popup and pass dynamic information
document.querySelectorAll(".item-live").forEach(item => {
    item.addEventListener("click", function () {
        // Get the closest parent with the `.item` class
        const parentItem = this.closest(".item");

        if (parentItem) {
            const topic = parentItem.dataset.topic;
            const date = parentItem.dataset.date;
            const description = parentItem.dataset.description;
            const time = parentItem.dataset.time;

            console.log('Topic:', topic);
            console.log('Date:', date);
            console.log('Description:', description);
            console.log('Time:', time);

            // Inject dynamic content into the popup
            popupInfo.querySelector(".meeting-title").textContent = topic;
            popupInfo.querySelector(".date").textContent = date;
            popupInfo.querySelector(".body#description").textContent = description;
            popupInfo.querySelector(".body#time").textContent = time;

            // Show the popup
            body.classList.add("overlay-active");
        }
    });
});

// Close button event listener
livePopCls.addEventListener("click", () => {
    body.classList.remove("overlay-active");
});

// Confirm button event listener
livePopConfirm.addEventListener("click", () => {
    displayNotification(notificationMsgContent);
    body.classList.remove("overlay-active");
});

// Function to display the notification
function displayNotification(msg, timeout = 3000) {
    const notificationMsg = document.querySelector("#notification"); // Make sure this exists in your HTML
    if (notificationMsg) {
        notificationMsg.innerHTML = msg;
        body.classList.add("noti-active");

        setTimeout(() => {
            body.classList.remove("noti-active");
        }, timeout);
    }
}
