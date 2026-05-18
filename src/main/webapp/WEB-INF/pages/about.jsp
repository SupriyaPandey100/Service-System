<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | About Us</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css">
</head>
<body>

    <%-- FIX: check both loggedUser and userSession --%>
    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="header.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="header_guest.jsp" %>
        </c:otherwise>
    </c:choose>

    <%-- HERO BANNER --%>
    <div class="about-hero-banner"
         style="background-image: url('${pageContext.request.contextPath}/images/Aboutpage.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;">
        <div class="hero-overlay">
            <div class="hero-icon-circle">
                <i class="fas fa-wrench"></i>
            </div>
            <h1>About ServiceHub</h1>
            <p>Your trusted platform for connecting with professional home service providers</p>
        </div>
    </div>

   

    <%-- MISSION SECTION --%>
    <section class="mission-container">
        <div class="mission-box">
            <h2>Our Mission</h2>
            <p class="mission-text">
                ServiceHub was founded with a simple mission: to make finding and booking reliable
                home service professionals as easy as possible. We understand that your home is your
                most valuable asset, and you deserve the best care for it.
            </p>
            <p class="mission-text">
                We carefully vet all our service providers to ensure they meet our high standards of
                professionalism, quality, and reliability. Our platform brings together skilled professionals
                and homeowners, creating a seamless experience for all your home service needs.
            </p>
        </div>
    </section>

    <%-- TEAM SECTION --%>
    <section class="team-section">
        <h2>Meet Our Team</h2>
        <p class="team-subtitle">The passionate people behind ServiceHub</p>
        <div class="team-grid">

            <div class="team-card">
                <div class="team-img-wrapper">
                    <img src="${pageContext.request.contextPath}/images/supriya.jpg.jpeg"
                         alt="Supriya Pandey" class="team-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="team-info">
                    <h3>Supriya Pandey</h3>
                    <span class="team-role">Founder &amp; CEO</span>
                    <p class="team-bio">Visionary leader with 10+ years in home service industry. Passionate about connecting customers with quality professionals.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="team-img-wrapper">
                    <img src="${pageContext.request.contextPath}/images/sunibha.jpg"
                         alt="Sunibha Maskey" class="team-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="team-info">
                    <h3>Sunibha Maskey</h3>
                    <span class="team-role">Head of Operations</span>
                    <p class="team-bio">Ensures smooth day-to-day operations and maintains high quality standards across all service providers.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="team-img-wrapper">
                    <img src="${pageContext.request.contextPath}/images/nikita.jpg"
                         alt="Nikita Bhatta" class="team-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="team-info">
                    <h3>Nikita Bhatta</h3>
                    <span class="team-role">Tech Lead</span>
                    <p class="team-bio">Architect of our platform, ensuring seamless booking experience and secure transactions for all users.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="team-img-wrapper">
                    <img src="${pageContext.request.contextPath}/images/ashika.jpg.jpeg"
                         alt="Mamta Poudel" class="team-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="team-info">
                    <h3>Mamta Poudel</h3>
                    <span class="team-role">Customer Success Lead</span>
                    <p class="team-bio">Dedicated to providing exceptional support and ensuring every customer has a great experience.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>

            <div class="team-card">
                <div class="team-img-wrapper">
                    <img src="${pageContext.request.contextPath}/images/pratikshya.jpeg"
                         alt="Pratikshya Shrestha" class="team-img"
                         onerror="this.style.display='none'">
                </div>
                <div class="team-info">
                    <h3>Pratikshya Shrestha</h3>
                    <span class="team-role">Head of Partnerships</span>
                    <p class="team-bio">Builds strong relationships with service providers, ensuring they meet our high quality standards.</p>
                    <div class="team-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <%-- CALL TO ACTION BANNER --%>
    <section class="join-container">
        <div class="join-box">
            <h2>Join Thousands of Satisfied Customers</h2>
            <p>Experience the convenience of professional home services at your fingertips</p>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
                    <a href="${pageContext.request.contextPath}/services" class="btn-primary">
                        <i class="fas fa-th-large"></i> Browse Services
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/register" class="btn-primary">
                        <i class="fas fa-user-plus"></i> Get Started Free
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="btn-outline">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%-- CORE VALUES SECTION --%>
    <section class="values-section">
        <h2>Our Core Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon"><i class="fas fa-check-circle"></i></div>
                <h3>Quality Service</h3>
                <p>We ensure all our service providers deliver top-quality work with professional standards.</p>
            </div>
            <div class="value-card">
                <div class="value-icon"><i class="fas fa-shield-alt"></i></div>
                <h3>Trust &amp; Safety</h3>
                <p>All professionals are verified, background-checked, and insured for your peace of mind.</p>
            </div>
            <div class="value-card">
                <div class="value-icon"><i class="fas fa-users"></i></div>
                <h3>Customer First</h3>
                <p>Your satisfaction is our priority. We are committed to providing excellent customer service.</p>
            </div>
            <div class="value-card">
                <div class="value-icon"><i class="fas fa-medal"></i></div>
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