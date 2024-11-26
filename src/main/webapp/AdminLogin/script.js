document.getElementById('loginForm').addEventListener('submit', function(event) {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('error-message');
    const successMessage = document.getElementById('success-message');

    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    errorMessage.innerText = '';
    successMessage.innerText = '';

    // Basic validation for email and password
    if (email.trim() === '' || password.trim() === '') {
        event.preventDefault();
        errorMessage.innerText = 'Email and password cannot be empty.';
    } else if (!emailPattern.test(email)) {
        event.preventDefault();
        errorMessage.innerText = 'Please enter a valid email address.';
    } else {
        // If validation passes, show the success message and alert
        successMessage.innerText = 'Login successful!';
        alert('Login successful!'); // Show alert box for success

        // Uncomment the next line to allow form submission after successful validation
        // event.preventDefault();
    }
});
