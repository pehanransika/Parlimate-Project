<%--
  Created by IntelliJ IDEA.
  User: Manuja Ransara
  Date: 11/21/2024
  Time: 7:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UpdateProfile</title>
</head>
<body>
        <%
          String email = req.getParameter("email");
          String password = req.getParameter("password");
          String userType = req.getParameter("userType");
          String name = req.getParameter("name");
          String address = req.getParameter("address");
          String phoneNumber = req.getParameter("phoneNumber");
          String profile = req.getParameter("profile");
          String img_url = req.getParameter("img_url");
        %>

        <form action="UpdateUserServlet" method="post">
          <table>

            <tr>
              <td>Email:</td>
              <td><input type="text" name="email" value="<% email %>" required></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><input type="text" name="Password" value="<% password %>"required></td>
            </tr>
            <tr>
              <td>UserType:</td>
              <td><input type="text" name="userType" value="<% userType %>" readonly></td>
            </tr>
            <tr>
              <td>Name :</td>
              <td><input type="text" name="name" value="<% name %>"required></td>
            </tr>
            <tr>
              <td>Address :</td>
              <td><input type="text" name="address" value="<% address %>"required></td>
            </tr>
            <tr>
              <td>Phone number :</td>
              <td><input type="text" name="phoneNumber" value="<% phoneNumber %>"required></td>
            </tr>
            <tr>
              <td>Profile :</td>
              <td><input type="text" name="profile" value="<% profile %>"required></td>
            </tr>
            <tr>
              <td>image url :</td>
              <td><input type="text" name="img_url" value="<% img_url %>"required></td>
            </tr>
            <tr>

              <td colspan="2"><input type="submit" value="update"></td>
            </tr>
          </table>
        </form>

</body>
</html>
