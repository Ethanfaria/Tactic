package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            List<Event> events = eventDAO.getEventsByUser(user.getUserId());
            request.setAttribute("events", events);
            request.setAttribute("userName", user.getUsername());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/auth.html");
        }
    }
}