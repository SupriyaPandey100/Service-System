<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  View Component: User Dashboard - My Bookings (bookings.jsp)
  Purpose: Displays a categorized list of the logged-in user's service requests.
           Allows users to view statuses and edit/cancel pending requests.
           
  Architecture & Logic:
  - Adheres strictly to the MVC design pattern using JSTL (<c:forEach>, <c:choose>).
  - Implements dynamic tab filtering based on the 'currentStatus' session/request attribute.
  - Implements View-Level Security: Edit/Cancel actions are strictly conditionally 
    rendered using <c:if> only when the booking status is 'Pending'.
  ==============================================================================
*/ %>

<!DOCTYPE html>
<html lang="en">
<head>
    <% /* =========================================
      HEAD SECTION: External Assets and Scoped Styling
      =========================================
    */ %>
    <meta charset="UTF-8">
    <title>My Bookings | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css">
    
    <style>
        .page-header { margin: 40px 0 20px; }
        .page-header h1 { font-size: 28px; color: #111827; font-weight: 800; margin-bottom: 8px;}
        .page-header p { color: #4B5563; font-size: 15px;}
        
        .booking-tabs { display: flex; gap: 12px; margin-bottom: 24px; flex-wrap: wrap; }
        .tab-btn { 
            padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600; 
            color: #4B5563; border: 1px solid #E5E7EB; background: #FFFFFF;
            text-decoration: none; transition: all 0.2s;
        }
        .tab-btn:hover { background: #F9FAFB; }
        .tab-btn.active { background: #9E8FE6; color: #FFFFFF; border-color: #9E8FE6; } 
        
        .empty-state-card {
            background: #FFFFFF; border: 1px solid #E5E7EB; border-radius: 12px;
            padding: 80px 20px; text-align: center; display: flex; flex-direction: column; align-items: center;
        }
        .empty-state-card i { font-size: 48px; color: #9CA3AF; margin-bottom: 16px; }
        .empty-state-card h3 { font-size: 18px; color: #111827; font-weight: 600; margin-bottom: 24px; }
        .btn-blue { background: #155DFC; color: white; padding: 12px 24px; border-radius: 8px; font-weight: 600; border: none; cursor: pointer; text-decoration: none;}
        .btn-blue:hover { background: #0D4BC7; }

        .bookings-container { display: flex; flex-direction: column; gap: 16px; }
        .booking-card { background: #FFF; border: 1px solid #E5E7EB; border-radius: 12px; padding: 20px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 4px rgba(0,0,0,0.02);}
        
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; }
        .status-Pending { background: #FFF3CD; color: #856404; }
        .status-Confirmed { background: #D1ECF1; color: #0C5460; }
        .status-Completed { background: #D4EDDA; color: #155724; }
        .status-Cancelled { background: #F8D7DA; color: #721C24; }
    </style>
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <% /* Render unified global header */ %>
    <jsp:include page="/components/header.jsp" />

    <main class="container" style="flex: 1; padding: 20px 40px; max-width: 1200px; margin: 0 auto; width: 100%; box-sizing: border-box;">
        
        <div class="page-header">
            <h1>My Bookings</h1>
            <p>Track and manage your service bookings</p>
        </div>

        <% /* =========================================
          FILTER TABS
          Dynamically highlights the active tab and displays record counts mapped from the DAO.
          =========================================
        */ %>
        <div class="booking-tabs">
            <a href="?status=All" class="tab-btn ${currentStatus == 'All' || empty currentStatus ? 'active' : ''}">All (<c:out value="${counts['All']}" default="0"/>)</a>
            <a href="?status=Pending" class="tab-btn ${currentStatus == 'Pending' ? 'active' : ''}">Pending (<c:out value="${counts['Pending']}" default="0"/>)</a>
            <a href="?status=Confirmed" class="tab-btn ${currentStatus == 'Confirmed' ? 'active' : ''}">Confirmed (<c:out value="${counts['Confirmed']}" default="0"/>)</a>
            <a href="?status=Completed" class="tab-btn ${currentStatus == 'Completed' ? 'active' : ''}">Completed (<c:out value="${counts['Completed']}" default="0"/>)</a>
            <a href="?status=Cancelled" class="tab-btn ${currentStatus == 'Cancelled' ? 'active' : ''}">Cancelled (<c:out value="${counts['Cancelled']}" default="0"/>)</a>
        </div>

        <% /* =========================================
          DATA RENDERING LOGIC
          Checks if the payload is empty to render a fallback state, 
          otherwise iterates through the dataset.
          =========================================
        */ %>
        <c:choose>
            <c:when test="${empty bookingsList}">
                <% /* Empty State View */ %>
                <div class="empty-state-card">
                    <i class="far fa-calendar-alt"></i>
                    <h3>No bookings found</h3>
                    <a href="${pageContext.request.contextPath}/services" class="btn-blue">Browse Services</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <% /* Populated Data View */ %>
                <div class="bookings-container">
                    
                    <% /* Loop through the active list of BookingModels provided by the Servlet */ %>
                    <c:forEach var="booking" items="${bookingsList}">
                        <div class="booking-card" style="flex-direction: column; align-items: stretch;">
                            
                            <% /* Card Content: Upper Row (Details & Status) */ %>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <div>
                                    <h3 style="margin: 0 0 8px 0; color: #111827;"><c:out value="${booking.serviceName}"/></h3>
                                    <p style="color: #4B5563; font-size: 14px; margin: 0;">
                                        <i class="far fa-calendar" style="margin-right: 4px;"></i> <c:out value="${booking.serviceDate}"/> 
                                        <span style="margin: 0 8px;">|</span>
                                        <i class="far fa-clock" style="margin-right: 4px;"></i> <c:out value="${booking.serviceTime}"/>
                                    </p>
                                </div>
                                <div style="text-align: right;">
                                    <span class="status-badge status-${booking.status}"><c:out value="${booking.status}"/></span>
                                    <p style="margin: 12px 0 0 0; font-weight: 800; color: #5D558A; font-size: 18px;">NPR <c:out value="${booking.price}"/></p>
                                </div>
                            </div>

                            <% /* =========================================
                              CONDITIONAL ACTION PANEL
                              Security Rule: Only render modification options if the 
                              appointment hasn't been confirmed/processed yet.
                              =========================================
                            */ %>
                            <c:if test="${booking.status == 'Pending'}">
                                <div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid #E5E7EB; display: flex; gap: 12px; justify-content: flex-end;">
                                    
                                    <% /* Edit Action (Routes to Form) */ %>
                                    <a href="${pageContext.request.contextPath}/edit-booking?id=${booking.id}" style="padding: 8px 16px; background: #F3F4F6; color: #4B5563; border-radius: 6px; text-decoration: none; font-size: 13px; font-weight: 600; transition: background 0.2s;">
                                        <i class="fas fa-edit" style="margin-right: 4px;"></i> Edit
                                    </a>
                                    
                                    <% /* Cancel Action (POST Request) */ %>
                                    <form action="${pageContext.request.contextPath}/bookings" method="POST" style="margin: 0;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                        <button type="submit" onclick="return confirm('Are you sure you want to cancel this booking request?');" style="padding: 8px 16px; background: #FEE2E2; color: #DC2626; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; transition: background 0.2s;">
                                            <i class="fas fa-times-circle" style="margin-right: 4px;"></i> Cancel Request
                                        </button>
                                    </form>
                                    
                                </div>
                            </c:if>

                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </main>

    <% /* Render unified global footer */ %>
    <jsp:include page="/components/footer.jsp" />

</body>
</html>