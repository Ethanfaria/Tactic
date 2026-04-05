package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/event/edit")
public class EditEventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../auth.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        String idParam = request.getParameter("id");
        String ctx = request.getContextPath();
        if (idParam == null) { response.sendRedirect(ctx + "/home"); return; }

        try {
            int eventId = Integer.parseInt(idParam);
            Event event = eventDAO.getEventById(eventId, user.getUserId());
            if (event == null) { response.sendRedirect(ctx + "/home"); return; }

            request.setAttribute("event", event);
            request.getRequestDispatcher("/edit-event.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        String ctx = request.getContextPath();

        try {
            int eventId = Integer.parseInt(request.getParameter("event_id"));

            if ("delete".equals(action)) {
                eventDAO.deleteEvent(eventId, user.getUserId());
                response.sendRedirect(ctx + "/home?success=deleted");
                return;
            }

            String eventName  = request.getParameter("event_name");
            String eventType  = request.getParameter("event_type");
            String eventDate  = request.getParameter("event_date");
            String eventTime  = request.getParameter("event_time");
            String location   = request.getParameter("location");
            String guestStr   = request.getParameter("guest_count");

            if (eventName == null || eventName.trim().isEmpty() ||
                    eventType == null || eventDate == null || eventTime == null) {
                response.sendRedirect(ctx + "/event/edit?id=" + eventId + "&error=missing");
                return;
            }

            int guestCount = 0;
            try { guestCount = Integer.parseInt(guestStr); } catch (NumberFormatException ignored) {}
            if (location == null) location = "";

            boolean updated = eventDAO.updateEvent(
                    eventId, user.getUserId(),
                    eventName.trim(), eventType,
                    eventDate, eventTime,
                    location.trim(), guestCount
            );

            if (updated) {
                response.sendRedirect(ctx + "/event/detail?id=" + eventId + "&success=updated");
            } else {
                response.sendRedirect(ctx + "/event/edit?id=" + eventId + "&error=server");
            }

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(ctx + "/home");
        }
    }
}