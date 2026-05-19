package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class AddStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
        //    int    id        = Integer.parseInt(req.getParameter("studentID").trim());
            String name      = req.getParameter("studentName").trim();
            String room      = req.getParameter("roomNumber").trim();
            Date   admDate   = Date.valueOf(req.getParameter("admissionDate"));
            double paid      = Double.parseDouble(req.getParameter("feesPaid").trim());
            double pending   = Double.parseDouble(req.getParameter("pendingFees").trim());

            Student s = new Student();
            s.setStudentName(name);
            s.setRoomNumber(room);
            s.setAdmissionDate(admDate);
            s.setFeesPaid(paid);
            s.setPendingFees(pending);
            boolean ok = new HostelDAO().addStudent(s);

            req.getSession().setAttribute("flashMsg",  ok
                ? "success|Student registered successfully."
                : "error|Failed to add student. ID may already exist.");
        } catch (Exception e) {
            req.getSession().setAttribute("flashMsg", "error|Invalid input: " + e.getMessage());
        }
        res.sendRedirect("studentadd.jsp");
    }
}
