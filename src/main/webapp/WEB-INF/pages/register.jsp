<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  System View Component: New User Registration Pipeline (register.jsp)
  
  System Description:
  This component provides the frontend interface for onboarding new users into 
  the ServiceHub platform. It captures essential user data and securely transmits 
  it to the RegisterServlet via a POST request for backend validation and database 
  insertion.
  
  Architecture & Logic:
  - Strictly enforces the MVC design pattern. All database connections, password 
    hashing, and validation logic are offloaded to the Servlet and DAO layers.
  - Dynamically renders server-side validation errors using JSTL (<c:if>) and EL.
  - Employs zero Java logic scriptlets to maintain a pure, maintainable View layer.
  - Dynamically injects the global header and footer components.
  ==============================================================================
*/ %>

<!DOCTYPE html>
<html lang="en">
<head>
    <% /* =========================================
      HEAD SECTION: Metadata and External Assets
      - Defines UTF-8 encoding to ensure secure and accurate character handling.
      - Pre-connects to Google APIs for optimized rendering of UI typography and icons.
      - Uses Expression Language to dynamically construct absolute paths to CSS files.
      =========================================
    */ %>
    <meta charset="UTF-8">
    <title>ServiceHub | Register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <% /* Modular UI Injection: Renders the unified smart header. */ %>
    <jsp:include page="/components/header.jsp" />

    <main style="flex: 1;">
        <div class="auth-container" style="display: flex; align-items: center; justify-content: center; padding: 60px 0; min-height: 70vh;">
            <div class="card" style="width: 100%; max-width: 480px; padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #e5e7eb; box-sizing: border-box;">
                
                <% /* =========================================
                  REGISTRATION HEADER
                  =========================================
                */ %>
                <h2 style="text-align: center; font-size: 26px; font-weight: 800; color: var(--text-main); margin-bottom: 8px;">Create Account</h2>
                <p style="text-align: center; color: var(--text-sub); font-size: 14px; margin-bottom: 24px;">Join our platform today</p>
                
                <% /* =========================================
                  DYNAMIC ERROR HANDLING
                  Intercepts feedback from the RegisterServlet. If validation fails 
                  (e.g., passwords don't match, email already exists), it renders 
                  the error message dynamically using JSTL.
                  =========================================
                */ %>
                <c:if test="${not empty error}">
                    <div style="background-color: #FDF2F2; color: #EC5B5B; padding: 12px 16px; border-radius: 8px; font-size: 14px; font-weight: 600; margin-bottom: 20px;">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <% /* =========================================
                  ACCOUNT CREATION FORM
                  Constructs a secure POST payload to transmit user details to the server.
                  Includes client-side 'required' attributes as a first line of defense 
                  before server-side validation.
                  =========================================
                */ %>
                <form action="${pageContext.request.contextPath}/register" method="POST" style="display: flex; flex-direction: column; gap: 16px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Full Name</label>
                        <input type="text" name="fullName" placeholder="Enter your full name" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Email Address</label>
                        <input type="email" name="email" placeholder="Enter your email" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Phone Number</label>
                        <input type="tel" name="phone" placeholder="10-digit phone number" style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Password</label>
                        <input type="password" name="password" placeholder="Minimum 6 characters" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; margin-bottom: 6px;">Confirm Password</label>
                        <input type="password" name="confirmPassword" placeholder="Re-enter password" required style="width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="padding: 14px; width: 100%; margin-top: 12px; font-family: inherit; font-weight: 600; border-radius: 8px; border: none; cursor: pointer;">Create Account</button>
                </form>

                <% /* System Routing: Fallback redirect for users who already have an account */ %>
                <p style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-sub);">Already have an account? <a href="${pageContext.request.contextPath}/login" style="color: var(--primary-color); font-weight: 700;">Login here</a></p>
            </div>
        </div>
    </main>

    <% /* Modular UI Injection: Renders the global footer component */ %>
    <jsp:include page="/components/footer.jsp" />

</body>
</html>