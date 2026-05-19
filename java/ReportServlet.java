package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ReportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String type = req.getParameter("reportType");
        HostelDAO dao = new HostelDAO();
        List<Student> results = null;
        String reportTitle = "";
        String errorMsg = null;

        try {
            switch (type) {
                case "pending":
                    results = dao.getStudentsWithPendingFees();
                    reportTitle = "Students with Pending Fees";
                    break;

                case "room":
                    String room = req.getParameter("roomNumber");
                    if (room == null || room.trim().isEmpty()) {
                        errorMsg = "Please enter a room number.";
                    } else {
                        results = dao.getStudentsByRoom(room.trim());
                        reportTitle = "Students in Room: " + room.trim();
                    }
                    break;

                case "daterange":
                    String fromStr = req.getParameter("fromDate");
                    String toStr   = req.getParameter("toDate");
                    if (fromStr == null || toStr == null || fromStr.isEmpty() || toStr.isEmpty()) {
                        errorMsg = "Please provide both From and To dates.";
                    } else {
                        Date from = Date.valueOf(fromStr);
                        Date to   = Date.valueOf(toStr);
                        results = dao.getStudentsByDateRange(from, to);
                        reportTitle = "Students Admitted: " + fromStr + " to " + toStr;
                    }
                    break;

                default:
                    errorMsg = "Unknown report type selected.";
            }
        } catch (Exception e) {
            errorMsg = "Error generating report: " + e.getMessage();
        }

        req.setAttribute("reportTitle",  reportTitle);
        req.setAttribute("reportResults", results);
        req.setAttribute("errorMsg",     errorMsg);
        req.getRequestDispatcher("report_result.jsp").forward(req, res);
    }
}
