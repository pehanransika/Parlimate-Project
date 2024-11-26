document.getElementById('registrationForm').addEventListener('submit', function(event) {
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const phoneNumber = document.getElementById('phonenumber').value.trim();
    const password = document.getElementById('password').value.trim();
    const confirmPassword = document.getElementById('confirmPassword').value.trim();
    const role = document.getElementById('role').value;

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phonePattern = /^\d{10}$/;

    if (!name || !email || !phoneNumber || !password || !confirmPassword || !role) {
        alert('Please fill in all the fields.');
        event.preventDefault();
        return;
    }

    if (!emailPattern.test(email)) {
        alert('Please enter a valid email address.');
        event.preventDefault();
        return;
    }

    if (!phonePattern.test(phoneNumber)) {
        alert('Phone number must be contain only numbers.');
        event.preventDefault();
        return;
    }

    if (password.length < 6) {
        alert('Password should be at least 6 characters long.');
        event.preventDefault();
        return;
    }

    if (password !== confirmPassword) {
        alert('Passwords do not match.');
        event.preventDefault();
        return;
    }

    alert('Registration successful!');
});
