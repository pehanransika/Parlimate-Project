<link rel="stylesheet" href="/sidebar1.css">

<div class="sidebar pd-1">
    <div class="navs">
        <ul>
            <li>
                <input type="radio" name="nav" id="nav-Home" value="http://localhost:8080/Parlimate/GetPostListServlet" checked/>
                <label for="nav-Home" onclick="navigate(this)"><i class="fa-solid fa-house"></i>Home</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-announcements" value="http://localhost:8080/Parlimate/Announcements/GetListServlet?announcementId=123" />
                <label for="nav-announcements" onclick="navigate(this)"><i class="fa-solid fa-bullhorn"></i>Announcements</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-fundraise" value="http://localhost:8080/Parlimate/Fundraising/GetAllFundraisingApprovelServlet" />
                <label for="nav-fundraise" onclick="navigate(this)"><i class="fa-solid fa-coins"></i>Fundraises</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-noti" value="http://localhost:8080/Parlimate/Notification/notification.jsp" />
                <label for="nav-noti" onclick="navigate(this)"><i class="fa-solid fa-scale-balanced"></i>Search & Compare</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-survey" value="http://localhost:8080/Parlimate/Surveys/surveys.jsp" />
                <label for="nav-survey" onclick="navigate(this)"><i class="fa-solid fa-clipboard"></i>Surveys</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-discusRoom" value="http://localhost:8080/Parlimate/DiscussionRoom/discussion-room.jsp" />
                <label for="nav-discusRoom" onclick="navigate(this)"><i class="fa-solid fa-people-group"></i>Meeting Room</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-help" value="http://localhost:8080/Parlimate/Help/help.jsp" />
                <label for="nav-help" onclick="navigate(this)"><i class="fa-solid fa-headset"></i>Help/Support</label>
            </li>
        </ul>
    </div>
</div>

<script>
    function navigate(label) {
        const inputElement = label.previousElementSibling;

        // Redirect to the input's value URL
        if (inputElement && inputElement.value) {
            window.location.href = inputElement.value;
        }
    }

    function highlightCurrentPage() {
        const currentURL = window.location.href;

        // Get all input elements in the sidebar
        const inputs = document.querySelectorAll('.sidebar input[type="radio"]');

        inputs.forEach(input => {
            // If the input's value matches the current URL, check the radio button
            if (input.value === currentURL) {
                input.checked = true;  // Check the radio input
                const label = input.nextElementSibling;
                if (label) {
                    label.classList.add('selected');  // Add the 'selected' class to the label
                }
            } else {
                const label = input.nextElementSibling;
                if (label) {
                    label.classList.remove('selected');  // Remove 'selected' class from other labels
                }
            }
        });
    }

    // Call the function when the page loads to highlight and check the current page's button
    window.onload = highlightCurrentPage;
</script>
