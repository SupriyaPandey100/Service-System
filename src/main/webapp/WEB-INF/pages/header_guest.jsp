<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
            </ul>
        </nav>
        
        <div class="header-tools">
            <a href="${pageContext.request.contextPath}/login" style="color: white; font-weight: 600; text-decoration: none; margin-right: 20px; font-size: 14px;">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn" style="background: rgba(255,255,255,0.2); color: white; padding: 8px 20px;">Register</a>
        </div>
    </div>
</header>