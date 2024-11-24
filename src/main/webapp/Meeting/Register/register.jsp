<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register for Meeting</title>
    <link rel="stylesheet" href="register.css">
</head>
<body>

<div class="modal">
    <div class="modal-header">
        <h2>Book a slot for your meeting</h2>
        <button>&times;</button>
    </div>
    <div class="modal-body">
        <input type="text" class="meeting-title" value="Meeting on Topic X">
        <div class="name">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your name">
        </div>
        <div class="detail-grid">
            <div class="detail-item">
                <label for="contactno">Contact No</label>
                <input type="text" id="contactno" placeholder="Enter your contact number">
            </div>
            <div class="detail-item">
                <label for="email">Email Address</label>
                <input type="email" id="email" placeholder="Enter your email address">
            </div>
        </div>
        <div class="password">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password">
        </div>
    </div>
    <div class="button-group">
        <button class="clear-btn">Clear</button>
        <button class="submit-btn">Submit</button>
    </div>
</div>

</body>
</html>
