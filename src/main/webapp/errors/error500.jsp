<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error | ServiceHub</title>
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
            border-top: 5px solid #EF4444;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
        }
        .error-icon {
            font-size: 64px;
            color: #EF4444;
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
        .btn-group {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        .btn-back {
            padding: 12px 20px;
            border: 1px solid #d1d5db;
            color: #374151;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            background: white;
            transition: background 0.2s;
        }
        .btn-back:hover {
            background: #f3f4f6;
        }
        .btn-dashboard {
            padding: 12px 20px;
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
        .btn-dashboard:hover {
            background-color: #0d4bc7;
        }
    </style>
</head>
<body>

    <div class="error-card">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1 class="error-code">500</h1>
        <h2 class="error-title">Internal Server Error</h2>
        <p class="error-desc">
            Something went wrong on our end. The server encountered an internal configuration issue.
        </p>
        <div class="btn-group">
            <a href="javascript:history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
        </div>
    </div>

</body>
</html>