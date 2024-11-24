<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Page</title>
    <link rel="stylesheet" href="login.css">
</head>
<body>
<div class="container">
    <div class="img-1">
        <img src="./images/img.jpg" alt="image">
    </div>
    <div class="login-form">
        <div class="form-header">
            <h2>Welcome back! 👋</h2>
            <br>
            <h3>Login to your account</h3>
        </div>
        <form>
            <label for="email">Email</label>
            <input type="email" id="email" placeholder="Please enter your email">

            <label for="password">password</label>
            <input type="password" id="password" placeholder="Enter password">

            <button type="submit">Login</button>
            <br>
            <div class ="forgot-passsword">
                <a href="#">Forgot Password?</a>
            </div>

        </form>
        <div class="login-options">
            <p>Login using</p>
            <div class="social-icons">
                <a href="#"><img src="./images/google-icon.png" alt="Google"></a>
                <a href="#"><img src="./images/microsoft-icon.png" alt="Microsoft"></a>
                <a href="#"><img src="./images/yahoo-icon.jpg" alt="Yahoo"></a>
                <a href="#"><img src="./images/facebook-icon.png" alt="Facebook"></a>
            </div>
        </div>
        <div class="register">
            <p>Not Registered?</p>
            <button class="signup-button" onclick="window.location.href='signup.html'">Sign Up</button>
        </div>
    </div>
</div>
</body>
</html>