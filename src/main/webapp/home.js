const addPostBtn = document.querySelector(".addPost-btn")
const popupCloseBtn = document.getElementById("popup-close-btn")
const popupClearBtn = document.getElementById("popup-clear-btn")
const popuppostBtn = document.getElementById("popup-post-btn")
const postLikeBtns = document.querySelectorAll(".post .like");
const postCmntBtns = document.querySelectorAll(".post button.comment");
const voteSubmissionBtn = document.getElementById("vote-btn");
const weeklySirveyRadios = document.querySelectorAll(`.weeklySurvey input[name="week-survey"]`);
const cmntVoteBtns = document.querySelectorAll(".cmnt .upvote");
let notificationMsgContent = "Your vote has been successfully added !";
let weeklySurveyVoted = false;



addPostBtn.addEventListener("click", () => {
    if (body.classList.contains("overlay-active")) {
        body.classList.remove("overlay-active")
    } else {
        body.classList.add("overlay-active")
    }
})

popupCloseBtn.addEventListener("click", () => {
    body.classList.remove("overlay-active")
})

popupClearBtn.addEventListener("click", () => {
    body.querySelector(".popup textarea").value = ""
    body.querySelector(".popup input[type='text']").value = ""
})

// close popup on click outside
document.addEventListener('click', function(event) {
    const cmntPopup = document.querySelector('.comment-popup');
    const container = document.querySelector('.comment-container');
    const isClickInsideCmntPopup = cmntPopup.contains(event.target);
    const isClickInsideCmntContainer = container.contains(event.target);
    const addPostPopup = document.querySelector('.popup-modal');
    const isClickInsideAddPostPopup = addPostPopup.contains(event.target);
    const addPostContainer = document.querySelector('.popup');
    const isClickInsideAddPostContainer = addPostContainer.contains(event.target);

    if (isClickInsideCmntPopup && !isClickInsideCmntContainer) {
        body.classList.remove("cmnt-visible")
    }
    if (isClickInsideAddPostPopup && !isClickInsideAddPostContainer) {
        this.body.classList.remove("overlay-active")
    }
});
popuppostBtn.addEventListener("click", () => {
    // implement validation here
    let validity = false
    const addPostTitle = body.querySelector(".popup #add-post-title")
    const addPostCaption = body.querySelector(".popup #add-post-caption")
    if (addPostTitle.value && addPostCaption.value) {
        validity = true
    } else {
        if (!addPostTitle.value) {
            addPostTitle.parentElement.classList.add("error")
        }
        if (!addPostCaption.value) {
            addPostCaption.parentElement.classList.add("error")
        }
        addPostTitle.addEventListener("input", () => {
            addPostTitle.parentElement.classList.remove("error")
        })
        addPostCaption.addEventListener("input", () => {
            addPostCaption.parentElement.classList.remove("error")
        })
    }
    if (validity) {
        notificationMsgContent = "Your post has been successfully added !"
        body.classList.remove("overlay-active")
        displayNotification(notificationMsgContent)
    }
})

postLikeBtns.forEach(likeBtn => {
    likeBtn.addEventListener("click", () => {
        likeBtn.closest(".post").classList.toggle("reacted")
    })
})
postCmntBtns.forEach(cmntBtn => {
    cmntBtn.addEventListener("click", () => {
        body.classList.add("cmnt-visible")
    })
})
cmntVoteBtns.forEach(voteBtn => {
    voteBtn.addEventListener("click", () => {
        const currPost = voteBtn.closest(".cmnt")
        const count = currPost.querySelector(".upvote span")
        if(currPost.classList.contains("upvoted")){
            voteBtn.querySelector("i").classList.remove("fa-solid")
            voteBtn.querySelector("i").classList.add("fa-light")
            count.innerHTML = parseInt(count.innerHTML) - 1
        } else {
            voteBtn.querySelector("i").classList.remove("fa-light")
            voteBtn.querySelector("i").classList.add("fa-solid")
            count.innerHTML = parseInt(count.innerHTML) + 1
        }
        currPost.classList.toggle("upvoted")
    })
    // increase/ decrease like count on click
})

voteSubmissionBtn.addEventListener("click", () => {
    checkIfWeeklySurveyVoted()
    // valaidation required here
    if (!voteSubmissionBtn.classList.contains("submitted") && weeklySurveyVoted) {
        voteSubmissionBtn.classList.add("submitted")
        voteSubmissionBtn.innerHTML = `<i class="fa-duotone fa-solid fa-check"></i> Voted`
        voteSubmissionBtn.closest(".votelist").classList.add("voted")
        notificationMsgContent = "Your vote has been successfully added !"
        displayNotification(notificationMsgContent, 2000)
        disableRadioButtons(true)
    } else {
        voteSubmissionBtn.classList.remove("submitted")
        voteSubmissionBtn.innerHTML = `submit my Vote`
        voteSubmissionBtn.closest(".votelist").classList.remove("voted")
        disableRadioButtons(false)
    }

})


function checkIfWeeklySurveyVoted() {
    weeklySirveyRadios.forEach(radio => {
        if(radio.checked){
            weeklySurveyVoted = true
        }
    })
}
function disableRadioButtons(bool) {
    const radioButtons = document.querySelectorAll('input[name="week-survey"]');
    radioButtons.forEach(radio => {
        radio.disabled = bool;
    });
}

function displayNotification(msg, timeout = 3000) {
    notificationMsg.innerHTML = msg
    body.classList.add("noti-active")
    setTimeout(() => {
        body.classList.remove("noti-active")
    }, timeout)
}


