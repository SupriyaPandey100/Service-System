<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- 
  ==============================================================================
  header of all pages are here (header.jsp)
  Purpose: Role-aware navigation bar using JSTL session scope attributes.
  ==============================================================================
--%>

<header>
    <div class="container">
        
        <%-- Logo: Links to Dashboard if logged in, otherwise Index --%>
        <a href="${pageContext.request.contextPath}/${sessionScope.userRole == 'ADMIN' ? 'admindashboard' : (not empty sessionScope.loggedUser ? 'dashboard' : 'index')}" class="logo-group">
            <i class="fas fa-wrench logo-icon"></i>
            <span class="brand-name">ServiceHub</span>
        </a>
        
        <nav>
            <ul class="nav-links">
                <c:choose>
                    <%-- 1. Admin Navigation --%>
                    <c:when test="${not empty sessionScope.loggedUser and sessionScope.userRole == 'ADMIN'}">
                        <li><a href="${pageContext.request.contextPath}/admindashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/manageuser">Manage Users</a></li>
                        <li><a href="${pageContext.request.contextPath}/manageBooking">Manage Bookings</a></li>
                        <li><a href="${pageContext.request.contextPath}/reports">Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/managetechnician">Technicians</a></li>
                    </c:when>
                    
                    <%-- 2. User/Customer Navigation --%>
                    <c:when test="${not empty sessionScope.loggedUser}">
                        <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/bookings">My Bookings</a></li>
                        <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                    </c:when>
                    
                    <%-- 3. Guest/Public Navigation --%>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
        
        <div class="header-tools">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                    
                    <%-- A. Search --%>
                    <form action="${pageContext.request.contextPath}/search" method="GET" class="search-bar-small">
                        <input type="text" name="query" placeholder="Search..." required>
                        <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                    </form>
                    
                    <%-- B. Notification System --%>
                    <div class="notification-wrapper">
                        <a href="${pageContext.request.contextPath}/notifications" class="notification-bell" style="text-decoration: none; color: inherit;">
                            <i class="fas fa-bell"></i>
                            <c:if test="${not empty sessionScope.notificationCount and sessionScope.notificationCount > 0}">
                                <span class="notification-count"><c:out value="${sessionScope.notificationCount}"/></span>
                            </c:if>
                        </a>
                    </div>
                    
                    <%-- C. User Profile Dropdown --%>
                    <div class="user-dropdown">
                        <div class="user-avatar"><i class="fas fa-user"></i></div>
                        <span class="user-name">
                            <c:out value="${sessionScope.loggedUser.fullName}"/>
                            <i class="fas fa-chevron-down" style="font-size: 10px; margin-left: 5px;"></i>
                        </span>
                        
                        <div class="dropdown-menu">
                        
                            <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> My Profile</a>
                            <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        
                        </div>
                        
                        
                    </div>
                </c:when>
                
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" style="color: white; font-weight: 600; text-decoration: none; margin-right: 20px; font-size: 14px;">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn" style="background: rgba(255,255,255,0.2); color: white; padding: 8px 20px; border-radius: 4px; text-decoration: none; font-size: 14px; font-weight: 600;">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>