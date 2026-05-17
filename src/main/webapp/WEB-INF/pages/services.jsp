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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/services.css">

    <style>
        /* =============================================
           LOGIN POPUP - services page only
        ============================================= */

        /* Full screen dark overlay */
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(17, 24, 39, 0.55);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        .popup-overlay.active {
            display: flex;
        }

        /* White centered popup card */
        .popup-card {
            background: #ffffff;
            border-radius: 16px;
            padding: 40px 36px 34px;
            max-width: 400px;
            width: 90%;
            text-align: center;
            position: relative;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.18);
            animation: popupIn 0.22s ease;
        }

        @keyframes popupIn {
            from { opacity: 0; transform: translateY(-16px) scale(0.97); }
            to   { opacity: 1; transform: translateY(0px) scale(1); }
        }

        /* X button top right */
        .popup-x {
            position: absolute;
            top: 13px;
            right: 15px;
            background: none;
            border: none;
            font-size: 1rem;
            color: #9ca3af;
            cursor: pointer;
            padding: 5px 8px;
            border-radius: 6px;
            transition: background 0.2s, color 0.2s;
        }

        .popup-x:hover {
            background: #f3f4f6;
            color: #374151;
        }

        /* Purple lock icon circle */
        .popup-lock-circle {
            width: 66px;
            height: 66px;
            background: #f0eef9;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            font-size: 1.6rem;
            color: #5D558A;
        }

        .popup-card h3 {
            font-size: 1.3rem;
            font-weight: 800;
            color: #111827;
            margin: 0 0 10px 0;
        }

        .popup-card p {
            font-size: 0.92rem;
            color: #6b7280;
            line-height: 1.6;
            margin: 0 0 24px 0;
        }

        /* Service detail pill shown inside popup */
        .popup-service-info {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 10px 16px;
            margin-bottom: 24px;
            font-size: 0.88rem;
            color: #374151;
            text-align: left;
        }

        .popup-service-info span {
            display: block;
            margin-bottom: 4px;
        }

        .popup-service-info span:last-child {
            margin-bottom: 0;
        }

        .popup-service-info strong {
            color: #111827;
        }

        /* Blue Login Now button - exact same style as Book Now */
        .popup-login-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            background: #155DFC;
            color: #ffffff;
            padding: 12px 24px;
            border-radius: 6px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: background 0.25s ease;
            margin-bottom: 12px;
        }

        .popup-login-btn:hover {
            background: #0d4bc7;
            color: #ffffff;
        }

        /* Cancel link below button */
        .popup-cancel-link {
            display: block;
            font-size: 0.85rem;
            color: #9ca3af;
            cursor: pointer;
            text-decoration: underline;
            text-underline-offset: 3px;
            transition: color 0.2s;
            background: none;
            border: none;
            width: 100%;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .popup-cancel-link:hover {
            color: #6b7280;
        }
    </style>
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

    <%--
        LOGIN POPUP
        Only rendered for guests.
        When guest clicks Book Now, we pass the service name + price into the popup
        and also store them in the login URL as params so BookingServlet can save
        them into session → after login, LoginServlet reads pendingServiceName
        and redirects straight to /book (booking form).
    --%>
    <c:if test="${empty sessionScope.loggedUser and empty sessionScope.userSession}">
        <div class="popup-overlay" id="loginPopup">
            <div class="popup-card">

                <button class="popup-x" onclick="closePopup()" type="button" title="Close">
                    <i class="fas fa-times"></i>
                </button>

                <div class="popup-lock-circle">
                    <i class="fas fa-lock"></i>
                </div>

                <h3>Login Required</h3>
                <p>Please login first to book this service</p>

                <%-- Service details shown inside popup (filled by JS) --%>
                <div class="popup-service-info">
                    <span>Service: <strong id="popupServiceName">-</strong></span>
                    <span>Category: <strong id="popupCategory">-</strong></span>
                    <span>Price: <strong id="popupPrice">-</strong></span>
                </div>

                <%--
                    Login Now button.
                    href is built by JS to include ?serviceName=...&price=...
                    so that BookingServlet saves them to session before forwarding to login.
                    After login, LoginServlet checks pendingServiceName and redirects to /book.
                --%>
                <a href="#" id="popupLoginBtn" class="popup-login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login Now
                </a>

                <button class="popup-cancel-link" onclick="closePopup()" type="button">
                    Cancel
                </button>

            </div>
        </div>
    </c:if>

    <main class="container" style="padding-top: 40px; min-height: 70vh;">
        <div class="catalog-header" style="text-align: center; margin-bottom: 40px;">
            <h1 style="font-size: 32px; color: var(--text-main); margin-bottom: 8px; font-weight: 800;">Our Services</h1>
            <p style="color: var(--text-sub); margin-bottom: 24px;">Browse through our wide range of professional home services</p>

            <form action="${pageContext.request.contextPath}/services" method="GET" class="search-container" style="margin-bottom: 24px; display: inline-block; width: 100%;">
                <input type="text" name="search" value="${searchQuery}" placeholder="Search for services..." style="padding: 12px 20px; width: 100%; max-width: 500px; border-radius: 8px; border: 1px solid var(--border-color); font-family: inherit;">
            </form>
        </div>

        <div class="filter-tabs" style="display: flex; gap: 12px; margin-bottom: 32px; justify-content: center; flex-wrap: wrap;">
            <a href="?category=all" class="btn btn-outline ${selectedCategory == 'all' or empty selectedCategory ? 'active' : ''}" style="${selectedCategory == 'all' or empty selectedCategory ? 'background: var(--primary-color); color: white;' : ''}">All</a>
            <c:forEach var="cat" items="${dynamicCategories}">
                <a href="?category=${cat}" class="btn btn-outline ${selectedCategory == cat ? 'active' : ''}" style="${selectedCategory == cat ? 'background: var(--primary-color); color: white;' : ''}">${cat}</a>
            </c:forEach>
        </div>

        <div class="grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; padding-bottom: 60px;">
            <c:forEach var="service" items="${serviceList}">
                <div class="service-card" style="background: white; border: 1px solid var(--border-color); border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); display: flex; flex-direction: column; min-height: 440px;">

                    <div class="card-img-wrapper" style="height: 200px; background-image: url('${pageContext.request.contextPath}/${service.imageUrl}'); background-size: cover; background-position: center; background-color: #F3F4F6;"></div>

                    <div class="card-content" style="padding: 20px; flex-grow: 1; display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <span class="card-tag" style="background: var(--secondary-bg); color: var(--primary-color); padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 600;">
                                <c:out value="${service.category}"/>
                            </span>
                            <h3 style="margin: 12px 0; font-size: 18px; color: var(--text-main); font-weight: 800;">
                                <c:out value="${service.name}"/>
                            </h3>
                            <p class="desc" style="color: var(--text-sub); font-size: 14px; margin-bottom: 16px; line-height: 1.5; min-height: 42px;">
                                <c:out value="${service.description}"/>
                            </p>

                            <div class="card-meta" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 13px;">
                                <span class="meta-rating" style="color: #FACC15;">
                                    <i class="fas fa-star"></i> <strong><c:out value="${service.rating != 0.0 ? service.rating : 'New'}"/></strong>
                                    <span style="color: var(--text-sub); font-weight: 400;">(<c:out value="${service.reviews}"/>)</span>
                                </span>
                                <span style="color: var(--text-sub);"><i class="far fa-clock"></i> <c:out value="${service.duration}"/></span>
                            </div>
                        </div>

                        <div class="card-footer" style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-color); padding-top: 16px; margin-top: auto;">
                            <div class="price-box">
                                <span class="price-label" style="display: block; font-size: 11px; color: var(--text-sub); text-align: left;">Starting at</span>
                                <span class="price-amount" style="font-weight: 700; color: var(--primary-color); font-size: 16px;">
                                    NPR <c:out value="${service.price}"/>
                                </span>
                            </div>

                            <%--
                                Logged-in  → goes directly to /book?serviceName=...&price=...
                                Guest      → opens popup with service details filled in,
                                             Login Now button takes them to /book?serviceName=...&price=...
                                             BookingServlet saves to session then forwards to login.
                                             After login → LoginServlet sees pendingServiceName → redirects to /book
                            --%>
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedUser or not empty sessionScope.userSession}">
                                    <a href="${pageContext.request.contextPath}/book?serviceName=${service.name}&price=${service.price}"
                                       class="book-btn"
                                       style="padding: 10px 18px; font-size: 13px; font-weight: 700; text-decoration: none; background-color: #155DFC; color: white; border-radius: 6px; display: inline-flex; align-items: center; gap: 6px;">
                                        Book Now <i class="fas fa-arrow-right" style="font-size: 11px;"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <%-- data-* attributes carry service info into the popup via JS --%>
                                    <button
                                        type="button"
                                        class="book-btn"
                                        onclick="openPopup('${service.name}', '${service.category}', '${service.price}')"
                                        data-name="${service.name}"
                                        data-category="${service.category}"
                                        data-price="${service.price}"
                                        style="padding: 10px 18px; font-size: 13px; font-weight: 700; background-color: #155DFC; color: white; border-radius: 6px; border: none; display: inline-flex; align-items: center; gap: 6px; cursor: pointer; font-family: 'Plus Jakarta Sans', sans-serif;">
                                        Book Now <i class="fas fa-arrow-right" style="font-size: 11px;"></i>
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

        // Opens popup and fills in the service details
        function openPopup(serviceName, category, price) {
            document.getElementById("popupServiceName").textContent = serviceName;
            document.getElementById("popupCategory").textContent = category;
            document.getElementById("popupPrice").textContent = "NPR " + price;

            // Build the login link: goes to /book first (saves to session), 
            // BookingServlet saves pendingServiceName then forwards to login,
            // after login LoginServlet sees pendingServiceName and redirects to /book
            var bookUrl = contextPath + "/book?serviceName=" + encodeURIComponent(serviceName) + "&price=" + encodeURIComponent(price);
            document.getElementById("popupLoginBtn").href = bookUrl;

            document.getElementById("loginPopup").classList.add("active");
            document.body.style.overflow = "hidden";
        }

        // Closes the popup
        function closePopup() {
            document.getElementById("loginPopup").classList.remove("active");
            document.body.style.overflow = "";
        }

        // Click dark background to close
        document.addEventListener("DOMContentLoaded", function () {
            var overlay = document.getElementById("loginPopup");
            if (overlay) {
                overlay.addEventListener("click", function (e) {
                    if (e.target === overlay) {
                        closePopup();
                    }
                });
            }
        });
    </script>

</body>
</html>