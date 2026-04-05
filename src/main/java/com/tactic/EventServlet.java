package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/event/create")
public class EventServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session — user must be logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../auth.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        String eventName  = request.getParameter("event_name");
        String eventType  = request.getParameter("event_type");
        String eventDate  = request.getParameter("event_date");
        String eventTime  = request.getParameter("event_time");
        String location   = request.getParameter("location");
        String guestStr   = request.getParameter("guest_count");

        // Basic server-side validation
        if (eventName == null || eventName.trim().isEmpty() ||
                eventType == null || eventType.trim().isEmpty() ||
                eventDate == null || eventDate.trim().isEmpty() ||
                eventTime == null || eventTime.trim().isEmpty()) {
            response.sendRedirect("../create-event.html?error=missing");
            return;
        }

        int guestCount = 0;
        try {
            guestCount = Integer.parseInt(guestStr);
        } catch (NumberFormatException e) {
            guestCount = 0;
        }

        // Handle optional location
        if (location == null) location = "";

        try {
            int eventId = eventDAO.createEvent(
                    user.getUserId(), eventName.trim(), eventType,
                    eventDate, eventTime, location.trim(), guestCount
            );

            if (eventId == -1) {
                response.sendRedirect("../create-event.html?error=server");
            } else {
                // Redirect to event detail page (we'll build this later)
                response.sendRedirect("../event/detail?id=" + eventId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../create-event.html?error=server");
        }
    }
}