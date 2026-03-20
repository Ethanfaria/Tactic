package com.tactic;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDAO.loginUser(email, password);

            if (user == null) {
                response.sendRedirect("auth.html?error=invalid");
                response.sendRedirect("auth.html?error=server");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Redirect based on role
                switch (user.getRole()) {
                    case "admin"    -> response.sendRedirect("admin/dashboard.html");
                    case "vendor"   -> response.sendRedirect("vendor/dashboard.html");
                    default         -> response.sendRedirect("dashboard.html");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.html?error=server");
        }
    }
}