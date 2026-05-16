<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body>

    <%@ include file="header_guest.jsp" %>

    <div class="auth-container" style="display: flex; align-items: center; justify-content: center; padding: 60px 0; min-height: 70vh;">
        <div class="card" style="width: 100%; max-width: 450px; padding: 40px; background: white;">
            <h2 style="text-align: center; font-size: 26px; font-weight: 800; color: var(--text-main); margin-bottom: 8px;">Welcome Back</h2>
            <p style="text-align: center; color: var(--text-sub); font-size: 14px; margin-bottom: 24px;">Sign in to your account</p>
            
            <c:if test="${not empty error}">
                <div style="background-color: #FDF2F2; color: #EC5B5B; padding: 12px 16px; border-radius: 8px; font-size: 14px; font-weight: 600; margin-bottom: 20px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" style="display: flex; flex-direction: column; gap: 20px;">
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px;">Email Address</label>
                    <input type="email" name="email" value="${rememberedEmail}" placeholder="Enter your email" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>
                
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px;">Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit;">
                </div>
                
                <button type="submit" class="btn btn-primary" style="padding: 14px; width: 100%; margin-top: 8px;">Sign In</button>
            </form>
            
            <p style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-sub);">Don't have an account? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary-color); font-weight: 700;">Register here</a></p>
        </div>
    </div>

    <%@ include file="footer_guest.jsp" %>
</body>
</html>