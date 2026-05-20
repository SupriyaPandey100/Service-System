<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Technician | HomeService</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root { --primary: #0066FF; --sidebar-dark: #1e293b; --bg-light: #f8fafc; --text-main: #334155; --success: #10b981; --error: #ef4444; --border: #e2e8f0; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: var(--bg-light); display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px; }
        .upload-card { background: white; padding: 2.5rem; border-radius: 20px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02); width: 100%; max-width: 480px; text-align: center; border: 1px solid rgba(226, 232, 240, 0.8); }
        h2 { color: var(--sidebar-dark); font-weight: 700; margin-bottom: 0.5rem; }
        .subtitle { color: #64748b; font-size: 0.9rem; margin-bottom: 1.5rem; }
        .alert { padding: 12px; border-radius: 10px; margin-bottom: 1.5rem; font-size: 0.85rem; font-weight: 500; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .alert-error { background: #fef2f2; color: var(--error); border: 1px solid #fee2e2; }
        .input-group { text-align: left; margin-bottom: 1.2rem; }
        .input-group label { display: block; font-size: 0.85rem; font-weight: 600; color: #64748b; margin-bottom: 6px; margin-left: 4px; }
        .input-group label .required { color: #ef4444; }
        .input-group input, .input-group select { width: 100%; padding: 12px 16px; border-radius: 12px; border: 1px solid var(--border); font-family: inherit; font-size: 0.95rem; color: var(--text-main); box-sizing: border-box; transition: all 0.2s; background: #fcfdfe; }
        .input-group input:focus, .input-group select:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 4px rgba(0, 102, 255, 0.1); background: white; }
        .row { display: flex; gap: 15px; }
        .row .input-group { flex: 1; }
        .btn-submit { background-color: var(--primary); color: white; border: none; padding: 14px; border-radius: 12px; font-size: 1rem; font-weight: 600; cursor: pointer; width: 100%; transition: transform 0.2s, background 0.2s; box-shadow: 0 4px 14px 0 rgba(0, 102, 255, 0.39); margin-top: 10px; }
        .btn-submit:hover { background-color: #0052CC; transform: translateY(-1px); }
        .back-link { display: inline-block; margin-top: 1.5rem; color: #64748b; text-decoration: none; font-size: 0.9rem; font-weight: 500; transition: color 0.2s; }
        .back-link:hover { color: var(--primary); }
    </style>
</head>
<body>

    <div class="upload-card">
        <h2>Edit Technician</h2>
        <p class="subtitle">Update technician details</p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="edittechnician" method="post">
            <input type="hidden" name="technician_id" value="${technician.technicianId}">

            <div class="input-group">
                <label>Full Name <span class="required">*</span></label>
                <input type="text" name="full_name" value="${technician.fullName}" placeholder="Enter full name">
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" name="email" value="${technician.email}" placeholder="Enter email">
                </div>
                <div class="input-group">
                    <label>Phone <span class="required">*</span></label>
                    <input type="tel" name="phone" value="${technician.phone}" placeholder="10 digits">
                </div>
            </div>

            <div class="input-group">
                <label>Services <span class="required">*</span></label>
                <input type="text" name="services" value="${technician.services}" placeholder="e.g., Plumbing, Electrical">
            </div>

            <div class="row">
                <div class="input-group">
                    <label>Completed Jobs</label>
                    <input type="number" name="completed_jobs" min="0" value="${technician.completedJobs}" placeholder="Jobs completed">
                </div>
                <div class="input-group">
                    <label>Status</label>
                    <select name="status">
                        <option value="active" ${technician.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${technician.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Update Technician
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/managetechnician" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Technicians
        </a>
    </div>

</body>
</html>