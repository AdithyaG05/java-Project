<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*, com.madel.Student" %>
<html>
<body>
<h2>Report Results</h2>

<table border="1">
<tr>
<th>ID</th><th>Name</th><th>Room</th>
<th>Date</th><th>Paid</th><th>Pending</th>
</tr>

<%
List<Student> list = (List<Student>) request.getAttribute("list");
if (list != null) {
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
}
%>

</table>

</body>
</html>