/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.31
 * Generated at: 2024-11-07 06:53:02 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.Profile;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class profile_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/index/sidebar.jsp", Long.valueOf(1730960287486L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\" />\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n");
      out.write("    <title>Profile | Parlimate</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../index/sidebar1.css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../header.css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../index.css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"./profile.css\" />\r\n");
      out.write("    <!-- icons -->\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            data-purpose=\"Layout StyleSheet\"\r\n");
      out.write("            title=\"Web Awesome\"\r\n");
      out.write("            href=\"/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css\"\r\n");
      out.write("    />\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css\"\r\n");
      out.write("    />\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<div class=\"sidebar pd-1\">\r\n");
      out.write("    <div class=\"navs\">\r\n");
      out.write("        <ul>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-Home\" value=\"http://localhost:8080/Parlimate\" checked/>\r\n");
      out.write("                <label for=\"nav-Home\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-house\"></i>Home</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-announcements\" value=\"http://localhost:8080/Parlimate/Announcements/announcements.jsp\" />\r\n");
      out.write("                <label for=\"nav-announcements\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-bullhorn\"></i>Announcements</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-fundraise\" value=\"http://localhost:8080/Parlimate/Fundraising/fundraising.jsp\" />\r\n");
      out.write("                <label for=\"nav-fundraise\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-coins\"></i>Fundraises</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-noti\" value=\"http://localhost:8080/Parlimate/Notification/notification.jsp\" />\r\n");
      out.write("                <label for=\"nav-noti\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-bell\"></i>Notifications</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-survey\" value=\"http://localhost:8080/Parlimate/Surveys/surveys.jsp\" />\r\n");
      out.write("                <label for=\"nav-survey\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-clipboard\"></i>Surveys</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-discusRoom\" value=\"http://localhost:8080/Parlimate/DiscussionRoom/discussion-room.jsp\" />\r\n");
      out.write("                <label for=\"nav-discusRoom\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-people-group\"></i>Meeting Room</label>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"radio\" name=\"nav\" id=\"nav-help\" value=\"http://localhost:8080/Parlimate/Help/help.jsp\" />\r\n");
      out.write("                <label for=\"nav-help\" onclick=\"navigate(this)\"><i class=\"fa-solid fa-headset\"></i>Help/Support</label>\r\n");
      out.write("            </li>\r\n");
      out.write("        </ul>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    function navigate(label) {\r\n");
      out.write("        const inputElement = label.previousElementSibling;\r\n");
      out.write("\r\n");
      out.write("        // Redirect to the input's value URL\r\n");
      out.write("        if (inputElement && inputElement.value) {\r\n");
      out.write("            window.location.href = inputElement.value;\r\n");
      out.write("        }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function highlightCurrentPage() {\r\n");
      out.write("        const currentURL = window.location.href;\r\n");
      out.write("\r\n");
      out.write("        // Get all input elements in the sidebar\r\n");
      out.write("        const inputs = document.querySelectorAll('.sidebar input[type=\"radio\"]');\r\n");
      out.write("\r\n");
      out.write("        inputs.forEach(input => {\r\n");
      out.write("            // If the input's value matches the current URL, check the radio button\r\n");
      out.write("            if (input.value === currentURL) {\r\n");
      out.write("                input.checked = true;  // Check the radio input\r\n");
      out.write("                const label = input.nextElementSibling;\r\n");
      out.write("                if (label) {\r\n");
      out.write("                    label.classList.add('selected');  // Add the 'selected' class to the label\r\n");
      out.write("                }\r\n");
      out.write("            } else {\r\n");
      out.write("                const label = input.nextElementSibling;\r\n");
      out.write("                if (label) {\r\n");
      out.write("                    label.classList.remove('selected');  // Remove 'selected' class from other labels\r\n");
      out.write("                }\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Call the function when the page loads to highlight and check the current page's button\r\n");
      out.write("    window.onload = highlightCurrentPage;\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div class=\"header pd-2\">\r\n");
      out.write("    <div class=\"start row\">\r\n");
      out.write("        <div class=\"sidebar-toggle-btn sideMenuBtn btn\">\r\n");
      out.write("            <i class=\"fa-sharp fa-solid fa-bars\"></i>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <div class=\"logo\">\r\n");
      out.write("            <a href=\"./index.html\"> PARLIMATE </a>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"headerSearchBar row\">\r\n");
      out.write("        <input\r\n");
      out.write("                type=\"search\"\r\n");
      out.write("                name=\"mainSearch\"\r\n");
      out.write("                id=\"headerSearchBar\"\r\n");
      out.write("                placeholder=\"Search politicians, Political parties....\"\r\n");
      out.write("        />\r\n");
      out.write("        <label for=\"headerSearchBar\">\r\n");
      out.write("            <i class=\"fa-solid fa-magnifying-glass\"></i>\r\n");
      out.write("        </label>\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"headerBtns\">\r\n");
      out.write("        <div class=\"headerBtn\">\r\n");
      out.write("            <input type=\"checkbox\" name=\"notifi\" id=\"notificationBtn\" />\r\n");
      out.write("            <label for=\"notificationBtn\" class=\"btn\">\r\n");
      out.write("                <i class=\"fa-solid fa-bell\"></i>\r\n");
      out.write("            </label>\r\n");
      out.write("            <span class=\"tip\">notifications</span>\r\n");
      out.write("            <div class=\"dropDownMenu\">\r\n");
      out.write("                <ul>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\" class=\"notification\">\r\n");
      out.write("                            <div class=\"noti-img\"></div>\r\n");
      out.write("                            <div class=\"noti-title\">\r\n");
      out.write("                                <div class=\"notification-from\">\r\n");
      out.write("                                    Ranil wickramasinghe\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <span\r\n");
      out.write("                                >Lorem, ipsum dolor sit amet\r\n");
      out.write("											consectetur adipisicing elit. Qui,\r\n");
      out.write("											ullam. Quos aperiam in re</span\r\n");
      out.write("                                >\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\" class=\"notification\">\r\n");
      out.write("                            <div class=\"noti-img\"></div>\r\n");
      out.write("                            <div class=\"noti-title\">\r\n");
      out.write("                                <div class=\"notification-from\">\r\n");
      out.write("                                    Ranil wickramasinghe\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <span\r\n");
      out.write("                                >Lorem, ipsum dolor sit amet\r\n");
      out.write("											consectetur adipisicing elit. Qui,\r\n");
      out.write("											ullam. Quos aperiam in re</span\r\n");
      out.write("                                >\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\" class=\"notification\">\r\n");
      out.write("                            <div class=\"noti-img\"></div>\r\n");
      out.write("                            <div class=\"noti-title\">\r\n");
      out.write("                                <div class=\"notification-from\">\r\n");
      out.write("                                    Ranil wickramasinghe\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <span\r\n");
      out.write("                                >Lorem, ipsum dolor sit amet\r\n");
      out.write("											consectetur adipisicing elit. Qui,\r\n");
      out.write("											ullam. Quos aperiam in re</span\r\n");
      out.write("                                >\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                </ul>\r\n");
      out.write("                <a\r\n");
      out.write("                        href=\"./Announcements/announcements.html\"\r\n");
      out.write("                        class=\"bottom-btn small-text capitalize\"\r\n");
      out.write("                >\r\n");
      out.write("                    see all notifications\r\n");
      out.write("                </a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"headerBtn\">\r\n");
      out.write("            <input type=\"checkbox\" name=\"profile\" id=\"profileBtn\" />\r\n");
      out.write("            <label for=\"profileBtn\" class=\"btn\">\r\n");
      out.write("                <i class=\"fa-solid fa-user\"></i>\r\n");
      out.write("            </label>\r\n");
      out.write("            <span class=\"tip\">profile</span>\r\n");
      out.write("            <div class=\"dropDownMenu\">\r\n");
      out.write("                <div class=\"profile\">\r\n");
      out.write("                    <a href=\"#\">\r\n");
      out.write("                        <div class=\"img\"></div>\r\n");
      out.write("                        <div class=\"details\">\r\n");
      out.write("                            <div class=\"name medium-text bold\">\r\n");
      out.write("                                Naleeka Kumarasinghe\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"email small-text\">\r\n");
      out.write("                                knaleeka845@gmail.com\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </a>\r\n");
      out.write("                </div>\r\n");
      out.write("                <ul class=\"capitalize\">\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\">\r\n");
      out.write("									<span>\r\n");
      out.write("										<i class=\"fa-regular fa-gear\"></i>\r\n");
      out.write("									</span>\r\n");
      out.write("                            <span> account settings </span>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <div class=\"sep-line\"></div>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\">\r\n");
      out.write("									<span>\r\n");
      out.write("										<i\r\n");
      out.write("                                                class=\"fa-regular fa-circle-question\"\r\n");
      out.write("                                        ></i>\r\n");
      out.write("									</span>\r\n");
      out.write("                            <span> help center </span>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"#\">\r\n");
      out.write("									<span>\r\n");
      out.write("										<i class=\"fa-regular fa-star\"></i>\r\n");
      out.write("									</span>\r\n");
      out.write("                            <span> upgrade plan </span>\r\n");
      out.write("                        </a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <div class=\"sep-line\"></div>\r\n");
      out.write("\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <div class=\"logoutBtn capitalize\">\r\n");
      out.write("                            <div class=\"cont\">\r\n");
      out.write("                                <input\r\n");
      out.write("                                        type=\"checkbox\"\r\n");
      out.write("                                        name=\"logoutBtn\"\r\n");
      out.write("                                        id=\"logoutBtn\"\r\n");
      out.write("                                />\r\n");
      out.write("                                <label for=\"logoutBtn\">\r\n");
      out.write("                                    <i class=\"fa-solid fa-sign-out\"></i>\r\n");
      out.write("                                    <span>logout</span>\r\n");
      out.write("                                </label>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </li>\r\n");
      out.write("                </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"container col\">\r\n");
      out.write("    <div class=\"pro-imgs\">\r\n");
      out.write("        <div class=\"cover-bg\"></div>\r\n");
      out.write("        <div class=\"profile-pic\"></div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"profile-container\">\r\n");
      out.write("        <div class=\"profile-details col\">\r\n");
      out.write("            <div class=\"user-ac row jc-sb\">\r\n");
      out.write("                <div class=\"content-1 col\">\r\n");
      out.write("                    <div class=\"name capitalize\">\r\n");
      out.write("                        Naleeka Kumarasinghe\r\n");
      out.write("                        <span class=\"verified\">verified</span>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"row\">\r\n");
      out.write("                        <div class=\"uName\">\r\n");
      out.write("                            <i class=\"fa-regular fa-at\"></i>\r\n");
      out.write("                            itsNaleeka\r\n");
      out.write("                        </div>\r\n");
      out.write("\r\n");
      out.write("                        <div class=\"city\">\r\n");
      out.write("                            <i class=\"fa-solid fa-location-dot\"></i>\r\n");
      out.write("                            Kandy\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"jDate\">\r\n");
      out.write("                            <i class=\"fa-solid fa-calendar\"></i>\r\n");
      out.write("                            Joined on<span>Aug 2024</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"content-2 row\">\r\n");
      out.write("                    <div class=\"btn message capitalize row\">\r\n");
      out.write("                        message\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"options btn\">\r\n");
      out.write("                        <i class=\"fa-solid fa-ellipsis\"></i>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"profession row\">\r\n");
      out.write("                <i class=\"fa-solid fa-briefcase\"></i>\r\n");
      out.write("                <span>Software Engineer</span>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"bio col\">\r\n");
      out.write("                <div class=\"title\">Bio :</div>\r\n");
      out.write("                <span class=\"bio-content\">\r\n");
      out.write("							A passionate advocate for change, [Your Name]\r\n");
      out.write("							believes in the power of informed and active\r\n");
      out.write("							citizenship. With a keen interest in politics and\r\n");
      out.write("							public policy, [he/she/they] is committed to staying\r\n");
      out.write("							updated on current issues and engaging in meaningful\r\n");
      out.write("							discussions. [Your Name] strives to bridge the gap\r\n");
      out.write("							between citizens and policymakers, ensuring that\r\n");
      out.write("							community voices are heard and represented. Whether\r\n");
      out.write("							itâs through online debates, local meetings, or\r\n");
      out.write("							volunteering, [he/she/they] is dedicated to making a\r\n");
      out.write("							difference and fostering a more inclusive and\r\n");
      out.write("							transparent political landscape.\r\n");
      out.write("						</span>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"pol-interest\">\r\n");
      out.write("                <div class=\"title\">Political Interests</div>\r\n");
      out.write("                <div class=\"tags capitalize\">\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >anura kumara dissanayake<span> AKD </span></a\r\n");
      out.write("                    >\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >Sunil Hadunhetti<span>hadunhettiSunil</span></a\r\n");
      out.write("                    >\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >Vijitha rajapakse<span>vijithaR</span></a\r\n");
      out.write("                    >\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >Harini amarasuriya<span>HariniA</span></a\r\n");
      out.write("                    >\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >Mahinda Rajapakse<span>mahindaR</span></a\r\n");
      out.write("                    >\r\n");
      out.write("                    <a href=\"#\"\r\n");
      out.write("                    >Ranil Wickramasinghe<span>RanilW</span></a\r\n");
      out.write("                    >\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <a href=\"./editProfile/index.html\" class=\"edit-btn btn row capitalize\">\r\n");
      out.write("            <i class=\"fa-solid fa-pen-to-square\"></i>\r\n");
      out.write("            edit profile\r\n");
      out.write("        </a>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("<script src=\"../script.js\"></script>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}