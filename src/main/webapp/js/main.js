console.log("OceanView Reservation System Loaded");

// Auto-hide success/error messages after 5 seconds
document.addEventListener("DOMContentLoaded", function() {
    const alerts = document.querySelectorAll(".success-message, .error-message, .success-alert, .error-alert");
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 500);
        }, 5000);
    });
});

// Confirm delete action
function confirmDelete(name) {
    return confirm(`Are you sure you want to delete the reservation for ${name}?`);
}

// Print invoice
function printInvoice() {
    window.print();
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-LK', {
        style: 'currency',
        currency: 'LKR'
    }).format(amount);
}

// Get today's date in YYYY-MM-DD format
function getTodayDate() {
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const day = String(today.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// Set minimum date for date inputs to today
document.addEventListener("DOMContentLoaded", function() {
    const checkInInputs = document.querySelectorAll('input[name="checkIn"]');
    const today = getTodayDate();
    
    checkInInputs.forEach(input => {
        input.setAttribute('min', today);
    });
});