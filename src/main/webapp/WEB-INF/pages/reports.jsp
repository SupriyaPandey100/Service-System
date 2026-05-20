<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reports | HomeService</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
{ margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #F5F5F5; color: #1a1a1a; }

header { background-color: #5D5482; color: #FFFFFF; padding: 16px 0; position: sticky; top: 0; z-index: 1000; }
header .container { display: flex; align-items: center; justify-content: space-between; width: 95%; max-width: 1600px; margin: 0 auto; padding: 0 20px; }
.logo-group { display: flex; align-items: center; gap: 8px; text-decoration: none; }
.logo-icon { color: #FFFFFF; font-size: 24px; }
.brand-name { font-size: 20px; font-weight: 800; color: #FFFFFF; }
.nav-links { display: flex; gap: 32px; list-style: none; }
.nav-links a { font-size: 14px; font-weight: 600; color: #FFFFFF; text-decoration: none; }
.nav-links a:hover, .nav-links a.active { color: #FFD700; }
.header-tools { display: flex; align-items: center; gap: 20px; }

.user-dropdown { position: relative; display: inline-block; }
.user-info { display: flex; align-items: center; gap: 8px; color: white; cursor: pointer; padding: 5px 10px; border-radius: 30px; }
.dropdown-menu { position: absolute; top: 45px; right: 0; width: 180px; background: white; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); opacity: 0; visibility: hidden; transition: 0.3s; z-index: 100; }
.user-dropdown:hover .dropdown-menu { opacity: 1; visibility: visible; }
.dropdown-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 16px; text-decoration: none; color: #333; font-size: 13px; }
.dropdown-menu a:hover { background-color: #f5f5f5; }
.text-danger { color: #EB5757 !important; }

.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; }
.page-title { margin-bottom: 30px; }
.page-title h1 { font-size: 28px; font-weight: 700; color: #1a1a1a; margin-bottom: 5px; }
.page-title p { color: #666; font-size: 14px; }

.stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
.stat-card { background: white; padding: 25px; border-radius: 16px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.stat-card i { font-size: 35px; color: #5D5482; margin-bottom: 15px; }
.stat-card h3 { font-size: 28px; color: #333; margin-bottom: 5px; }
.stat-card p { color: #666; font-size: 13px; }

.report-section { background: white; border-radius: 16px; padding: 25px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
.report-section h2 { font-size: 18px; margin-bottom: 20px; color: #333; border-bottom: 2px solid #5D5482; padding-bottom: 10px; display: inline-block; }

table { width: 100%; border-collapse: collapse; }
th { text-align: left; padding: 12px 15px; background: #FAFAFA; font-size: 13px; font-weight: 600; color: #666; border-bottom: 1px solid #EEE; }
td { padding: 12px 15px; font-size: 14px; border-bottom: 1px solid #EEE; }
tr:hover { background: #F9F9F9; }

.progress-bar { background: #E0E0E0; border-radius: 10px; height: 20px; width: 100%; overflow: hidden; }
.progress-fill { background: #5D5482; height: 100%; border-radius: 10px; }

.status-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
.status-badge.COMPLETED { background: #E8F5E9; color: #27AE60; }
.status-badge.PENDING { background: #FFF3E0; color: #F2994A; }
.status-badge.CONFIRMED { background: #E3F2FD; color: #2196F3; }
.status-badge.CANCELLED { background: #FFEBEE; color: #EB5757; }

footer { background: #5D5482; padding: 3rem 5% 2rem; margin-top: 40px; }
.footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 3rem; max-width: 1200px; margin: 0 auto; padding-bottom: 2rem; border-bottom: 1px solid rgba(255,255,255,0.15); }
.footer-col h3 { font-size: 16px; margin-bottom: 1rem; color: #FFFFFF; }
.footer-col p, .footer-col a { color: rgba(255,255,255,0.75); font-size: 13px; margin-bottom: 8px; text-decoration: none; display: block; }
.footer-col a:hover { color: #FFD700; }
.copyright { text-align: center; color: rgba(255,255,255,0.6); font-size: 12px; margin-top: 2rem; }
</style>
</head>
<body>

<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admindashboard" class="logo-group">
            <i class="fas fa-wrench logo-icon"></i>
            <span class="brand-name">HomeService</span>
        </a>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/admindashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/manageuser">Users</a></li>
            <li><a href="${pageContext.request.contextPath}/managetechnician">Technicians</a></li>
            <li><a href="${pageContext.request.contextPath}/reports" class="active">Reports</a></li>
        </ul>
        <div class="header-tools">
            <div class="user-dropdown">
                <div class="user-info">
                    <i class="fas fa-user-circle"></i>
                    <span>Admin</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="dropdown-menu">
                    <a href="#"><i class="fas fa-user-cog"></i> My Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div class="page-title">
        <h1><i class="fas fa-chart-line"></i> Reports & Analytics</h1>
        <p>View insights and statistics of your home service platform</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <i class="fas fa-calendar"></i>
            <h3>${totalBookings}</h3>
            <p>Total Bookings</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-rupee-sign"></i>
            <h3>₹ ${totalRevenue}</h3>
            <p>Total Revenue</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-users"></i>
            <h3>${totalCustomers}</h3>
            <p>Total Customers</p>
        </div>
    </div>

    <div class="report-section">
        <h2><i class="fas fa-chart-pie"></i> Booking Status</h2>
        <table>
            <thead>
                <tr><th>Status</th><th>Count</th><th>Percentage</th></tr>
            </thead>
            <tbody>
                <c:set var="total" value="${totalBookings}"/>
                <c:forEach items="${bookingStatus}" var="status">
                    <tr>
                        <td><span class="status-badge ${status.key}">${status.key}</span></td>
                        <td>${status.value}</td>
                        <td>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${total > 0 ? (status.value * 100 / total) : 0}%;"></div>
                            </div>
                            ${total > 0 ? (status.value * 100 / total) : 0}%
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookingStatus}">
                    <tr><td colspan="3" style="text-align: center;">No data available</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <div class="report-section">
        <h2><i class="fas fa-trophy"></i> Top Performing Technicians</h2>
        <table>
            <thead>
                <tr><th>Rank</th><th>Technician Name</th><th>Services</th><th>Completed Jobs</th><th>Contact</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${topTechnicians}" var="tech" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><strong>${tech.fullName}</strong></td>
                        <td>${tech.services}</td>
                        <td>${tech.completedJobs}</td>
                        <td>${tech.phone}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty topTechnicians}">
                    <tr><td colspan="5" style="text-align: center;">No data available</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <div class="footer-grid">
        <div class="footer-col">
            <h3><i class="fas fa-wrench"></i> HomeService</h3>
            <p>Your trusted platform for quality home services.</p>
        </div>
        <div class="footer-col">
            <h3>Quick Links</h3>
            <a href="#">Services</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </div>
        <div class="footer-col">
            <h3>Contact Info</h3>
            <p>Email: info@homeservice.com</p>
            <p>Phone: +977 9841234567</p>
            <p>Address: Kathmandu, Nepal</p>
        </div>
    </div>
    <div class="copyright">
        © 2026 HomeService. All rights reserved.
    </div>
</footer>

</body>
</html>