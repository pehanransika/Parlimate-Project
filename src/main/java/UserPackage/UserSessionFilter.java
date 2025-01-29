package UserPackage;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*") // This filter will apply to all URLs
public class UserSessionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false); // Retrieve existing session if available

        if (session != null) {
            // Get the user and userProfile from session and set them as request attributes
            Object user = session.getAttribute("user");
            Object userProfile = session.getAttribute("userProfile");

            if (user != null) {
                request.setAttribute("user", user);
            }
            if (userProfile != null) {
                request.setAttribute("userProfile", userProfile);
            }
        }

        // Continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}

