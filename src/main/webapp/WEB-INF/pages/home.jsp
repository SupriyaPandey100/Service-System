<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<% /* ==============================================================================
  View Component: Home / Services Catalog Page (home.jsp)
  Purpose: Serves as the primary public landing page. Displays the complete 
           catalog of available home services for users to browse.
           
  Architecture & Logic:
  - Adheres strictly to the MVC design pattern.
  - Dynamically renders service data using JSTL (<c:forEach>) and EL (${service}).
  - Implements unified component architecture by calling /components/ files.
  ==============================================================================
*/ %>

<!DOCTYPE html>
<html lang="en">
<head>
    <% /* =========================================
      HEAD SECTION: Metadata and External Assets
      - Connects to Google Fonts and FontAwesome for UI typography/icons.
      - Loads specific stylesheets utilizing EL for dynamic context paths.
      =========================================
    */ %>
    <meta charset="UTF-8">
    <title>ServiceHub | Our Services</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/services.css">
</head>
<body style="background-color: #f9fafb; margin: 0; display: flex; flex-direction: column; min-height: 100vh;">

    <% /* Render the unified smart header. It autonomously handles guest vs. logged-in UI. */ %>
    <jsp:include page="/components/header.jsp" />

    <main style="flex: 1;">
        
        <% /* =========================================
          PAGE HEADER & SEARCH BAR
          Allows users to submit a text-based query to the ServicesServlet.
          =========================================
        */ %>
        <div class="catalog-header" style="padding-top: 40px; text-align: center;">
            <h1 style="font-size: 32px; color: var(--text-main); margin-bottom: 8px;">Our Services</h1>
            <p style="color: var(--text-sub); margin-bottom: 24px;">Browse through our wide range of professional home services</p>
            
            <form action="${pageContext.request.contextPath}/services" method="GET" class="search-container" style="margin-bottom: 24px; display: inline-block; width: 100%;">
                <input type="text" name="search" placeholder="Search for services..." style="padding: 12px 20px; width: 100%; max-width: 500px; border-radius: 8px; border: 1px solid var(--border-color); font-family: inherit;">
            </form>
        </div>

        <% /* =========================================
          CATEGORY FILTER TABS
          Provides quick-link parameters to filter the catalog by trade category.
          =========================================
        */ %>
        <div class="filter-tabs" style="display: flex; gap: 12px; margin-bottom: 32px; justify-content: center; flex-wrap: wrap;">
            <a href="?category=all" class="btn btn-outline active" style="background: var(--primary-color); color: white;">All</a>
            <a href="?category=Plumbing" class="btn btn-outline">Plumbing</a>
            <a href="?category=Electrical" class="btn btn-outline">Electrical</a>
            <a href="?category=Painting" class="btn btn-outline">Painting</a>
            <a href="?category=Cleaning" class="btn btn-outline">Cleaning</a>
            <a href="?category=AC" class="btn btn-outline">AC Repair</a>
            <a href="?category=Carpentry" class="btn btn-outline">Carpentry</a>
        </div>

        <% /* =========================================
          SERVICE CATALOG GRID
          Iterates over the 'serviceList' array passed from the Controller.
          =========================================
        */ %>
        <div class="container">
            <div class="grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; padding-bottom: 60px;">
                
                <c:forEach var="service" items="${serviceList}">
                    <div class="service-card" style="background: white; border: 1px solid var(--border-color); border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                        <div class="service-img" style="height: 200px; background: url('${service.imageUrl}') center/cover;"></div>
                        <div class="card-content" style="padding: 20px;">
                            
                            <% /* Dynamic Service Tags and Details */ %>
                            <span class="card-tag" style="background: var(--secondary-bg); color: var(--primary-color); padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 600;">${service.category}</span>
                            <h3 style="margin: 12px 0; font-size: 18px; color: var(--text-main); font-weight: 800;">${service.name}</h3>
                            <p style="color: var(--text-sub); font-size: 14px; margin-bottom: 16px; line-height: 1.5;">${service.description}</p>
                            
                            <% /* Static mock metadata for UI presentation */ %>
                            <div class="card-meta" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 13px;">
                                <span style="color: #FACC15;"><i class="fas fa-star"></i> 4.8 (158)</span>
                                <span style="color: var(--text-sub);"><i class="far fa-clock"></i> 2 hours</span>
                            </div>
                            
                            <% /* Service Pricing and Authentication Check for Booking */ %>
                            <div class="card-footer" style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border-color); padding-top: 16px;">
                                <div>
                                    <span style="font-size: 11px; color: var(--text-sub); display: block;">Starting at</span>
                                    <span style="font-weight: 700; color: var(--primary-color); font-size: 16px;">NPR ${service.price}</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="padding: 8px 16px; font-size: 13px; text-decoration: none;">Login to Book</a>
                            </div>
                            
                        </div>
                    </div>
                </c:forEach>
                
            </div>
        </div>
    </main>

    <% /* Render the unified global footer */ %>
    <jsp:include page="/components/footer.jsp" />

</body>
</html>