<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student – HMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Update Student Record</h2>
            <p class="subtitle">Search by Student ID and edit the record</p>
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

    <!-- Search Panel -->
    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-title"><span class="icon">&#128269;</span> Lookup Student</div>
        <form action="UpdateStudentServlet" method="get" class="search-row">
            <input type="number" name="studentID" placeholder="Enter Student ID to search..." required min="1">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <%-- Edit Form --%>
    <%
        Student s = (Student) request.getAttribute("student");
        if (s != null) {
    %>
    <div class="card">
        <div class="card-title"><span class="icon">&#9998;</span> Edit Record – ID: <%= s.getStudentID() %></div>
        <form action="UpdateStudentServlet" method="post">
            <input type="hidden" name="studentID" value="<%= s.getStudentID() %>">
            <div class="form-grid">
                <div class="form-group">
                    <label>Student ID</label>
                    <input type="text" value="<%= s.getStudentID() %>" disabled
                           style="background:#f0ead8; color:var(--text-mid);">
                </div>
                <div class="form-group">
                    <label for="studentName">Full Name <span style="color:#c0392b">*</span></label>
                    <input type="text" id="studentName" name="studentName"
                           value="<%= s.getStudentName() %>" required>
                </div>
                <div class="form-group">
                    <label for="roomNumber">Room Number <span style="color:#c0392b">*</span></label>
                    <input type="text" id="roomNumber" name="roomNumber"
                           value="<%= s.getRoomNumber() %>" required>
                </div>
                <div class="form-group">
                    <label for="admissionDate">Admission Date <span style="color:#c0392b">*</span></label>
                    <input type="date" id="admissionDate" name="admissionDate"
                           value="<%= s.getAdmissionDate() %>" required>
                </div>
                <div class="form-group">
                    <label for="feesPaid">Fees Paid (₹)</label>
                    <input type="number" id="feesPaid" name="feesPaid"
                           value="<%= s.getFeesPaid() %>" step="0.01" min="0" required>
                </div>
                <div class="form-group">
                    <label for="pendingFees">Pending Fees (₹)</label>
                    <input type="number" id="pendingFees" name="pendingFees"
                           value="<%= s.getPendingFees() %>" step="0.01" min="0" required>
                </div>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">&#10003; &nbsp;Save Changes</button>
                <a href="studentupdate.jsp" class="btn btn-outline">&#8592; &nbsp;Clear</a>
            </div>
        </form>
    </div>
    <% } else { %>
    <div class="card">
        <div class="empty-state">
            <div class="es-icon">&#128203;</div>
            <p>Enter a Student ID above to load and edit the record.</p>
        </div>
    </div>
    <% } %>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
