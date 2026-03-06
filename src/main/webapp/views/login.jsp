<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort · Staff Login</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/login.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts for Inter font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="../js/validation.js" defer></script>
</head>
<body>

<div class="login-container">
    <!-- Left Panel - Branding & Visual -->
    <div class="login-brand">
        <div class="brand-content">
            <div class="resort-badge">
                <i class="fas fa-umbrella-beach"></i>
                <span>Ocean View Resort</span>
            </div>
            
            <h1>Welcome Back</h1>
            
            <p class="brand-description">
                Access the staff dashboard to manage reservations, 
                room assignments, and guest services.
            </p>
            
            <div class="feature-list">
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Real-time room management</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Booking calendar integration</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Guest check-in/out system</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Housekeeping coordination</span>
                </div>
            </div>
            
            <div class="brand-footer">
                <i class="fas fa-shield-alt"></i>
                <span>Staff access only</span>
            </div>
        </div>
    </div>
    
    <!-- Right Panel - Login Form -->
    <div class="login-form-container">
        <div class="login-form-wrapper">
            <!-- Mobile Logo (visible on small screens) -->
            <div class="mobile-brand">
                <i class="fas fa-umbrella-beach"></i>
                <span>Ocean View Resort</span>
            </div>
            
            <div class="form-header">
                <h2>Staff Login</h2>
                <p>Please enter your credentials to access the dashboard</p>
            </div>
            
            <!-- Error Message -->
            <% if(request.getParameter("error") != null) { %>
                <div class="error-alert">
                    <i class="fas fa-exclamation-circle"></i>
                    <div class="error-content">
                        <strong>Authentication Failed</strong>
                        <span>Invalid username or password. Please try again.</span>
                    </div>
                    <button class="error-close" onclick="this.parentElement.remove()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            <% } %>
            
            <!-- Success Message (optional - for logout or password reset) -->
            <% if(request.getParameter("logout") != null) { %>
                <div class="success-alert">
                    <i class="fas fa-check-circle"></i>
                    <div class="success-content">
                        <strong>Logged Out Successfully</strong>
                        <span>You have been securely logged out.</span>
                    </div>
                </div>
            <% } %>
            
            <form action="<%= request.getContextPath() %>/LoginServlet" method="post" class="login-form" id="loginForm">
                <div class="input-group">
                    <label for="username">
                        <i class="fas fa-user"></i>
                        <span>Username</span>
                    </label>
                    <input 
                        type="text" 
                        name="username" 
                        id="username" 
                        placeholder="Enter your username"
                        required
                        autocomplete="username"
                        autofocus
                    >
                </div>
                
                <div class="input-group">
                    <label for="password">
                        <i class="fas fa-lock"></i>
                        <span>Password</span>
                    </label>
                    <div class="password-wrapper">
                        <input 
                            type="password" 
                            name="password" 
                            id="password" 
                            placeholder="Enter your password"
                            required
                            autocomplete="current-password"
                        >
                        <button 
                            type="button" 
                            class="password-toggle" 
                            onclick="togglePasswordVisibility()"
                            aria-label="Toggle password visibility"
                        >
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="login-button" id="loginButton">
                    <span class="button-text">Sign in to Dashboard</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
                
                <div class="security-note">
                    <span>Developed for Cardiff met Assigment By Sathira Sri Sathsara</span>
                </div>
            </form>
            
            <!-- Demo Credentials (for testing - remove in production) -->
            <div class="demo-credentials">
                <p class="demo-label">Demo Access</p>
                <div class="credential-row">
                    <span class="role">Staff:</span>
                    <span class="creds">admin / password</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add JavaScript for password visibility toggle -->
<script>
function togglePasswordVisibility() {
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    }
}

// Form validation
document.getElementById('loginForm').addEventListener('submit', function(e) {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value;
    const loginButton = document.getElementById('loginButton');
    
    if (!username || !password) {
        e.preventDefault();
        showValidationError('Please fill in all fields');
        return;
    }
    
    // Disable button to prevent double submission
    loginButton.disabled = true;
    loginButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing in...';
});

function showValidationError(message) {
    // Create error element if it doesn't exist
    let errorDiv = document.querySelector('.validation-error');
    if (!errorDiv) {
        errorDiv = document.createElement('div');
        errorDiv.className = 'validation-error';
        const form = document.getElementById('loginForm');
        form.insertBefore(errorDiv, form.firstChild);
    }
    
    errorDiv.innerHTML = `
        <i class="fas fa-exclamation-triangle"></i>
        <span>${message}</span>
    `;
    
    // Remove after 3 seconds
    setTimeout(() => {
        if (errorDiv) errorDiv.remove();
    }, 3000);
}
</script>

</body>
</html>