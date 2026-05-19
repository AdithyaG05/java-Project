package com.servlet;

import com.dao.HostelDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("studentID");
        try {
            int id = Integer.parseInt(idParam.trim());
            boolean ok = new HostelDAO().deleteStudent(id);
            req.getSession().setAttribute("flashMsg", ok
                ? "success|Student with ID " + id + " deleted successfully."
                : "error|No student found with ID " + id + ".");
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("flashMsg", "error|Invalid Student ID.");
        }
        res.sendRedirect("studentdelete.jsp");
    }
}
