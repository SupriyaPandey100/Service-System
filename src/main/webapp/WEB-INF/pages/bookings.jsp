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
       
        .tab-btn.active {
            background: #5D558A !important;
            color: #ffffff !important;
            border-color: #5D558A !important;
        }

      
        .booking-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
        }

        
        .status-badge {
            display: inline-block;
            padding: 5px 14px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 700;
            text-transform: capitalize;
        }

        .badge-pending   { background: #FFF3CD; color: #856404; }
        .badge-confirmed { background: #D1ECF1; color: #0C5460; }
        .badge-completed { background: #D4EDDA; color: #155724; }
        .badge-cancelled { background: #F8D7DA; color: #721C24; }
        .badge-default   { background: #f3f4f6; color: #374151; }

       
        .pay-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            text-transform: capitalize;
        }

        .pay-pending { background: #FEF3C7; color: #92400E; }
        .pay-paid    { background: #D1FAE5; color: #065F46; }
        .pay-failed  { background: #FEE2E2; color: #991B1B; }

      
        .detail-row {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 14px;
        }

        .detail-row span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .detail-row i {
            color: #9ca3af;
            width: 14px;
        }

      
        .card-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 14px;
            border-top: 1px solid #f3f4f6;
            flex-wrap: wrap;
            gap: 10px;
        }

       
        .admin-note {
            font-size: 12px;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .note-pending   { background: #FFF3CD; color: #856404; }
        .note-confirmed { background: #D1ECF1; color: #0C5460; }
        .note-completed { background: #D4EDDA; color: #155724; }
        .note-cancelled { background: #F8D7DA; color: #721C24; }
    </style>
</head>
<body style="background-color: #f9fafb;">

    <%@ include file="header.jsp" %>

    <main class="container" style="min-height: 70vh; max-width: 1000px; margin: 0 auto; padding: 20px 20px 60px;">

     
        <c:if test="${not empty successMessage}">
            <div style="background: #D1E7DD; color: #0F5132; padding: 16px 20px; border-radius: 10px; margin-top: 20px; margin-bottom: 10px; border: 1px solid #BADBCC; font-weight: 600; font-size: 14px;">
                <i class="fas fa-check-circle" style="margin-right: 8px;"></i>
                <c:out value="${successMessage}"/>
            </div>
        </c:if>

       
        <c:if test="${not empty errorMessage}">
            <div style="background: #F8D7DA; color: #721C24; padding: 16px 20px; border-radius: 10px; margin-top: 20px; margin-bottom: 10px; border: 1px solid #F5C6CB; font-weight: 600; font-size: 14px;">
                <i class="fas fa-exclamation-circle" style="margin-right: 8px;"></i>
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

       
        <div style="margin: 36px 0 20px;">
            <h1 style="font-size: 28px; color: #111827; font-weight: 800; margin: 0 0 6px 0;">My Bookings</h1>
            <p style="color: #6b7280; font-size: 15px; margin: 0;">Track and manage your home service appointments</p>
        </div>

       
        <div style="display: flex; gap: 10px; margin-bottom: 26px; flex-wrap: wrap;">
            <a href="?status=All"
               class="btn btn-outline tab-btn ${currentStatus == 'All' ? 'active' : ''}">
                All (${bookingCounts['All']})
            </a>
            <a href="?status=pending"
               class="btn btn-outline tab-btn ${currentStatus == 'pending' ? 'active' : ''}">
                Pending (${bookingCounts['pending']})
            </a>
            <a href="?status=confirmed"
               class="btn btn-outline tab-btn ${currentStatus == 'confirmed' ? 'active' : ''}">
                Confirmed (${bookingCounts['confirmed']})
            </a>
            <a href="?status=completed"
               class="btn btn-outline tab-btn ${currentStatus == 'completed' ? 'active' : ''}">
                Completed (${bookingCounts['completed']})
            </a>
            <a href="?status=cancelled"
               class="btn btn-outline tab-btn ${currentStatus == 'cancelled' ? 'active' : ''}">
                Cancelled (${bookingCounts['cancelled']})
            </a>
        </div>

        <c:choose>

            <c:when test="${empty userBookings}">
                <div style="background: #ffffff; border: 1px solid #e5e7eb; border-radius: 14px; padding: 80px 20px; text-align: center;">
                    <i class="far fa-calendar-times" style="font-size: 48px; color: #d1d5db; display: block; margin-bottom: 16px;"></i>
                    <h3 style="font-size: 18px; font-weight: 700; color: #111827; margin: 0 0 10px 0;">No bookings found</h3>
                    <p style="color: #9ca3af; font-size: 14px; margin: 0 0 24px 0;">You have no bookings in this category yet.</p>
                    <a href="${pageContext.request.contextPath}/services"
                       style="display: inline-block; background: #155DFC; color: #ffffff; padding: 12px 28px; border-radius: 8px; font-weight: 700; font-size: 14px; text-decoration: none;">
                        Browse Services
                    </a>
                </div>
            </c:when>

           
            <c:otherwise>
                <div style="display: flex; flex-direction: column; gap: 16px;">
                    <c:forEach var="booking" items="${userBookings}">
                        <div class="booking-card">

                        
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 10px; margin-bottom: 14px;">
                                <div>
                                    <span style="font-size: 11px; color: #9ca3af; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; display: block; margin-bottom: 4px;">
                                        Booking #<c:out value="${booking.bookingId}"/>
                                    </span>
                                    <h3 style="margin: 0; font-size: 18px; font-weight: 800; color: #111827;">
                                        <c:out value="${booking.serviceName}"/>
                                    </h3>
                                </div>

                              
                                <div style="display: flex; flex-direction: column; align-items: flex-end; gap: 6px;">

                                   
                                    <span class="status-badge
                                        <c:choose>
                                            <c:when test="${booking.status == 'pending'}">badge-pending</c:when>
                                            <c:when test="${booking.status == 'confirmed'}">badge-confirmed</c:when>
                                            <c:when test="${booking.status == 'completed'}">badge-completed</c:when>
                                            <c:when test="${booking.status == 'cancelled'}">badge-cancelled</c:when>
                                            <c:otherwise>badge-default</c:otherwise>
                                        </c:choose>">
                                        <c:out value="${booking.status}"/>
                                    </span>

                                  
                                    <span class="pay-badge
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'paid'}">pay-paid</c:when>
                                            <c:when test="${booking.paymentStatus == 'failed'}">pay-failed</c:when>
                                            <c:otherwise>pay-pending</c:otherwise>
                                        </c:choose>">
                                        Payment: <c:out value="${booking.paymentStatus}"/>
                                    </span>
                                </div>
                            </div>

                           
                            <div class="detail-row">
                                <span>
                                    <i class="far fa-calendar-alt"></i>
                                    <c:out value="${booking.preferredDate}"/>
                                </span>
                                <span>
                                    <i class="far fa-clock"></i>
                                    <c:out value="${booking.preferredTime}"/>
                                </span>
                                <span>
                                    <i class="fas fa-map-marker-alt"></i>
                                    <c:out value="${booking.serviceAddress}" default="No address provided"/>
                                </span>
                                <span>
                                    <i class="fas fa-phone"></i>
                                    <c:out value="${booking.customerPhone}" default="No phone provided"/>
                                </span>
                            </div>

                          
                            <c:if test="${not empty booking.additionalNotes}">
                                <p style="font-size: 13px; color: #9ca3af; font-style: italic; margin: 0 0 14px 0; padding: 10px 14px; background: #f9fafb; border-radius: 6px; border-left: 3px solid #e5e7eb;">
                                    <i class="fas fa-sticky-note" style="margin-right: 6px;"></i>
                                    <c:out value="${booking.additionalNotes}"/>
                                </p>
                            </c:if>

                          
                            <div class="card-bottom">
                                <span style="font-size: 18px; font-weight: 800; color: #5D558A;">
                                    NPR <c:out value="${booking.totalAmount}"/>
                                </span>

                             
                                <c:choose>
                                    <c:when test="${booking.status == 'pending'}">
                                        <span class="admin-note note-pending">
                                            <i class="fas fa-hourglass-half"></i>
                                            Waiting for admin confirmation
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'confirmed'}">
                                        <span class="admin-note note-confirmed">
                                            <i class="fas fa-check-circle"></i>
                                            Booking confirmed by admin
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'completed'}">
                                        <span class="admin-note note-completed">
                                            <i class="fas fa-star"></i>
                                            Service completed
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'cancelled'}">
                                        <span class="admin-note note-cancelled">
                                            <i class="fas fa-times-circle"></i>
                                            Booking cancelled
                                        </span>
                                    </c:when>
                                </c:choose>
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