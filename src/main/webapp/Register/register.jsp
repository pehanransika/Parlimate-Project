<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <link rel="stylesheet" href="register.css">
</head>
<body>
<div class="container">
    <h1>Register</h1>
    <div class="registration-options">
        <button onclick="showForm('user')">Register as User</button>
        <button onclick="showForm('politician')">Register as Politician</button>
        <button onclick="showForm('party')">Register as Political Party</button>
    </div>

    <!-- User Registration Form -->
    <div id="user-form" class="form-section">
        <h2>User Registration</h2>
        <form>
            <label for="user-name">Name</label>
            <input type="text" id="user-name" placeholder="Enter your name">

            <label for="user-email">Email</label>
            <input type="email" id="user-email" placeholder="Enter your email">

            <label for="user-phone">Phone Number</label>
            <input type="text" id="user-phone" placeholder="Enter your phone number">

            <button type="submit" onclick="sendOtp()">Register & Send OTP</button>
        </form>
    </div>

    <!-- Politician Registration Form -->
    <div id="politician-form" class="form-section">
        <h2>Politician Registration</h2>
        <form>
            <label for="politician-name">Name</label>
            <input type="text" id="politician-name" placeholder="Enter your name">

            <label for="politician-email">Email</label>
            <input type="email" id="politician-email" placeholder="Enter your email">

            <label for="politician-phone">Phone Number</label>
            <input type="text" id="politician-phone" placeholder="Enter your phone number">

            <label for="nic-front">Upload NIC Front</label>
            <input type="file" id="nic-front">

            <label for="nic-back">Upload NIC Back</label>
            <input type="file" id="nic-back">

            <button type="submit" onclick="sendOtpAndEmailVerification()">Register & Send OTP & Email Verification</button>
        </form>
    </div>

    <!-- Political Party Registration Form -->
    <div id="party-form" class="form-section">
        <h2>Political Party Registration</h2>
        <form>
            <label for="party-name">Party Name</label>
            <input type="text" id="party-name" placeholder="Enter the party name">

            <label for="party-logo">Upload Party Logo</label>
            <input type="file" id="party-logo">

            <label for="party-leader">Party Leader Name</label>
            <input type="text" id="party-leader" placeholder="Enter the leader's name">

            <button type="submit">Register Political Party</button>
        </form>
    </div>
</div>

<script src="register.js"></script>
</body>
</html>
