<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <!-- Hero Banner -->
    <div style="background: linear-gradient(135deg, var(--navy) 0%, var(--navy-light) 100%);
                border-radius: 14px; padding: 2.8rem 3rem; margin-bottom: 2.5rem;
                display: flex; align-items: center; justify-content: space-between; color: white;
                box-shadow: var(--shadow);">
        <div>
            <p style="font-size:0.82rem; letter-spacing:0.14em; text-transform:uppercase;
                      color:var(--gold-light); margin-bottom:0.5rem;">Welcome to</p>
            <h2 style="font-family:'Playfair Display',serif; font-size:2.1rem; margin-bottom:0.6rem;">
                Hostel Management System
            </h2>
            <p style="font-size:0.95rem; color:rgba(255,255,255,0.7); max-width: 500px;">
                A centralised platform for managing student admissions, room allocations,
                fee records, and generating insightful occupancy reports.
            </p>
        </div>
        <div style="font-size:4rem; opacity:0.18;">&#127968;</div>
    </div>

    <!-- Module Cards -->
    <h3 style="font-family:'Playfair Display',serif; font-size:1.1rem; color:var(--navy);
               margin-bottom:1.25rem; letter-spacing:0.02em;">Quick Access Modules</h3>

    <div class="dash-grid">
        <a href="studentadd.jsp" class="dash-card">
            <div class="dc-icon dc-gold">&#43;</div>
            <div class="dc-body">
                <h3>Add Student</h3>
                <p>Register a new hostel resident and assign a room</p>
            </div>
        </a>
        <a href="studentupdate.jsp" class="dash-card">
            <div class="dc-icon dc-navy">&#9998;</div>
            <div class="dc-body">
                <h3>Update Record</h3>
                <p>Modify existing student information or fee status</p>
            </div>
        </a>
        <a href="studentdelete.jsp" class="dash-card">
            <div class="dc-icon dc-red">&#10006;</div>
            <div class="dc-body">
                <h3>Delete Student</h3>
                <p>Remove a student record from the system</p>
            </div>
        </a>
        <a href="DisplayStudentsServlet" class="dash-card">
            <div class="dc-icon dc-navy">&#128203;</div>
            <div class="dc-body">
                <h3>View Students</h3>
                <p>Browse all residents or search by student ID</p>
            </div>
        </a>
        <a href="report_form.jsp" class="dash-card">
            <div class="dc-icon dc-green">&#128200;</div>
            <div class="dc-body">
                <h3>Reports</h3>
                <p>Generate fee, room-wise, and admission reports</p>
            </div>
        </a>
    </div>

    <!-- Info Section -->
    <div class="card">
        <div class="card-title">
            <span class="icon">&#8505;</span> System Information
        </div>
        <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:1.5rem;">
            <div>
                <p style="font-size:0.78rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.3rem;">Database</p>
                <p style="font-weight:600; color:var(--navy);">MySQL – hosteldb</p>
            </div>
            <div>
                <p style="font-size:0.78rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.3rem;">Server</p>
                <p style="font-weight:600; color:var(--navy);">Apache Tomcat 9</p>
            </div>
            <div>
                <p style="font-size:0.78rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.3rem;">Table</p>
                <p style="font-weight:600; color:var(--navy);">HostelStudents</p>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
