package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/event/detail")
public class EventDetailServlet extends HttpServlet {

    private EventDAO eventDAO = new EventDAO();
    private GuestDAO guestDAO = new GuestDAO();
    private BudgetDAO budgetDAO = new BudgetDAO();
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../auth.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("../home");
            return;
        }

        try {
            int eventId = Integer.parseInt(idParam);
            Event event = eventDAO.getEventById(eventId, user.getUserId());

            if (event == null) {
                // Either not found or doesn't belong to this user
                response.sendRedirect("../home");
                return;
            }

            // Fetch related data
            List<Guest> guests = guestDAO.getGuestsByEvent(eventId);
            Budget budget = budgetDAO.getBudgetByEvent(eventId);
            List<Booking> bookings = bookingDAO.getBookingsForEvent(eventId);

            request.setAttribute("event", event);
            request.setAttribute("guests", guests);
            request.setAttribute("guestCount", guests.size());
            request.setAttribute("budget", budget);
            request.setAttribute("bookings", bookings);

            request.getRequestDispatcher("/event-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("../home");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("../home");
        }
    }
}