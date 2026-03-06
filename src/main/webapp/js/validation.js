function validateLogin() {
    let username = document.getElementById("username").value.trim();
    let password = document.getElementById("password").value.trim();

    if (username === "" || password === "") {
        alert("Please fill all fields");
        return false;
    }

    return true;
}

// Toggle password visibility in login form
function togglePasswordVisibility() {
    const passwordInput = document.getElementById("password");
    const toggleIcon = document.getElementById("toggleIcon");
    
    if (passwordInput.type === "password") {
        passwordInput.type = "text";
        toggleIcon.classList.remove("fa-eye");
        toggleIcon.classList.add("fa-eye-slash");
    } else {
        passwordInput.type = "password";
        toggleIcon.classList.remove("fa-eye-slash");
        toggleIcon.classList.add("fa-eye");
    }
}

// Validate reservation form
function validateReservation() {
    const checkIn = document.getElementsByName("checkIn")[0].value;
    const checkOut = document.getElementsByName("checkOut")[0].value;
    
    if (!checkIn || !checkOut) {
        alert("Please select check-in and check-out dates");
        return false;
    }
    
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    
    if (checkOutDate <= checkInDate) {
        alert("Check-out date must be after check-in date");
        return false;
    }
    
    return true;
}

// Validate contact number
function validateContact(input) {
    const pattern = /^[0-9]{10}$/;
    if (!pattern.test(input.value)) {
        input.style.borderColor = "red";
        return false;
    } else {
        input.style.borderColor = "#ddd";
        return true;
    }
}