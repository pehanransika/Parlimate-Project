/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.96
 * Generated at: 2025-03-12 16:33:57 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.admin.userManagment;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import UserPackage.UserModel;
import UserPackage.UserController;
import java.util.List;

public final class userManagment_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("jar:file:/E:/jstl-1.2.jar!/META-INF/fn.tld", Long.valueOf(1153365282000L));
    _jspx_dependants.put("/WEB-INF/lib/jstl-1.2.jar", Long.valueOf(1725271156711L));
    _jspx_dependants.put("jar:file:/E:/jstl-1.2.jar!/META-INF/c.tld", Long.valueOf(1153365282000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(4);
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("UserPackage.UserModel");
    _jspx_imports_classes.add("UserPackage.UserController");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
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

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
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
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
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

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <style>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    </style>\r\n");
      out.write("    <meta charset=\"UTF-8\" />\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n");
      out.write("    <title>User Management | Admin Dashboard</title>\r\n");
      out.write("\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"./userManagment.css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"../index.css\" />\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"./profile.css\"/>\r\n");
      out.write("\r\n");
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
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css\"\r\n");
      out.write("    />\r\n");
      out.write("\r\n");
      out.write("    <link\r\n");
      out.write("            rel=\"stylesheet\"\r\n");
      out.write("            href=\"https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css\"\r\n");
      out.write("    />\r\n");
      out.write("</head>\r\n");
      out.write("<body class=\"\">\r\n");
      out.write("<div class=\"navMenu f-col center\">\r\n");
      out.write("    <div class=\"logo\">\r\n");
      out.write("        <img src=\"../assets/logo.png\" alt=\"Parlimate\" id=\"logo\" />\r\n");
      out.write("    </div>\r\n");
      out.write("    <div class=\"navigation\">\r\n");
      out.write("        <ul>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"../Home/index.jsp\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-house\"></i>\r\n");
      out.write("                    <span>home</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"userManagment.jsp\" class=\"nav-item f-row active\">\r\n");
      out.write("                    <i class=\"fa-regular fa-users\"></i>\r\n");
      out.write("                    <span>user management</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"../Fundraising/fundraisingManagement.jsp\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-briefcase\"></i>\r\n");
      out.write("                    <span>fundraise management</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-check-to-slot\"></i>\r\n");
      out.write("                    <span>survey management</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-cards-blank\"></i>\r\n");
      out.write("                    <span>post management</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-circle-check\"></i>\r\n");
      out.write("                    <span>requests</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"nav-item f-row\">\r\n");
      out.write("                    <i class=\"fa-regular fa-sliders-up\"></i>\r\n");
      out.write("                    <span>platform settings</span>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("        </ul>\r\n");
      out.write("        <ul>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"f-row profile\">\r\n");
      out.write("                    <div class=\"p-img\"></div>\r\n");
      out.write("                    <div class=\"sUser f-col\">\r\n");
      out.write("                        <div class=\"name\">Naleeka Kumarasinghe</div>\r\n");
      out.write("                        <div class=\"role\">Admin</div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <a href=\"#\" class=\"f-row log-out\">\r\n");
      out.write("                    <i class=\"fa-solid fa-right-from-bracket\"></i>\r\n");
      out.write("                    log out\r\n");
      out.write("                </a>\r\n");
      out.write("            </li>\r\n");
      out.write("        </ul>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<div class=\"pageContent\">\r\n");
      out.write("    <div class=\"container f-col\">\r\n");
      out.write("        <div class=\"top f-row\">\r\n");
      out.write("            <div class=\"page f-col\">\r\n");
      out.write("                <div class=\"page-title capitalize\">User management</div>\r\n");
      out.write("                <div class=\"page-desc\">\r\n");
      out.write("                    Manage user roles, permissions, and activity logs.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"content f-col\">\r\n");
      out.write("            <div class=\"topS f-row\">\r\n");
      out.write("                <div class=\"show f-row\">\r\n");
      out.write("                    Shows\r\n");
      out.write("                    <select name=\"rows\" id=\"rows\">\r\n");
      out.write("                        <option value=\"10\">10</option>\r\n");
      out.write("                        <option value=\"20\">20</option>\r\n");
      out.write("                        <option value=\"50\">50</option>\r\n");
      out.write("                    </select>\r\n");
      out.write("                    entries per page\r\n");
      out.write("                </div>\r\n");
      out.write("\r\n");
      out.write("                <div class=\"actions f-row\">\r\n");
      out.write("                    <div class=\"search-bar\">\r\n");
      out.write("                        <label for=\"user-search\">\r\n");
      out.write("                            <i class=\"fa-solid fa-magnifying-glass\"></i>\r\n");
      out.write("                        </label>\r\n");
      out.write("                        <input\r\n");
      out.write("                                type=\"search\"\r\n");
      out.write("                                placeholder=\"Search by name/userId\"\r\n");
      out.write("                                name=\"user-search\"\r\n");
      out.write("                                id=\"user-search\"\r\n");
      out.write("                        />\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"filter\">\r\n");
      out.write("                        <button class=\"filter-btn f-row\" id=\"filter-btn\">\r\n");
      out.write("                            <i class=\"fa-solid fa-filter\"></i>\r\n");
      out.write("                            Filter\r\n");
      out.write("                        </button>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <button class=\"add-btn f-row\" id=\"openPopup\">\r\n");
      out.write("                        <i class=\"fa-sharp fa-solid fa-plus\"></i>\r\n");
      out.write("                        Add User\r\n");
      out.write("                    </button>\r\n");
      out.write("\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"total-records f-row\">\r\n");
      out.write("                total <span> 560 </span> records\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"data f-col\">\r\n");
      out.write("                <table class=\"users\">\r\n");
      out.write("                    <thead>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>User ID</td>\r\n");
      out.write("                        <td>Email</td>\r\n");
      out.write("                        <td>Role</td>\r\n");
      out.write("                        <td>status</td>\r\n");
      out.write("                        <td class=\"head-row f-row\">joined on</td>\r\n");
      out.write("                        <td>View Profile</td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    </thead>\r\n");
      out.write("                    <tbody>\r\n");
      out.write("                    ");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                    </tbody>\r\n");
      out.write("                <div class=\"pagination capitalize f-row\">\r\n");
      out.write("                    <span>prev</span>\r\n");
      out.write("                    <span class=\"curr-page\">1</span>\r\n");
      out.write("                    <span>next</span>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- Popup -->\r\n");
      out.write("<!-- Profile Popup -->\r\n");
      out.write("<div id=\"profilePopup\" class=\"popup\">\r\n");
      out.write("    <div class=\"popup-content\">\r\n");
      out.write("        <span class=\"close\" onclick=\"closeProfilePopup()\">&times;</span>\r\n");
      out.write("        <h2>Profile Details</h2>\r\n");
      out.write("        <div id=\"profileDetails\">\r\n");
      out.write("            <!-- User details will be loaded here dynamically -->\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("    document.addEventListener(\"DOMContentLoaded\", function() {\r\n");
      out.write("        document.querySelectorAll('.actbtn button').forEach(button => {\r\n");
      out.write("            button.addEventListener('click', function(event) {\r\n");
      out.write("                event.stopPropagation(); // Prevents closing immediately after opening\r\n");
      out.write("                let menu = this.nextElementSibling;\r\n");
      out.write("                document.querySelectorAll('.actbtn .menu').forEach(m => {\r\n");
      out.write("                    if (m !== menu) {\r\n");
      out.write("                        m.classList.remove('nav-active');\r\n");
      out.write("                    }\r\n");
      out.write("                });\r\n");
      out.write("                menu.classList.toggle('nav-active');\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Close the menu when clicking outside\r\n");
      out.write("        document.addEventListener(\"click\", function (event) {\r\n");
      out.write("            if (event.target.classList.contains(\"view-profile-btn\")) {\r\n");
      out.write("                let userId = event.target.getAttribute(\"data-user-id\");\r\n");
      out.write("                openProfilePopup(userId);\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    // Function to close profile popup\r\n");
      out.write("        function closeProfilePopup() {\r\n");
      out.write("            document.getElementById(\"profilePopup\").style.display = \"none\";\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        // Attach event listeners\r\n");
      out.write("        document.querySelectorAll(\".view-profile-btn\").forEach(button => {\r\n");
      out.write("            button.addEventListener(\"click\", function () {\r\n");
      out.write("                const userId = this.getAttribute(\"data-user-id\");\r\n");
      out.write("                openProfilePopup(userId);\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Attach functions to the window object so they can be accessed in inline onclick events\r\n");
      out.write("        window.openProfilePopup = openProfilePopup;\r\n");
      out.write("        window.closeProfilePopup = closeProfilePopup;\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    function openProfilePopup(userId) {\r\n");
      out.write("        fetch(`/UserDetailsServlet?userId=");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("`)\r\n");
      out.write("            .then(response => response.json())\r\n");
      out.write("            .then(user => {\r\n");
      out.write("                if (user.error) {\r\n");
      out.write("                    document.getElementById(\"profileDetails\").innerHTML = `<p>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.error}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</p>`;\r\n");
      out.write("                } else {\r\n");
      out.write("                    document.getElementById(\"profileDetails\").innerHTML = `\r\n");
      out.write("                    <p><strong>User ID:</strong> ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</p>\r\n");
      out.write("                    <p><strong>Email:</strong> ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.email}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</p>\r\n");
      out.write("                    <p><strong>Role:</strong> ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</p>\r\n");
      out.write("                    <p><strong>Joined On:</strong> ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.created_at}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("</p>\r\n");
      out.write("                `;\r\n");
      out.write("                    document.getElementById(\"profilePopup\").style.display = \"block\";\r\n");
      out.write("                }\r\n");
      out.write("            })\r\n");
      out.write("            .catch(error => {\r\n");
      out.write("                console.error(\"Error fetching user details:\", error);\r\n");
      out.write("                document.getElementById(\"profileDetails\").innerHTML = \"<p>Failed to load user details.</p>\";\r\n");
      out.write("            });\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function closeProfilePopup() {\r\n");
      out.write("        document.getElementById(\"profilePopup\").style.display = \"none\";\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    // Sample user data (Replace with actual data fetching logic)\r\n");
      out.write("    const usersData = [\r\n");
      out.write("        ");
      if (_jspx_meth_c_005fforEach_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("    ];\r\n");
      out.write("\r\n");
      out.write("    // Attach event listeners dynamically\r\n");
      out.write("    document.addEventListener(\"DOMContentLoaded\", function () {\r\n");
      out.write("        // Toggle dropdown menu\r\n");
      out.write("        document.querySelectorAll('.actbtn button').forEach(button => {\r\n");
      out.write("            button.addEventListener('click', function (event) {\r\n");
      out.write("                event.stopPropagation();\r\n");
      out.write("                let menu = this.nextElementSibling;\r\n");
      out.write("                document.querySelectorAll('.actbtn .menu').forEach(m => {\r\n");
      out.write("                    if (m !== menu) {\r\n");
      out.write("                        m.classList.remove('nav-active');\r\n");
      out.write("                    }\r\n");
      out.write("                });\r\n");
      out.write("                menu.classList.toggle('nav-active');\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Close the menu when clicking outside\r\n");
      out.write("        document.addEventListener(\"click\", function (event) {\r\n");
      out.write("            document.querySelectorAll('.actbtn .menu').forEach(menu => {\r\n");
      out.write("                if (!menu.contains(event.target)) {\r\n");
      out.write("                    menu.classList.remove('nav-active');\r\n");
      out.write("                }\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Open profile popup\r\n");
      out.write("        document.addEventListener(\"click\", function (event) {\r\n");
      out.write("            if (event.target.classList.contains(\"view-profile-btn\")) {\r\n");
      out.write("                let userId = event.target.getAttribute(\"data-user-id\");\r\n");
      out.write("                openProfilePopup(userId);\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    // Toggle popup-active class on body when delete user button is clicked\r\n");
      out.write("        document.querySelectorAll(\".del-user\").forEach(button => {\r\n");
      out.write("            button.addEventListener(\"click\", function() {\r\n");
      out.write("                document.body.classList.add(\"popup-active\");\r\n");
      out.write("                document.querySelector(\".delete-user-popup\").classList.add(\"popup-show\");\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Close popup when close button is clicked\r\n");
      out.write("        document.querySelectorAll(\".close-btn\").forEach(button => {\r\n");
      out.write("            button.addEventListener(\"click\", function() {\r\n");
      out.write("                document.body.classList.remove(\"popup-active\");\r\n");
      out.write("                document.querySelector(\".filter-user-popup\").classList.remove(\"popup-show\");\r\n");
      out.write("                document.querySelector(\".delete-user-popup\").classList.remove(\"popup-show\");\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("\r\n");
      out.write("        // Close popup when proceed button is clicked\r\n");
      out.write("        document.querySelector(\".proceed\").addEventListener(\"click\", function() {\r\n");
      out.write("            document.body.classList.remove(\"popup-active\");\r\n");
      out.write("            document.querySelector(\".delete-user-popup\").classList.remove(\"popup-show\");\r\n");
      out.write("        });\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
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

  private boolean _jspx_meth_c_005fforEach_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f0.setParent(null);
    // /admin/userManagment/userManagment.jsp(196,20) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setVar("user");
    // /admin/userManagment/userManagment.jsp(196,20) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setItems(new org.apache.jasper.el.JspValueExpression("/admin/userManagment/userManagment.jsp(196,20) '${allUsers}'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${allUsers}",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
    int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
      if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("                        <tr>\r\n");
          out.write("                            <td>");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("</td>\r\n");
          out.write("                            <td >\r\n");
          out.write("                                <div class=\"p-img\"></div>\r\n");
          out.write("                                <div class=\"credentials f-col\">\r\n");
          out.write("                                    <div class=\"name\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.email}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("</div>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("                                </div>\r\n");
          out.write("                            </td>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("                            <td class=\"role\">\r\n");
          out.write("                                <span class=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userType.toLowerCase()}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write('"');
          out.write('>');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("</span>\r\n");
          out.write("                            </td>\r\n");
          out.write("                            <td>Active</td>\r\n");
          out.write("                            <td>");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.created_at}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("</td>\r\n");
          out.write("                            <td class=\"actbtn\">\r\n");
          out.write("                                <button>\r\n");
          out.write("                                    <i class=\"fa-regular fa-ellipsis-vertical\"></i>\r\n");
          out.write("                                </button>\r\n");
          out.write("                                <ul class=\"menu\">\r\n");
          out.write("                                    <li class=\"f-row\" >\r\n");
          out.write("                                        <i class=\"fa-regular fa-user\"></i>\r\n");
          out.write("                                        <button class=\"view-profile-btn\" data-user-id=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("\">\r\n");
          out.write("                                            <i class=\"fa-regular fa-user\"></i>\r\n");
          out.write("                                            View Profile\r\n");
          out.write("                                        </button>\r\n");
          out.write("                                    </li>\r\n");
          out.write("\r\n");
          out.write("\r\n");
          out.write("                                    <li class=\"f-row del-user\">\r\n");
          out.write("                                        <i class=\"fa-regular fa-trash\"></i>\r\n");
          out.write("                                        delete user\r\n");
          out.write("                                    </li>\r\n");
          out.write("                                </ul>\r\n");
          out.write("                            </td>\r\n");
          out.write("                        </tr>\r\n");
          out.write("                    ");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f0.doFinally();
    }
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
    org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fforEach_005f0, _jsp_getInstanceManager());
    return false;
  }

  private boolean _jspx_meth_c_005fforEach_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f1 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f1.setParent(null);
    // /admin/userManagment/userManagment.jsp(334,8) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setVar("user");
    // /admin/userManagment/userManagment.jsp(334,8) name = items type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f1.setItems(new org.apache.jasper.el.JspValueExpression("/admin/userManagment/userManagment.jsp(334,8) '${allUsers}'",_jsp_getExpressionFactory().createValueExpression(_jspx_page_context.getELContext(),"${allUsers}",java.lang.Object.class)).getValue(_jspx_page_context.getELContext()));
    int[] _jspx_push_body_count_c_005fforEach_005f1 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f1 = _jspx_th_c_005fforEach_005f1.doStartTag();
      if (_jspx_eval_c_005fforEach_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("        {\r\n");
          out.write("            userId: \"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("\",\r\n");
          out.write("            email: \"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.email}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("\",\r\n");
          out.write("            userType: \"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.userType}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("\",\r\n");
          out.write("            created_at: \"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${user.created_at}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
          out.write("\"\r\n");
          out.write("        },\r\n");
          out.write("        ");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (java.lang.Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f1.doFinally();
    }
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f1);
    org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fforEach_005f1, _jsp_getInstanceManager());
    return false;
  }
}
