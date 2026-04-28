<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2>Update Student</h2>
<form action="<%= request.getContextPath() %>/updateStudent" method="post">
ID: <input type="text" name="id"><br>
Name: <input type="text" name="name"><br>
Room: <input type="text" name="room"><br>
Date: <input type="date" name="date"><br>
Fees Paid: <input type="text" name="paid"><br>
Pending Fees: <input type="text" name="pending"><br>
<input type="submit" value="Update">
</form>
</body>
</html>