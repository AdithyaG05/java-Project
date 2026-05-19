<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Report – HMS</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .panel { display:none; }
        .panel.active { display:block; }
        .report-opt { cursor:pointer; }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<main>
    <div class="page-header">
        <div>
            <h2>Report Generation</h2>
            <p class="subtitle">Select a report type and provide the required criteria</p>
            <div class="gold-line"></div>
        </div>
    </div>

    <div class="card">
        <div class="card-title"><span class="icon">&#128200;</span> Select Report Type</div>

        <div class="report-options" id="reportOptions">
            <div class="report-opt" onclick="selectReport('pending')" id="opt-pending">
                <div style="font-size:1.6rem; margin-bottom:0.5rem;">&#128176;</div>
                <h4>Pending Fees</h4>
                <p>Students with outstanding fee dues</p>
            </div>
            <div class="report-opt" onclick="selectReport('room')" id="opt-room">
                <div style="font-size:1.6rem; margin-bottom:0.5rem;">&#127968;</div>
                <h4>Room Occupancy</h4>
                <p>All students assigned to a specific room</p>
            </div>
            <div class="report-opt" onclick="selectReport('daterange')" id="opt-daterange">
                <div style="font-size:1.6rem; margin-bottom:0.5rem;">&#128197;</div>
                <h4>Admission Period</h4>
                <p>Students admitted within a date range</p>
            </div>
        </div>

        <!-- Panel: Pending Fees (no params needed) -->
        <form action="ReportServlet" method="post">
            <input type="hidden" name="reportType" value="pending">
            <div class="panel" id="panel-pending">
                <div class="alert" style="background:#f0f4ff; border-color:var(--navy-light); color:var(--navy);">
                    &#8505;&nbsp; This report lists all students who have a pending fee amount greater than zero.
                    No additional input is required.
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">&#128200; &nbsp;Generate Report</button>
                </div>
            </div>
        </form>

        <!-- Panel: Room -->
        <form action="ReportServlet" method="post">
            <input type="hidden" name="reportType" value="room">
            <div class="panel" id="panel-room">
                <div class="form-grid" style="max-width:420px; margin-bottom:1.25rem;">
                    <div class="form-group full">
                        <label for="roomNumber">Room Number <span style="color:#c0392b">*</span></label>
                        <input type="text" id="roomNumber" name="roomNumber" placeholder="e.g. A-101" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">&#128200; &nbsp;Generate Report</button>
                </div>
            </div>
        </form>

        <!-- Panel: Date Range -->
        <form action="ReportServlet" method="post">
            <input type="hidden" name="reportType" value="daterange">
            <div class="panel" id="panel-daterange">
                <div class="form-grid" style="max-width:600px; margin-bottom:1.25rem;">
                    <div class="form-group">
                        <label for="fromDate">From Date <span style="color:#c0392b">*</span></label>
                        <input type="date" id="fromDate" name="fromDate" required>
                    </div>
                    <div class="form-group">
                        <label for="toDate">To Date <span style="color:#c0392b">*</span></label>
                        <input type="date" id="toDate" name="toDate" required>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">&#128200; &nbsp;Generate Report</button>
                </div>
            </div>
        </form>

    </div>
</main>

<%@ include file="footer.jsp" %>

<script>
    function selectReport(type) {
        // Clear all option highlights
        document.querySelectorAll('.report-opt').forEach(el => el.classList.remove('selected'));
        document.querySelectorAll('.panel').forEach(el => el.classList.remove('active'));
        // Activate selected
        document.getElementById('opt-' + type).classList.add('selected');
        document.getElementById('panel-' + type).classList.add('active');
    }
</script>
</body>
</html>
