
let disCloseBtn = document.querySelector(".live-meeting-popup .cls-btn")
const livePopup = document.querySelector(".item-live")
const livePopCls = document.querySelector(".live-meeting-popup .btns .close")
const livePopConfirm = document.querySelector(".live-meeting-popup .btns .confirm")
let notifi = "Your invitation will be sent via email"

disCloseBtn.addEventListener("click", () => {
    body.classList.remove("overlay-active");

})
livePopCls.addEventListener("click", () => {
    body.classList.remove("overlay-active");
})

livePopup.addEventListener("click", () => {
    console.log("live clicked")
    body.classList.add("overlay-active");
})

livePopConfirm.addEventListener("click", () => {
    notificationMsgContent = notifi
    body.classList.remove("overlay-active");
    displayNotification(notificationMsgContent)
})


function displayNotification(msg, timeout = 3000) {
    notificationMsg.innerHTML = msg
    body.classList.add("noti-active")
    setTimeout(() => {
        body.classList.remove("noti-active")
    }, timeout)
}