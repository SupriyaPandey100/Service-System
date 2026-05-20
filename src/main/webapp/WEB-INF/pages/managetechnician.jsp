<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Technicians | ServiceHub</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
{ margin: 0; padding: 0; box-sizing: border-box; }
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
.container { max-width: 1200px; margin: 0 auto; padding: 30px 20px; }
.page-title { margin-bottom: 20px; }
.page-title h1 { font-size: 24px; font-weight: 700; color: #1a1a1a; margin-bottom: 5px; }
.page-title p { color: #666; font-size: 14px; }

/* Add Button */
.add-btn-container { display: flex; justify-content: flex-end; margin-bottom: 20px; }
.btn-add { background: #0066FF; color: white; border: none; padding: 12px 24px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; }
.btn-add:hover { background: #0052CC; }

/* Table */
.table-wrapper { background: white; border-radius: 16px; overflow-x: auto; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
table { width: 100%; border-collapse: collapse; min-width: 800px; }
th { text-align: left; padding: 16px 20px; background: #FAFAFA; font-size: 13px; font-weight: 600; color: #666; border-bottom: 1px solid #EEE; }
td { padding: 16px 20px; font-size: 14px; border-bottom: 1px solid #EEE; vertical-align: top; }
tr:hover { background: #F9F9F9; }

.tech-name { font-weight: 700; color: #1a1a1a; }
.completed-jobs { font-size: 12px; color: #888; margin-top: 5px; }
.contact-email { color: #1a1a1a; }
.contact-phone { font-size: 12px; color: #888; margin-top: 5px; }

.status-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
.status-badge.active { background: #E8F5E9; color: #27AE60; }
.status-badge.inactive { background: #FFEBEE; color: #EB5757; }

.action-buttons { display: flex; gap: 8px; }
.btn-edit { background: #5D5482; color: white; border: none; padding: 6px 12px; border-radius: 6px; font-size: 12px; cursor: pointer; text-decoration: none; display: inline-block; }
.btn-delete { background: #EB5757; color: white; border: none; padding: 6px 12px; border-radius: 6px; font-size: 12px; cursor: pointer; }
.btn-edit:hover, .btn-delete:hover { opacity: 0.8; }

/* Message Toast */
.message-toast { position: fixed; top: 80px; right: 20px; padding: 12px 20px; border-radius: 8px; background: white; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 1000; animation: slideIn 0.3s ease; }
.message-toast.success { border-left: 4px solid #27AE60; }
.message-toast.error { border-left: 4px solid #EB5757; }
@keyframes slideIn { from { transform: translateX(100%); opacity: 0; } to { transform: translateX(0); opacity: 1; } }

/* Footer */
footer { background: #5D5482; padding: 3rem 5% 2rem; margin-top: 40px; }
.footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 3rem; max-width: 1200px; margin: 0 auto; padding-bottom: 2rem; border-bottom: 1px solid rgba(255,255,255,0.15); }
.footer-col h3 { font-size: 16px; margin-bottom: 1rem; color: #FFFFFF; }
.footer-col p, .footer-col a { color: rgba(255,255,255,0.75); font-size: 13px; margin-bottom: 8px; text-decoration: none; display: block; }
.footer-col a:hover { color: #FFD700; }
.copyright { text-align: center; color: rgba(255,255,255,0.6); font-size: 12px; margin-top: 2rem; }
.empty-state { text-align: center; padding: 60px; color: #999; }
.empty-state i { font-size: 48px; margin-bottom: 15px; opacity: 0.5; }
</style>
</head>
<body>

<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin" class="logo-group">
            <i class="fas fa-wrench logo-icon"></i>
            <span class="brand-name">HomeService</span>
        </a>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/admindashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/manageuser">Users</a></li>
            <li><a href="${pageContext.request.contextPath}/managetechnician" class="active">Technicians</a></li>
            <li><a href="${pageContext.request.contextPath}/manageBooking">Bookings</a></li>
        </ul>
        <div class="header-tools">
            <div class="search-container">
                <form method="get" action="${pageContext.request.contextPath}/managetechnician">
                    <div class="search-bar-small">
                        <input type="text" name="search" placeholder="Search technicians..." value="${param.search}">
                        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                    </div>
                </form>
            </div>
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
        <h1>Manage Technician</h1>
        <p>Add, edit, or remove service technician</p>
    </div>

    <c:if test="${not empty message}">
        <div class="message-toast ${messageType}">
            <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            ${message}
        </div>
    </c:if>

    <div class="add-btn-container">
        <a href="${pageContext.request.contextPath}/addtechnician" class="btn-add">
            <i class="fa-solid fa-circle-plus"></i> Add Technician
        </a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Services</th>
                    <th>Completed Jobs</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${technicians}" var="tech">
                    <tr data-id="${tech.technicianId}">
                        <td>
                            <div class="tech-name">${tech.fullName}</div>
                        </td>
                        <td>
                            <div class="contact-email"><i class="fa-solid fa-envelope"></i> ${tech.email}</div>
                            <div class="contact-phone"><i class="fa-solid fa-phone"></i> ${tech.phone}</div>
                        </td>
                        <td>${tech.services}</td>
                        <td>
                            <div class="completed-jobs"><i class="fa-solid fa-briefcase"></i> ${tech.completedJobs} completed jobs</div>
                        </td>
                        <td>
                            <span class="status-badge ${tech.status}">
                                ${tech.status == 'active' ? '● active' : '○ inactive'}
                            </span>
                        </td>
                        <td class="action-buttons">
                            <a href="${pageContext.request.contextPath}/edittechnician?id=${tech.technicianId}" class="btn-edit">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </a>
                            <form method="post" action="managetechnician" style="display: inline;" onsubmit="return confirm('Delete ${tech.fullName}?')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${tech.technicianId}">
                                <button type="submit" class="btn-delete"><i class="fas fa-trash"></i> Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty technicians}">
                    <tr>
                        <td colspan="6" class="empty-state">
                            <i class="fa-solid fa-users"></i>
                            No technicians found
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

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