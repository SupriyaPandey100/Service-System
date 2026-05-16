<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | User Dashboard</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body>

    <%@ include file="header.jsp" %>

    <main class="dashboard container">
        
        <section class="welcome-banner">
            <div class="welcome-text">
                <h1>Welcome back, <c:out value="${user.fullName}"/>! <i class="fas fa-hand-sparkles" style="color: #FFD700;"></i></h1>
                <p>Find and manage your home services easily.</p>
            </div>
            <a href="${pageContext.request.contextPath}/services" class="btn btn-primary">Browse Services</a>
        </section>

        <section class="stats-grid">
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Total Bookings</span>
                    <div class="stat-value"><c:out value="${totalBookings}"/></div>
                    <a href="${pageContext.request.contextPath}/bookings" class="view-link">View all bookings &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-hourglass-half"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Pending</span>
                    <div class="stat-value"><c:out value="${pendingBookings}"/></div>
                    <a href="${pageContext.request.contextPath}/bookings?status=pending" class="view-link">View pending &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Completed</span>
                    <div class="stat-value"><c:out value="${completedBookings}"/></div>
                    <a href="${pageContext.request.contextPath}/bookings?status=completed" class="view-link">View completed &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-bell"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Notifications</span>
                    <div class="stat-value"><c:out value="${notificationCount}"/></div>
                    <a href="#" class="view-link">View all &rarr;</a>
                </div>
            </div>
        </section>

        <div class="dashboard-content">
            <div class="main-column">
                <section class="service-finder-section card">
                    <h2 class="section-title">What service do you need help with?</h2>
                    
                    <form action="${pageContext.request.contextPath}/services" method="GET" class="search-bar-large">
                        <input type="text" name="search" placeholder="Search for cleaning, plumbing, electrician...">
                        <button type="submit" class="btn btn-primary btn-search">Search</button>
                    </form>
                    
                    <div class="services-grid">
                        <a href="${pageContext.request.contextPath}/services?category=Cleaning" class="service-category">
                            <div class="service-category-icon"><i class="fas fa-broom"></i></div>
                            <span class="service-category-name">Cleaning</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/services?category=Plumbing" class="service-category">
                            <div class="service-category-icon"><i class="fas fa-faucet"></i></div>
                            <span class="service-category-name">Plumbing</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/services?category=Electrical" class="service-category">
                            <div class="service-category-icon"><i class="fas fa-bolt"></i></div>
                            <span class="service-category-name">Electrician</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/services?category=AC" class="service-category">
                            <div class="service-category-icon"><i class="fas fa-snowflake"></i></div>
                            <span class="service-category-name">AC Repair</span>
                        </a>
                    </div>
                </section>
            </div>

            <aside class="dashboard-sidebar">
                <section class="card help-card">
                    <div class="help-icon-large"><i class="fas fa-headset"></i></div>
                    <h3>Need Help?</h3>
                    <p style="font-size: 14px; opacity: 0.9;">Our support team is here for you 24/7.</p>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline" style="width: 100%;">Contact Support</a>
                </section>
            </aside>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
    
</body>
</html>