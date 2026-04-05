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
                String referer = request.getHeader("Referer");
                if (referer != null && referer.contains("vendor-signup")) {
                    response.sendRedirect("vendor-signup.html?error=duplicate");
                } else {
                    response.sendRedirect("auth.html?error=duplicate&tab=signup");
                }
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                if("vendor".equals(user.getRole())){
                    response.sendRedirect("vendor/create-profile");
                }else{
                    response.sendRedirect("home");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("auth.html?error=server");
        }
    }
}