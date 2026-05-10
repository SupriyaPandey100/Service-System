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
    
    
    <style>
        :root {
            --brown: #49301E;
            --green: #2C362B;
            --beige: #F8F2E4;
            --white: #ffffff;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background-color: var(--beige); color: var(--brown); line-height: 1.6; }

        /* NAVBAR */
        .navbar { background-color: var(--brown); padding: 1rem 8%; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 1000; }
        .logo { color: white; font-weight: 800; font-size: 1.5rem; text-decoration: none; display: flex; align-items: center; gap: 8px; }
        .nav-links { list-style: none; display: flex; gap: 2rem; }
        .nav-links a { text-decoration: none; color: rgba(255,255,255,0.8); font-size: 0.95rem; font-weight: 500; }
        .auth-btns { display: flex; gap: 20px; align-items: center; }
        .btn-reg { background: var(--green); color: white; padding: 10px 20px; border-radius: 6px; text-decoration: none; font-weight: 600; }

        /* HERO SECTION - MATCHING FIGMA */
        .hero { 
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1581578731548-c64695cc6958?q=80&w=2070&auto=format&fit=crop');
            background-size: cover; background-position: center;
            height: 550px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; color: white; padding: 0 10%;
        }
        .hero h1 { font-size: 3.2rem; font-weight: 800; margin-bottom: 15px; max-width: 850px; }
        .hero p { font-size: 1.15rem; margin-bottom: 35px; opacity: 0.9; max-width: 700px; }
        .hero-btns { display: flex; gap: 15px; }
        .btn-beige { background: #EADDCA; color: var(--brown); padding: 14px 28px; border-radius: 8px; text-decoration: none; font-weight: 700; display: flex; align-items: center; gap: 8px; }
        .btn-outline { border: 2px solid white; color: white; padding: 12px 28px; border-radius: 8px; text-decoration: none; font-weight: 700; }

        /* SERVICES SECTION */
        .section-padding { padding: 80px 8%; text-align: center; }
        .section-title { font-size: 2.2rem; font-weight: 800; margin-bottom: 10px; }
        .section-subtitle { color: #666; margin-bottom: 50px; font-weight: 500; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; }
        .s-card { background: white; padding: 40px 30px; border-radius: 12px; text-align: left; transition: 0.3s; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
        .s-card:hover { transform: translateY(-8px); }
        .s-card i { background: var(--beige); color: var(--brown); padding: 15px; border-radius: 8px; margin-bottom: 25px; display: inline-block; font-size: 1.2rem; }
        .s-card h3 { margin-bottom: 12px; font-weight: 700; }
        .s-card p { font-size: 0.95rem; color: #555; margin-bottom: 20px; }
        .learn-more { color: var(--brown); text-decoration: none; font-weight: 700; font-size: 0.9rem; }

        /* WHY CHOOSE US - FIGMA MATCH */
        .why-us { background-color: #EFE9DB; }
        .why-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 50px; margin-top: 40px; }
        .why-item i { font-size: 2.2rem; color: var(--brown); background: rgba(73, 48, 30, 0.1); padding: 25px; border-radius: 50%; margin-bottom: 20px; display: inline-block; }
        .why-item h3 { margin-bottom: 10px; font-weight: 700; }

        /* CALL TO ACTION */
        .cta-banner { background: var(--brown); color: white; border-radius: 20px; padding: 70px; margin: 40px 8%; text-align: center; }
        .cta-banner h2 { font-size: 2.2rem; margin-bottom: 15px; font-weight: 700; }
        .cta-banner p { margin-bottom: 35px; opacity: 0.85; font-size: 1.1rem; }
        .btn-cta { background: #EADDCA; color: var(--brown); padding: 14px 35px; border-radius: 8px; text-decoration: none; font-weight: 700; }

        /* FOOTER */
        footer { background: var(--brown); color: white; padding: 70px 8% 30px; }
        .f-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 60px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 50px; }
        .f-col h3 { margin-bottom: 25px; display: flex; align-items: center; gap: 10px; }
        .f-col h4 { margin-bottom: 25px; color: var(--white); }
        .f-col p { font-size: 0.95rem; color: rgba(255,255,255,0.75); line-height: 1.8; margin-bottom: 10px; }
        .copyright { text-align: center; padding-top: 25px; font-size: 0.85rem; color: rgba(255,255,255,0.5); }
        
        @media (max-width: 992px) {
            .why-grid, .f-grid { grid-template-columns: 1fr; }
            .hero h1 { font-size: 2.2rem; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="#" class="logo"><i class="fas fa-wrench"></i> ServiceHub</a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About</a></li>
        
    </ul>
    <div class="auth-btns">
        <a href="${pageContext.request.contextPath}/login" style="color:white; text-decoration:none; font-weight:600;">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-reg">Register</a>
    </div>
</nav>

<header class="hero">
    <h1>Professional Home Services at Your Doorstep</h1>
    <p>Book trusted professionals for plumbing, electrical, cleaning, and more. Quick, reliable, and affordable services.</p>
    <div class="hero-btns">
        <a href="#" class="btn-beige">Browse Services <i class="fas fa-arrow-right"></i></a>
        <a href="${pageContext.request.contextPath}/register" class="btn-outline">Get Started</a>
    </div>
</header>

<section class="section-padding">
    <h2 class="section-title">Our Services</h2>
    <p class="section-subtitle">Professional services for all your home needs</p>
    <div class="grid">
        <div class="s-card"><i class="fas fa-wrench"></i><h3>Plumbing</h3><p>Expert plumbing services for all your needs including repairs and installations.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
        <div class="s-card"><i class="fas fa-bolt"></i><h3>Electrical</h3><p>Licensed electricians for safe installations, wiring, and repair services.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
        <div class="s-card"><i class="fas fa-paint-roller"></i><h3>Painting</h3><p>Professional interior and exterior painting and decoration services.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
        <div class="s-card"><i class="fas fa-tint"></i><h3>Cleaning</h3><p>Deep cleaning, sanitation, and home maintenance services.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
        <div class="s-card"><i class="fas fa-wind"></i><h3>AC Repair</h3><p>Air conditioning repair, cleaning, and professional maintenance.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
        <div class="s-card"><i class="fas fa-hammer"></i><h3>Carpentry</h3><p>Custom furniture repair, woodwork, and installation services.</p><a href="#" class="learn-more">Learn More &rarr;</a></div>
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
    <a href="${pageContext.request.contextPath}/register" class="btn-cta">Create Account</a>
</div>

<footer>
    <div class="f-grid">
        <div class="f-col">
            <h3><i class="fas fa-wrench"></i> ServiceHub</h3>
            <p>Your trusted platform for quality home services. Book professional service providers with ease and confidence.</p>
        </div>
        <div class="f-col">
            <h4>Quick Links</h4>
            <p>Services</p>
            <p>About Us</p>
            
        </div>
        <div class="f-col">
            <h4>Contact Info</h4>
            <p>Email: info@ServiceHub.com</p>
            <p>Phone: +977 9841234567</p>
            <p>Address: Kathmandu, Nepal</p>
        </div>
    </div>
    <div class="copyright">&copy; 2026 ServiceHub. All rights reserved.</div>
</footer>

</body>
</html>