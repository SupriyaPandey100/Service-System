package com.HomeService.utils;



import com.HomeService.model.UserModel;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpSession;



/**

 * SessionUtils - Utility class for managing user sessions.

 * Handles creating, retrieving, and destroying sessions.

 */

public class SessionUtils {



    /**

     * Creates a new session and stores the logged in user.

     * Input  : request, UserModel object

     * Output : session created with user stored inside

     */

    public static void setUserSession(HttpServletRequest request, UserModel user) {

        HttpSession session = request.getSession(true);

        session.setAttribute("userSession", user);

        session.setMaxInactiveInterval(30 * 60);

    }



    /**

     * Retrieves the logged in user from session.

     * Input  : request

     * Output : UserModel object or null if not logged in

     */

    public static UserModel getUserSession(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session != null) {

            return (UserModel) session.getAttribute("userSession");

        }

        return null;

    }



    /**

     * Checks if a user is currently logged in.

     * Input  : request

     * Output : true if logged in, false if not

     */

    public static boolean isLoggedIn(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        return session != null && session.getAttribute("userSession") != null;

    }



    /**

     * Destroys the session when user logs out.

     * Input  : request

     * Output : session invalidated and cleared

     */

    public static void destroySession(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session != null) {

            session.invalidate();

        }

    }

}