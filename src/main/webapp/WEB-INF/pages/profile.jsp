<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:choose>
	<c:when test="${not empty requestScope.user}">
		<c:set var="user" value="${requestScope.user}" />
	</c:when>
	<c:otherwise>
		<c:set var="user" value="${sessionScope.userSession}" />
	</c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ServiceHub | My Profile</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
:root {
	--primary: #64508d;
	--primary-dark: #554178;
	--bg: #f7f5fb;
	--card: #ffffff;
	--line: #e6e0f3;
	--text: #1f2937;
	--muted: #7a6f96;
	--accent: #2f6df6;
	--accent-dark: #1f57dd;
	--success: #20b15a;
	--success-bg: #e8f8ee;
	--shadow: 0 14px 34px rgba(32, 35, 56, 0.12);
}

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
	background: var(--bg);
	color: var(--text);
	min-height: 100vh;
}

.page-shell {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.main-area {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: flex-start;
	padding: 3rem 1rem 2.8rem;
}

.profile-card {
	width: min(100%, 410px);
	background: var(--card);
	border: 1px solid rgba(230, 224, 243, 0.9);
	border-radius: 18px;
	box-shadow: var(--shadow);
	padding: 1.6rem 1.55rem 1.45rem;
}

.profile-head {
	text-align: center;
	margin-bottom: 1.1rem;
}

.avatar-wrap {
	display: flex;
	justify-content: center;
	margin-bottom: 0.95rem;
}

.avatar {
	width: 68px;
	height: 68px;
	border-radius: 50%;
	background: #ece8f5;
	position: relative;
	display: grid;
	place-items: center;
	overflow: hidden;
	border: 3px solid #e8e1f4;
	cursor: pointer;
}

.avatar img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.avatar-badge {
	position: absolute;
	inset: auto 0 0 0;
	background: rgba(0, 0, 0, 0.45);
	color: #fff;
	font-size: 0.62rem;
	font-weight: 600;
	text-align: center;
	padding: 0.18rem 0;
	opacity: 0;
	pointer-events: none;
}

.avatar:hover .avatar-badge {
	opacity: 1;
}

.profile-title {
	font-size: 1.75rem;
	line-height: 1.2;
	color: #111827;
	font-weight: 800;
	margin-bottom: 0.3rem;
}

.profile-subtitle {
	font-size: 0.85rem;
	color: #b09adf;
	font-weight: 500;
}

.status-box {
	background: #f8f6f1;
	border-radius: 12px;
	padding: 0.72rem 0.82rem;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 0.75rem;
	margin: 1rem 0 1.05rem;
}

.status-labels {
	display: grid;
	gap: 0.42rem;
	font-size: 0.86rem;
	font-weight: 700;
	color: #2b2b2b;
}

.status-values {
	display: grid;
	gap: 0.35rem;
	justify-items: end;
}

.badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 62px;
	padding: 0.22rem 0.56rem;
	border-radius: 999px;
	font-size: 0.68rem;
	font-weight: 700;
	text-transform: lowercase;
}

.badge-approved {
	background: var(--success-bg);
	color: var(--success);
}

.badge-role {
	background: #ede8fa;
	color: #65518e;
}

.field-group {
	margin-bottom: 0.78rem;
}

.field-label {
	display: block;
	margin-bottom: 0.35rem;
	font-size: 0.86rem;
	font-weight: 700;
	color: #111827;
}

.field-wrap {
	position: relative;
}

.field-icon {
	position: absolute;
	left: 0.72rem;
	top: 50%;
	transform: translateY(-50%);
	color: #9a90ad;
	font-size: 0.92rem;
	pointer-events: none;
}

.field-input {
	width: 100%;
	height: 38px;
	padding: 0 0.82rem 0 2.1rem;
	border: 1px solid #e3def0;
	border-radius: 8px;
	outline: none;
	font-family: inherit;
	font-size: 0.86rem;
	color: #222;
	background: #fff;
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.field-input:focus {
	border-color: #8a6de0;
	box-shadow: 0 0 0 3px rgba(138, 109, 224, 0.12);
}

.message {
	border-radius: 10px;
	padding: 0.72rem 0.84rem;
	margin-bottom: 0.9rem;
	font-size: 0.83rem;
	font-weight: 600;
}

.success {
	background: var(--success-bg);
	color: #14753b;
	border: 1px solid #cdeed8;
}

.error {
	background: #fef2f2;
	color: #b91c1c;
	border: 1px solid #fecaca;
}

.submit-btn {
	width: 100%;
	height: 39px;
	border: none;
	border-radius: 8px;
	background: linear-gradient(90deg, var(--accent), var(--accent-dark));
	color: #fff;
	font-size: 0.88rem;
	font-weight: 700;
	cursor: pointer;
	box-shadow: 0 8px 18px rgba(47, 109, 246, 0.24);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	margin-top: 0.2rem;
}

.submit-btn:hover {
	transform: translateY(-1px);
	box-shadow: 0 10px 22px rgba(47, 109, 246, 0.28);
}

@media ( max-width : 720px) {
	.main-area {
		padding: 1.4rem 0.75rem 2rem;
	}
	.profile-card {
		padding: 1.25rem 1rem 1rem;
		border-radius: 16px;
	}
	.profile-title {
		font-size: 1.5rem;
	}
	.status-box {
		flex-direction: column;
		align-items: flex-start;
	}
	.status-values {
		justify-items: start;
	}
}
</style>
</head>
<body>

<div class="page-shell">

	<main class="main-area">
		<section class="profile-card">

			<div class="profile-head">
				<div class="avatar-wrap">
					<label class="avatar" for="profilePic">
						<c:choose>
							<c:when test="${not empty user.profileImage}">
								<img src="${pageContext.request.contextPath}/${user.profileImage}" alt="Profile Image">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/images/default-profile.png" alt="Default Profile Image">
							</c:otherwise>
						</c:choose>
						<span class="avatar-badge">Change Photo</span>
					</label>
				</div>

				<h1 class="profile-title">My Profile</h1>
				<div class="profile-subtitle">Manage your personal information</div>
			</div>

			<c:if test="${not empty success}">
				<div class="message success">
					<c:out value="${success}" />
				</div>
			</c:if>

			<c:if test="${not empty error}">
				<div class="message error">
					<c:out value="${error}" />
				</div>
			</c:if>

			<form id="profileForm" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">

				<input type="file" id="profilePic" name="profilePic" accept="image/*" hidden>

				<div class="status-box">
					<div class="status-labels">
						<span>Account Status:</span>
						<span>Account Type:</span>
					</div>

					<div class="status-values">
						<span class="badge badge-approved">
							<c:out value="${empty user.status ? 'approved' : user.status}" />
						</span>
						<span class="badge badge-role">
							<c:out value="${empty user.role ? 'user' : user.role}" />
						</span>
					</div>
				</div>

				<div class="field-group">
					<label class="field-label" for="fullName">Full Name</label>
					<div class="field-wrap">
						<span class="field-icon">
							
						</span>
						<input class="field-input" type="text" id="fullName" name="fullName"
						       value="${user.fullName}" placeholder="Enter your full name" required>
					</div>
				</div>

				<div class="field-group">
					<label class="field-label" for="username">Username</label>
					<div class="field-wrap">
						<span class="field-icon">
							
						</span>
						<input class="field-input" type="text" id="username" name="username"
						       value="${user.username}" placeholder="Enter your username" required>
					</div>
				</div>

				<div class="field-group">
					<label class="field-label" for="email">Email Address</label>
					<div class="field-wrap">
						<span class="field-icon">
							
						</span>
						<input class="field-input" type="email" id="email" name="email"
						       value="${user.email}" placeholder="Enter your email address" required>
					</div>
				</div>

				<div class="field-group">
					<label class="field-label" for="phone">Phone Number</label>
					<div class="field-wrap">
						<span class="field-icon">
							
						</span>
						<input class="field-input" type="text" id="phone" name="phone"
						       value="${user.phone}" placeholder="Enter your phone number" required>
					</div>
				</div>

				<button type="submit" class="submit-btn">Update Profile</button>
			</form>
		</section>
	</main>

</div>

</body>
</html>