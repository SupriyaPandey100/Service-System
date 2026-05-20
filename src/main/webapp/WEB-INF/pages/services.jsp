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
</head>
<body>

    <jsp:include page="/components/header.jsp" />

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
                <div class="service-card" style="background: white; border: 1px solid var(--border-color); border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); display: flex; flex-direction: column; min-height: 400px;">
                    
                    <div class="card-img-wrapper" style="height: 200px; background-image: url('${pageContext.request.contextPath}/${service.imageUrl}'); background-size: cover; background-position: center; background-color: #F3F4F6;"></div>
                    
                    <div class="card-content" style="padding: 20px; flex-grow: 1; display: flex; flex-direction: column; justify-content: space-between;">
                        <div>
                            <span class="card-tag" style="background: var(--secondary-bg); color: var(--primary-color); padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 600;">
                                <c:out value="${service.category}"/>
                            </span>
                            <h3 style="margin: 12px 0; font-size: 18px; color: var(--text-main); font-weight: 800;">
                                <c:out value="${service.name}"/>
                            </h3>
                            <p class="desc" style="color: var(--text-sub); font-size: 14px; margin-bottom: 24px; line-height: 1.5; min-height: 42px;">
                                <c:out value="${service.description}"/>
                            </p>
                        </div>
                        
                        <div class="card-footer" style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-color); padding-top: 16px; margin-top: auto;">
                            
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div class="price-box">
                                    <span class="price-label" style="display: block; font-size: 11px; color: var(--text-sub); text-align: left;">Starting at</span>
                                    <span class="price-amount" style="font-weight: 700; color: var(--primary-color); font-size: 16px;">
                                        NPR <c:out value="${service.price}"/>
                                    </span>
                                </div>
                                
                                <c:if test="${not empty sessionScope.loggedUser}">
                                    <a href="${pageContext.request.contextPath}/wishlist?action=add&id=${service.id}" 
                                       title="Save for later"
                                       style="color: #9ca3af; font-size: 20px; text-decoration: none; transition: color 0.2s; margin-top: 6px;"
                                       onmouseover="this.style.color='#7C3AED'" 
                                       onmouseout="this.style.color='#9ca3af'">
                                        <i class="far fa-heart"></i>
                                    </a>
                                </c:if>
                            </div>
                            
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedUser}">
                                    <a href="${pageContext.request.contextPath}/book?serviceName=${service.name}&price=${service.price}" 
                                       class="btn btn-primary" 
                                       style="padding: 10px 18px; font-size: 13px; font-weight: 700; text-decoration: none; background-color: #155DFC; color: white; border-radius: 8px; display: inline-block;">
                                        Book Now <i class="fas fa-arrow-right" style="margin-left: 4px; font-size: 11px;"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login" 
                                       class="btn btn-primary" 
                                       style="padding: 10px 18px; font-size: 13px; font-weight: 700; text-decoration: none; background-color: #155DFC; color: white; border-radius: 8px; display: inline-block;">
                                        <i class="fas fa-lock" style="margin-right: 4px;"></i> Login
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            
                        </div>
                        
                    </div>
                </div>
            </c:forEach>
            
        </div>
    </main>

    <jsp:include page="/components/footer.jsp" />

</body>
</html>