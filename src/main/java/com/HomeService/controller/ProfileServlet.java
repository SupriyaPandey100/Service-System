package com.HomeService.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

import com.HomeService.dao.UserDAO;
import com.HomeService.model.UserModel;
import com.HomeService.utils.CookieUtils;
import com.HomeService.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;



/**

 * ProfileServlet - Handles viewing and updating user profile.

 * Mapped to URL: /profile

 *

 * doGet  - Loads profile page with user data from session.

 * doPost - Receives updated form data and saves to database.

 */

@WebServlet("/profile")

@MultipartConfig

public class ProfileServlet extends HttpServlet {



    /**

     * UserDAO instance to perform database operations

     * for user profile updates.

     */

    private UserDAO userDAO = new UserDAO();



    /**

     * doGet - Called when user visits /profile URL.

     *

     * Input  : HttpServletRequest, HttpServletResponse

     * Output : Forwards to profile.jsp if logged in.

     *          Redirects to login if not logged in.

     */

    @Override

    protected void doGet(HttpServletRequest request,

                        HttpServletResponse response)

                        throws ServletException, IOException {



        // Check if user is logged in

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userSession") == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;

        }



        // Get last login cookie using CookieUtils

        String lastLogin = CookieUtils.getCookieValue(request, "lastLogin");

        if (lastLogin != null) {

            request.setAttribute("lastLogin", lastLogin);

        }



        // Forward to profile page using RequestDispatcher

        request.getRequestDispatcher(

            "/WEB-INF/pages/profile.jsp"

        ).forward(request, response);

    }



    /**

     * doPost - Called when user submits Update Profile form.

     *

     * Input  : fullName, email, phone from HTML form

     * Output : Updates database and shows success or error message.

     */

    @Override

    protected void doPost(HttpServletRequest request,

                         HttpServletResponse response)

                         throws ServletException, IOException {



        // Check if user is logged in

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userSession") == null) {

            response.sendRedirect(request.getContextPath() + "/login");

            return;

        }



     // Get form data from request

        String fullName = request.getParameter("fullName");

        String username = request.getParameter("username");

        String email    = request.getParameter("email");

        String phone    = request.getParameter("phone");



     // Validate fields are not empty

        if (fullName == null || fullName.trim().isEmpty() ||

            username == null || username.trim().isEmpty() ||

            email == null    || email.trim().isEmpty() ||

            phone == null    || phone.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required!");

            request.getRequestDispatcher(

                "/WEB-INF/pages/profile.jsp"

            ).forward(request, response);

            return;

        }



        // Get logged in user from session

        UserModel user = (UserModel) session.getAttribute("userSession");

        Part photoPart = request.getPart("profilePic");



        String profileImagePath = user.getProfileImage();



        if (photoPart != null && photoPart.getSize() > 0) {



            String fileName = Paths.get(

                    photoPart.getSubmittedFileName()

            ).getFileName().toString();



            String uploadPath = getServletContext()

                    .getRealPath("/images/profile");



            File uploadDir = new File(uploadPath);



            if (!uploadDir.exists()) {

                uploadDir.mkdirs();

            }



            String savedFileName =

            		"user_" + user.getUserId() + "_" + fileName;



            photoPart.write(

                    uploadPath + File.separator + savedFileName

            );



            profileImagePath =

                    "images/profile/" + savedFileName;

        }



     // Update user object with new form data

        user.setFullName(fullName);

        user.setUsername(username);

        user.setEmail(email);

        user.setPhone(phone);

        user.setProfileImage(profileImagePath);



        try {

            // Save updated data to database using UserDAO

            userDAO.updateUserProfile(user);



            // Update session with new user data using SessionUtils

            SessionUtils.setUserSession(request, user);



            // Store last login time in cookie using CookieUtils

            CookieUtils.addCookie(response, "lastLogin",

            	    String.valueOf(System.currentTimeMillis()), 7 * 24 * 60 * 60);



            // Set success message

            request.setAttribute("success", "Profile updated successfully!");

        } catch (SQLException e) {

            request.setAttribute("error", "Failed to update profile. Try again!");

            e.printStackTrace();

        }



     // Send updated user object back to JSP

        request.setAttribute("user", user);



        // Forward back to profile page using RequestDispatcher

        request.getRequestDispatcher(

            "/WEB-INF/pages/profile.jsp"

        ).forward(request, response);

    }

}