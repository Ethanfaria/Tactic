package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");
        String role     = request.getParameter("role");

        // Default to customer if role not provided
        if (role == null || role.isEmpty()) role = "customer";

        try {
            User user = userDAO.registerUser(username, email, phone, password, role);

            if (user == null) {
                // Duplicate email/username/phone
                response.sendRedirect("auth.html?error=duplicate&tab=signup");
                response.sendRedirect("auth.html?error=server&tab=signup");
            } else {
                // Store user in session and redirect to dashboard
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("home.html");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("auth.html?error=server");
        }
    }
}