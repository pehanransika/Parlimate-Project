<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="../uLogin/login.css" />
    <link rel="stylesheet" href="../container.css" />
    <link rel="stylesheet" href="../index.css" />
    <link rel="stylesheet" href="./signup.css">

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
        <p>Create your parlimate account</p>
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
            Sign up with Google
        </button>
        <div class="email-section col">
            <div class="seperator row">
                <div class="line"></div>
                <span>or use email</span>
                <div class="line"></div>
            </div>
            <div class="signup-slider row">
                <span class="slider"></span>
                <div id="citizen-set" class="active">
                    citizen
                </div>
                <div id="politician-set">
                    politician
                </div>
                <div id="politicalParty-set">
                    political party
                </div>
            </div>
            <div class="signup-content col">
                <div class="row-fields row">
                    <input type="text" class="inp-field" placeholder="First name">
                    <input type="text" class="inp-field" placeholder="Last name">
                </div>
                <input type="email" name="singup-email" id="singup-email" class="inp-field" placeholder="Email address">
                <div class="row-fields row">
                    <div class="pswrd">
                        <input type="password" class="inp-field" placeholder="Password" id="password">
                        <i class="fa-solid fa-eye toggle-password" data-target="password"></i>
                    </div>
                    <div class="pswrd">
                        <input type="password" class="inp-field" placeholder="Confirm password" id="confirm-password">
                        <i class="fa-solid fa-eye toggle-password" data-target="confirm-password"></i>
                    </div>
                </div>
                <input type="tel" class="inp-field" placeholder="+94 12 3456 789" name="telNumber-signup" id="telNumber-signup">
                <select name="district" id="district" required="true">
                    <option value="invalid" disabled="disabled" selected>District</option>
                    <option value="kandy">kandy</option>
                    <option value="colombo">colombo</option>
                    <option value="mathara">mathara</option>
                    <option value="horana">horana</option>
                    <option value="jaffna">jaffna</option>
                    <option value="galle">galle</option>
                </select>
            </div>
            <div class="remember row">
                <input
                        type="checkbox"
                        name="agreement-signup"
                        id="agreement-signup"
                />
                <label for="agreement-signup"
                >I hereby agree to the policies of Parlimate</label
                >
            </div>
            <button class="btn login-btn">Create account</button>
            <div class="signup-section col">
                <div class="divider"></div>
                <span> Already have an account? <a href="#">Login</a> </span>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const slider = document.querySelector('.signup-slider .slider');
        const tabs = document.querySelectorAll('.signup-slider div');

        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                // Remove active class from all tabs
                tabs.forEach(t => t.classList.remove('active'));
                // Add active class to the clicked tab
                tab.classList.add('active');

                // Update slider position and width
                const tabRect = tab.getBoundingClientRect();
                const sliderRect = slider.parentElement.getBoundingClientRect();
                slider.style.width = `${tabRect.width}px`;
                slider.style.left = `${tabRect.left - sliderRect.left}px`;
            });
        });

        // Initialize slider position and width based on the active tab
        const activeTab = document.querySelector('.signup-slider .active');
        if (activeTab) {
            const tabRect = activeTab.getBoundingClientRect();
            const sliderRect = slider.parentElement.getBoundingClientRect();
            slider.style.width = `${tabRect.width}px`;
            slider.style.left = `${tabRect.left - sliderRect.left}px`;
        }

        const togglePasswordIcons = document.querySelectorAll('.toggle-password');

        togglePasswordIcons.forEach(icon => {
            icon.addEventListener('click', () => {
                const targetId = icon.getAttribute('data-target');
                const passwordField = document.getElementById(targetId);

                // Toggle the type attribute
                const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordField.setAttribute('type', type);

                // Toggle the eye icon
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            });
        });

    });

</script>
</html>