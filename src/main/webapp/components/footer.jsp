<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- 
  ==============================================================================
  Component: Global Footer (footer.jsp)
  Purpose: Serves as the universal footer across the entire application.
  
  Architecture & Logic: 
  Unlike the header component, the footer content (About, Quick Links, and 
  Contact Info) is universally applicable to both authenticated users and 
  unauthenticated guests. Therefore, no conditional JSTL rendering is required. 
  This ensures a consistent layout and reduces unnecessary server processing.
  ==============================================================================
--%>

<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            
            <div class="footer-about">
                <h3><i class="fas fa-wrench" style="color: #FFFFFF;"></i> ServiceHub</h3>
                <p>Your trusted platform for quality home services. Book professional service providers with ease and track your appointments in real-time.</p>
            </div>
            
            <div class="footer-links">
                <h4>Quick Links</h4>
                <a href="${pageContext.request.contextPath}/services">Browse Services</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Support</a>
            </div>
            
            <div class="footer-contact">
                <h4>Contact Info</h4>
                <p><i class="fas fa-envelope"></i> info@servicehub.com</p>
                <p><i class="fas fa-phone"></i> +977 9841234567</p>
                <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
            </div>
            
        </div>
        
        <div class="footer-bottom">
            <p>&copy; 2026 ServiceHub. All rights reserved.</p>
        </div>
    </div>
</footer>