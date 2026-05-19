<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student" %>
<%@ page import="com.dao.HostelDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student – HMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Student Registration</h2>
            <p class="subtitle">Add a new student to the hostel database</p>
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

    <div class="card">
        <div class="card-title">
            <span class="icon">&#43;</span> New Student Details
        </div>

        <form action="AddStudentServlet" method="post">
            <div class="form-grid">
             <div class="form-group">
             <%HostelDAO h = new HostelDAO();
             int id = h.getStudentID(); %>
             
                    <label for="studentID">Student ID <span style="color:#c0392b">*</span></label>
                    <input type="text" id="studentID" name="studentID" value ="<%=id%>" placeholder="e.g. 1001" required min="1" disabled>
                </div>  
                
                <div class="form-group">
                    <label for="studentName">Full Name <span style="color:#c0392b">*</span></label>
                    <input type="text" id="studentName" name="studentName" placeholder="Enter full name" required>
                </div>
                <div class="form-group">
                    <label for="roomNumber">Room Number <span style="color:#c0392b">*</span></label>
                    <input type="number" id="roomNumber" step="1" name="roomNumber" placeholder="e.g. A-101" required>
                </div>
                <div class="form-group">
                    <label for="admissionDate">Admission Date <span style="color:#c0392b">*</span></label>
                    <input type="date" id="admissionDate" name="admissionDate" required>
                </div>
                <div class="form-group">
                    <label for="feesPaid">Fees Paid (₹) <span style="color:#c0392b">*</span></label>
                    <input type="number" id="feesPaid" name="feesPaid" placeholder="0.00" step="1000" min="0" required>
                </div>
                <div class="form-group">
                    <label for="pendingFees">Pending Fees (₹) <span style="color:#c0392b">*</span></label>
                    <input type="number" id="pendingFees" name="pendingFees" placeholder="0.00" step="1000" min="0" required>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">&#10003; &nbsp;Register Student</button>
                <button type="reset"  class="btn btn-outline">&#8635; &nbsp;Reset Form</button>
                <a href="index.jsp" class="btn btn-outline">&#8592; &nbsp;Back to Dashboard</a>
            </div>
        </form>
    </div>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>
