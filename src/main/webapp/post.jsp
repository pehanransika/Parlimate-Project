<style>
    /* General Styles */
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f7fb;
        margin: 20px;
        padding: 20px;
    }
    body.sidebar-deactive .sidebar {
        transform: translateX(-100%);
    }

    .top-bar {
        display: flex;
        justify-content: flex-end;
        margin-top: 80px;

    }

    .button-home {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        cursor: pointer;
        text-decoration: none;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    .button-home:hover {
        background-color: #0056b3;
    }

    h2 {
        color: #3a3a3a;
        text-align: center;
        margin-bottom: 30px;
    }

    /* Search Input Styles */
    #searchInput {
        width: 100%;
        max-width: 200px;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
        margin-left: 250px;
    }

    #searchInput:focus {
        border-color: #007bff;
    }

    /* Announcement List Styles */
    .post-list {
        list-style-type: none;
        padding: 0;
        margin-right: 20px;
        gap: 1.5rem;
    }


    .post-item {
        background-color: #ffffff;
        margin-bottom: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 20px;
        position: relative;
        display: flex;
        cursor: pointer;
        flex-direction: column;
        gap: 15px;
    }
    .post-item:hover {
        outline: 1px solid rgb(185, 185, 185);
        border-left: 0.75rem solid #5490FF;
    }


    .post-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .post-info h3 {
        margin: 0;
        font-size: 18px;
        color: #333;
    }

    .post-info p {
        margin: 0;
        font-size: 14px;
        color: #888;
    }

    .post-content {
        margin-top: 10px;
        font-size: 16px;
        color: #555;
    }

    /* Button Styles */
    .post-actions {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }

    .button {
        border: none;
        padding: 10px 0; /* Adjusted padding for consistent height */
        cursor: pointer;
        font-size: 14px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
        width: 100px; /* Ensures both buttons have the same width */
        height: 40px; /* Ensures both buttons have the same height */
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .button-update {
        background-color: #6a5acd; /* Light purple */
        color: white;
    }

    .button-update:hover {
        background-color: #5b4ab5;
    }

    .button-delete {
        background-color: #f44336; /* Red */
        color: white;
    }

    .button-delete:hover {
        background-color: #e53935;
    }

    /* Popup Modal Styles */
    .popup-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
    }

    .popup {
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        width: 400px;
        position: relative;
    }

    .popup .close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        cursor: pointer;
    }

    .formSection {
        margin-bottom: 15px;
    }

    .formSection label {
        display: block;
        margin-bottom: 5px;
    }

    .formSection input, .formSection textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .popbtns {
        text-align: center;
        margin-top: 20px;
    }

    .post-btn {
        padding: 10px 20px;
        background-color: #6a5acd;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .post-btn:hover {
        background-color: #5b4ab5;
    }
</style>
<div class="top-bar">

    <a href="index.jsp" class="button-home">Go to Home</a>
</div>

<h2>My Posts</h2>

<input type="text" id="searchInput" placeholder="Search posts..." onkeyup="filterAnnouncements()">

<ul class="post-list">
    <c:forEach var="post" items="${allposts}">
        <li class="post-item">
            <div class="post-header">
                <div class="post-info">


                    <p>${post.datetime}</p>


                </div>
            </div>
            <div class="post-content">
                    ${post.content}
            </div>
            <div class="post-actions">
                <!-- Update Button triggers the popup modal with announcement data -->
                <button class="button button-update" onclick="openEditPopup('${post.postId}', '${post.userId}',  '${fn:escapeXml(post.content)}', '${post.datetime}')">Update</button>


                <!-- Delete Button -->
                <form action="DeletePostServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this post?');" style="display:inline;">
                    <input type="hidden" name="postid" value="${post.postId}" />
                    <button type="submit" class="button button-delete">Delete</button>
                </form>


            </div>
        </li>
    </c:forEach>
</ul>

<!-- Update Announcement Popup Modal -->
<div class="popup-modal" id="editPopup">
    <div class="popup">
        <div class="title">
            <span>Edit Post</span>
            <button class="close-btn" onclick="closeEditPopup()">
                <i class="fa-solid fa-times"></i>
            </button>
        </div>

        <form action="UpdatePostServlet" method="post">
            <!-- Hidden fields for post ID and user ID -->
            <input type="hidden" name="postid" id="postid" value="${postid}" />
            <input type="hidden" name="userid" id="userid" value="${userid}" />

            <!-- Content Section -->
            <div class="formSection">
                <label for="editContent">Content</label>
                <textarea id="editContent" name="content" placeholder="Edit content here..." required></textarea>
            </div>

            <!-- Save Button -->
            <div class="popbtns">
                <button type="submit" class="post-btn">Save Changes</button>
            </div>
        </form>

    </div>

</div>

<script>
    let sideMenuBtns = document.querySelectorAll(".sideMenuBtn");
    const body = document.querySelector("body");
    const navRadios = document.querySelectorAll('input[name="nav"]');

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
    // Function to open the modal and populate the form
    function openEditPopup(postid, userid, content, datetime) {
        // Show the popup modal
        document.getElementById('editPopup').style.display = 'flex';

        // Remove milliseconds from the datetime value
        const formattedDatetime = datetime.substring(0, 16);

        // Populate the form with the current announcement data
        document.getElementById('postid').value = postid;
        document.getElementById('userid').value = userid;

        document.getElementById('editContent').value = content;
        document.getElementById('editDatetime').value = formattedDatetime;
    }

    // Function to close the popup modal
    function closeEditPopup() {
        // Hide the popup modal
        document.getElementById('editPopup').style.display = 'none';
    }

    // Function to filter announcements
    function filterAnnouncements() {
        const input = document.getElementById("searchInput").value.toUpperCase();
        const listItems = document.querySelectorAll(".announcement-item");

        listItems.forEach(item => {
            const text = item.textContent || item.innerText;
            item.style.display = text.toUpperCase().includes(input) ? "" : "none";
        });
    }

</script>