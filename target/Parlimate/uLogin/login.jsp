<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="./login.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="../index.css" />

    <!-- icons -->
    <link
            rel="stylesheet"
            data-purpose="Layout StyleSheet"
            title="Web Awesome"
            href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
    />

    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"
    />
    <link
            rel="stylesheet"
            href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
    />
</head>
<body>
<div class="login-container col">
    <div class="head col">
        <h2 class="title">Welcome to Parlimate</h2>
        <p>Please sign in or signup below</p>
    </div>
    <div class="content col">
        <button class="google-login btn row">
            <svg
                    xmlns="http://www.w3.org/2000/svg"
                    x="0px"
                    y="0px"
                    width="100"
                    height="100"
                    viewBox="0 0 48 48"
            >
                <path
                        fill="#FFC107"
                        d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12c0-6.627,5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24c0,11.045,8.955,20,20,20c11.045,0,20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"
                ></path>
                <path
                        fill="#FF3D00"
                        d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"
                ></path>
                <path
                        fill="#4CAF50"
                        d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"
                ></path>
                <path
                        fill="#1976D2"
                        d="M43.611,20.083H42V20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"
                ></path>
            </svg>
            Sign in with Google
        </button>
        <div class="email-section col">
            <div class="seperator row">
                <div class="line"></div>
                <span>or use email</span>
                <div class="line"></div>
            </div>
            <div class="input-fields col">
                <input
                        type="email"
                        name="login-email"
                        id="login-email"
                        placeholder="Email address"
                />
                <div class="pswrd">
                    <input
                            type="password"
                            name="login-pswd"
                            id="login-pswd"
                            placeholder="Password"
                    />
                    <i class="fa-solid fa-eye" id="toggle-password"></i>
                </div>
            </div>
            <div class="ops row">
                <div class="remember row">
                    <input
                            type="checkbox"
                            name="remember-device"
                            id="remember-device"
                    />
                    <label for="remember-device"
                    >Remember me on this device</label
                    >
                </div>
                <a href="#">Forgot password?</a>
            </div>
            <button class="btn login-btn">Login</button>
            <div class="signup-section col">
                <div class="divider"></div>
                <span> Not a member? <a href="#">Signup now</a> </span>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const togglePassword = document.querySelector('#toggle-password');
        const passwordField = document.querySelector('#login-pswd');

        togglePassword.addEventListener('click', () => {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            togglePassword.classList.toggle('fa-eye');
            togglePassword.classList.toggle('fa-eye-slash');
        });
    });
</script>
</html>
