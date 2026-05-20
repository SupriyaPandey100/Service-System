<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Wishlist | ServiceHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=6.0">
    
    <style>
        .wishlist-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        .wishlist-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 40px;
        }
        .wishlist-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        }
        .item-main-details {
            display: flex;
            gap: 20px;
            align-items: center;
            flex: 1;
        }
        .icon-container {
            width: 70px;
            height: 70px;
            background-color: #f3f0fa;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #7C3AED;
            font-size: 28px;
            flex-shrink: 0;
        }
        .text-info h3 {
            margin: 0 0 6px 0;
            font-size: 18px;
            color: #111827;
            font-weight: 700;
        }
        .text-info p {
            margin: 0 0 12px 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.5;
            max-width: 500px;
        }
        .tag-category {
            display: inline-block;
            background: #f3f4f6;
            color: #4b5563;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
        }
        .item-actions-box {
            display: flex;
            align-items: center;
            gap: 30px;
        }
        .price-meta {
            text-align: right;
        }
        .price-val {
            font-size: 18px;
            font-weight: 800;
            color: #111827;
            display: block;
        }
        .price-lbl {
            font-size: 12px;
            color: #9ca3af;
        }
        .btn-book {
            background: #7C3AED;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn-book:hover { background: #6D28D9; }
        
        .btn-delete {
            color: #EF4444;
            background: #FEF2F2;
            border: none;
            width: 38px;
            height: 38px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-delete:hover { background: #FEE2E2; }

        .promo-banner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f5f3ff;
            border: 1px solid #e0dbfa;
            border-radius: 12px;
            padding: 20px 30px;
        }
    </style>
</head>
<body style="background-color: #f9fafb;">

    <jsp:include page="/components/header.jsp" />

    <main class="container" style="margin-top: 40px; min-height: 75vh; max-width: 1100px; margin-left: auto; margin-right: auto; padding: 0 20px;">
        
        <div class="wishlist-header">
            <div>
                <h1 style="font-size: 28px; margin: 0 0 4px 0; font-weight: 800; color: #111827;">My Wishlist <i class="far fa-heart" style="color: #7C3AED;"></i></h1>
                <p style="color: #6b7280; margin: 0; font-size: 14px;">Services you saved for later</p>
            </div>
            <span style="background: #eedffd; color: #7C3AED; padding: 4px 12px; border-radius: 50px; font-weight: 700; font-size: 13px;">
                <c:out value="${itemCount}"/> items
            </span>
        </div>

        <div class="wishlist-container">
            <c:choose>
                <c:when test="${empty wishlistItems}">
                    <div style="text-align: center; padding: 60px 20px; background: white; border-radius: 12px; border: 1px solid #e5e7eb;">
                        <i class="far fa-heart" style="font-size: 48px; color: #d1d5db; margin-bottom: 16px;"></i>
                        <h3 style="color: #374151; margin-bottom: 8px;">Your wishlist is empty</h3>
                        <p style="color: #6b7280; margin-bottom: 20px;">Explore our catalog to save your favorite home services!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${wishlistItems}">
                        <div class="wishlist-row">
                            <div class="item-main-details">
                                <div class="icon-container">
                                    <c:choose>
                                        <c:when test="${item.category == 'Cleaning'}"><i class="fas fa-broom"></i></c:when>
                                        <c:when test="${item.category == 'Plumbing'}"><i class="fas fa-faucet"></i></c:when>
                                        <c:otherwise><i class="fas fa-bolt"></i></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-info">
                                    <h3><c:out value="${item.serviceName}"/></h3>
                                    <p><c:out value="${item.description}"/></p>
                                    <span class="tag-category"><c:out value="${item.category}"/></span>
                                </div>
                            </div>
                            
                            <div class="item-actions-box">
                                <div class="price-meta">
                                    <span class="price-val">Rs. <c:out value="${item.price}"/></span>
                                    <span class="price-lbl">Starting from</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/book?serviceName=${item.serviceName}&price=${item.price}" class="btn-book">Book Now</a>
                                <a href="?action=delete&id=${item.wishlistId}" class="btn-delete" title="Remove from Wishlist">
                                    <i class="far fa-trash-alt"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="promo-banner">
            <div style="display: flex; gap: 16px; align-items: center;">
                <div style="width: 44px; height: 44px; border-radius: 50%; border: 1px solid #7C3AED; display: flex; align-items: center; justify-content: center; color: #7C3AED;">
                    <i class="far fa-heart"></i>
                </div>
                <div>
                    <h4 style="margin: 0 0 2px 0; font-size: 16px; color: #111827; font-weight: 700;">Need more services?</h4>
                    <p style="margin: 0; font-size: 13px; color: #6b7280;">Explore our wide range of professional home services.</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/services" class="btn-book" style="background: #7C3AED;">Browse Services</a>
        </div>

    </main>

    <jsp:include page="/components/footer.jsp" />

</body>
</html>