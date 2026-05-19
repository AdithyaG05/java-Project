<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Students – HMS</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Student Directory</h2>
            <p class="subtitle">View all registered hostel students or search by ID</p>
            <div class="gold-line"></div>
        </div>
        <div style="margin-left:auto;">
            <a href="studentadd.jsp" class="btn btn-gold btn-sm">&#43; &nbsp;Add New Student</a>
        </div>
    </div>

    <!-- Search -->
    <div class="card" style="margin-bottom:1.5rem; padding:1.4rem 2rem;">
        <form action="DisplayStudentsServlet" method="get" class="search-row">
            <input type="number" name="studentID" placeholder="Search by Student ID (leave blank for all)..." min="1">
            <button type="submit" class="btn btn-primary">Search</button>
            <a href="DisplayStudentsServlet" class="btn btn-outline">Show All</a>
        </form>
    </div>

    <%
        String noResult  = (String)  request.getAttribute("noResult");
        Student single   = (Student) request.getAttribute("singleStudent");
        List<Student> list = (List<Student>) request.getAttribute("studentList");

        if (noResult != null) {
    %>
        <div class="alert alert-error">&#9888;&nbsp;<%= noResult %></div>
    <% } else if (single != null) { %>

    <!-- Single Student -->
    <div class="card">
        <div class="card-title"><span class="icon">&#128100;</span> Student Profile</div>
        <table>
            <thead>
                <tr>
                    <th>Student ID</th><th>Full Name</th><th>Room No.</th>
                    <th>Admission Date</th><th>Fees Paid (₹)</th><th>Pending Fees (₹)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong><%= single.getStudentID() %></strong></td>
                    <td><%= single.getStudentName() %></td>
                    <td><span class="badge badge-ok"><%= single.getRoomNumber() %></span></td>
                    <td><%= single.getAdmissionDate() %></td>
                    <td>&#8377; <%= String.format("%.2f", single.getFeesPaid()) %></td>
                    <td>
                        <% if (single.getPendingFees() > 0) { %>
                            <span class="badge badge-warn">&#8377; <%= String.format("%.2f", single.getPendingFees()) %></span>
                        <% } else { %>
                            <span class="badge badge-ok">Nil</span>
                        <% } %>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="margin-top:1.25rem; display:flex; gap:0.75rem;">
            <a href="UpdateStudentServlet?studentID=<%= single.getStudentID() %>" class="btn btn-primary btn-sm">&#9998; &nbsp;Edit</a>
            <a href="studentdelete.jsp?studentID=<%= single.getStudentID() %>" class="btn btn-danger btn-sm">&#10006; &nbsp;Delete</a>
            <a href="DisplayStudentsServlet" class="btn btn-outline btn-sm">&#8592; All Students</a>
        </div>
    </div>

    <% } else if (list != null) { %>

    <!-- All Students Table -->
    <div class="card" style="padding:0; overflow:hidden;">
        <div style="padding:1.5rem 2rem; border-bottom:1px solid var(--border);
                    display:flex; align-items:center; justify-content:space-between;">
            <div class="card-title" style="margin:0; border:none; padding:0;">
                <span class="icon">&#128203;</span> All Students
            </div>
            <span style="font-size:0.85rem; color:var(--text-light);">
                Total: <strong><%= list.size() %></strong> student(s)
            </span>
        </div>

        <% if (list.isEmpty()) { %>
        <div class="empty-state">
            <div class="es-icon">&#128203;</div>
            <p>No students found in the database.</p>
        </div>
        <% } else { %>
        <div class="table-wrap" style="border:none; border-radius:0;">
            <table>
                <thead>
                    <tr>
                        <th>#</th><th>Student ID</th><th>Full Name</th><th>Room No.</th>
                        <th>Admission Date</th><th>Fees Paid (₹)</th><th>Pending (₹)</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% int sno = 1; for (Student stu : list) { %>
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
                        <td>
                            <a href="UpdateStudentServlet?studentID=<%= stu.getStudentID() %>"
                               class="btn btn-primary btn-sm">&#9998;</a>
                            <a href="studentdelete.jsp?studentID=<%= stu.getStudentID() %>"
                               class="btn btn-danger btn-sm" style="margin-left:0.35rem;">&#10006;</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>

    <% } %>
</main>

<%@ include file="footer.jsp" %>
</body>
</html>   