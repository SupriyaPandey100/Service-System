<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Secure Booking Form</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: 'Plus Jakarta Sans', sans-serif;">

    <jsp:include page="header.jsp" />

    <main class="container" style="padding: 40px 20px; min-height: 75vh; display: flex; justify-content: center; align-items: center; max-width: 1200px; margin: 0 auto;">
        <div class="card" style="width: 100%; max-width: 650px; padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #e5e7eb; box-sizing: border-box;">
            
            <div style="text-align: center; margin-bottom: 30px; border-bottom: 1px solid #e5e7eb; padding-bottom: 20px;">
                <h1 style="font-size: 26px; color: #111827; font-weight: 800; margin: 0 0 6px 0;">Confirm Your Booking</h1>
                <p style="color: #4b5563; font-size: 14px; margin: 0;">Review your account information and pick a convenient slot.</p>
            </div>

            <div style="background: #f3f4f6; border: 1px solid #e5e7eb; border-radius: 12px; padding: 20px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <span style="font-size: 11px; color: #5D558A; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; display: block;">Selected Service</span>
                    <h2 style="font-size: 20px; color: #111827; font-weight: 800; margin: 4px 0 0 0;"><c:out value="${sessionScope.pendingServiceName}" default="Home Service"/></h2>
                </div>
                <div style="text-align: right;">
                    <span style="font-size: 11px; color: #4b5563; display: block;">Total Base Cost</span>
                    <span style="font-size: 20px; color: #5D558A; font-weight: 800;">NPR <c:out value="${sessionScope.pendingPrice}" default="1500"/></span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/book" method="POST" style="display: flex; flex-direction: column; gap: 20px;">
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Customer Name</label>
                        <input type="text" value="${not empty sessionScope.loggedUser ? sessionScope.loggedUser.fullName : sessionScope.userSession.fullName}" readonly style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; background-color: #f9fafb; color: #4b5563; cursor: not-allowed; font-family: inherit; box-sizing: border-box;">
                    </div>
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Registered Email</label>
                        <input type="email" value="${not empty sessionScope.loggedUser ? sessionScope.loggedUser.email : sessionScope.userSession.email}" readonly style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; background-color: #f9fafb; color: #4b5563; cursor: not-allowed; font-family: inherit; box-sizing: border-box;">
                    </div>
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Service Delivery Address <span style="color:#EB5757;">*</span></label>
                    <input type="text" name="address" required placeholder="House number, Street Name, Ward, City" style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Preferred Date <span style="color:#EB5757;">*</span></label>
                        <input type="date" name="bookingDate" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Preferred Arrival Time <span style="color:#EB5757;">*</span></label>
                        <select name="bookingTime" required style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; background: white; box-sizing: border-box; height: 46px;">
                            <option value="">Choose a time slot</option>
                            <option value="Morning (8:00 AM - 12:00 PM)">Morning (8:00 AM - 12:00 PM)</option>
                            <option value="Afternoon (12:00 PM - 4:00 PM)">Afternoon (12:00 PM - 4:00 PM)</option>
                            <option value="Evening (4:00 PM - 8:00 PM)">Evening (4:00 PM - 8:00 PM)</option>
                        </select>
                    </div>
                </div>

                <div>
                    <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">Special Instructions / Problem Description</label>
                    <textarea name="instructions" rows="4" placeholder="Please specify if you have any special requests or details about the issue..." style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; resize: vertical; box-sizing: border-box;"></textarea>
                </div>

                <button type="submit" style="padding: 14px; font-weight: 700; font-size: 15px; margin-top: 10px; background-color: #155DFC; color: white; border: none; border-radius: 8px; cursor: pointer; font-family: inherit; transition: background 0.2s;">
                    <i class="fas fa-lock" style="margin-right: 6px;"></i> Confirm and Book Service
                </button>
            </form>
        </div>
    </main>

    <jsp:include page="footer.jsp" />

</body>
</html>