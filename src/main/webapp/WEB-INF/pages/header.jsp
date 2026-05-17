<header>
    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard" class="logo-group">
            <i class="fas fa-wrench logo-icon"></i>
            <span class="brand-name">ServiceHub</span>
        </a>
        
        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/About">About</a></li>
                <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
            </ul>
        </nav>
        
        <div class="header-tools">
            <form action="${pageContext.request.contextPath}/search" method="GET" class="search-bar-small">
                <input type="text" name="query" placeholder="Search bookings, notifications..." required>
                <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
            </form>
            
            <div class="notification-wrapper">
                <div class="notification-bell">
                    <i class="fas fa-bell"></i>
                    <c:if test="${not empty notificationCount and notificationCount > 0}">
                        <span class="notification-count"><c:out value="${notificationCount}"/></span>
                    </c:if>
                </div>
                
                <div class="notification-dropdown">
                    <div class="dropdown-header">
                        <h3>Notifications</h3>
                        <a href="${pageContext.request.contextPath}/mark-notifications-read">Mark all as read</a>
                    </div>
                    <div class="dropdown-body">
                        <c:choose>
                            <c:when test="${empty notificationsList}">
                                <div style="text-align: center; padding: 30px 20px; color: var(--text-sub);">
                                    <i class="fas fa-bell-slash" style="font-size: 24px; margin-bottom: 10px; opacity: 0.5;"></i>
                                    <p style="margin: 0; font-size: 14px;">No new notifications</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notif" items="${notificationsList}">
                                    <div class="notification-item">
                                        <div class="notification-icon-small">
                                            <c:choose>
                                                <c:when test="${notif.type == 'SUCCESS'}"><i class="fas fa-check-circle" style="color: #27AE60;"></i></c:when>
                                                <c:when test="${notif.type == 'WARNING'}"><i class="fas fa-exclamation-triangle" style="color: #F2994A;"></i></c:when>
                                                <c:otherwise><i class="fas fa-info-circle" style="color: var(--primary-color);"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="notification-content">
                                            <p><c:out value="${notif.message}"/></p>
                                            <span class="time"><c:out value="${notif.createdAt}"/></span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <div class="user-dropdown">
                <div class="user-avatar"><i class="fas fa-user"></i></div>
                <span class="user-name">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedUser}">
                            <c:out value="${sessionScope.loggedUser.fullName}"/>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${sessionScope.userSession.fullName}"/>
                        </c:otherwise>
                    </c:choose>
                    <i class="fas fa-chevron-down" style="font-size: 10px; margin-left: 5px;"></i>
                </span>
                
                <div class="dropdown-menu">
                    <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> My Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>