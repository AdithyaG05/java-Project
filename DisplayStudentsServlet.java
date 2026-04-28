package com.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.HostelDAO;

/**
 * Servlet implementation class DisplayStudentsServlet
 */
@WebServlet("/displayStudents")

public class DisplayStudentsServlet extends HttpServlet {
    private HostelDAO dao;

    public void init() { dao = new HostelDAO(); }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // 🔴 ADD HERE
            System.out.println(">>> DisplayStudentsServlet HIT <<<");

            req.setAttribute("list", dao.getAllStudents());
            RequestDispatcher rd = req.getRequestDispatcher("studentdisplay.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}