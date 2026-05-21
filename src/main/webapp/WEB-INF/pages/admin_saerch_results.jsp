<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<a href="${pageContext.request.contextPath}/admindashboard" class="logo-group">

<div class="container" style="margin-top: 40px; min-height: 60vh;">
    <h2>Search Results for: "<c:out value="${searchQuery}" />"</h2>
    <hr>

    <c:choose>
        <%-- If NO results are found --%>
        <c:when test="${!hasResults}">
            <div class="alert alert-warning text-center">
                <h4>No results found!</h4>
                <p>We couldn't find any users or bookings matching your search.</p>
                <a href="${pageContext.request.contextPath}/admindashboard" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </c:when>

        <%-- If results ARE found --%>
        <c:otherwise>
            
            <%-- 1. Display Found Users --%>
            <c:if test="${not empty userResults}">
                <h3>Users Found</h3>
                <table class="table table-bordered">
                    <tr><th>Name</th><th>Email</th><th>Role</th></tr>
                    <c:forEach var="u" items="${userResults}">
                        <tr>
                            <td>${u.fullName}</td>
                            <td>${u.email}</td>
                            <td>${u.role}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <%-- 2. Display Found Bookings --%>
            <c:if test="${not empty adminBookingResults}">
                <h3 class="mt-4">Bookings Found</h3>
                <table class="table table-bordered">
                    <tr><th>Service</th><th>Status</th></tr>
                    <c:forEach var="b" items="${adminBookingResults}">
                        <tr>
                            <td>${b.serviceName}</td>
                            <td>${b.status}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/components/footer.jsp" />