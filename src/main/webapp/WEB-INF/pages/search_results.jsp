<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body>

    <header>
        <div class="container">
            <a href="${pageContext.request.contextPath}/index" class="logo-group">
                <i class="fas fa-wrench logo-icon"></i>
                <span class="brand-name">ServiceHub</span>
            </a>
            
            <nav>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/dashboard" class="active">Dashboard</a></li>
                </ul>
            </nav>
            
            <div class="header-tools">
                
                <form action="${pageContext.request.contextPath}/search" method="GET" class="search-bar-small">
                    <input type="text" name="query" value="${searchQuery}" placeholder="Search bookings, notifications..." required>
                    <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                </form>
                
                <div class="notification-wrapper">
                    <div class="notification-bell">
                        <i class="fas fa-bell"></i>
                        <c:if test="${not empty notificationCount and notificationCount > 0}">
                            <span class="notification-count"><c:out value="${notificationCount}"/></span>
                        </c:if>
                    </div>
                    
                    <div class="notification-dropdown">
                        <div class="dropdown-header">
                            <h3>Notifications</h3>
                            <a href="${pageContext.request.contextPath}/mark-notifications-read">Mark all as read</a>
                        </div>
                        <div class="dropdown-body">
                            <c:choose>
                                <c:when test="${empty notificationsList}">
                                    <div style="text-align: center; padding: 30px 20px; color: var(--text-sub);">
                                        <i class="fas fa-bell-slash" style="font-size: 24px; margin-bottom: 10px; opacity: 0.5;"></i>
                                        <p style="margin: 0; font-size: 14px;">No new notifications</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="notif" items="${notificationsList}">
                                        <div class="notification-item">
                                            <div class="notification-icon-small">
                                                <c:choose>
                                                    <c:when test="${notif.type == 'SUCCESS'}"><i class="fas fa-check-circle" style="color: #27AE60;"></i></c:when>
                                                    <c:when test="${notif.type == 'WARNING'}"><i class="fas fa-exclamation-triangle" style="color: #F2994A;"></i></c:when>
                                                    <c:otherwise><i class="fas fa-info-circle" style="color: var(--primary-color);"></i></c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="notification-content">
                                                <p><c:out value="${notif.message}"/></p>
                                                <span class="time"><c:out value="${notif.createdAt}"/></span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <div class="user-dropdown">
                    <div class="user-avatar"><i class="fas fa-user"></i></div>
                    <span class="user-name"><c:out value="${user.fullName}"/> <i class="fas fa-chevron-down" style="font-size: 10px; margin-left: 5px;"></i></span>
                    
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> My Profile</a>
                        <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main class="dashboard container" style="margin-top: 40px; min-height: 60vh;">
        
        <div style="margin-bottom: 32px;">
            <h1 style="font-size: 28px; color: var(--text-main);">Search Results</h1>
            <p style="color: var(--text-sub);">Showing results for: <strong style="color: var(--primary-color);">"<c:out value="${searchQuery}"/>"</strong></p>
        </div>

        <c:choose>
            <c:when test="${hasResults}">
                <div class="dashboard-content" style="grid-template-columns: 1fr; gap: 32px;">
                    
                    <c:if test="${not empty bookingResults}">
                        <section class="card">
                            <h2 class="section-title"><i class="fas fa-calendar-check" style="color: var(--primary-color);"></i> Bookings Found</h2>
                            
                            <div class="bookings-list">
                                <c:forEach var="booking" items="${bookingResults}">
                                    <div class="booking-item" style="display: flex; justify-content: space-between; align-items: center; padding: 16px; border-bottom: 1px solid var(--border-color);">
                                        <div>
                                            <h3 style="margin: 0 0 4px 0; font-size: 16px; color: var(--text-main);"><c:out value="${booking.serviceName}"/></h3>
                                            <p style="margin: 0; font-size: 13px; color: var(--text-sub);">
                                                <i class="far fa-calendar"></i> <c:out value="${booking.serviceDate}"/> at <c:out value="${booking.serviceTime}"/>
                                            </p>
                                        </div>
                                        <div style="text-align: right;">
                                            <span style="display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; background: var(--secondary-bg); color: var(--primary-color);">
                                                <c:out value="${booking.status}"/>
                                            </span>
                                            <p style="margin: 4px 0 0 0; font-weight: 700; font-size: 14px; color: var(--text-main);">Rs. <c:out value="${booking.price}"/></p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </c:if>

                    <c:if test="${not empty notificationResults}">
                        <section class="card">
                            <h2 class="section-title"><i class="fas fa-bell" style="color: var(--primary-color);"></i> Notifications Found</h2>
                            <div class="notifications-list">
                                <c:forEach var="notif" items="${notificationResults}">
                                    <div class="notification-item" style="display: flex; gap: 12px; padding: 16px; border-bottom: 1px solid var(--border-color);">
                                        <div class="notification-icon-small" style="width: 36px; height: 36px; border-radius: 8px; background-color: var(--secondary-bg); display: flex; align-items: center; justify-content: center; flex-shrink: 0; color: var(--primary-color);">
                                            <i class="fas fa-envelope-open-text"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p style="font-size: 14px; margin: 0; color: var(--text-main); font-weight: 500;"><c:out value="${notif.message}"/></p>
                                            <span class="time" style="font-size: 11px; color: var(--text-sub);"><c:out value="${notif.createdAt}"/></span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </c:if>

                </div>
            </c:when>
            
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 60px 20px;">
                    <i class="fas fa-search" style="font-size: 48px; color: var(--border-color); margin-bottom: 16px;"></i>
                    <h3 style="color: var(--text-main); margin-bottom: 8px;">No results found</h3>
                    <p style="color: var(--text-sub); margin-bottom: 24px;">We couldn't find anything matching "<c:out value="${searchQuery}"/>".</p>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Return to Dashboard</a>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-about">
                    <h3><i class="fas fa-wrench" style="color: #FFFFFF;"></i> ServiceHub</h3>
                    <p>Your trusted platform for quality home services. Book professional service providers with ease and track your appointments in real-time.</p>
                </div>
                <div class="footer-links">
                    <h4>Quick Links</h4>
                    <a href="${pageContext.request.contextPath}/services">Browse Services</a>
                    <a href="${pageContext.request.contextPath}/about">About Us</a>
                    <a href="${pageContext.request.contextPath}/contact">Contact Support</a>
                </div>
                <div class="footer-contact">
                    <h4>Contact Info</h4>
                    <p><i class="fas fa-envelope"></i> info@servicehub.com</p>
                    <p><i class="fas fa-phone"></i> +977 9841234567</p>
                    <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 ServiceHub. All rights reserved.</p>
            </div>
        </div>
    </footer>

</body>
</html>