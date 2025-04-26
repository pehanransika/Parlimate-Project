<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="UserPackage.UserModel" %>
<%@ page import="UserPackage.AdminModel" %>

<%
  HttpSession session1 = request.getSession(false);
  if (session1 == null || session1.getAttribute("user") == null) {
    response.sendRedirect("../index.jsp");
    return;
  }

  UserModel user = (UserModel) session1.getAttribute("user");
  int userId = user.getUserId();

  AdminModel admin = new AdminModel();
  String adminName = admin.getAdminNameByUserId(userId);
%>



<!DOCTYPE html>
<html lang="en">
<head>
  <style>


  </style>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Comment Management | Admin Dashboard</title>

  <link rel="stylesheet" href="./CommentManagement.css" />
  <link rel="stylesheet" href="../index.css" />
  <link rel="stylesheet" href="./profile.css"/>

  <!-- icons -->
  <link
          rel="stylesheet"
          data-purpose="Layout StyleSheet"
          title="Web Awesome"
          href="/css/app-wa-09b459cf485d4b1f3304947240314c05.css?vsn=d"
  />

  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css"
  />

  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-duotone-solid.css"
  />

  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-thin.css"
  />

  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-solid.css"
  />

  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-regular.css"
  />
  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/solid.css"
  />
  <link
          rel="stylesheet"
          href="https://site-assets.fontawesome.com/releases/v6.6.0/css/sharp-light.css"
  />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body class="">

<div class="navMenu f-col center">
  <div class="logo">
    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Parlimate" id="logo" />
  </div>
  <div class="navigation">
    <ul>
      <li>
        <a href="${pageContext.request.contextPath}/admin/Home/GetAnalyticsCountServlet" class="nav-item f-row">
          <i class="fa-regular fa-house"></i>
          <span>home</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/userManagement/UserManagementServlet" class="nav-item f-row">
          <i class="fa-regular fa-users"></i>
          <span>users</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/Fundraising/FundraisingManagementServlet" class="nav-item f-row">
          <i class="fa-regular fa-briefcase"></i>
          <span>fundraise management</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/Surveys/GetParlimateSurveysServlet" class="nav-item f-row">
          <i class="fa-regular fa-check-to-slot"></i>
          <span>survey management</span>
        </a>
      </li>
      <li>
        <a href="#" class="nav-item f-row">
          <i class="fa-regular fa-cards-blank"></i>
          <span>post management</span>
        </a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/admin/CommentManagement/CommentManagementServlet" class="nav-item f-row active">
          <i class="fa-regular fa-comments"></i>
          <span>Comment Management</span>
        </a>
      </li>
      <%--				<li>--%>
      <%--					<a href="#" class="nav-item f-row">--%>
      <%--						<i class="fa-regular fa-circle-check"></i>--%>
      <%--						<span>requests</span>--%>
      <%--					</a>--%>
      <%--				</li>--%>
      <li>
        <a href="${pageContext.request.contextPath}/admin/BankTransferManagement/BankTransferManagementServlet" class="nav-item f-row">
          <i class="fa-regular fa-money-bill-transfer"></i>
          <span>bank transfer management</span>
        </a>
      </li>
      <li>
        <a href="<%= request.getContextPath() %>/GetAllMeetingRequestAdminServlet" class="nav-item f-row">
          <i class="fa-regular fa-circle-check"></i>
          <span>Meeting Management</span>
        </a>
      </li>
      <li>
        <a href="<%= request.getContextPath() %>/GetProfileListServlet" class="nav-item f-row">
          <i class="fa-regular fa-sliders-up"></i>
          <span>Profile Management</span>
        </a>
      </li>
    </ul>
    <ul>
      <li>
        <a href="#" class="f-row profile">
          <div class="p-img"><img src="<%= request.getContextPath() %>/images/Admin/admin.png"></div>
          <div class="sUser f-col">
            <div class="name"><%= adminName != null ? adminName : "Unknown Admin" %></div>
            <div class="role">Admin</div>
          </div>
        </a>
      </li>
      <li>
        <a href="#" class="f-row log-out" onclick="logoutUser()">
          <i class="fa-solid fa-right-from-bracket"></i>
          log out
        </a>
      </li>
    </ul>
  </div>
</div>

<div class="pageContent">
  <div class="container f-col">
    <div class="top f-row">
      <div class="page f-col">
        <div class="page-title capitalize">Comment management</div>
        <div class="page-desc">
          Manage user comments
        </div>
      </div>

    </div>

      <div class="data f-col">
        <table class="users">
          <thead>
          <tr>
            <td>Comment ID</td>
            <td>Post ID</td>
            <td>Post </td>
            <td>Comment content</td>
            <td class="head-row f-row">commented on</td>
            <td>Delete Comment</td>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="comment" items="${alladminComment}">
            <tr>
              <td>${comment.commentid}</td>
              <td>${comment.postid}</td>
              <td>${comment.name}</td>
              <td>${comment.content}</td>
              <td>${comment.time}</td>

              <td class="actbtn">

                  <li class="f-row del-comment">
                    <i class="fa-regular fa-trash"></i>

                    <form action="${pageContext.request.contextPath}/admin/CommentManagement/CommentDeleteAdminServlet"
                          method="POST"
                          onsubmit="return confirm('Are you sure you want to delete this request?');"
                          style="display:inline;">
                      <input type="hidden" name="commentId" value="${comment.commentid}"/>

                      <button type="submit" class="delete-btn">Delete</button>
                    </form>
                  </li>
                </ul>
              </td>
            </tr>
          </c:forEach>


          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
</div>



<script>



</script>
</body>

</html>
