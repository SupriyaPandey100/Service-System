<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body>

    <%@ include file="header_guest.jsp" %>

    <div class="auth-container" style="display: flex; align-items: center; justify-content: center; padding: 60px 0; min-height: 70vh;">
        <div class="card" style="width: 100%; max-width: 480px; padding: 40px; background: white;">
            <h2 style="text-align: center; font-size: 26px; font-weight: 800; color: var(--text-main); margin-bottom: 8px;">Create Account</h2>
            <p style="text-align: center; color: var(--text-sub); font-size: 14px; margin-bottom: 24px;">Join our platform today</p>
            
            <c:if test="${not empty error}">
                <div style="background-color: #FDF2F2; color: #EC5B5B; padding: 12px 16px; border-radius: 8px; font-size: 14px; font-weight: 600; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" style="display: flex; flex-direction: column; gap: 16px;">
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Full Name</label>
                    <input type="text" name="fullName" placeholder="Enter your full name" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Email Address</label>
                    <input type="email" name="email" placeholder="Enter your email" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Phone Number</label>
                    <input type="tel" name="phone" placeholder="10-digit phone number" style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Password</label>
                    <input type="password" name="password" placeholder="Minimum 6 characters" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Re-enter password" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>
                
                <button type="submit" class="btn btn-primary" style="padding: 14px; width: 100%; margin-top: 12px;">Create Account</button>
            </form>

            <p style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-sub);">Already have an account? <a href="login" style="color: var(--primary-color); font-weight: 700;">Login here</a></p>
        </div>
    </div>

    <%@ include file="footer_guest.jsp" %>

</body>
</html>