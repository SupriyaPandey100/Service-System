<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  System View Component: Secure User Authentication (login.jsp)
  
  System Description:
  This component acts as the secure entry point for returning users to authenticate 
  into the ServiceHub platform. It strictly enforces the MVC design pattern by 
  delegating all backend business logic (Sessions/Cookies) to the LoginServlet.
  
  It utilizes Expression Language (EL) and JSTL for conditional rendering and 
  cookie handling (Remember Me functionality). No Java logic scriptlets are used.
  ==============================================================================
*/ %>

<!DOCTYPE html>
<html lang="en">
<head>
    <% /* =========================================
      HEAD SECTION: Metadata and External Assets
      - Preconnects to external APIs for optimized font/icon loading.
      - Loads specific stylesheets utilizing EL for dynamic context paths.
      =========================================
    */ %>
    <meta charset="UTF-8">
    <title>ServiceHub | Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <% /* Modular UI Injection: Renders the unified smart header component */ %>
    <jsp:include page="/components/header.jsp" />

    <main style="flex: 1;">
        <div class="auth-container" style="display: flex; align-items: center; justify-content: center; padding: 60px 0; min-height: 70vh;">
            <div class="card" style="width: 100%; max-width: 450px; padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #e5e7eb; box-sizing: border-box;">
                
                <h2 style="text-align: center; font-size: 26px; font-weight: 800; color: var(--text-main); margin-bottom: 8px;">Welcome Back</h2>
                <p style="text-align: center; color: var(--text-sub); font-size: 14px; margin-bottom: 24px;">Sign in to your account</p>
                
                <% /* =========================================
                  Dynamic Error Handling System:
                  Renders the warning UI only when a failure occurs from the Servlet.
                  =========================================
                */ %>
                <c:if test="${not empty error}">
                    <div style="background-color: #FDF2F2; color: #EC5B5B; padding: 12px 16px; border-radius: 8px; font-size: 14px; font-weight: 600; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <% /* =========================================
                  Secure Credential Transmission Form:
                  Includes EL (${rememberedEmail}) to autonomously populate the email field 
                  if a session token was previously saved via cookies.
                  =========================================
                */ %>
                <form action="${pageContext.request.contextPath}/login" method="post" style="display: flex; flex-direction: column; gap: 20px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px;">Email Address</label>
                        <input type="email" name="email" value="${rememberedEmail}" placeholder="Enter your email" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>
                    
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 8px;">Password</label>
                        <input type="password" name="password" placeholder="Enter your password" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>
                    
                    <% /* Client-Side Cookie Control (Remember Me Checkbox) */ %>
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <input type="checkbox" name="rememberMe" id="rememberMe" style="cursor: pointer;" ${not empty rememberedEmail ? 'checked' : ''}>
                        <label for="rememberMe" style="font-size: 13px; color: var(--text-sub); cursor: pointer;">Remember my email</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="padding: 14px; width: 100%; margin-top: 8px; font-family: inherit; font-weight: 600; border-radius: 8px; border: none; cursor: pointer;">Sign In</button>
                </form>
                
                <% /* System Routing: Redirects unauthenticated users to the registration pipeline */ %>
                <p style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-sub);">Don't have an account? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary-color); font-weight: 700;">Register here</a></p>
            </div>
        </div>
    </main>

    <% /* Modular UI Injection: Renders the global footer component */ %>
    <jsp:include page="/components/footer.jsp" />
    
</body>
</html>