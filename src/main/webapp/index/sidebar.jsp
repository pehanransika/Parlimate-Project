<link rel="stylesheet" href="/sidebar1.css">

<style>
    .sidebar label.selected {
        background-color: #e0e0e0;
        font-weight: bold;
        border-left: 4px solid #007BFF;
        color: #007BFF;
    }
</style>

<div class="sidebar pd-1">
    <div class="navs">
        <ul>
            <li>
                <input type="radio" name="nav" id="nav-Home" value="http://localhost:8080/Parlimate/GetPostListServlet" />
                <label for="nav-Home" onclick="navigate(this)"><i class="fa-solid fa-house"></i>Home</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-announcements" value="http://localhost:8080/Parlimate/Announcements/GetListServlet" />
                <label for="nav-announcements" onclick="navigate(this)"><i class="fa-solid fa-bullhorn"></i>Announcements</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-fundraise" value="http://localhost:8080/Parlimate/Fundraising/GetAllFundraisingApprovelServlet" />
                <label for="nav-fundraise" onclick="navigate(this)"><i class="fa-solid fa-coins"></i>Fundraises</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-noti" value="http://localhost:8080/Parlimate/SearchCompare/searchCompare.jsp" />
                <label for="nav-noti" onclick="navigate(this)"><i class="fa-solid fa-scale-balanced"></i>Search & Compare</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-survey" value="http://localhost:8080/Parlimate/Surveys/GetParlimateSurveysServlet" />
                <label for="nav-survey" onclick="navigate(this)"><i class="fa-solid fa-clipboard"></i>Surveys</label>
            </li>
            <li>
                <input type="radio" name="nav" id="nav-discusRoom" value="http://localhost:8080/Parlimate/DiscussionRoom/GetAllMeetingUserServlet" />
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
        if (inputElement && inputElement.value) {
            window.location.href = inputElement.value;
        }
    }

    function normalizeUrl(url) {
        return url.split(/[?#]/)[0].replace(/\/$/, "").toLowerCase();
    }

    function highlightCurrentPage() {
        const currentURL = normalizeUrl(window.location.href);
        const inputs = document.querySelectorAll('.sidebar input[type="radio"]');
        let matchFound = false;

        // First, clear all selections
        inputs.forEach(input => {
            input.checked = false;
            const label = input.nextElementSibling;
            if (label) label.classList.remove('selected');
        });

        // Then, find the best match
        inputs.forEach(input => {
            const inputURL = normalizeUrl(input.value);
            const label = input.nextElementSibling;

            if (currentURL === inputURL) { // Exact match
                input.checked = true;
                if (label) label.classList.add('selected');
                matchFound = true;
            }
        });

        // If no exact match, try partial matching with longest path
        if (!matchFound) {
            let bestMatchInput = null;
            let longestMatchLength = 0;

            inputs.forEach(input => {
                const inputURL = normalizeUrl(input.value);
                if (currentURL.startsWith(inputURL) && inputURL.length > longestMatchLength) {
                    bestMatchInput = input;
                    longestMatchLength = inputURL.length;
                }
            });

            if (bestMatchInput) {
                bestMatchInput.checked = true;
                const label = bestMatchInput.nextElementSibling;
                if (label) label.classList.add('selected');
            }
        }
    }

    window.onload = highlightCurrentPage;
</script>