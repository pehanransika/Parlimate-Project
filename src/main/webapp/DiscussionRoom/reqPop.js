const prevBtns = document.querySelectorAll('.prev-btn');
const nextBtns = document.querySelectorAll('.next-btn');
const formSteps = document.querySelectorAll('.input-group');
const progressItems = document.querySelectorAll('#progress .item');
const discCancelBtn = document.querySelector(".cancel-btn")
const discCloseBtn = document.querySelector("#meetClsBtn")
const newMeetingBtn = document.querySelector(".newmeeting")

let formStepNum = 0;

nextBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
        formStepNum++

        if(formStepNum > formSteps.length - 1) {
            formStepNum = formSteps.length - 1;
        }

        updateFormStes();
        updateProgress();
    })
})

prevBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
        formStepNum--
        updateFormStes();
        updateProgress();
    })
})

discCancelBtn.addEventListener("click", () => {
    body.classList.remove("reqPop-active")
})
discCloseBtn.addEventListener("click", () => {
    body.classList.remove("reqPop-active")
})

newMeetingBtn.addEventListener("click", () => {
    body.classList.add("reqPop-active")
})

function updateFormStes() {
    formSteps.forEach((formStep) => {
        formStep.classList.remove("form-active")
    })

    formSteps[formStepNum].classList.add("form-active")
}

function updateProgress() {
    progressItems.forEach((item, idx) => {
        item.classList.remove("item-active")
        if (idx == formStepNum ) {
            item.classList.add("item-active")
        }
    })
}