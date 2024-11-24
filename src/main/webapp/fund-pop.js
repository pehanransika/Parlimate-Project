const fundFInp = document.getElementById('fund-att');
let filesList = document.getElementById("att-list");
const numOfFiles = document.querySelector("span.no-of-files");
const fundBtn = document.querySelector(".req-fundraising");
const fundCloseBtn = document.querySelector(".popup-f .head .close-btn");
const fundCancelBtn = document.querySelector(".popup-f .cancel-btn")

fundBtn.addEventListener("click", ()=> {
    body.classList.add("fund-active");
})
fundCloseBtn.addEventListener("click", () => {
    body.classList.contains("fund-active") ? body.classList.remove("fund-active") : null;
})
fundCancelBtn.addEventListener("click", () => {
    body.classList.contains("fund-active") ? body.classList.remove("fund-active") : null;
})

fundFInp.addEventListener("change", () => {
    numOfFiles.textContent = `${fundFInp.files.length} files(s) selected`; 

    for (i of fundFInp.files) {
        let reader = new FileReader();

        const name = i.name;
        let unit = "KB";
        const fileSize = (i.size / 1024).toFixed(1);
        if (fileSize > 1024) {
            fileSize = (fileSize / 1024).toFixed(1);
            unit = "MB";
        }

        let listItem = document.createElement("li");
        listItem.classList.add("att-item", "row")
        listItem.innerHTML = `<span class="row">
									<i class="fa-duotone fa-solid fa-check"></i>
									<div class="file-name">
										${name}
									</div>
								</span>
								<div class="f-size">${fileSize}<span class="unit">${unit}</span> </div>
                                <div class="delete-item">
									<i class="fa-solid fa-trash"></i>
								</div>
							`;

        listItem.querySelector('.delete-item').addEventListener('click', () => {
            listItem.remove();
            numOfFiles.textContent = `${filesList.children.length} files(s) selected`;
        });
        
        filesList.appendChild(listItem);
    }
})