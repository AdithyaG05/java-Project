package com.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.dao.HostelDAO;
import com.madel.Student;

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {
    private HostelDAO dao;

    public void init() { 
        dao = new HostelDAO(); 
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            Student s = new Student(
                Integer.parseInt(req.getParameter("id")),
                req.getParameter("name"),
                req.getParameter("room"),
                Date.valueOf(req.getParameter("date")),
                Double.parseDouble(req.getParameter("paid")),
                Double.parseDouble(req.getParameter("pending"))
            );

            dao.updateStudent(s);

            // ✅ Correct redirect
            res.sendRedirect("displaystudents");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}