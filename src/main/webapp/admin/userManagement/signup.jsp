<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to CSS -->
</head>
<body>

<button id="openPopup">Sign Up</button> <!-- Button to open popup -->

<div id="signupPopup" class="popup-container">
    <div class="popup-content">
        <span class="close-btn">&times;</span>

        <form action="UserInsertServlet" method="post" onsubmit="return validateForm()">
            <div class="signup-cont col">
                <h2 class="title">Welcome to Parlimate</h2>
                <p>Create your Parlimate account</p>

                <div class="signup-slider row">
                    <label class="active tab" for="userType-cit">Citizen</label>
                    <label class="tab" for="userType-pol">Politician</label>
                    <label class="tab" for="userType-part">Political Party</label>
                    <span class="slider"></span>
                </div>

                <input type="radio" name="userType" id="userType-cit" value="Citizen" checked hidden />
                <input type="radio" name="userType" id="userType-pol" value="Politician" hidden />
                <input type="radio" name="userType" id="userType-part" value="Political Party" hidden />

                <div class="signup-content col">
                    <input type="text" class="inp-field" name="name" placeholder="Full name" required
                           pattern="^[A-Za-z]+([ ]?[A-Za-z]+)*$" title="Please enter a valid name" />
                    <input type="email" name="email" class="inp-field" placeholder="Email address" required
                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}" />
                    <input type="password" class="inp-field" name="password" placeholder="Password" id="password" required
                           minlength="6" pattern="^(?=.*[A-Z])(?=.*[!@#$%^&*()_+]).{6,}$" />
                    <input type="tel" name="phoneNumber" class="inp-field" placeholder="Contact number" required
                           pattern="^0\d{9}$" maxlength="10" />
                    <input type="text" name="address" class="inp-field" placeholder="Address" required />

                    <select name="district" class="inp-field" required>
                        <option value="" disabled selected>Select District</option>
                        <option value="colombo">Colombo</option>
                        <option value="gampaha">Gampaha</option>
                        <option value="kandy">Kandy</option>
                        <option value="matale">Matale</option>
                        <option value="galle">Galle</option>
                    </select>

                    <!-- Politician/Party Inputs -->
                    <div class="extra-fields">
                        <input type="text" class="inp-field polParty" name="partyName" placeholder="Party Name" />
                        <input type="text" class="inp-field polParty" name="leaderName" placeholder="Party Leader's Name" />
                        <input type="number" class="inp-field polParty" name="noOfMembers" placeholder="Number of members" min="1" />
                    </div>

                    <div class="remember row">
                        <input type="checkbox" name="agreement-signup" required />
                        <label for="agreement-signup">I agree to the policies of Parlimate</label>
                    </div>

                    <button type="submit" class="btn login-btn">Create Account</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="script.js"></script> <!-- Link to JavaScript -->
</body>
</html>
