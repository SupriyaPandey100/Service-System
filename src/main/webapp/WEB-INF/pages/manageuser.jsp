<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users | ServiceHub</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
    --border-color: #E6E8EC;
    --text-sub: #808191;
    --danger: #EB5757;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: #F5F5F5;
}

/* Header */
header {
    background-color: #5D5482;
    color: #FFFFFF;
    border-bottom: none;
    padding: 16px 0;
    position: sticky;
    top: 0;
    z-index: 1000;
}

header .container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 95%;
    max-width: 1600px;
    margin: 0 auto;
    padding: 0 20px;
}

.logo-group {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
}

.logo-icon {
    color: #FFFFFF;
    font-size: 24px;
}

.brand-name {
    font-size: 20px;
    font-weight: 800;
    color: #FFFFFF;
}

.nav-links {
    display: flex;
    gap: 32px;
    list-style: none;
    margin: 0;
    padding: 0;
}

.nav-links a {
    font-size: 14px;
    font-weight: 600;
    color: #FFFFFF;
    text-decoration: none;
    transition: color 0.3s;
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

/* Search Bar */
.search-container {
    position: relative;
}

.search-bar-small {
    position: relative;
    display: flex;
    width: 250px;
    margin: 0;
}

.search-bar-small input {
    width: 100%;
    padding: 10px 40px 10px 16px;
    border-radius: 12px;
    border: 1px solid var(--border-color);
    background-color: #FFFFFF;
    font-family: inherit;
    font-size: 13px;
    outline: none;
}

.search-btn {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: var(--text-sub);
    cursor: pointer;
}

/* User Dropdown */
.user-dropdown {
    display: flex;
    align-items: center;
    gap: 12px;
    cursor: pointer;
    position: relative;
}

.user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: rgba(255,255,255,0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #FFFFFF;
}

.user-name {
    font-size: 14px;
    font-weight: 600;
    color: #FFFFFF;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 120%;
    right: 0;
    background-color: white;
    min-width: 180px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.1);
    border-radius: 8px;
    border: 1px solid var(--border-color);
    z-index: 1001;
    overflow: hidden;
}

.dropdown-menu.show {
    display: block;
    animation: fadeIn 0.2s ease-out;
}

.dropdown-menu a {
    color: #11142D;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.2s;
}

.dropdown-menu a i {
    margin-right: 8px;
    width: 16px;
    color: #5D5482;
}

.dropdown-menu a:hover {
    background-color: #F3F1FB;
    color: #5D5482;
}

.text-danger {
    color: var(--danger) !important;
}

.text-danger i {
    color: var(--danger) !important;
}

/* Notification Bell */
.notification-wrapper {
    position: relative;
}

.notification-bell {
    position: relative;
    font-size: 20px;
    color: #FFFFFF;
    cursor: pointer;
}

/* Main Container */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 30px 20px;
}

/* Page Title */
.page-title {
    margin-bottom: 30px;
}

.page-title h1 {
    font-size: 24px;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 5px;
}

.page-title p {
    color: #666;
    font-size: 14px;
}

/* Stats Cards - Now using <a> tags for backend filtering */
.stats-cards {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    border-radius: 12px;
    padding: 20px 30px;
    flex: 1;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    border: 2px solid transparent;
    text-decoration: none;
    display: block;
}

.stat-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.stat-card.active {
    border-color: #5D5482;
    background: #F8F7FB;
}

.stat-number {
    font-size: 28px;
    font-weight: 800;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 13px;
    color: #666;
}

.stat-card.all .stat-number { color: #5D5482; }
.stat-card.pending .stat-number { color: #F2994A; }
.stat-card.approved .stat-number { color: #27AE60; }
.stat-card.rejected .stat-number { color: var(--danger); }

/* Filter Tabs */
.filter-tabs {
    display: flex;
    gap: 8px;
    margin-bottom: 25px;
    border-bottom: 1px solid #E0E0E0;
    padding-bottom: 12px;
}

.filter-btn {
    background: none;
    border: none;
    padding: 8px 20px;
    font-size: 14px;
    font-weight: 600;
    color: #888;
    cursor: pointer;
    border-radius: 20px;
    transition: all 0.2s;
    text-decoration: none;
    display: inline-block;
}

.filter-btn:hover {
    color: #5D5482;
}

.filter-btn.active {
    background: #5D5482;
    color: white;
}

/* Table */
.table-wrapper {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    text-align: left;
    padding: 16px 20px;
    background: #FAFAFA;
    font-size: 13px;
    font-weight: 600;
    color: #666;
    border-bottom: 1px solid #EEE;
}

td {
    padding: 16px 20px;
    font-size: 14px;
    border-bottom: 1px solid #EEE;
}

tr:last-child td {
    border-bottom: none;
}

tr:hover {
    background: #F9F9F9;
}

/* Status Badge */
.status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

.status-badge.pending {
    background: #FFF3E0;
    color: #F2994A;
}

.status-badge.approved {
    background: #E8F5E9;
    color: #27AE60;
}

.status-badge.rejected {
    background: #FFEBEE;
    color: var(--danger);
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
}

.btn-approve {
    background: #27AE60;
    color: white;
    border: none;
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 500;
    cursor: pointer;
}

.btn-reject {
    background: var(--danger);
    color: white;
    border: none;
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 500;
    cursor: pointer;
}

.btn-approve:hover, .btn-reject:hover {
    opacity: 0.8;
}

.btn-disabled {
    background: #E0E0E0;
    color: #999;
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 12px;
}

/* Pending Message */
.pending-message {
    margin-top: 20px;
    padding: 12px 16px;
    background: #FFF8E1;
    border-radius: 8px;
    font-size: 13px;
    color: #F2994A;
    border-left: 3px solid #F2994A;
}

.pending-message i {
    margin-right: 8px;
}

/* Message Toast */
.message-toast {
    position: fixed;
    top: 80px;
    right: 20px;
    padding: 12px 20px;
    border-radius: 8px;
    background: white;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    z-index: 1000;
    animation: slideIn 0.3s ease;
}

.message-toast.success {
    border-left: 4px solid #27AE60;
}

.message-toast.error {
    border-left: 4px solid var(--danger);
}

@keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Footer - Purple */
footer {
    background: #5D5482;
    padding: 3rem 5% 2rem;
    margin-top: 40px;
}

.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 3rem;
    max-width: 1200px;
    margin: 0 auto;
    padding-bottom: 2rem;
    border-bottom: 1px solid rgba(255,255,255,0.15);
}

.footer-col h3 {
    font-size: 16px;
    margin-bottom: 1rem;
    color: #FFFFFF;
}

.footer-col p,
.footer-col a {
    color: rgba(255,255,255,0.75);
    font-size: 13px;
    margin-bottom: 8px;
    text-decoration: none;
    display: block;
}

.footer-col a:hover {
    color: #FFD700;
}

.copyright {
    text-align: center;
    color: rgba(255,255,255,0.6);
    font-size: 12px;
    margin-top: 2rem;
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 60px;
    color: var(--text-sub);
}

.empty-state i {
    font-size: 48px;
    margin-bottom: 15px;
    opacity: 0.5;
}
</style>
</head>
<body>

<!-- Header -->
<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin" class="logo-group">
            <i class="fas fa-wrench logo-icon"></i>
            <span class="brand-name">ServiceHub</span>
        </a>
       
        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/manageuser" class="active">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/managetechnician">Technicians</a></li>
                <li><a href="#">Bookings</a></li>
            </ul>
        </nav>
       
        <div class="header-tools">
            <div class="search-container">
                <form class="search-bar-small" onsubmit="return false;">
                    <input type="text" id="searchInput" placeholder="Search users..." autocomplete="off">
                    <button type="button" class="search-btn"><i class="fas fa-search"></i></button>
                </form>
            </div>
           
            <div class="notification-wrapper">
                <div class="notification-bell">
                    <i class="fas fa-bell"></i>
                </div>
            </div>
           
            <div class="user-dropdown" onclick="toggleDropdown(event)">
                <div class="user-avatar"><i class="fas fa-user"></i></div>
                <span class="user-name">Admin <i class="fas fa-chevron-down" style="font-size: 10px;"></i></span>
               
                <div class="dropdown-menu" id="profileDropdown">
                    <a href="#"><i class="fas fa-user-cog"></i> My Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Main Container -->
<div class="container">
    <div class="page-title">
        <h1>Manage Users</h1>
        <p>Approve, reject, or remove user accounts</p>
    </div>

    <!-- Success/Error Message -->
    <c:if test="${not empty message}">
        <div class="message-toast ${messageType}">
            <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
            ${message}
        </div>
        <script>
            setTimeout(function() {
                document.querySelector('.message-toast')?.remove();
            }, 3000);
        </script>
    </c:if>

    <!-- Stats Cards - BACKEND FILTERING  -->
    <div class="stats-cards">
        <a href="manageuser?status=all" class="stat-card all ${currentFilter == 'all' ? 'active' : ''}">
            <div class="stat-number">${totalUsers}</div>
            <div class="stat-label">All</div>
        </a>
        <a href="manageuser?status=pending" class="stat-card pending ${currentFilter == 'pending' ? 'active' : ''}">
            <div class="stat-number">${pendingCount}</div>
            <div class="stat-label">Pending</div>
        </a>
        <a href="manageuser?status=approved" class="stat-card approved ${currentFilter == 'approved' ? 'active' : ''}">
            <div class="stat-number">${approvedCount}</div>
            <div class="stat-label">Approved</div>
        </a>
        <a href="manageuser?status=rejected" class="stat-card rejected ${currentFilter == 'rejected' ? 'active' : ''}">
            <div class="stat-number">${rejectedCount}</div>
            <div class="stat-label">Rejected</div>
        </a>
    </div>

    <!-- Filter Tabs - BACKEND FILTERING with <a> tags -->
    <div class="filter-tabs">
        <a href="manageuser?status=all" class="filter-btn ${currentFilter == 'all' ? 'active' : ''}">All (${totalUsers})</a>
        <a href="manageuser?status=pending" class="filter-btn ${currentFilter == 'pending' ? 'active' : ''}">Pending (${pendingCount})</a>
        <a href="manageuser?status=approved" class="filter-btn ${currentFilter == 'approved' ? 'active' : ''}">Approved (${approvedCount})</a>
        <a href="manageuser?status=rejected" class="filter-btn ${currentFilter == 'rejected' ? 'active' : ''}">Rejected (${rejectedCount})</a>
    </div>

    <!-- Users Table -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td><strong>${user.fullName}</strong></td>
                        <td>${user.email}</td>
                        <td>${user.number}</td>
                        <td>
                            <span class="status-badge ${user.status}">
                                <c:choose>
                                    <c:when test="${user.status == 'pending'}">pending</c:when>
                                    <c:when test="${user.status == 'approved'}">approved</c:when>
                                    <c:when test="${user.status == 'rejected'}">rejected</c:when>
                                </c:choose>
                            </span>
                        </td>
                        <td class="action-buttons">
                            <c:if test="${user.status == 'pending'}">
                                <form method="post" action="manageuser" style="display: inline;">
                                    <input type="hidden" name="id" value="${user.userId}">
                                    <input type="hidden" name="action" value="approve">
                                    <input type="hidden" name="currentFilter" value="${currentFilter}">
                                    <button type="submit" class="btn-approve">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                </form>
                                <form method="post" action="manageuser" style="display: inline;">
                                    <input type="hidden" name="id" value="${user.userId}">
                                    <input type="hidden" name="action" value="reject">
                                    <input type="hidden" name="currentFilter" value="${currentFilter}">
                                    <button type="submit" class="btn-reject" onclick="return confirm('Reject ${user.fullName}?')">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${user.status != 'pending'}">
                                <span class="btn-disabled">
                                    <i class="fas fa-lock"></i> No Action
                                </span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 50px;">
                            <i class="fas fa-users" style="font-size: 48px; color: #CCC; margin-bottom: 10px; display: block;"></i>
                            No users found
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Pending Message -->
    <div class="pending-message">
        <i class="fas fa-clock"></i> ${pendingCount} user registration(s) pending approval
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="footer-grid">
        <div class="footer-col">
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services. Book professional service providers with ease.</p>
        </div>
        <div class="footer-col">
            <h3>Quick Links</h3>
            <a href="#">Services</a>
            <a href="#">About Us</a>
            <a href="#">Contact</a>
        </div>
        <div class="footer-col">
            <h3>Contact Info</h3>
            <p>Email: info@servicehub.com</p>
            <p>Phone: +977 9841234567</p>
            <p>Address: Kathmandu, Nepal</p>
        </div>
    </div>
    <div class="copyright">
        © 2026 ServiceHub. All rights reserved.
    </div>
</footer>

<script>
    /** Toggle dropdown function **/
    function toggleDropdown(event) {
        event.stopPropagation();
        var dropdown = document.getElementById('profileDropdown');
        dropdown.classList.toggle('show');
    }
    
    /** Close dropdown when clicking outside **/
    document.addEventListener('click', function(event) {
        var dropdown = document.getElementById('profileDropdown');
        var userDropdown = document.querySelector('.user-dropdown');
        
        if (dropdown && userDropdown) {
            if (!userDropdown.contains(event.target)) {
                dropdown.classList.remove('show');
            }
        }
    });
    
    /** Prevent dropdown from closing when clicking inside it **/
    var profileDropdown = document.getElementById('profileDropdown');
    if (profileDropdown) {
        profileDropdown.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    }
    
    /** Search functionality (only for UI - does NOT affect backend filtering)**/
    var searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            var searchTerm = this.value.toLowerCase();
            var rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(function(row) {
                var name = row.querySelector('td:first-child')?.innerText.toLowerCase() || '';
                var email = row.querySelector('td:nth-child(2)')?.innerText.toLowerCase() || '';
                var phone = row.querySelector('td:nth-child(3)')?.innerText.toLowerCase() || '';
                
                if (name.includes(searchTerm) || email.includes(searchTerm) || phone.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }
</script>

</body>
</html>