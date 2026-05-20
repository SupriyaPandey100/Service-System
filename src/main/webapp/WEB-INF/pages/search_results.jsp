<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%-- 
  ==============================================================================
  System View Component: Global Search Results (search.jsp)
  
  System Description:
  This component processes and displays the output of the user's global search 
  queries. It acts as a dynamic dashboard capable of rendering heterogeneous 
  data types (Bookings and Notifications) returned by the SearchServlet.
  
  Architecture & Logic:
  - Strictly enforces the MVC design pattern by receiving pre-processed data arrays 
    (bookingResults, notificationResults) from the backend controller.
  - Utilizes Expression Language (EL) and JSTL (<c:choose>, <c:if>, <c:forEach>) 
    to conditionally render UI modules based on whether results exist.
  - Employs zero Java logic scriptlets, maintaining a pure View layer.
  - Dynamically injects modular header and footer components.
  ==============================================================================
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%-- 
      System Initialization & Asset Loading:
      Ensures standard UTF-8 encoding and injects responsive stylesheets using 
      EL for absolute pathing, preventing 404 errors regardless of URL structure.
    --%>
    <meta charset="UTF-8">
    <title>Search Results | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body>

    <%-- Modular UI Injection: Renders the unified smart header component --%>
    <jsp:include page="/components/header.jsp" />

    <main class="dashboard container" style="margin-top: 40px; min-height: 60vh;">
        
        <%-- Page Header: Displays the user's active search query dynamically --%>
        <div style="margin-bottom: 32px;">
            <h1 style="font-size: 28px; color: var(--text-main);">Search Results</h1>
            <p style="color: var(--text-sub);">Showing results for: <strong style="color: var(--primary-color);">"<c:out value="${searchQuery}"/>"</strong></p>
        </div>

        <%-- 
          Core Logic Routing: 
          Checks the boolean 'hasResults' flag set by the Servlet to determine 
          if it should render the data grid or the empty state fallback.
        --%>
        <c:choose>
            <c:when test="${hasResults}">
                <div class="dashboard-content" style="grid-template-columns: 1fr; gap: 32px;">
                    
                    <%-- Module 1: Bookings Results --%>
                    <c:if test="${not empty bookingResults}">
                        <section class="card">
                            <h2 class="section-title"><i class="fas fa-calendar-check" style="color: var(--primary-color);"></i> Bookings Found</h2>
                            
                            <div class="bookings-list">
                                <c:forEach var="booking" items="${bookingResults}">
                                    <div class="booking-item" style="display: flex; justify-content: space-between; align-items: center; padding: 16px; border-bottom: 1px solid var(--border-color);">
                                        <div>
                                            <h3 style="margin: 0 0 4px 0; font-size: 16px; color: var(--text-main);"><c:out value="${booking.serviceName}"/></h3>
                                            <p style="margin: 0; font-size: 13px; color: var(--text-sub);">
                                                <i class="far fa-calendar"></i> <c:out value="${booking.serviceDate}"/> at <c:out value="${booking.serviceTime}"/>
                                            </p>
                                        </div>
                                        <div style="text-align: right;">
                                            <span style="display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; background: var(--secondary-bg); color: var(--primary-color);">
                                                <c:out value="${booking.status}"/>
                                            </span>
                                            <p style="margin: 4px 0 0 0; font-weight: 700; font-size: 14px; color: var(--text-main);">NPR <c:out value="${booking.price}"/></p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </c:if>

                    <%-- Module 2: Notifications Results --%>
                    <c:if test="${not empty notificationResults}">
                        <section class="card">
                            <h2 class="section-title"><i class="fas fa-bell" style="color: var(--primary-color);"></i> Notifications Found</h2>
                            <div class="notifications-list">
                                <c:forEach var="notif" items="${notificationResults}">
                                    <div class="notification-item" style="display: flex; gap: 12px; padding: 16px; border-bottom: 1px solid var(--border-color);">
                                        <div class="notification-icon-small" style="width: 36px; height: 36px; border-radius: 8px; background-color: var(--secondary-bg); display: flex; align-items: center; justify-content: center; flex-shrink: 0; color: var(--primary-color);">
                                            <i class="fas fa-envelope-open-text"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p style="font-size: 14px; margin: 0; color: var(--text-main); font-weight: 500;"><c:out value="${notif.message}"/></p>
                                            <span class="time" style="font-size: 11px; color: var(--text-sub);"><c:out value="${notif.createdAt}"/></span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </c:if>

                </div>
            </c:when>
            
            <%-- Fallback Module: Displayed when no queries match database records --%>
            <c:otherwise>
                <div class="card" style="text-align: center; padding: 60px 20px;">
                    <i class="fas fa-search" style="font-size: 48px; color: var(--border-color); margin-bottom: 16px;"></i>
                    <h3 style="color: var(--text-main); margin-bottom: 8px;">No results found</h3>
                    <p style="color: var(--text-sub); margin-bottom: 24px;">We couldn't find anything matching "<c:out value="${searchQuery}"/>".</p>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Return to Dashboard</a>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <%-- Modular UI Injection: Renders the global footer component --%>
    <jsp:include page="/components/footer.jsp" />

</body>
</html>