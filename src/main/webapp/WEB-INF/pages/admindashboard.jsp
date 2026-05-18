<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | ServiceHub</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admindashboard.css">

   
    <style>

        .navbar {
            background: linear-gradient(135deg, #6B3E9B 0%, #8B5FBF 100%);
            padding: 12px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .logo {
            color: white;
            font-weight: 800;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-links {
            display: flex;
            gap: 32px;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            font-size: 14px;
            font-weight: 600;
            color: #FFFFFF;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #FFD700;
        }

        .header-tools {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .search-bar {
            position: relative;
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #6B3E9B;
        }

        .search-input {
            width: 250px;
            padding: 10px 12px 10px 35px;
            border: none;
            border-radius: 25px;
            outline: none;
        }

        .user-dropdown {
            position: relative;
            display: inline-block;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
            color: white;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 30px;
        }

        .user-info:hover {
            background: rgba(255,255,255,0.2);
        }

        .dropdown-menu {
            position: absolute;
            top: 45px;
            right: 0;
            width: 180px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: 0.3s;
        }

        .user-dropdown:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-menu a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            text-decoration: none;
            color: #333;
            font-size: 13px;
        }

        .dropdown-menu a:hover {
            background-color: #f5f5f5;
        }

        .logout-link {
            border-top: 1px solid #eee;
            color: #e74c3c !important;
        }

        .logout-link i {
            color: #e74c3c !important;
        }

    </style>
</head>

<body>


<nav class="navbar">

    <div class="logo">
        <i class="fas fa-wrench"></i>
        ServiceHub
    </div>

    <!-- Admin Navigation -->
    <c:if test="${sessionScope.userSession.role == 'ADMIN'}">
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admindashboard">Admin Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/manageBooking">Bookings</a>
            <a href="${pageContext.request.contextPath}/admin/manageuser">Users</a>
            <a href="${pageContext.request.contextPath}/admin/managetechnician">Technicians</a>
        </div>
    </c:if>

   
    <div class="header-tools">

        <div class="search-bar">
            <i class="fas fa-search search-icon"></i>
            <form action="${pageContext.request.contextPath}/search" method="get">
                <input type="text" name="query" class="search-input" placeholder="Search bookings, users...">
            </form>
        </div>

        <div class="user-dropdown">

            <div class="user-info">
                <i class="fas fa-user-circle"></i>
                <span>${sessionScope.userSession.fullName}</span>
                <i class="fas fa-chevron-down"></i>
            </div>

            <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/profile">
                    <i class="fa-solid fa-circle-user"></i>My Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>

        </div>

    </div>

</nav>


<main class="dashboard-main">
    <div class="dashboard-container">

        <div class="page-header">
            <h1>Admin Dashboard</h1>
            <p>Manage your home service platform</p>
        </div>

     
        <div class="stats-grid">
            <div class="stat-card">
                <i class="fa-solid fa-wrench"></i>
                <h3>${totalUsers}</h3>
                <p>Total Services</p>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-user-gear"></i>
                <h3>${totalTechnicians}</h3>
                <p>Technicians</p>
            </div>

            <div class="stat-card">
                <i class="fa-regular fa-calendar"></i>
                <h3>${totalBookings}</h3>
                <p>Total Bookings</p>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-arrow-trend-up"></i>
                <h3>${pendingBookings}</h3>
                <p>Pending Bookings</p>
            </div>
        </div>

        
        <div class="quick-actions">
            <h2>Quick Actions</h2>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/managetechnician" class="action-btn">
                    <i class="fa-solid fa-user-gear"></i>
                    <span>Manage Technician</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/manageBooking" class="action-btn">
                    <i class="fa-solid fa-calendar"></i>
                    <span>Manage Bookings</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/manageuser" class="action-btn">
                    <i class="fa-solid fa-users"></i>
                    <span>Manage Users</span>
                </a>
            </div>
        </div>

    </div>
</main>

</body>
<footer class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services. Book professional service providers with ease and confidence.</p>
        </div>
        
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h3>Contact Info</h3>
            <p><i class="fas fa-envelope"></i> info@ServiceHub.com</p>
            <p><i class="fas fa-phone"></i> +977 9841234567</p>
            <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2026 ServiceHub. All rights reserved.</p>
    </div>
</footer>

<style>
    /* ========== FOOTER STYLES ========== */
    .footer {
        background: linear-gradient(135deg, #6B3E9B 0%, #8B5FBF 100%);
        color: white;
        padding: 40px 8% 20px;
        margin-top: 60px;
    }
    
    .footer-content {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 50px;
        margin-bottom: 30px;
    }
    
    .footer-section h3 {
        margin-bottom: 20px;
        font-size: 1.2rem;
        display: flex;
        align-items: center;
        gap: 10px;
        color: white;
    }
    
    .footer-section p {
        color: rgba(255, 255, 255, 0.8);
        line-height: 1.6;
        margin-bottom: 10px;
        font-size: 0.9rem;
    }
    
    .footer-section ul {
        list-style: none;
        padding: 0;
    }
    
    .footer-section ul li {
        margin-bottom: 10px;
    }
    
    .footer-section ul li a {
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
        transition: all 0.3s;
        font-size: 0.9rem;
    }
    
    .footer-section ul li a:hover {
        color: white;
        padding-left: 5px;
    }
    
    .footer-section i {
        width: 25px;
        margin-right: 5px;
    }
    
    .footer-bottom {
        text-align: center;
        padding-top: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    .footer-bottom p {
        color: rgba(255, 255, 255, 0.6);
        font-size: 0.85rem;
    }
    
    /* ========== RESPONSIVE DESIGN ========== */
    @media (max-width: 992px) {
        .footer-content {
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
        }
    }
    
    @media (max-width: 768px) {
        .footer {
            padding: 40px 5% 20px;
            margin-top: 40px;
        }
        .footer-content {
            grid-template-columns: 1fr;
            text-align: center;
            gap: 30px;
        }
        .footer-section h3 {
            justify-content: center;
        }
        .footer-section ul li a:hover {
            padding-left: 0;
        }
        .footer-section i {
            margin-right: 0;
        }
    }
</style>
</html>