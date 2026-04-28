<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="com.madel.Student" %>
<%= request.getAttribute("list") %>

<html>
<head>
    <title>Student Display</title>
</head>
<body>

<h2>Student List</h2>

<table border="1">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Room</th>
    <th>Date</th>
    <th>Fees Paid</th>
    <th>Pending Fees</th>
</tr>

<%
List<Student> list = (List<Student>) request.getAttribute("list");

if (list != null && !list.isEmpty()) {
    for (Student s : list) {
%>
<tr>
    <td><%= s.getStudentID() %></td>
    <td><%= s.getStudentName() %></td>
    <td><%= s.getRoomNumber() %></td>
    <td><%= s.getAdmissionDate() %></td>
    <td><%= s.getFeesPaid() %></td>
    <td><%= s.getPendingFees() %></td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="6">No students found</td>
</tr>
<%
}
%>

</table>

</body>
</html>