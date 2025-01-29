<%--
  Created by IntelliJ IDEA.
  User: Manuja Ransara
  Date: 11/21/2024
  Time: 5:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Enter Your Details</h2>
              <form action="LoginServlet" method="post">
                <table>

                  <tr>
                    <td>Email:</td>
                    <td><input type="text" name="email" required></td>
                  </tr>
                  <tr>
                    <td>Password:</td>
                    <td><input type="text" name="password" required></td>
                  </tr>

                  <tr>
                    <td colspan="2"><input type="submit" value="Login"></td>
                  </tr>
                </table>
              </form>

</body>
</html>
