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
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background-color: #F5F5F5;
    color: #1a1a1a;
}

/* Header - Same as Manage User */
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
    border: 1px solid #E6E8EC;
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
    color: #808191;
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
    border: 1px solid #E6E8EC;
    z-index: 1001;
    overflow: hidden;
}

.dropdown-menu.show {
    display: block;
}

.dropdown-menu a {
    color: #11142D;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    font-size: 14px;
    font-weight: 500;
}

.dropdown-menu a i {
    margin-right: 8px;
    width: 16px;
    color: #5D5482;
}

.dropdown-menu a:hover {
    background-color: #F3F1FB;
}

.text-danger {
    color: #EB5757 !important;
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
    margin-bottom: 20px;
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

/* Add Button - Blue */
.add-btn-container {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
}

.btn-add {
    background: #0066FF;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: opacity 0.2s;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-add:hover {
    background: #0052CC;
}

/* Table */
.table-wrapper {
    background: white;
    border-radius: 16px;
    overflow-x: auto;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 800px;
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
    vertical-align: top;
}

tr:last-child td {
    border-bottom: none;
}

tr:hover {
    background: #F9F9F9;
}

/* Name column with completed jobs */
.tech-name {
    font-weight: 700;
    color: #1a1a1a;
}

.completed-jobs {
    font-size: 12px;
    color: #888;
    margin-top: 5px;
}

/* Contact column */
.contact-email {
    color: #1a1a1a;
    word-break: break-all;
}

.contact-phone {
    font-size: 12px;
    color: #888;
    margin-top: 5px;
}

/* Rating Stars */
.stars {
    color: #F2994A;
    font-size: 14px;
}

.rating-number {
    color: #1a1a1a;
    margin-left: 5px;
}

/* Status Badge */
.status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

.status-badge.active {
    background: #E8F5E9;
    color: #27AE60;
}

.status-badge.inactive {
    background: #FFEBEE;
    color: #EB5757;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
}

.btn-edit {
    background: #5D5482;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 12px;
    cursor: pointer;
}

.btn-delete {
    background: #EB5757;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 12px;
    cursor: pointer;
}

.btn-edit:hover, .btn-delete:hover {
    opacity: 0.8;
}

/* MODAL STYLES */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    z-index: 2000;
    justify-content: center;
    align-items: center;
}

.modal.show {
    display: flex;
}

.modal-content {
    background: white;
    border-radius: 16px;
    width: 90%;
    max-width: 500px;
    max-height: 90vh;
    overflow-y: auto;
    animation: modalFadeIn 0.3s ease;
}

@keyframes modalFadeIn {
    from {
        opacity: 0;
        transform: translateY(-30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.modal-header {
    padding: 20px 25px;
    border-bottom: 1px solid #EEE;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    font-size: 18px;
    color: #1a1a1a;
    display: flex;
    align-items: center;
    gap: 10px;
}

.modal-header h3 i {
    color: #5D5482;
}

.close-modal {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #999;
}

.close-modal:hover {
    color: #EB5757;
}

.modal-body {
    padding: 25px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 5px;
    color: #333;
}

.form-group label .required {
    color: #EB5757;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #E0E0E0;
    border-radius: 8px;
    font-size: 14px;
    font-family: inherit;
}

.form-group input:focus,
.form-group select:focus {
    outline: none;
    border-color: #5D5482;
}

.form-group small {
    font-size: 11px;
    color: #999;
}

.form-row {
    display: flex;
    gap: 15px;
    margin-bottom: 18px;
}

.form-row .form-group {
    flex: 1;
    margin-bottom: 0;
}

.modal-footer {
    padding: 20px 25px;
    border-top: 1px solid #EEE;
    display: flex;
    justify-content: flex-end;
    gap: 12px;
}

.btn-submit {
    background: #0066FF;
    color: white;
    border: none;
    padding: 10px 24px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-submit:hover {
    background: #0052CC;
}

.btn-cancel {
    background: #E0E0E0;
    color: #666;
    border: none;
    padding: 10px 24px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
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
    border-left: 4px solid #EB5757;
}

@keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
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

.empty-state {
    text-align: center;
    padding: 60px;
    color: #999;
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
            <span class="brand-name">HomeService</span>
        </a>
       
        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/manageuser">Users</a></li>
                <li><a href="${pageContext.request.contextPath}/managetechnician" class="active">Technicians</a></li>
                <li><a href="#">Bookings</a></li>
            </ul>
        </nav>
       
        <div class="header-tools">
            <div class="search-container">
                <form class="search-bar-small" onsubmit="return false;">
                    <input type="text" id="searchInput" placeholder="Search technicians..." autocomplete="off">
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
        <h1>Manage Technician</h1>
        <p>Add, edit, or remove service technician</p>
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

    <!-- Add Button -->
    <div class="add-btn-container">
        <button class="btn-add" id="openModalBtn">
            <i class="fas fa-plus-circle"></i> Add Technician
        </button>
    </div>

    <!-- Technicians Table -->
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Contact</th>
                    <th>Services</th>
                    <th>Rating</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${technicians}" var="tech">
                    <tr data-id="${tech.technicianId}" 
                        data-name="${tech.fullName}"
                        data-email="${tech.email}"
                        data-phone="${tech.phone}"
                        data-services="${tech.services}"
                        data-rating="${tech.rating}"
                        data-jobs="${tech.completedJobs}"
                        data-status="${tech.status}">
                        
                        <td>
                            <div class="tech-name">${tech.fullName}</div>
                            <div class="completed-jobs"><i class="fas fa-briefcase"></i> ${tech.completedJobs} completed jobs</div>
                        </td>
                        <td>
                            <div class="contact-email"><i class="fas fa-envelope"></i> ${tech.email}</div>
                            <div class="contact-phone"><i class="fas fa-phone"></i> ${tech.phone}</div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty tech.services}">${tech.services}</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="stars">
                                <c:choose>
                                    <c:when test="${tech.rating >= 4.5}">★★★★★</c:when>
                                    <c:when test="${tech.rating >= 3.5}">★★★★☆</c:when>
                                    <c:when test="${tech.rating >= 2.5}">★★★☆☆</c:when>
                                    <c:when test="${tech.rating >= 1.5}">★★☆☆☆</c:when>
                                    <c:otherwise>★☆☆☆☆</c:otherwise>
                                </c:choose>
                            </span>
                            <span class="rating-number">${tech.rating}</span>
                        </td>
                        <td>
                            <span class="status-badge ${tech.status}">
                                <c:choose>
                                    <c:when test="${tech.status == 'active'}">● active</c:when>
                                    <c:otherwise>○ inactive</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="action-buttons">
                            <!-- EDIT Button -->
                            <button type="button" class="btn-edit" onclick="openEditModal(${tech.technicianId})">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            
                            <!-- DELETE Button -->
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
                        <td colspan="6" style="text-align: center; padding: 50px;">
                            <i class="fas fa-users" style="font-size: 48px; color: #CCC; margin-bottom: 10px; display: block;"></i>
                            No technicians found
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL POPUP FOR ADD TECHNICIAN -->
<div id="addTechnicianModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-user-plus"></i> Add New Technician</h3>
            <button class="close-modal" id="closeModalBtn">&times;</button>
        </div>
        <form method="post" action="managetechnician">
            <input type="hidden" name="action" value="add">
            <div class="modal-body">
                <div class="form-group">
                    <label>Name <span class="required">*</span></label>
                    <input type="text" name="full_name" placeholder="Enter full name" required>
                </div>
                <div class="form-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" name="email" placeholder="Enter email address" required>
                </div>
                <div class="form-group">
                    <label>Phone <span class="required">*</span></label>
                    <input type="tel" name="phone" placeholder="Enter phone number" required>
                </div>
                <div class="form-group">
                    <label>Services (comma-separated) <span class="required">*</span></label>
                    <input type="text" name="services" placeholder="e.g., Plumbing, Electrical" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Rating</label>
                        <input type="number" name="rating" step="0.1" min="0" max="5" placeholder="0.0 - 5.0" value="0.0">
                    </div>
                    <div class="form-group">
                        <label>Completed Jobs</label>
                        <input type="number" name="completed_jobs" min="0" placeholder="Jobs completed" value="0">
                    </div>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" id="cancelModalBtn">Cancel</button>
                <button type="submit" class="btn-submit"><i class="fas fa-plus-circle"></i> Add Technician</button>
            </div>
        </form>
    </div>
</div>

<!-- MODAL POPUP FOR EDIT TECHNICIAN -->
<div id="editTechnicianModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-edit"></i> Edit Technician</h3>
            <button class="close-modal" id="closeEditModalBtn">&times;</button>
        </div>
        <form method="post" action="managetechnician" id="editForm">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="technician_id" id="edit_id">
            <div class="modal-body">
                <div class="form-group">
                    <label>Name <span class="required">*</span></label>
                    <input type="text" name="full_name" id="edit_name" placeholder="Enter full name" required>
                </div>
                <div class="form-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" name="email" id="edit_email" placeholder="Enter email address" required>
                </div>
                <div class="form-group">
                    <label>Phone <span class="required">*</span></label>
                    <input type="tel" name="phone" id="edit_phone" placeholder="Enter phone number" required>
                </div>
                <div class="form-group">
                    <label>Services (comma-separated) <span class="required">*</span></label>
                    <input type="text" name="services" id="edit_services" placeholder="e.g., Plumbing, Electrical" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Rating</label>
                        <input type="number" name="rating" id="edit_rating" step="0.1" min="0" max="5" placeholder="0.0 - 5.0">
                    </div>
                    <div class="form-group">
                        <label>Completed Jobs</label>
                        <input type="number" name="completed_jobs" id="edit_jobs" min="0" placeholder="Jobs completed">
                    </div>
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" id="edit_status">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" id="cancelEditModalBtn">Cancel</button>
                <button type="submit" class="btn-submit"> Update Technician</button>
            </div>
        </form>
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
        © 2026 HomeService. All rights reserved.
    </div>
</footer>

<script>
    // Toggle dropdown function
    function toggleDropdown(event) {
        event.stopPropagation();
        var dropdown = document.getElementById('profileDropdown');
        dropdown.classList.toggle('show');
    }
    
    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        var dropdown = document.getElementById('profileDropdown');
        var userDropdown = document.querySelector('.user-dropdown');
        
        if (dropdown && userDropdown) {
            if (!userDropdown.contains(event.target)) {
                dropdown.classList.remove('show');
            }
        }
    });
    
    // ADD MODAL functionality
    var addModal = document.getElementById('addTechnicianModal');
    var openAddBtn = document.getElementById('openModalBtn');
    var closeAddBtn = document.getElementById('closeModalBtn');
    var cancelAddBtn = document.getElementById('cancelModalBtn');
    
    function openAddModal() {
        addModal.classList.add('show');
    }
    
    function closeAddModal() {
        addModal.classList.remove('show');
    }
    
    if (openAddBtn) openAddBtn.addEventListener('click', openAddModal);
    if (closeAddBtn) closeAddBtn.addEventListener('click', closeAddModal);
    if (cancelAddBtn) cancelAddBtn.addEventListener('click', closeAddModal);
    
    // EDIT MODAL functionality
    var editModal = document.getElementById('editTechnicianModal');
    var closeEditBtn = document.getElementById('closeEditModalBtn');
    var cancelEditBtn = document.getElementById('cancelEditModalBtn');
    
    function closeEditModal() {
        editModal.classList.remove('show');
    }
    
    function openEditModal(id) {
        // Get the row data from data attributes
        var row = document.querySelector('tr[data-id="' + id + '"]');
        
        if (row) {
            document.getElementById('edit_id').value = id;
            document.getElementById('edit_name').value = row.getAttribute('data-name');
            document.getElementById('edit_email').value = row.getAttribute('data-email');
            document.getElementById('edit_phone').value = row.getAttribute('data-phone');
            document.getElementById('edit_services').value = row.getAttribute('data-services');
            document.getElementById('edit_rating').value = row.getAttribute('data-rating');
            document.getElementById('edit_jobs').value = row.getAttribute('data-jobs');
            document.getElementById('edit_status').value = row.getAttribute('data-status');
            
            editModal.classList.add('show');
        }
    }
    
    if (closeEditBtn) closeEditBtn.addEventListener('click', closeEditModal);
    if (cancelEditBtn) cancelEditBtn.addEventListener('click', closeEditModal);
    
    // Close modals when clicking outside
    window.addEventListener('click', function(event) {
        if (event.target === addModal) {
            closeAddModal();
        }
        if (event.target === editModal) {
            closeEditModal();
        }
    });
    
    // Search functionality
    var searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            var searchTerm = this.value.toLowerCase();
            var rows = document.querySelectorAll('tbody tr');
            
            rows.forEach(function(row) {
                var text = row.innerText.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    }
</script>

</body>
</html>