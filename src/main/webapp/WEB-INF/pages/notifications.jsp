<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  System View Component: Dedicated Notification Hub (notifications.jsp)
  
  System Description:
  Renders an exhaustive operational ledger of user-specific system alerts, service 
  confirmations, and warning messages passed dynamically from the NotificationDAO.
  ==============================================================================
*/ %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Notifications | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    
    
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <jsp:include page="/components/header.jsp" />

    <main class="dashboard container" style="flex: 1; padding: 40px; max-width: 800px; margin: 0 auto; width: 100%; box-sizing: border-box;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <div>
                <h1 style="font-size: 28px; color: var(--text-main); font-weight: 800; margin: 0 0 6px 0;">Notification Center</h1>
                <p style="color: var(--text-sub); margin: 0; font-size: 14px;">Review system logs and updates regarding your home bookings.</p>
            </div>
            <c:if test="${not empty notificationsList}">
                <a href="${pageContext.request.contextPath}/mark-notifications-read" style="color: #5D558A; font-weight: 700; text-decoration: none; font-size: 14px;">Mark all as read</a>
            </c:if>
        </div>

        <div class="card" style="background: white; border-radius: 12px; border: 1px solid #e5e7eb; padding: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.02);">
            <c:choose>
                <c:when test="${empty notificationsList}">
                    <div style="text-align: center; padding: 80px 20px; color: #9CA3AF;">
                        <i class="fas fa-bell-slash" style="font-size: 48px; margin-bottom: 20px; opacity: 0.4; color: #5D558A;"></i>
                        <h3 style="color: #111827; font-size: 18px; margin-bottom: 6px;">All caught up!</h3>
                        <p style="margin: 0; font-size: 14px;">You have no active system notifications at this time.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="notif" items="${notificationsList}">
                        <div class="notification-item" style="display: flex; gap: 16px; padding: 20px; border-bottom: 1px solid #f3f4f6; align-items: center;">
                            <div class="notification-icon-small" style="width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; background: #f3f4f6;">
                                <c:choose>
                                    <c:when test="${notif.type == 'SUCCESS'}"><i class="fas fa-check-circle" style="color: #27AE60; font-size: 18px;"></i></c:when>
                                    <c:when test="${notif.type == 'WARNING'}"><i class="fas fa-exclamation-triangle" style="color: #F2994A; font-size: 18px;"></i></c:when>
                                    <c:otherwise><i class="fas fa-info-circle" style="color: #155DFC; font-size: 18px;"></i></c:otherwise>
                                </c:choose>
                            </div>
                            <div style="flex: 1;">
                                <p style="margin: 0 0 4px 0; font-size: 15px; color: #111827; font-weight: 500;"><c:out value="${notif.message}"/></p>
                                <span style="font-size: 12px; color: #9CA3AF;"><i class="far fa-clock"></i> <c:out value="${notif.createdAt}"/></span>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <jsp:include page="/components/footer.jsp" />
    
</body>
</html>