package com.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.HostelDAO;

/**
 * Servlet implementation class ReportCriteriaServlet
 */
@WebServlet("/reportByDate")
public class ReportCriteriaServlet extends HttpServlet {
    private HostelDAO dao;

    public void init() { dao = new HostelDAO(); }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            Date start = Date.valueOf(req.getParameter("start"));
            Date end = Date.valueOf(req.getParameter("end"));

            req.setAttribute("list", dao.getStudentsByDate(start, end));
            RequestDispatcher rd = req.getRequestDispatcher("report_result.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}