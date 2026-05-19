package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DisplayStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("studentID");
        HostelDAO dao  = new HostelDAO();

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                Student s = dao.getStudentByID(Integer.parseInt(idParam.trim()));
                req.setAttribute("singleStudent", s);
                if (s == null)
                    req.setAttribute("noResult", "No student found with ID " + idParam.trim());
            } catch (NumberFormatException e) {
                req.setAttribute("noResult", "Invalid Student ID entered.");
            }
        } else {
            List<Student> list = dao.getAllStudents();
            req.setAttribute("studentList", list);
        }

        req.getRequestDispatcher("studentdisplay.jsp").forward(req, res);
    }
}
