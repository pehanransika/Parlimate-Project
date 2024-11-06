
function showForm(formType) {

    document.querySelectorAll('.form-section').forEach(section => section.style.display = 'none');


    document.getElementById(`${formType}-form`).style.display = 'block';
}


function sendOtp() {
    alert('OTP sent to the provided phone number.');
}


function sendOtpAndEmailVerification() {
    alert('OTP and verification email sent.');
}


document.addEventListener('DOMContentLoaded', () => {

    document.querySelectorAll('.form-section').forEach(section => section.style.display = 'none');
});
