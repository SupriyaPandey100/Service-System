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



    <style>

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #F5F5F5; color: #1a1a1a; }



        /* Header */

        header { background-color: #5D5482; color: #FFFFFF; padding: 16px 0; position: sticky; top: 0; z-index: 1000; }

        header .container { display: flex; align-items: center; justify-content: space-between; width: 95%; max-width: 1600px; margin: 0 auto; padding: 0 20px; }

        .logo-group { display: flex; align-items: center; gap: 8px; text-decoration: none; }

        .logo-icon { color: #FFFFFF; font-size: 24px; }

        .brand-name { font-size: 20px; font-weight: 800; color: #FFFFFF; }

        .nav-links { display: flex; gap: 32px; list-style: none; }

        .nav-links a { font-size: 14px; font-weight: 600; color: #FFFFFF; text-decoration: none; }

        .nav-links a:hover, .nav-links a.active { color: #FFD700; }

        .header-tools { display: flex; align-items: center; gap: 20px; }



        /* Search Form */

        .search-container { position: relative; }

        .search-bar-small { position: relative; display: flex; width: 250px; }

        .search-bar-small input { width: 100%; padding: 10px 40px 10px 16px; border-radius: 12px; border: 1px solid #E6E8EC; background-color: #FFFFFF; font-size: 13px; outline: none; }

        .search-btn { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; }



        /* User Dropdown - CSS only hover */

        .user-dropdown { position: relative; display: inline-block; }

        .user-info { display: flex; align-items: center; gap: 8px; color: white; cursor: pointer; padding: 5px 10px; border-radius: 30px; }

        .dropdown-menu { position: absolute; top: 45px; right: 0; width: 180px; background: white; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); opacity: 0; visibility: hidden; transition: 0.3s; z-index: 100; }

        .user-dropdown:hover .dropdown-menu { opacity: 1; visibility: visible; }

        .dropdown-menu a { display: flex; align-items: center; gap: 10px; padding: 12px 16px; text-decoration: none; color: #333; font-size: 13px; }

        .dropdown-menu a:hover { background-color: #f5f5f5; }

        .text-danger { color: #EB5757 !important; }



        /* Main Container */

        .dashboard-container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; }

        .dashboard-main { min-height: calc(100vh - 200px); }

        

        .page-header { margin-bottom: 30px; }

        .page-header h1 { font-size: 28px; color: #1a1a1a; margin-bottom: 5px; }

        .page-header p { color: #666; }



        /* Stats Grid */

        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }

        .stat-card { background: white; padding: 25px; border-radius: 16px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }

        .stat-card i { font-size: 35px; color: #5D5482; margin-bottom: 15px; }

        .stat-card h3 { font-size: 28px; color: #333; margin-bottom: 5px; }

        .stat-card p { color: #666; font-size: 13px; }



        /* Quick Actions */

        .quick-actions { background: white; border-radius: 16px; padding: 25px; margin-top: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }

        .quick-actions h2 { font-size: 18px; margin-bottom: 20px; color: #333; }

        .action-buttons { display: flex; gap: 20px; flex-wrap: wrap; }

        .action-btn { display: flex; align-items: center; gap: 12px; padding: 15px 25px; background: #5D5482; color: white; text-decoration: none; border-radius: 12px; transition: transform 0.2s, box-shadow 0.2s; flex: 1; min-width: 180px; justify-content: center; }

        .action-btn:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(93,84,130,0.3); background: #4a4368; }

        .action-btn i { font-size: 20px; }

        .action-btn span { font-size: 14px; font-weight: 600; }



        /* Footer */

        footer { background: #5D5482; padding: 3rem 5% 2rem; margin-top: 40px; }

        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 3rem; max-width: 1200px; margin: 0 auto; padding-bottom: 2rem; border-bottom: 1px solid rgba(255,255,255,0.15); }

        .footer-col h3 { font-size: 16px; margin-bottom: 1rem; color: #FFFFFF; }

        .footer-col p, .footer-col a { color: rgba(255,255,255,0.75); font-size: 13px; margin-bottom: 8px; text-decoration: none; display: block; }

        .footer-col a:hover { color: #FFD700; }

        .copyright { text-align: center; color: rgba(255,255,255,0.6); font-size: 12px; margin-top: 2rem; }



        @media (max-width: 768px) {

            .action-buttons { flex-direction: column; }

            .nav-links { flex-direction: column; gap: 10px; }

            .footer-grid { grid-template-columns: 1fr; text-align: center; gap: 30px; }

        }

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

            <li><a href="${pageContext.request.contextPath}/admindashboard" class="active">Dashboard</a></li>

            <li><a href="${pageContext.request.contextPath}/manageuser">Users</a></li>

            <li><a href="${pageContext.request.contextPath}/managetechnician">Technicians</a></li>

            <li><a href="${pageContext.request.contextPath}/manageBooking">Bookings</a></li>

        </ul>

        <div class="header-tools">

            <div class="search-container">

                <form method="get" action="${pageContext.request.contextPath}/admindashboard">

                    <div class="search-bar-small">

                        <input type="text" name="query" placeholder="Search...">

                        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>

                    </div>

                </form>

            </div>

            <div class="user-dropdown">

                <div class="user-info">

                    <i class="fas fa-user-circle"></i>

                    <span>${sessionScope.userSession.fullName}</span>

                    <i class="fas fa-chevron-down"></i>

                </div>

                <div class="dropdown-menu">

                    <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> My Profile</a>

                    <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>

                </div>

            </div>

        </div>

    </div>

</header>



<main class="dashboard-main">

    <div class="dashboard-container">

        <div class="page-header">

            <h1>Admin Dashboard</h1>

            <p>Manage your home service platform</p>

        </div>



        <div class="stats-grid">

            <div class="stat-card">

                <i class="fa-solid fa-wrench"></i>

                <h3>${totalServices}</h3>

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

                <a href="${pageContext.request.contextPath}/managetechnician" class="action-btn">

                    <i class="fa-solid fa-user-gear"></i>

                    <span>Manage Technician</span>

                </a>

                <a href="${pageContext.request.contextPath}/manageBooking" class="action-btn">

    <i class="fa-solid fa-calendar"></i>

    <span>Manage Bookings</span>

</a>

                <a href="${pageContext.request.contextPath}/manageuser" class="action-btn">

                    <i class="fa-solid fa-users"></i>

                    <span>Manage Users</span>

                </a>

                <a href="${pageContext.request.contextPath}/reports" class="action-btn">

                    <i class="fa-solid fa-chart-line"></i>

                    <span>Generate Report</span>

                </a>

            </div>

        </div>

    </div>

</main>



<footer>

    <div class="footer-grid">

        <div class="footer-col">

            <h3><i class="fa-solid fa-wrench"></i> HomeService</h3>

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