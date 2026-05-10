<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!-- FIXED JSTL URI FOR TOMCAT 10 -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Our Services</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shared.css">
</head>

<body>
    <nav class="navbar">
        <div class="logo"><i class="fas fa-wrench"></i> ServiceHub</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index">Home</a>
            <a href="${pageContext.request.contextPath}/services">Services</a>
            <a href="#">About</a>
            
        </div>
        <div class="auth-links" style="display: flex; align-items: center; gap: 20px;">
            <c:choose>
                <c:when test="${not empty userSession}">
                    <a href="${pageContext.request.contextPath}/dashboard" style="color: white; text-decoration: none;">Dashboard</a>
                    <span style="color: white;"><i class="far fa-user"></i> ${userSession.fullName}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-btn" style="text-decoration: none;"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" style="color: white; text-decoration: none;">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="nav-btn" style="text-decoration: none;">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>

    <div class="services-header">
        <h1>Our Services</h1>
        <p>Browse through our wide range of professional home services</p>
        <div class="search-bar">
            <i class="fas fa-search" style="position: absolute; margin: 15px 0 0 15px; color: #888;"></i>
            <input type="text" placeholder="Search for services..." style="padding-left: 45px;">
        </div>
    </div>

    <div class="filter-tabs">
        <button class="active">All</button>
        <button>Plumbing</button>
        <button>Electrical</button>
        <button>Painting</button>
        <button>Cleaning</button>
        <button>AC Repair</button>
        <button>Carpentry</button>
    </div>

    <div class="services-grid">
        <div class="service-card">
            <!-- Replaced broken img with Unsplash link from your other file -->
            <div class="service-img" style="height: 180px; background: url('https://images.unsplash.com/photo-1585704032915-c3400ca199e7?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80') center/cover;"></div>
            <div class="service-info">
                <span class="category">Plumbing</span>
                <h3>Plumbing Repair</h3>
                <p>Professional plumbing repair services for leaks, clogs, and pipe issues</p>
                <div class="service-meta">
                    <span style="color: #d4af37;"><i class="fas fa-star"></i> 4.8 (158)</span>
                    <span><i class="far fa-clock"></i> 2 hours</span>
                </div>
                <div class="service-footer">
                    <div>
                        <span style="font-size: 11px; color: #888; display: block;">Starting at</span>
                        <span class="price">NPR 1500</span>
                    </div>
                    <button class="book-btn">Book <i class="fas fa-arrow-right"></i></button>
                </div>
            </div>
        </div>

        <div class="service-card">
            <div class="service-img" style="height: 180px; background: url('https://images.unsplash.com/photo-1621905251189-08b45d6a269e?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80') center/cover;"></div>
            <div class="service-info">
                <span class="category">Electrical</span>
                <h3>Electrical Installation</h3>
                <p>Licensed electricians for wiring, fixtures, and electrical installations</p>
                <div class="service-meta">
                    <span style="color: #d4af37;"><i class="fas fa-star"></i> 4.9 (203)</span>
                    <span><i class="far fa-clock"></i> 3 hours</span>
                </div>
                <div class="service-footer">
                    <div>
                        <span style="font-size: 11px; color: #888; display: block;">Starting at</span>
                        <span class="price">NPR 2000</span>
                    </div>
                    <button class="book-btn">Book <i class="fas fa-arrow-right"></i></button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>