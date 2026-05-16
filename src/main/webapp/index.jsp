<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Professional Home Services</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userdashboard.css?v=5.0">
    
    <style>
        .hero { 
            background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)), 
                        url('https://images.unsplash.com/photo-1581578731548-c64695cc6958?q=80&w=2070&auto=format&fit=crop');
            background-size: cover; background-position: center;
            height: 550px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; color: white;
            padding: 0 10%;
        }
        .hero h1 { font-size: 3.2rem; font-weight: 800; margin-bottom: 15px; max-width: 850px; }
        .hero p { font-size: 1.15rem; margin-bottom: 35px; opacity: 0.95; max-width: 700px; }
        .hero-btns { display: flex; gap: 15px; }
        
        .btn-beige { background: var(--primary-color); color: white; padding: 14px 28px; border-radius: 8px; text-decoration: none; font-weight: 700; display: flex; align-items: center; gap: 8px; transition: background 0.3s;}
        .btn-beige:hover { background: #594bb8; }
        
        .btn-white { background: white; color: var(--theme-bg-color); padding: 14px 28px; border-radius: 8px; text-decoration: none; font-weight: 700; transition: all 0.3s; border: none; }
        .btn-white:hover { background: #f0f0f0; }

        .section-padding { padding: 80px 8%; text-align: center; }
        .section-title { font-size: 2.2rem; font-weight: 800; margin-bottom: 10px; color: var(--theme-bg-color); }
        .section-subtitle { color: var(--text-sub); margin-bottom: 50px; font-weight: 500; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; }
        
        .s-card { background: white; padding: 40px 30px; border-radius: 12px; text-align: left; transition: 0.3s; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid var(--border-color); }
        .s-card:hover { transform: translateY(-8px); box-shadow: 0 12px 30px rgba(0,0,0,0.1); }
        .s-card i { background: var(--secondary-bg); color: var(--primary-color); padding: 16px; border-radius: 10px; margin-bottom: 25px; display: inline-block; font-size: 1.3rem; }
        .s-card h3 { margin-bottom: 12px; font-weight: 800; color: var(--text-main); }
        .s-card p { font-size: 0.95rem; color: var(--text-sub); margin-bottom: 25px; line-height: 1.5; }
        
        .learn-more { color: var(--text-main); text-decoration: none; font-weight: 700; font-size: 0.95rem; transition: color 0.3s; display: flex; align-items: center; gap: 5px; }
        .learn-more:hover { color: var(--primary-color); }

        .why-us { background-color: var(--secondary-bg); }
        .why-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 50px; margin-top: 40px; }
        .why-item i { font-size: 2.2rem; color: var(--primary-color); background: white; padding: 25px; border-radius: 50%; margin-bottom: 20px; display: inline-block; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .why-item h3 { margin-bottom: 10px; font-weight: 800; color: var(--text-main); }
        .why-item p { color: var(--text-sub); }

        .cta-banner { background: var(--theme-bg-color); color: white; border-radius: 16px; padding: 70px; margin: 40px 8%; text-align: center; }
        .cta-banner h2 { font-size: 2.2rem; margin-bottom: 15px; font-weight: 800; }
        .cta-banner p { margin-bottom: 35px; opacity: 0.9; font-size: 1.1rem; }
    </style>
</head>
<body>

    <%@ include file="WEB-INF/pages/header_guest.jsp" %>

    <header class="hero">
        <h1>Professional Home Services at Your Doorstep</h1>
        <p>Book trusted professionals for plumbing, electrical, cleaning, and more. Quick, reliable, and affordable services.</p>
        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/services" class="btn-beige">Browse Services <i class="fas fa-arrow-right"></i></a>
            <a href="${pageContext.request.contextPath}/register" class="btn-white">Get Started</a>
        </div>
    </header>

    <section class="section-padding">
        <h2 class="section-title">Our Services</h2>
        <p class="section-subtitle">Professional services for all your home needs</p>
        <div class="grid">
            <div class="s-card"><i class="fas fa-wrench"></i><h3>Plumbing</h3><p>Expert plumbing services for all your needs including repairs and installations.</p><a href="${pageContext.request.contextPath}/services?category=Plumbing" class="learn-more">Learn More &rarr;</a></div>
            <div class="s-card"><i class="fas fa-bolt"></i><h3>Electrical</h3><p>Licensed electricians for safe installations, wiring, and repair services.</p><a href="${pageContext.request.contextPath}/services?category=Electrical" class="learn-more">Learn More &rarr;</a></div>
            <div class="s-card"><i class="fas fa-paint-roller"></i><h3>Painting</h3><p>Professional interior and exterior painting and decoration services.</p><a href="${pageContext.request.contextPath}/services?category=Painting" class="learn-more">Learn More &rarr;</a></div>
            <div class="s-card"><i class="fas fa-tint"></i><h3>Cleaning</h3><p>Deep cleaning, sanitation, and home maintenance services.</p><a href="${pageContext.request.contextPath}/services?category=Cleaning" class="learn-more">Learn More &rarr;</a></div>
            <div class="s-card"><i class="fas fa-wind"></i><h3>AC Repair</h3><p>Air conditioning repair, cleaning, and professional maintenance.</p><a href="${pageContext.request.contextPath}/services?category=AC" class="learn-more">Learn More &rarr;</a></div>
            <div class="s-card"><i class="fas fa-hammer"></i><h3>Carpentry</h3><p>Custom furniture repair, woodwork, and installation services.</p><a href="${pageContext.request.contextPath}/services?category=Carpentry" class="learn-more">Learn More &rarr;</a></div>
        </div>
    </section>

    <section class="section-padding why-us">
        <h2 class="section-title">Why Choose Us</h2>
        <p class="section-subtitle">Trusted by thousands of customers</p>
        <div class="why-grid">
            <div class="why-item"><i class="fas fa-user-check"></i><h3>Verified Professionals</h3><p>All service providers are verified and background-checked for your safety.</p></div>
            <div class="why-item"><i class="fas fa-medal"></i><h3>Quality Service</h3><p>Top-rated professionals with excellent customer reviews and track records.</p></div>
            <div class="why-item"><i class="fas fa-layer-group"></i><h3>Wide Range</h3><p>Access to various home service categories in one single platform.</p></div>
        </div>
    </section>

    <div class="cta-banner">
        <h2>Ready to Get Started?</h2>
        <p>Join thousands of satisfied customers who trust our platform.</p>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="background: white; color: var(--theme-bg-color);">Create Account</a>
    </div>

    <%@ include file="WEB-INF/pages/footer_guest.jsp" %>

</body>
</html>