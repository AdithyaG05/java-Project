<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Results – HMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Report Results</h2>
            <p class="subtitle"><%= request.getAttribute("reportTitle") != null ? request.getAttribute("reportTitle") : "" %></p>
            <div class="gold-line"></div>
        </div>
        <div style="margin-left:auto; display:flex; gap:0.75rem;">
            <a href="report_form.jsp" class="btn btn-outline btn-sm">&#8592; &nbsp;New Report</a>
            <button onclick="window.print()" class="btn btn-primary btn-sm">&#128438; &nbsp;Print</button>
        </div>
    </div>

    <%
        String errorMsg = (String) request.getAttribute("errorMsg");
        if (errorMsg != null) {
    %>
        <div class="alert alert-error">&#9888;&nbsp;<%= errorMsg %></div>
        <div style="margin-top:1rem;">
            <a href="report_form.jsp" class="btn btn-primary">&#8592; Go Back</a>
        </div>
    <%
        } else {
            List<Student> results = (List<Student>) request.getAttribute("reportResults");
            String title = (String) request.getAttribute("reportTitle");
    %>

    <!-- Summary Bar -->
    <div style="background:var(--navy); color:white; border-radius:10px; padding:1rem 1.5rem;
                margin-bottom:1.5rem; display:flex; align-items:center; justify-content:space-between;">
        <div>
            <p style="font-size:0.78rem; color:var(--gold-light); text-transform:uppercase;
                      letter-spacing:0.1em; margin-bottom:0.2rem;">Report</p>
            <p style="font-family:'Playfair Display',serif; font-size:1.05rem;"><%= title %></p>
        </div>
        <div style="text-align:right;">
            <p style="font-size:2rem; font-weight:700; color:var(--gold);"><%= results != null ? results.size() : 0 %></p>
            <p style="font-size:0.78rem; color:rgba(255,255,255,0.6);">Record(s) found</p>
        </div>
    </div>

    <% if (results == null || results.isEmpty()) { %>
    <div class="card">
        <div class="empty-state">
            <div class="es-icon">&#128203;</div>
            <p>No records found matching the selected criteria.</p>
        </div>
    </div>
    <% } else { %>
    <div class="card" style="padding:0; overflow:hidden;">
        <div class="table-wrap" style="border:none; border-radius:0;">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student ID</th>
                        <th>Full Name</th>
                        <th>Room No.</th>
                        <th>Admission Date</th>
                        <th>Fees Paid (₹)</th>
                        <th>Pending Fees (₹)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int sno = 1;
                        double totalPaid = 0, totalPending = 0;
                        for (Student stu : results) {
                            totalPaid    += stu.getFeesPaid();
                            totalPending += stu.getPendingFees();
                    %>
                    <tr>
                        <td style="color:var(--text-light);"><%= sno++ %></td>
                        <td><strong><%= stu.getStudentID() %></strong></td>
                        <td><%= stu.getStudentName() %></td>
                        <td><span class="badge badge-ok"><%= stu.getRoomNumber() %></span></td>
                        <td><%= stu.getAdmissionDate() %></td>
                        <td>&#8377; <%= String.format("%.2f", stu.getFeesPaid()) %></td>
                        <td>
                            <% if (stu.getPendingFees() > 0) { %>
                                <span class="badge badge-warn">&#8377; <%= String.format("%.2f", stu.getPendingFees()) %></span>
                            <% } else { %>
                                <span class="badge badge-ok">Nil</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <!-- Totals Row -->
                    <tr style="background:#f0ead8; font-weight:600; border-top:2px solid var(--border);">
                        <td colspan="5" style="text-align:right; padding-right:1.5rem; color:var(--navy);">
                            Total
                        </td>
                        <td style="color:var(--success-txt);">&#8377; <%= String.format("%.2f", totalPaid) %></td>
                        <td style="color:#c0392b;">&#8377; <%= String.format("%.2f", totalPending) %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <% } %>
    <% } %>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
