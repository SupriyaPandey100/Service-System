<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageBooking.css">
</head>
<body>

<jsp:include page="/components/header.jsp" />

<main class="main-container">
    <div class="page-header">
        <h1>Manage Bookings</h1>
        <p>View and manage all service bookings</p>
    </div>

    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${sessionScope.success}
        </div>
        <% session.removeAttribute("success"); %>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i> ${sessionScope.error}
        </div>
        <% session.removeAttribute("error"); %>
    </c:if>

    <div class="filter-tabs">
        <a href="?status=all" class="filter-tab ${currentStatus == null || currentStatus == 'all' ? 'active' : ''}">
            All (${totalCount})
        </a>
        <a href="?status=PENDING" class="filter-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
            Pending (${pendingCount})
        </a>
        <a href="?status=CONFIRMED" class="filter-tab ${currentStatus == 'CONFIRMED' ? 'active' : ''}">
            Confirmed (${confirmedCount})
        </a>
        <a href="?status=COMPLETED" class="filter-tab ${currentStatus == 'COMPLETED' ? 'active' : ''}">
            Completed (${completedCount})
        </a>
        <a href="?status=CANCELLED" class="filter-tab ${currentStatus == 'CANCELLED' ? 'active' : ''}">
            Cancelled (${cancelledCount})
        </a>
    </div>

    <div class="bookings-grid">
        <c:forEach var="booking" items="${bookings}">
            <div class="booking-card">
                <!-- HEADER -->
                <div class="booking-header">
                    <div class="service-info">
                        <i class="fas fa-wrench"></i>
                        <h3>${booking.serviceName}</h3>
                    </div>
                    <div class="booking-status">
                        <c:choose>
                            <c:when test="${booking.status == 'PENDING'}">
                                <span class="status-badge status-pending">Pending</span>
                            </c:when>
                            <c:when test="${booking.status == 'CONFIRMED'}">
                                <span class="status-badge status-confirmed">Confirmed</span>
                            </c:when>
                            <c:when test="${booking.status == 'COMPLETED'}">
                                <span class="status-badge status-completed">Completed</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-cancelled">Cancelled</span>
                            </c:otherwise>
                        </c:choose>
                        <small>
                            <i class="fas fa-calendar-alt"></i>
                            Booked on <fmt:formatDate value="${booking.createdAt}" pattern="M/d/yyyy" />
                        </small>
                    </div>
                </div>

                <!-- BODY -->
                <div class="booking-body">
                    <div class="booking-details">
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <strong>Customer:</strong> ${booking.customerName}
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <strong>Date:</strong> ${booking.scheduledDate}
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <strong>Time:</strong> ${booking.scheduledTime}
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <strong>Address:</strong> ${booking.address}
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-phone"></i>
                            <strong>Phone:</strong> ${booking.customerPhone}
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-cog"></i>
                            <strong>Assigned Provider:</strong>
                            <c:choose>
                                <c:when test="${not empty booking.technicianName}">
                                    ${booking.technicianName}
                                </c:when>
                                <c:otherwise>
                                    <span class="not-assigned">Not Assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty booking.technicianPhone}">
                            <div class="detail-row">
                                <i class="fas fa-phone-alt"></i>
                                <strong>Provider Contact:</strong> ${booking.technicianPhone}
                            </div>
                        </c:if>
                    </div>

                    <!-- ACTION BUTTONS based on STATUS -->
                    <div class="booking-actions">
                        <!-- PENDING: Show Assign and Cancel buttons -->
                        <c:if test="${booking.status == 'PENDING'}">
                            <form action="${pageContext.request.contextPath}/admin/manage-booking" method="post" class="assign-form">
                                <input type="hidden" name="action" value="assign">
                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                <select name="technicianId" required>
                                    <option value="">-- Select Technician --</option>
                                    <c:forEach var="tech" items="${technicians}">
                                        <option value="${tech.userId}">${tech.fullName} - ${tech.specialization}</option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn-assign">Assign Provider</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin/manage-booking" method="post">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                <button type="submit" class="btn-cancel" onclick="return confirm('Cancel this booking?')">Cancel Booking</button>
                            </form>
                        </c:if>

                        <!-- CONFIRMED: Show Mark Completed button -->
                        <c:if test="${booking.status == 'CONFIRMED'}">
                            <form action="${pageContext.request.contextPath}/admin/manage-booking" method="post">
                                <input type="hidden" name="action" value="complete">
                                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                <button type="submit" class="btn-complete">Mark Completed</button>
                            </form>
                        </c:if>

                        <!-- COMPLETED: Show completion message (NO buttons) -->
                        <c:if test="${booking.status == 'COMPLETED'}">
                            <span class="completed-label">
                                <i class="fas fa-check-circle"></i> Service Completed
                            </span>
                        </c:if>

                        <!-- CANCELLED: Show cancelled message -->
                        <c:if test="${booking.status == 'CANCELLED'}">
                            <span class="cancelled-label">
                                <i class="fas fa-times-circle"></i> Booking Cancelled
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty bookings}">
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <p>No bookings found</p>
            </div>
        </c:if>
    </div>
</main>

<jsp:include page="/components/footer.jsp" />

</body>
</html>