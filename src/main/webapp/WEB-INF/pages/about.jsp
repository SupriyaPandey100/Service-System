<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- REQUIREMENT: Using JSTL Core library to handle conditional logic without scriptlets --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | About Us</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <%-- Style sheets mapped correctly to separate presentation concerns --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shared.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css?v=5.1">
</head>
<body>

    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="header.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="header_guest.jsp" %>
        </c:otherwise>
    </c:choose>

    <div class="about-hero-banner">
        <div class="hero-overlay">
            <div class="hero-icon"><i class="fas fa-wrench"></i></div>
            <h1>About ServiceHub</h1>
            <p>Your trusted platform for connecting with professional home service providers</p>
            
            <%-- REQUIREMENT: Render cookie tracking metadata if active --%>
            <c:if test="${not empty cookieMessage}">
                <div style="margin-top: 20px; padding: 10px 20px; background: rgba(255,255,255,0.15); border-radius: 50px; font-size: 0.9rem; display: inline-block; color: #ffffff;">
                    <i class="far fa-clock"></i> ${cookieMessage}
                </div>
            </c:if>
        </div>
    </div>

    <section class="mission-container">
        <div class="mission-box">
            <h2>Our Mission</h2>
            <p>
                ServiceHub was founded with a simple mission: to make finding and booking reliable 
                home service professionals as easy as possible. We understand that your home is your 
                most valuable asset, and you deserve the best care for it.
            </p>
            <p>
                We carefully vet all our service providers to ensure they meet our high standards of 
                professionalism, quality, and reliability. Our platform brings together skilled professionals 
                and homeowners, creating a seamless experience for all your home service needs.
            </p>
        </div>
    </section>

    <section class="join-container">
        <div class="join-box">
            <h2>Join Thousands of Satisfied Customers</h2>
            <p>Experience the convenience of professional home services at your fingertips</p>
            <a href="${pageContext.request.contextPath}/services" class="btn-blue">
                Browse Services
            </a>
        </div>
    </section>

    <section class="values-section">
        <h2 class="section-title">Our Core Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-check-circle"></i></div>
                <h3>Quality Service</h3>
                <p>We ensure all our service providers deliver top-quality work with professional standards.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-shield-alt"></i></div>
                <h3>Trust & Safety</h3>
                <p>All professionals are verified, background-checked, and insured for your peace of mind.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <h3>Customer First</h3>
                <p>Your satisfaction is our priority. We're committed to providing excellent customer service.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-medal"></i></div>
                <h3>Excellence</h3>
                <p>We strive for excellence in every service, ensuring consistent quality and reliability.</p>
            </div>
        </div>
    </section>

    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="footer.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="footer_guest.jsp" %>
        </c:otherwise>
    </c:choose>

</body>
</html>