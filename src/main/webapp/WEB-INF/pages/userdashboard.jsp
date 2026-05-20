<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  System View Component: Authenticated User Dashboard Layout (userdashboard.jsp)
  ==============================================================================
*/ %>

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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=6.0">
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <jsp:include page="/components/header.jsp" />

    <main class="dashboard container" style="flex: 1; padding: 20px 40px; max-width: 1200px; margin: 0 auto; width: 100%; box-sizing: border-box;">
        
        <section class="welcome-banner">
            <div class="welcome-text">
                <c:set var="activeUser" value="${not empty sessionScope.loggedUser ? sessionScope.loggedUser : sessionScope.userSession}" />
                <h1>Welcome back, <c:out value="${activeUser.fullName}" default="User"/> </h1>
                <p>Find and manage your home services easily.</p>
            </div>
            <a href="${pageContext.request.contextPath}/services" class="btn btn-primary">Browse Services</a>
        </section>

        <section class="stats-grid">
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Total Bookings</span>
                    <div class="stat-value"><c:out value="${bookingCounts['All']}" default="0"/></div>
                    <a href="${pageContext.request.contextPath}/bookings?status=All" class="view-link">View all bookings &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-hourglass-half"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Pending</span>
                    <div class="stat-value"><c:out value="${bookingCounts['Pending']}" default="0"/></div>
                    <a href="${pageContext.request.contextPath}/bookings?status=Pending" class="view-link">View pending &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Completed</span>
                    <div class="stat-value"><c:out value="${bookingCounts['Completed']}" default="0"/></div>
                    <a href="${pageContext.request.contextPath}/bookings?status=Completed" class="view-link">View completed &rarr;</a>
                </div>
            </div>
            
            <div class="card stat-card">
                <div class="stat-icon"><i class="fas fa-bell"></i></div>
                <div class="stat-info">
                    <span class="stat-label">Notifications</span>
                    <div class="stat-value"><c:out value="${notificationCount}" default="0"/></div>
                    <a href="#notificationModal" class="view-link">View all &rarr;</a>
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
                            <div class="service-category-icon"><i class="fa-solid fa-broom"></i></div>
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

    <div id="notificationModal" class="system-modal-overlay">
        <div class="system-modal-container">
            
            <div class="system-modal-header">
                <div class="modal-header-text">
                    <h2> Notifications</h2>
                    <p>Track your  actions </p>
                </div>
                <a href="#close" class="modal-close-anchor">&times;</a>
            </div>
            
            <div class="system-modal-body">
                <c:choose>
                    <c:when test="${empty notificationsList}">
                        <div style="text-align: center; padding: 60px 20px; color: var(--text-sub);">
                            <i class="fas fa-bell-slash" style="font-size: 44px; margin-bottom: 16px; color: var(--primary-color); opacity: 0.5;"></i>
                            <h4 style="margin: 0 0 4px 0; color: var(--text-main); font-size: 16px; font-weight: 700;">All caught up!</h4>
                            <p style="margin: 0; font-size: 13px;">Check your updates</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="notif" items="${notificationsList}">
                            <div class="modal-notification-item">
                                <div class="modal-icon-wrapper">
                                    <c:choose>
                                        <c:when test="${notif.type == 'SUCCESS'}"><i class="fas fa-check-circle" style="color: #27AE60;"></i></c:when>
                                        <c:when test="${notif.type == 'WARNING'}"><i class="fas fa-exclamation-triangle" style="color: #F2994A;"></i></c:when>
                                        <c:otherwise><i class="fas fa-info-circle" style="color: var(--primary-color);"></i></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="modal-content-wrapper">
                                    <p><c:out value="${notif.message}"/></p>
                                    <span class="timestamp-stamp"><i class="far fa-clock"></i> <c:out value="${notif.createdAt}"/></span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="system-modal-footer">
                <c:choose>
                    <c:when test="${not empty notificationsList}">
                        <a href="${pageContext.request.contextPath}/mark-notifications-read" class="modal-btn-action">
                            <i class="fas fa-check-double"></i> Mark all as read
                        </a>
                        <a href="#close" class="modal-btn-cancel">Close</a>
                    </c:when>
                    <c:otherwise>
                        <a href="#close" class="modal-btn-action" style="width: 100%; text-align: center; background-color: var(--primary-color) !important;">
                            Close
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </div>
    </div> 

    <jsp:include page="/components/footer.jsp" />
    
</body>
</html>