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
 * Servlet implementation class ReportServlet
 */
@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private HostelDAO dao;

    public void init() { dao = new HostelDAO(); }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            String type = req.getParameter("type");

            if ("pending".equals(type)) {
                req.setAttribute("list", dao.getPendingFees());
            } else if ("room".equals(type)) {
                req.setAttribute("list",
                    dao.getStudentsByRoom(req.getParameter("room")));
            }

            RequestDispatcher rd = req.getRequestDispatcher("report_result.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}