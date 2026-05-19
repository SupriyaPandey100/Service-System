<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ServiceHub | Contact Us</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --primary:#5f4b8b;
            --primary-dark:#4c3b72;
            --accent:#2563eb;
            --accent-dark:#1d4ed8;
            --bg:#f8f7fc;
            --card:#ffffff;
            --text:#1f2937;
            --muted:#6b7280;
            --line:#e5e7eb;
            --shadow:0 14px 35px rgba(17,24,39,0.12);
        }

        *{
            box-sizing:border-box;
            margin:0;
            padding:0;
        }

        body{
            font-family:'Plus Jakarta Sans', sans-serif;
            background:var(--bg);
            color:var(--text);
            min-height:100vh;
            display:flex;
            flex-direction:column;
        }

        a{
            text-decoration:none;
            color:inherit;
        }

        .navbar{
            background:linear-gradient(90deg, var(--primary-dark), var(--primary));
            color:#fff;
            padding:0.9rem 4.5%;
            display:flex;
            align-items:center;
            justify-content:space-between;
            box-shadow:0 3px 18px rgba(0,0,0,0.12);
            position:sticky;
            top:0;
            z-index:1000;
        }

        .nav-left, .nav-right{
            display:flex;
            align-items:center;
            gap:1.2rem;
        }

        .brand{
            display:flex;
            align-items:center;
            gap:0.55rem;
            font-weight:800;
            font-size:1.12rem;
            white-space:nowrap;
        }

        .nav-links{
            display:flex;
            align-items:center;
            gap:1.45rem;
            list-style:none;
            margin-left:0.75rem;
        }

        .nav-links a{
            color:rgba(255,255,255,0.92);
            font-size:0.95rem;
        }

        .nav-links a:hover{
            text-decoration:underline;
        }

        .logout-btn{
            border:1px solid rgba(255,255,255,0.35);
            background:rgba(255,255,255,0.08);
            color:#fff;
            padding:0.52rem 0.95rem;
            border-radius:12px;
            cursor:pointer;
            font:inherit;
        }

        .hero{
            padding:2.4rem 4.5% 1rem;
        }

        .hero-card{
            background:linear-gradient(135deg, #ffffff, #f3efff);
            border:1px solid rgba(95,75,139,0.12);
            border-radius:22px;
            box-shadow:var(--shadow);
            padding:2rem;
            display:grid;
            grid-template-columns:minmax(0, 1.05fr) minmax(320px, 0.95fr);
            gap:1.4rem;
            align-items:stretch;
        }

        .hero-left{
            background:linear-gradient(180deg, rgba(95,75,139,0.08), rgba(95,75,139,0.03));
            border-radius:18px;
            padding:1.7rem;
            display:flex;
            flex-direction:column;
            justify-content:center;
        }

        .hero-left h1{
            font-size:2rem;
            margin-bottom:0.55rem;
            color:#1f1630;
        }

        .hero-left p{
            color:var(--muted);
            line-height:1.7;
            font-size:0.96rem;
            margin-bottom:1rem;
        }

        .quick-points{
            display:grid;
            gap:0.65rem;
            margin-top:0.3rem;
        }

        .quick-item{
            background:#fff;
            border:1px solid var(--line);
            border-radius:14px;
            padding:0.8rem 0.95rem;
            font-size:0.92rem;
            color:#374151;
        }

        .hero-right{
            background:#fff;
            border-radius:18px;
            border:1px solid var(--line);
            padding:1.4rem;
            display:flex;
            flex-direction:column;
        }

        .info-grid{
            display:grid;
            grid-template-columns:1fr;
            gap:0.8rem;
        }

        .info-box{
            border:1px solid var(--line);
            border-radius:14px;
            padding:1rem;
            background:#fafaff;
        }

        .info-box h3{
            font-size:0.98rem;
            margin-bottom:0.35rem;
            color:#111827;
        }

        .info-box p{
            font-size:0.9rem;
            color:var(--muted);
            line-height:1.65;
        }

        .main-wrap{
            padding:0 4.5% 2.2rem;
            flex:1;
        }

        .content-grid{
            display:grid;
            grid-template-columns:minmax(0, 1.1fr) minmax(320px, 0.9fr);
            gap:1.4rem;
            align-items:stretch;
        }

        .panel{
            background:var(--card);
            border-radius:22px;
            box-shadow:var(--shadow);
            border:1px solid rgba(229,231,235,0.9);
            min-width:0;
            height:100%;
            display:flex;
            flex-direction:column;
        }

        .contact-card{
            padding:1.6rem;
        }

        .section-title{
            margin-bottom:1rem;
        }

        .section-title h2{
            font-size:1.45rem;
            color:#111827;
            margin-bottom:0.25rem;
        }

        .section-title p{
            color:var(--muted);
            font-size:0.94rem;
            line-height:1.6;
        }

        .message{
            padding:0.9rem 1rem;
            border-radius:12px;
            margin-bottom:1rem;
            font-size:0.92rem;
            font-weight:600;
        }

        .success{
            background:#ecfdf5;
            border:1px solid #bbf7d0;
            color:#15803d;
        }

        .error{
            background:#fef2f2;
            border:1px solid #fecaca;
            color:#b91c1c;
        }

        .form-grid{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:1rem;
        }

        .form-group{
            margin-bottom:1rem;
        }

        .form-group.full{
            grid-column:1 / -1;
        }

        .form-group label{
            display:block;
            margin-bottom:0.48rem;
            font-size:0.92rem;
            font-weight:700;
            color:#111827;
        }

        .form-control{
            width:100%;
            border:1px solid #e5e7eb;
            border-radius:12px;
            padding:0.92rem 1rem;
            font-family:inherit;
            font-size:0.95rem;
            outline:none;
            background:#fff;
            transition:border-color .2s ease, box-shadow .2s ease;
        }

        .form-control:focus{
            border-color:#8b5cf6;
            box-shadow:0 0 0 3px rgba(139,92,246,0.12);
        }

        textarea.form-control{
            min-height:150px;
            resize:vertical;
        }

        .submit-btn{
            width:100%;
            border:none;
            border-radius:12px;
            padding:0.95rem 1rem;
            background:linear-gradient(90deg, var(--accent), var(--accent-dark));
            color:#fff;
            font-size:0.98rem;
            font-weight:700;
            cursor:pointer;
            box-shadow:0 8px 18px rgba(37,99,235,0.24);
            transition:transform .2s ease, box-shadow .2s ease;
        }

        .submit-btn:hover{
            transform:translateY(-1px);
            box-shadow:0 10px 22px rgba(37,99,235,0.28);
        }

        .side-card{
            padding:1.6rem;
            height:100%;
            justify-content:flex-start;
        }

        .service-grid{
            display:grid;
            gap:0.85rem;
            margin-top:1rem;
            flex:1;
        }

        .service-item{
            padding:1rem;
            border-radius:14px;
            background:#fafaff;
            border:1px solid var(--line);
        }

        .service-item h4{
            font-size:0.95rem;
            margin-bottom:0.25rem;
            color:#111827;
        }

        .service-item p{
            font-size:0.9rem;
            line-height:1.65;
            color:var(--muted);
        }

        .footer{
            background:linear-gradient(180deg, var(--primary), #5b4d84);
            color:rgba(255,255,255,0.92);
            padding:2rem 4.5% 1.2rem;
        }

        .footer-grid{
            display:grid;
            grid-template-columns:1.2fr 0.8fr 1fr;
            gap:2rem;
            align-items:start;
        }

        .footer h3{
            font-size:1rem;
            margin-bottom:0.75rem;
            color:#fff;
        }

        .footer p, .footer a, .footer li{
            font-size:0.9rem;
            line-height:1.65;
            color:rgba(255,255,255,0.86);
        }

        .footer ul{
            list-style:none;
            display:grid;
            gap:0.45rem;
        }

        .footer-bottom{
            margin-top:1.3rem;
            padding-top:1rem;
            border-top:1px solid rgba(255,255,255,0.14);
            text-align:center;
            font-size:0.85rem;
            color:rgba(255,255,255,0.82);
        }

        @media (max-width: 980px){
            .hero-card,
            .content-grid,
            .footer-grid{
                grid-template-columns:1fr;
            }
        }

        @media (max-width: 720px){
            .navbar{
                flex-direction:column;
                align-items:flex-start;
                gap:0.9rem;
            }

            .nav-left, .nav-right{
                width:100%;
                justify-content:space-between;
                flex-wrap:wrap;
            }

            .nav-links{
                width:100%;
                justify-content:flex-start;
                flex-wrap:wrap;
            }

            .hero{
                padding:1.2rem 0.8rem 0.8rem;
            }

            .main-wrap{
                padding:0 0.8rem 1.4rem;
            }

            .hero-left h1{
                font-size:1.6rem;
            }

            .form-grid{
                grid-template-columns:1fr;
            }
        }
    </style>
</head>
<body>

<header class="navbar">
    <div class="nav-left">
        <a href="${pageContext.request.contextPath}/home" class="brand">
            <span>ServiceHub</span>
        </a>

        <nav>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/service">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
            </ul>
        </nav>
    </div>

    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
    </div>
</header>

<section class="hero">
    <div class="hero-card">
        <div class="hero-left">
            <h1>Contact ServiceHub</h1>
            <p>
                Need help with any home service? Send us your inquiry and our team will respond as soon as possible.
            </p>

            <div class="quick-points">
                <div class="quick-item">Fast response for service booking and support</div>
                <div class="quick-item">Professional help for cleaning, plumbing, electrical and more</div>
            </div>
        </div>

        <div class="hero-right">
            <div class="info-grid">
                <div class="info-box">
                    <h3>Call Us</h3>
                    <p>+977 9841234567</p>
                </div>
                <div class="info-box">
                    <h3>Email Us</h3>
                    <p>support@servicehub.com</p>
                </div>
                <div class="info-box">
                    <h3>Visit Us</h3>
                    <p>Kathmandu, Nepal</p>
                </div>
            </div>
        </div>
    </div>
</section>

<main class="main-wrap">
    <div class="content-grid">
        <section class="panel contact-card">
            <div class="section-title">
                <h2>Send us a message</h2>
                <p>Fill in the form below and we will get back to you.</p>
            </div>

            <c:if test="${not empty success}">
                <div class="message success"><c:out value="${success}" /></div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="message error"><c:out value="${error}" /></div>
            </c:if>

            <form action="${pageContext.request.contextPath}/contact" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input class="form-control" type="text" id="fullName" name="fullName"
                               value="${param.fullName}" placeholder="Enter your full name" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input class="form-control" type="email" id="email" name="email"
                               value="${param.email}" placeholder="Enter your email" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input class="form-control" type="tel" id="phone" name="phone"
                               value="${param.phone}" placeholder="Enter your phone number" required>
                    </div>

                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input class="form-control" type="text" id="subject" name="subject"
                               value="${param.subject}" placeholder="Enter subject" required>
                    </div>

                    <div class="form-group full">
                        <label for="message">Message</label>
                        <textarea class="form-control" id="message" name="message"
                                  placeholder="Write your message here" required>${param.message}</textarea>
                    </div>

                    <div class="form-group full">
                        <button type="submit" class="submit-btn">Send Message</button>
                    </div>
                </div>
            </form>
        </section>

        <aside class="panel side-card">
            <div class="section-title">
                <h2>All Service Categories</h2>
                <p>These are the main services your ServiceHub project offers.</p>
            </div>

            <div class="service-grid">
                <div class="service-item">
                    <h4>Plumbing Repair</h4>
                    <p>Professional plumbing help for leaks, clogs, and pipes.</p>
                </div>

                <div class="service-item">
                    <h4>Electrical Installation</h4>
                    <p>Licensed electricians for wiring and installations.</p>
                </div>

                <div class="service-item">
                    <h4>House Painting</h4>
                    <p>Interior and exterior painting with quality finishes.</p>
                </div>

                <div class="service-item">
                    <h4>Deep Cleaning</h4>
                    <p>Comprehensive deep cleaning for the entire home.</p>
                </div>

                <div class="service-item">
                    <h4>Pest Control</h4>
                    <p>Safe pest control and home sanitization services.</p>
                </div>

                <div class="service-item">
                    <h4>AC Repair</h4>
                    <p>Cooling system maintenance and repair support.</p>
                </div>
            </div>
        </aside>
    </div>
</main>

<footer class="footer">
    <div class="footer-grid">
        <div>
            <h3>ServiceHub</h3>
            <p>Your trusted platform for quality home services. Book professional service providers with ease.</p>
        </div>

        <div>
            <h3>Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/service">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>

        <div>
            <h3>Contact Info</h3>
            <p>Email: support@servicehub.com</p>
            <p>Phone: +977 9841234567</p>
            <p>Address: Kathmandu, Nepal</p>
        </div>
    </div>

    <div class="footer-bottom">
        © 2026 ServiceHub. All rights reserved.
    </div>
</footer>

</body>
</html>