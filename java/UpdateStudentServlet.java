package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class UpdateStudentServlet extends HttpServlet {

    // GET – load student data into form
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("studentID");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                Student s = new HostelDAO().getStudentByID(Integer.parseInt(idParam.trim()));
                req.setAttribute("student", s);
                if (s == null)
                    req.getSession().setAttribute("flashMsg", "error|No student found with ID " + idParam);
            } catch (NumberFormatException e) {
                req.getSession().setAttribute("flashMsg", "error|Invalid Student ID.");
            }
        }
        req.getRequestDispatcher("studentupdate.jsp").forward(req, res);
    }

    // POST – save updated data
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int    id      = Integer.parseInt(req.getParameter("studentID").trim());
            String name    = req.getParameter("studentName").trim();
            String room    = req.getParameter("roomNumber").trim();
            Date   admDate = Date.valueOf(req.getParameter("admissionDate"));
            double paid    = Double.parseDouble(req.getParameter("feesPaid").trim());
            double pending = Double.parseDouble(req.getParameter("pendingFees").trim());

            Student s  = new Student(id, name, room, admDate, paid, pending);
            boolean ok = new HostelDAO().updateStudent(s);

            req.getSession().setAttribute("flashMsg", ok
                ? "success|Student record updated successfully."
                : "error|Update failed. Student may not exist.");
        } catch (Exception e) {
            req.getSession().setAttribute("flashMsg", "error|Invalid input: " + e.getMessage());
        }
        res.sendRedirect("studentupdate.jsp");
    }
}
