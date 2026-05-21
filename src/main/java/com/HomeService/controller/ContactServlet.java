package com.HomeService.controller;



import java.io.IOException;
import java.sql.SQLException;

import com.HomeService.dao.ContactDAO;
import com.HomeService.model.ContactMessage;
import com.HomeService.utils.CookieUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



/**

 * ContactServlet handles Contact Us page requests.

 *

 * doGet  -> Loads contact page

 * doPost -> Validates and stores contact messages

 */

@WebServlet("/contact")

public class ContactServlet extends HttpServlet {



    private static final long serialVersionUID = 1L;



    /**

     * DAO object for database operations.

     */

    private final ContactDAO contactDAO = new ContactDAO();



    /**

     * Loads the Contact Us page.

     *

     * @param request  client request

     * @param response server response

     * @throws ServletException if forwarding fails

     * @throws IOException      if an I/O error occurs

     */

    @Override

    protected void doGet(HttpServletRequest request,

                         HttpServletResponse response)

            throws ServletException, IOException {



        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp")

               .forward(request, response);

    }



    /**

     * Handles contact form submission.

     *

     * @param request  client request

     * @param response server response

     * @throws ServletException if forwarding fails

     * @throws IOException      if an I/O error occurs

     */

    @Override

    protected void doPost(HttpServletRequest request,

                          HttpServletResponse response)

            throws ServletException, IOException {



        String fullName = request.getParameter("fullName");

        String email    = request.getParameter("email");

        String phone    = request.getParameter("phone");

        String subject  = request.getParameter("subject");

        String message  = request.getParameter("message");



        /**

         * Validation for empty fields.

         */

        if (fullName == null || fullName.trim().isEmpty()

                || email == null || email.trim().isEmpty()

                || phone == null || phone.trim().isEmpty()

                || subject == null || subject.trim().isEmpty()

                || message == null || message.trim().isEmpty()) {



            request.setAttribute("error",

                    "All fields are required.");



            request.getRequestDispatcher("/WEB-INF/pages/contact.jsp")

                   .forward(request, response);

            return;

        }



        /**

         * Create model object.

         */

        ContactMessage contactMessage = new ContactMessage();



        contactMessage.setFullName(fullName);

        contactMessage.setEmail(email);

        contactMessage.setPhone(phone);

        contactMessage.setSubject(subject);

        contactMessage.setMessage(message);

        contactMessage.setStatus("NEW");



        try {



            /**

             * Save message into database.

             */

            boolean saved =

                    contactDAO.saveContactMessage(contactMessage);



            if (saved) {



                /**

                 * Save contact email in cookie.

                 */

                CookieUtils.addCookie(

                        response,

                        "contactEmail",

                        email.trim(),

                        7 * 24 * 60 * 60

                );



                request.setAttribute(

                        "success",

                        "Your message has been sent successfully!"

                );



            } else {



                request.setAttribute(

                        "error",

                        "Failed to send message."

                );

            }



        } catch (SQLException e) {



            request.setAttribute(

                    "error",

                    "Database error occurred."

            );



            e.printStackTrace();

        }



        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp")

               .forward(request, response);

    }

}