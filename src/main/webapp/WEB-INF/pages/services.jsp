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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/services.css?v=3.0">
</head>
<body>

    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="header.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="header_guest.jsp" %>
        </c:otherwise>
    </c:choose>

    <c:if test="${empty sessionScope.loggedUser and empty sessionScope.userSession}">
        <div class="popup-overlay" id="loginPopup">
            <div class="popup-card">
                <button class="popup-x" onclick="closePopup()" type="button">
                    <i class="fas fa-times"></i>
                </button>
                <div class="popup-lock-circle">
                    <i class="fas fa-lock"></i>
                </div>
                <h3>Login Required</h3>
                <p>Please login first to book this service</p>
                <div class="popup-service-info">
                    <span>Service: <strong id="popupServiceName">-</strong></span>
                    <span>Category: <strong id="popupCategory">-</strong></span>
                    <span>Price: <strong id="popupPrice">-</strong></span>
                </div>
                <a href="#" id="popupLoginBtn" class="popup-login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login Now
                </a>
                <button class="popup-cancel-link" onclick="closePopup()" type="button">Cancel</button>
            </div>
        </div>
    </c:if>

    <main class="container" style="padding-top: 40px; min-height: 70vh;">

        <div class="catalog-header">
            <h1>Our Services</h1>
            <p>Browse through our wide range of professional home services</p>

            <form action="${pageContext.request.contextPath}/services" method="GET" class="search-container">
                <i class="fas fa-search"></i>
                <input type="text" name="search" value="${searchQuery}" placeholder="Search for services...">
            </form>
        </div>

        <div class="filter-tabs">
            <a href="?category=all" class="filter-btn ${selectedCategory == 'all' or empty selectedCategory ? 'active' : ''}">All</a>
            <c:forEach var="cat" items="${dynamicCategories}">
                <a href="?category=${cat}" class="filter-btn ${selectedCategory == cat ? 'active' : ''}">${cat}</a>
            </c:forEach>
        </div>

        <div class="grid">
            <c:forEach var="service" items="${serviceList}">
                <div class="service-card">

                    <div class="card-img-wrapper"
                         style="background-image: url('${pageContext.request.contextPath}/${service.imageUrl}');">
                    </div>

                    <div class="card-content">
                        <div>
                            <span class="card-tag"><c:out value="${service.category}"/></span>
                            <h3><c:out value="${service.name}"/></h3>
                            <p class="desc"><c:out value="${service.description}"/></p>

                            <div class="card-meta">
                                <span class="meta-rating">
                                    <i class="fas fa-star"></i>
                                    <strong><c:out value="${service.rating != 0.0 ? service.rating : 'New'}"/></strong>
                                    <span class="meta-reviews">(<c:out value="${service.reviews}"/>)</span>
                                </span>
                                <span class="meta-duration">
                                    <i class="far fa-clock"></i>
                                    <c:out value="${service.duration}"/>
                                </span>
                            </div>
                        </div>

                        <div class="card-footer">
                            <div class="price-box">
                                <span class="price-label">Starting at</span>
                                <span class="price-amount">NPR <c:out value="${service.price}"/></span>
                            </div>

                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
                                    <a href="${pageContext.request.contextPath}/book?serviceName=${service.name}&price=${service.price}"
                                       class="book-btn">
                                        Book Now <i class="fas fa-arrow-right"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="book-btn"
                                            onclick="openPopup('${service.name}', '${service.category}', '${service.price}')">
                                        Book Now <i class="fas fa-arrow-right"></i>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>
            </c:forEach>
        </div>

    </main>

    <c:choose>
        <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
            <%@ include file="footer.jsp" %>
        </c:when>
        <c:otherwise>
            <%@ include file="footer_guest.jsp" %>
        </c:otherwise>
    </c:choose>

    <script>
        var contextPath = "${pageContext.request.contextPath}";

        function openPopup(serviceName, category, price) {
            document.getElementById("popupServiceName").textContent = serviceName;
            document.getElementById("popupCategory").textContent    = category;
            document.getElementById("popupPrice").textContent       = "NPR " + price;
            document.getElementById("popupLoginBtn").href =
                contextPath + "/book?serviceName=" + encodeURIComponent(serviceName) + "&price=" + encodeURIComponent(price);
            document.getElementById("loginPopup").classList.add("active");
            document.body.style.overflow = "hidden";
        }

        function closePopup() {
            document.getElementById("loginPopup").classList.remove("active");
            document.body.style.overflow = "";
        }

        document.addEventListener("DOMContentLoaded", function () {
            var overlay = document.getElementById("loginPopup");
            if (overlay) {
                overlay.addEventListener("click", function (e) {
                    if (e.target === overlay) closePopup();
                });
            }
        });
    </script>

</body>
</html>