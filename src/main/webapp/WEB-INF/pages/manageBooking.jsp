<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Manage Bookings | ServiceHub</title>
	<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
		  rel="stylesheet">
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="stylesheet"
		  type="text/css"
		  href="${pageContext.request.contextPath}/css/manageBooking.css">
	<style>
		/* =========================
		   NAVBAR
		========================= */
		.navbar {
			background: linear-gradient(135deg, #6B3E9B 0%, #8B5FBF 100%);
			padding: 12px 8%;
			display: flex;
			justify-content: space-between;
			align-items: center;
			flex-wrap: wrap;
			gap: 20px;
			position: sticky;
			top: 0;
			z-index: 1000;
			box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
		}
		.logo {
			color: white;
			font-weight: 800;
			font-size: 1.5rem;
			display: flex;
			align-items: center;
			gap: 10px;
		}
		.nav-links {
			display: flex;
			gap: 32px;
			margin: 0;
			padding: 0;
		}
		.nav-links a {
			font-size: 14px;
			font-weight: 600;
			color: #FFFFFF;
			text-decoration: none;
			transition: 0.3s;
		}
		.nav-links a:hover,
		.nav-links a.active {
			color: #FFD700;
		}
		.header-tools {
			display: flex;
			align-items: center;
			gap: 20px;
		}
		.search-bar {
			position: relative;
		}
		.search-icon {
			position: absolute;
			left: 12px;
			top: 50%;
			transform: translateY(-50%);
			color: #6B3E9B;
		}
		.search-input {
			width: 250px;
			padding: 10px 12px 10px 35px;
			border: none;
			border-radius: 25px;