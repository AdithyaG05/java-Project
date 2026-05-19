<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student, com.dao.HostelDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student – HMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Delete Student Record</h2>
            <p class="subtitle">Permanently remove a student from the hostel database</p>
            <div class="gold-line"></div>
        </div>
    </div>

    <%-- Flash Message --%>
    <%
        String flash = (String) session.getAttribute("flashMsg");
        if (flash != null) {
            session.removeAttribute("flashMsg");
            String[] parts = flash.split("\\|", 2);
            String type = parts[0]; String msg = parts[1];
            String cls = "success".equals(type) ? "alert-success" : "alert-error";
            String icon = "success".equals(type) ? "&#10004;" : "&#9888;";
    %>
        <div class="alert <%= cls %>"><%= icon %>&nbsp;<%= msg %></div>
    <%  } %>

    <!-- Step 1: Search Panel -->
    <div class="card" style="max-width:560px; margin-bottom:1.5rem;">
        <div class="card-title" style="color:#c0392b;">
            <span class="icon">&#128269;</span> Lookup Student Before Deleting
        </div>
        <form action="studentdelete.jsp" method="get" class="search-row">
            <input type="number" name="studentID" placeholder="Enter Student ID to preview..." required min="1"
                   value="<%= request.getParameter("studentID") != null ? request.getParameter("studentID") : "" %>">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <%-- Step 2: Show student info if ID provided --%>
    <%
        String idParam = request.getParameter("studentID");
        Student s = null;
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                s = new HostelDAO().getStudentByID(Integer.parseInt(idParam.trim()));
            } catch (NumberFormatException e) { }
        }

        if (idParam != null && !idParam.trim().isEmpty()) {
            if (s == null) {
    %>
        <div class="alert alert-error">&#9888;&nbsp; No student found with ID <strong><%= idParam %></strong>.</div>
    <%
            } else {
    %>
    <!-- Student Info Preview Card -->
    <div class="card" style="max-width:560px;">
        <div class="card-title"><span class="icon">&#128100;</span> Student Found – Confirm Deletion</div>

        <!-- Info Grid -->
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:1rem; margin-bottom:1.5rem;
                    background:#fdf8f0; border:1px solid var(--border); border-radius:8px; padding:1.25rem;">
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Student ID</p>
                <p style="font-weight:700; color:var(--navy); font-size:1rem;"><%= s.getStudentID() %></p>
            </div>
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Full Name</p>
                <p style="font-weight:600; color:var(--navy);"><%= s.getStudentName() %></p>
            </div>
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Room Number</p>
                <p style="font-weight:600; color:var(--navy);"><%= s.getRoomNumber() %></p>
            </div>
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Admission Date</p>
                <p style="font-weight:600; color:var(--navy);"><%= s.getAdmissionDate() %></p>
            </div>
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Fees Paid</p>
                <p style="font-weight:600; color:var(--success-txt);">&#8377; <%= String.format("%.2f", s.getFeesPaid()) %></p>
            </div>
            <div>
                <p style="font-size:0.75rem; text-transform:uppercase; letter-spacing:0.08em;
                          color:var(--text-light); margin-bottom:0.2rem;">Pending Fees</p>
                <p style="font-weight:600; color:<%= s.getPendingFees() > 0 ? "#c0392b" : "var(--success-txt)" %>;">
                    &#8377; <%= String.format("%.2f", s.getPendingFees()) %>
                    <%= s.getPendingFees() > 0 ? " &#9888;" : " &#10004;" %>
                </p>
            </div>
        </div>

        <!-- Warning -->
        <div class="alert" style="background:#fdf2f2; border-color:#c0392b; color:#922b21; margin-bottom:1.5rem;">
            &#9888;&nbsp; You are about to <strong>permanently delete</strong> this record.
            This action <strong>cannot be undone</strong>.
        </div>

        <!-- Delete Form -->
        <form action="DeleteStudentServlet" method="post"
              onsubmit="return confirm('Delete <%= s.getStudentName() %> (ID: <%= s.getStudentID() %>)? This cannot be undone.');">
            <input type="hidden" name="studentID" value="<%= s.getStudentID() %>">
            <div class="form-actions">
                <button type="submit" class="btn btn-danger">&#10006; &nbsp;Yes, Delete This Student</button>
                <a href="studentdelete.jsp" class="btn btn-outline">&#8592; &nbsp;Cancel</a>
            </div>
        </form>
    </div>
    <%
            }
        }
    %>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>