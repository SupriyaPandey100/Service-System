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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css?v=5.2">
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

    <%-- HERO BANNER - image stored in images/about/ folder as you requested --%>
    <div class="about-hero-banner">
        <div class="hero-overlay">
            <div class="hero-icon">
                <i class="fas fa-wrench"></i>
            </div>
            <h1>About ServiceHub</h1>
            <p>Your trusted platform for connecting with professional home service providers</p>

            <%-- REQUIREMENT: Cookie tracking metadata shown if user has visited before --%>
            <c:if test="${not empty cookieMessage}">
                <div class="cookie-badge">
                    <i class="far fa-clock"></i> ${cookieMessage}
                </div>
            </c:if>
        </div>
    </div>

    <%-- STATS BAR - dynamic numbers set by AboutServlet, fetched from backend --%>
    <section class="stats-bar-section">
        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number">
                    <i class="fas fa-smile"></i> ${happyCustomers}
                </span>
                <span class="stat-label">Happy Customers</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">
                    <i class="fas fa-user-check"></i> ${verifiedPros}
                </span>
                <span class="stat-label">Verified Professionals</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">
                    <i class="fas fa-tags"></i> ${serviceCategories}
                </span>
                <span class="stat-label">Service Categories</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-number">
                    <i class="fas fa-star"></i> ${avgRating}
                </span>
                <span class="stat-label">Average Rating</span>
            </div>
        </div>
    </section>

    <%-- MISSION SECTION --%>
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

    <%-- HOW IT WORKS SECTION - team images stored in images/about/ folder --%>
    <section class="how-it-works-section">
        <h2 class="section-title">How It Works</h2>
        <div class="how-grid">
            <div class="how-step">
                <div class="how-img-wrapper">
                    <img
                        src="${pageContext.request.contextPath}/images/about/step-browse.jpg"
                        alt="Browse Services"
                        class="how-img"
                        onerror="this.style.display='none'"
                    >
                </div>
                <div class="step-number">01</div>
                <h3><i class="fas fa-search"></i> Browse Services</h3>
                <p>Explore our wide range of home services across multiple categories all in one place.</p>
            </div>
            <div class="how-step">
                <div class="how-img-wrapper">
                    <img
                        src="${pageContext.request.contextPath}/images/about/step-book.jpg"
                        alt="Book Instantly"
                        class="how-img"
                        onerror="this.style.display='none'"
                    >
                </div>
                <div class="step-number">02</div>
                <h3><i class="fas fa-calendar-check"></i> Book Instantly</h3>
                <p>Choose your preferred time and book a professional in just a few clicks.</p>
            </div>
            <div class="how-step">
                <div class="how-img-wrapper">
                    <img
                        src="${pageContext.request.contextPath}/images/about/step-done.jpg"
                        alt="Job Done"
                        class="how-img"
                        onerror="this.style.display='none'"
                    >
                </div>
                <div class="step-number">03</div>
                <h3><i class="fas fa-check-double"></i> Job Done</h3>
                <p>Sit back and relax while our verified professionals take care of your home.</p>
            </div>
        </div>
    </section>

    <%-- TEAM SECTION - team member images stored in images/about/ folder --%>
    <section class="team-section">
        <h2 class="section-title">Meet the Team</h2>
        <p class="section-subtitle">The people behind ServiceHub who make it all happen</p>
        <div class="team-grid">
            <c:forEach var="member" items="${teamMembers}">
                <div class="team-card">
                    <div class="team-img-wrapper">
                        <img
                            src="${pageContext.request.contextPath}/images/about/${member.photo}"
                            alt="${member.name}"
                            class="team-img"
                            onerror="this.style.display='none'"
                        >
                    </div>
                    <h4 class="team-name"><c:out value="${member.name}"/></h4>
                    <span class="team-role">
                        <i class="fas fa-id-badge"></i>
                        <c:out value="${member.role}"/>
                    </span>
                </div>
            </c:forEach>
        </div>
    </section>

    <%-- CALL TO ACTION BANNER --%>
    <section class="join-container">
        <div class="join-box">
            <h2>Join Thousands of Satisfied Customers</h2>
            <p>Experience the convenience of professional home services at your fingertips</p>

            <%-- Button shows differently based on login state --%>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
                    <a href="${pageContext.request.contextPath}/services" class="btn-blue">
                        <i class="fas fa-th-large"></i> Browse Services
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/register" class="btn-blue">
                        <i class="fas fa-user-plus"></i> Get Started Free
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="btn-outline-white">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%-- CORE VALUES SECTION --%>
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
                <h3>Trust &amp; Safety</h3>
                <p>All professionals are verified, background-checked, and insured for your peace of mind.</p>
            </div>
            <div class="value-card">
                <div class="card-icon"><i class="fas fa-users"></i></div>
                <h3>Customer First</h3>
                <p>Your satisfaction is our priority. We are committed to providing excellent customer service.</p>
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