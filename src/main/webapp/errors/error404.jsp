<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found | ServiceHub</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f9fafb;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .error-card {
            text-align: center;
            padding: 50px 40px;
            max-width: 450px;
            width: 90%;
            background: white;
            border-radius: 16px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
        }
        .error-icon {
            font-size: 64px;
            color: #9ca3af;
            margin-bottom: 20px;
        }
        .error-code {
            font-size: 56px;
            color: #111827;
            margin: 0 0 10px 0;
            font-weight: 800;
            line-height: 1;
        }
        .error-title {
            font-size: 22px;
            color: #1f2937;
            margin: 0 0 15px 0;
            font-weight: 700;
        }
        .error-desc {
            color: #4b5563;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 15px;
        }
        .btn-redirect {
            padding: 12px 24px;
            background-color: #155DFC;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            transition: background 0.2s;
        }
        .btn-redirect:hover {
            background-color: #0d4bc7;
        }
    </style>
</head>
<body>

    <div class="error-card">
        <div class="error-icon">
            <i class="fas fa-compass"></i>
        </div>
        <h1 class="error-code">404</h1>
        <h2 class="error-title">Page Not Found</h2>
        <p class="error-desc">
            The page you are looking for might have been removed, renamed, or is temporarily unavailable.
        </p>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-redirect">
            <i class="fas fa-th-large"></i> Go to Dashboard
        </a>
    </div>

</body>
</html>