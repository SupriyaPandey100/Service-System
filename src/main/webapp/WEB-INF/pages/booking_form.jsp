<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Book a Service</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
</head>
<body style="background-color: #f9fafb; margin: 0; font-family: 'Plus Jakarta Sans', sans-serif;">

    <%@ include file="header.jsp" %>

    <main style="min-height: 75vh; display: flex; justify-content: center; align-items: center; padding: 40px 20px;">
        <div style="width: 100%; max-width: 650px; padding: 40px; background: white; border-radius: 14px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid #e5e7eb; box-sizing: border-box;">

            <%-- Heading --%>
            <div style="text-align: center; margin-bottom: 28px; border-bottom: 1px solid #e5e7eb; padding-bottom: 20px;">
                <h1 style="font-size: 24px; color: #111827; font-weight: 800; margin: 0 0 6px 0;">Confirm Your Booking</h1>
                <p style="color: #6b7280; font-size: 14px; margin: 0;">Fill in your details and pick a convenient time slot</p>
            </div>

            <%-- Selected service summary box --%>
            <div style="background: #f3f4f6; border: 1px solid #e5e7eb; border-radius: 10px; padding: 18px 20px; margin-bottom: 28px; display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <span style="font-size: 11px; color: #5D558A; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; display: block;">Selected Service</span>
                    <h2 style="font-size: 18px; color: #111827; font-weight: 800; margin: 4px 0 0 0;">
                        <c:out value="${sessionScope.pendingServiceName}" default="Home Service"/>
                    </h2>
                </div>
                <div style="text-align: right;">
                    <span style="font-size: 11px; color: #6b7280; display: block;">Total Amount</span>
                    <span style="font-size: 20px; color: #5D558A; font-weight: 800;">
                        NPR <c:out value="${sessionScope.pendingPrice}" default="0"/>
                    </span>
                </div>
            </div>

            
            <form action="${pageContext.request.contextPath}/book" method="POST" style="display: flex; flex-direction: column; gap: 18px;">

             
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                            Customer Name
                        </label>
                        <input type="text"
                               value="${not empty sessionScope.loggedUser ? sessionScope.loggedUser.fullName : sessionScope.userSession.fullName}"
                               readonly
                               style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; background: #f9fafb; color: #6b7280; cursor: not-allowed; font-family: inherit; box-sizing: border-box;">
                    </div>
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                            Email
                        </label>
                        <input type="email"
                               value="${not empty sessionScope.loggedUser ? sessionScope.loggedUser.email : sessionScope.userSession.email}"
                               readonly
                               style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; background: #f9fafb; color: #6b7280; cursor: not-allowed; font-family: inherit; box-sizing: border-box;">
                    </div>
                </div>

        
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                        Phone Number
                    </label>
                    <input type="text"
                           name="customerPhone"
                           required
                           placeholder="e.g. 9812345678"
                           style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                </div>

             
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 18px;">
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                            Preferred Date
                        </label>
                        <input type="date"
                               name="preferredDate"
                               required
                               style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                    </div>
                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                            Preferred Time
                        </label>
                        <select name="preferredTime"
                                required
                                style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; background: white; box-sizing: border-box; height: 46px;">
                            <option value="">Choose a time slot</option>
                            <option value="09:00 AM">09:00 AM</option>
                            <option value="10:00 AM">10:00 AM</option>
                            <option value="11:00 AM">11:00 AM</option>
                            <option value="12:00 PM">12:00 PM</option>
                            <option value="01:00 PM">01:00 PM</option>
                            <option value="02:00 PM">02:00 PM</option>
                            <option value="03:00 PM">03:00 PM</option>
                            <option value="04:00 PM">04:00 PM</option>
                            <option value="05:00 PM">05:00 PM</option>
                        </select>
                    </div>
                </div>

              
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                        Service Address
                    </label>
                    <input type="text"
                           name="serviceAddress"
                           required
                           placeholder="House number, Street, City"
                           style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; box-sizing: border-box;">
                </div>

             
                <div>
                    <label style="display: block; font-size: 13px; font-weight: 700; margin-bottom: 8px; color: #111827;">
                        Additional Notes
                    </label>
                    <textarea name="additionalNotes"
                              rows="4"
                              placeholder="Describe the issue or any special instructions..."
                              style="width: 100%; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-family: inherit; resize: vertical; box-sizing: border-box;"></textarea>
                </div>

                <%-- Submit button --%>
                <button type="submit"
                        style="padding: 14px; font-weight: 700; font-size: 15px; margin-top: 6px; background-color: #155DFC; color: white; border: none; border-radius: 8px; cursor: pointer; font-family: inherit; transition: background 0.2s;">
                    <i class="fas fa-check-circle" style="margin-right: 6px;"></i> Confirm and Book Service
                </button>

            </form>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

</body>
</html>