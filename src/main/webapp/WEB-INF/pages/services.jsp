<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ServiceHub | Our Services</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/services.css?v=2.0">
</head>
<body>

    <%-- Show correct header based on login state --%>
    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="header.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="header_guest.jsp" %>
        </c:otherwise>
    </c:choose>

    <%-- =============================================
         LOGIN REQUIRED POPUP OVERLAY
         Shown only when a guest clicks "Book Now"
         Controlled by servlet setting showLoginPopup=true
         ============================================= --%>
    <c:if test="${showLoginPopup eq true}">
        <div class="popup-overlay" id="loginPopupOverlay">
            <div class="popup-box">
                <div class="popup-icon">
                    <i class="fas fa-lock"></i>
                </div>
                <h2 class="popup-title">Login Required</h2>
                <p class="popup-desc">
                    You need to be logged in to book a service.<br>
                    Please sign in to continue with your booking.
                </p>
                <a href="${pageContext.request.contextPath}/login" class="popup-btn-login">
                    <i class="fas fa-sign-in-alt"></i> Go to Login
                </a>
                <a href="${pageContext.request.contextPath}/services" class="popup-btn-cancel">
                    Continue Browsing
                </a>
            </div>
        </div>
    </c:if>

    <main class="services-main container">

        <%-- PAGE HEADING - comes from servlet attributes --%>
        <div class="catalog-header">
            <h1 class="catalog-title">
                <i class="fas fa-th-large" style="color: #155DFC; margin-right: 10px;"></i>
                ${pageTitle}
            </h1>
            <p class="catalog-subtitle">${pageSubtitle}</p>

            <%-- SEARCH FORM - GET method, no scriptlets --%>
            <form action="${pageContext.request.contextPath}/services" method="GET" class="search-form">
                <div class="search-wrapper">
                    <i class="fas fa-search search-icon-inside"></i>
                    <input
                        type="text"
                        name="search"
                        value="${searchQuery}"
                        placeholder="Search for a service..."
                        class="search-input"
                    >
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </form>

            <%-- LAST SEARCHED CATEGORY REMINDER - cookie-backed, from servlet --%>
            <c:if test="${not empty suggestedCategory}">
                <p class="suggested-hint">
                    <i class="fas fa-history"></i>
                    Last time you browsed: <strong>${suggestedCategory}</strong>
                    &mdash;
                    <a href="?category=${suggestedCategory}" class="hint-link">Browse again</a>
                </p>
            </c:if>
        </div>

        <%-- CATEGORY FILTER TABS - built from dynamicCategories list set in servlet --%>
        <div class="filter-tabs">
            <a href="?category=all"
               class="filter-tab ${selectedCategory eq 'all' or empty selectedCategory ? 'tab-active' : ''}">
                <i class="fas fa-border-all"></i> All
            </a>
            <c:forEach var="cat" items="${dynamicCategories}">
                <a href="?category=${cat}"
                   class="filter-tab ${selectedCategory eq cat ? 'tab-active' : ''}">
                    <c:choose>
                        <c:when test="${cat eq 'Plumbing'}">
                            <i class="fas fa-faucet"></i>
                        </c:when>
                        <c:when test="${cat eq 'Electrical'}">
                            <i class="fas fa-bolt"></i>
                        </c:when>
                        <c:when test="${cat eq 'Cleaning'}">
                            <i class="fas fa-broom"></i>
                        </c:when>
                        <c:when test="${cat eq 'Painting'}">
                            <i class="fas fa-paint-roller"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-tools"></i>
                        </c:otherwise>
                    </c:choose>
                    ${cat}
                </a>
            </c:forEach>
        </div>

        <%-- RESULT COUNT - set by servlet --%>
        <p class="result-count">
            <i class="fas fa-list-ul"></i>
            Showing <strong>${serviceCount}</strong> service(s)
            <c:if test="${not empty searchQuery}">
                for &quot;<strong>${searchQuery}</strong>&quot;
            </c:if>
        </p>

        <%-- SERVICE CARDS GRID --%>
        <div class="services-grid">

            <c:choose>
                <c:when test="${empty serviceList}">
                    <div class="no-results">
                        <i class="fas fa-search-minus no-results-icon"></i>
                        <h3>No services found</h3>
                        <p>Try searching with a different keyword or browse all categories.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-reset">
                            <i class="fas fa-redo"></i> Reset Search
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="service" items="${serviceList}">
                        <div class="service-card">

                            <%-- CARD IMAGE - path comes from servlet data --%>
                            <div class="card-img-wrapper">
                                <img
                                    src="${pageContext.request.contextPath}/images/services/${service.imageUrl}"
                                    alt="${service.name}"
                                    class="card-img"
                                    onerror="this.style.display='none'"
                                >
                                <span class="card-category-badge">
                                    <c:out value="${service.category}"/>
                                </span>
                            </div>

                            <div class="card-body">

                                <h3 class="card-service-name">
                                    <c:out value="${service.name}"/>
                                </h3>

                                <p class="card-desc">
                                    <c:out value="${service.description}"/>
                                </p>

                                <%-- RATING & DURATION META --%>
                                <div class="card-meta">
                                    <span class="meta-rating">
                                        <i class="fas fa-star star-icon"></i>
                                        <c:choose>
                                            <c:when test="${service.rating ne 0.0}">
                                                <strong><c:out value="${service.rating}"/></strong>
                                                <span class="review-count">(<c:out value="${service.reviews}"/> reviews)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="new-badge">New</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="meta-duration">
                                        <i class="far fa-clock"></i>
                                        <c:out value="${service.duration}"/>
                                    </span>
                                </div>

                                <%-- PRICE AND BOOK NOW BUTTON --%>
                                <div class="card-footer">
                                    <div class="price-block">
                                        <span class="price-label">Starting at</span>
                                        <span class="price-amount">
                                            NPR <c:out value="${service.price}"/>
                                        </span>
                                    </div>

                                    <%-- 
                                        BOOKING BUTTON LOGIC:
                                        - If logged in: goes directly to booking form
                                        - If guest: goes to services servlet with bookAttempt flag
                                          which triggers the login popup via servlet
                                    --%>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
                                            <a href="${pageContext.request.contextPath}/book?serviceName=${service.name}&price=${service.price}"
                                               class="btn-book">
                                                Book Now <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/services?bookAttempt=true&serviceName=${service.name}&price=${service.price}"
                                               class="btn-book btn-book-guest">
                                                Book Now <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

    <%-- FOOTER --%>
    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="footer.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="footer_guest.jsp" %>
        </c:otherwise>
    </c:choose>

</body>
</html>