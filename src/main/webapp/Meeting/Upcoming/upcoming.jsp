<%HttpSession session1 = request.getSession(false); // false to not create a new session if one doesn't exist
    if (session1 == null || session.getAttribute("user") == null) {
// User is not logged in, redirect to login page
        response.sendRedirect("../index.jsp");
        return;
    }%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset = "ÜTF-8">>
    <meta name = "viewport" content="width=device-width,initial-scale=1.0">
    <title>Upcoming Meeting</title>
    <link rel="stylesheet" href="upcoming.css">

</head>
<body>
<div class="modal">
    <div class="modal-header">
        <h2>Upcoming Meeting</h2>

    </div>
    <div class="modal-body">
        <input type="text" class="meeting-title" value="Meeting on TopiC">
        <div class="caption">
            <p>
                Vivamus nec rutrum lorem, ut mollis augue. Duis egestas efficitur vestibulum. Sed posuere augue, varius ac lectus ac, dapibus consectetur sem. Vivamus vitae finibus ipsum. Donec eget orci porttitor, tristique massa sed,
            </p>
        </div>
        <div class="detail-grid">
            <div class="detail-item">
                <label for="date">Date</label>
                <input type="text" id="date" placeholder="Enter Date" />
            </div>
            <div class="detail-item">
                <label for="time">Time</label>
                <input type="text" id="date" placeholder="Enter Time"/>
            </div>
            <div class="detail-item">
                <label for="slots">Remaining Slots</label>
                <select id="slots">
                    <option value="slot1">10:00 AM - 11:00 AM</option>
                    <option value="slot2">11:00 AM - 12:00 PM</option>
                    <option value="slot3">1:00 PM - 2:00 PM</option>
                    <option value="slot4">2:00 PM - 3:00 PM</option>
                    <option value="slot5">3:00 PM - 4:00 PM</option>
                </select>
            </div>
            <div class="button-group">
                <button class="notify-btn">Notify Me</button>
                <button class="register-btn">Register</button>
            </div>
        </div>
    </div>
</div>
</body>

</html>