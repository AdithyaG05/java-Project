<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2>Reports</h2>

<a href="reports?type=pending">Students with Pending Fees</a><br><br>

<form action="reports" method="get">
Room Number: <input type="text" name="room">
<input type="hidden" name="type" value="room">
<input type="submit" value="Search">
</form>

<br>

<form action="reportByDate" method="post">
Start Date: <input type="date" name="start"><br>
End Date: <input type="date" name="end"><br>
<input type="submit" value="Search">
</form>

</body>
</html>