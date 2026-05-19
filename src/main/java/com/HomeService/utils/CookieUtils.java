package com.HomeService.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtils - Utility class for managing cookies.
 * Handles creating, retrieving, and deleting cookies.
 */
public class CookieUtils {

    /**
     * Creates and adds a cookie to the response.
     * Input  : response, cookie name, value, expiry in seconds
     * Output : cookie added to user browser
     */
    public static void addCookie(HttpServletResponse response,
                                  String name,
                                  String value,
                                  int expirySeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(expirySeconds);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    /**
     * Retrieves a cookie value by name from the request.
     * Input  : request, cookie name
     * Output : cookie value as String or null if not found
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Deletes a cookie by setting expiry time to 0.
     * Input  : response, cookie name
     * Output : cookie removed from user browser
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}