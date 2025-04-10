let disCloseBtn = document.querySelector(".live-meeting-popup .cls-btn");
const livePopCls = document.querySelector(".live-meeting-popup .btns .close");
const livePopConfirm = document.querySelector(".live-meeting-popup .btns .confirm");
let notificationMsgContent = "Your invitation will be sent via email";
const popupInfo = document.querySelector(".live-meeting-popup .content"); // To display dynamic content


// Event listener to open the popup and pass dynamic information
document.querySelectorAll(".item-live").forEach(item => {
    item.addEventListener("click", function() {

        console.log('Topic 1:', item.dataset.topic);
        console.log('Date 1:', item.dataset.date);
        console.log('Description 1:', item.dataset.description);
        console.log('Time 1:', item.dataset.time);
        // Access data attributes using dataset
        const topic = this.dataset.topic;
        const date = this.dataset.date;
        const description = this.dataset.description;
        const time = this.dataset.time;

        // Inject dynamic content into the popup
        popupInfo.querySelector(".meeting-title").textContent = topic;
        popupInfo.querySelector(".date").textContent = date;
        popupInfo.querySelector(".body:nth-of-type(1)").textContent = description;
        popupInfo.querySelector(".body:nth-of-type(2)").textContent = time;

        // Show the popup
        body.classList.add("overlay-active");
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
    const notificationMsg = document.querySelector("#notification"); // Assuming you have an element with id 'notification' to show messages
    notificationMsg.innerHTML = msg;
    body.classList.add("noti-active");

    setTimeout(() => {
        body.classList.remove("noti-active");
    }, timeout);
}
