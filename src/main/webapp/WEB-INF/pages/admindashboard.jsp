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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>


<jsp:include page="/components/header.jsp" />


<main class="dashboard-main">
    <div class="dashboard-container">
        <div class="page-header">
            <h1>Admin Dashboard</h1>
            <p>Manage your home service platform</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <i class="fa-solid fa-wrench"></i>
                <h3>8</h3>
                <p>Total Services</p>
            </div>
            <div class="stat-card">
                <i class="fa-solid fa-user-gear"></i>
                <h3>4</h3>
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

       <!-- Quick Actions -->
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
       
              
</main>

<!-- YOUR EXISTING FOOTER - UNCHANGED -->
<jsp:include page="/components/footer.jsp" />

</body>
</html>