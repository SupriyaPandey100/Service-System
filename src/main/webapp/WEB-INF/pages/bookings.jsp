<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | ServiceHub</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    
    <style>
        .tab-btn.active { background: #5D558A !important; color: #FFFFFF !important; border-color: #5D558A !important; }
        .booking-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body style="background-color: #f9fafb;">

    <%@ include file="header.jsp" %>

    <main class="container" style="min-height: 70vh; max-width: 1000px; margin: 0 auto; padding: 20px inherit;">
        
        <c:if test="${not empty successMessage}">
            <div style="background-color: #D1E7DD; color: #0F5132; padding: 16px; border-radius: 8px; margin-top: 20px; margin-bottom: 10px; border: 1px solid #BADBCC; font-weight: 600;">
                <i class="fas fa-check-circle" style="margin-right: 8px;"></i> <c:out value="${successMessage}"/>
            </div>
        </c:if>
        
        <div class="page-header" style="margin: 40px 0 20px; text-align: left;">
            <h1 style="font-size: 28px; color: var(--text-main); font-weight: 800; margin-bottom: 8px;">My Bookings</h1>
            <p style="color: var(--text-sub); font-size: 15px;">Track and manage your scheduled home service appointments</p>
        </div>

        <div class="booking-tabs" style="display: flex; gap: 12px; margin-bottom: 24px; flex-wrap: wrap;">
            <a href="?status=All" class="btn btn-outline tab-btn ${currentStatus == 'All' or empty currentStatus ? 'active' : ''}">All</a>
            <a href="?status=Pending" class="btn btn-outline tab-btn ${currentStatus == 'Pending' ? 'active' : ''}">Pending</a>
            <a href="?status=Confirmed" class="btn btn-outline tab-btn ${currentStatus == 'Confirmed' ? 'active' : ''}">Confirmed</a>
            <a href="?status=Completed" class="btn btn-outline tab-btn ${currentStatus == 'Completed' ? 'active' : ''}">Completed</a>
            <a href="?status=Cancelled" class="btn btn-outline tab-btn ${currentStatus == 'Cancelled' ? 'active' : ''}">Cancelled</a>
        </div>

        <c:choose>
            <c:when test="${empty userBookings}">
                <div class="card help-card" style="margin: 40px 0; background-color: #FFFFFF; border: 1px solid var(--border-color); color: var(--text-main); border-radius: 12px; padding: 80px 20px; text-align: center; display: flex; flex-direction: column; align-items: center; box-sizing: border-box;">
                    <div class="help-icon-large" style="margin-bottom: 16px;">
                        <i class="far fa-calendar-times" style="color: #9ca3af; font-size: 48px;"></i>
                    </div>
                    <h3 style="font-size: 18px; color: var(--text-main); font-weight: 700; margin-bottom: 12px; margin-top: 0;">No appointments found</h3>
                    <p style="color: var(--text-sub); margin: 0 0 24px 0; font-size: 14px;">There are no logs found matching this status configuration context.</p>
                    <a href="${pageContext.request.contextPath}/services" class="btn btn-primary" style="background-color: #155DFC; color: white; padding: 12px 24px; border-radius: 8px; font-weight: 700; text-decoration: none; display: inline-block;">Browse Marketplace</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="bookings-container" style="display: flex; flex-direction: column; gap: 16px; padding-bottom: 60px;">
                    <c:forEach var="booking" items="${userBookings}">
                        <div class="card booking-card" style="display: flex; justify-content: space-between; align-items: center; padding: 24px; box-sizing: border-box;">
                            <div>
                                <span style="background: #f3f4f6; color: #4b5563; padding: 4px 10px; border-radius: 50px; font-size: 11px; font-weight: 700; text-transform: uppercase; display: inline-block; margin-bottom: 8px;">Order #${booking.id}</span>
                                <h3 style="margin: 0 0 8px 0; font-size: 18px; font-weight: 800; color: var(--text-main);"><c:out value="${booking.serviceName}"/></h3>
                                <p style="color: var(--text-sub); font-size: 14px; margin: 0 0 6px 0;">
                                    <i class="far fa-calendar-alt" style="margin-right: 6px;"></i> <c:out value="${booking.bookingDate}"/> at <c:out value="${booking.bookingTime}"/>
                                </p>
                                <p style="color: #9ca3af; font-size: 13px; margin: 0;"><i class="fas fa-map-marker-alt" style="margin-right: 4px;"></i> <c:out value="${booking.address}" default="Address unassigned"/></p>
                            </div>
                            <div style="text-align: right; display: flex; flex-direction: column; align-items: flex-end; gap: 10px;">
                                <span style="display: inline-block; padding: 6px 14px; border-radius: 6px; font-size: 12px; font-weight: 700; text-transform: capitalize;
                                    <c:choose>
                                        <c:when test="${booking.status == 'Pending' or booking.status == 'PENDING'}">background: #FFF3CD; color: #856404;</c:when>
                                        <c:when test="${booking.status == 'Confirmed' or booking.status == 'CONFIRMED'}">background: #D1ECF1; color: #0C5460;</c:when>
                                        <c:when test="${booking.status == 'Completed' or booking.status == 'COMPLETED'}">background: #D4EDDA; color: #155724;</c:when>
                                        <c:when test="${booking.status == 'Cancelled' or booking.status == 'CANCELLED'}">background: #F8D7DA; color: #721C24;</c:when>
                                        <c:otherwise>background: var(--secondary-bg); color: var(--text-main);</c:otherwise>
                                    </c:choose>
                                "><c:out value="${booking.status}"/></span>
                                
                                <p style="margin: 0; font-weight: 800; font-size: 18px; color: var(--primary-color);">NPR <c:out value="${booking.price}"/></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <%@ include file="footer.jsp" %>
    
</body>
</html>