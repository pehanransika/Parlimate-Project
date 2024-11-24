<%--
  Created by IntelliJ IDEA.
  User: Manuja Ransara
  Date: 11/21/2024
  Time: 2:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
  <h2>Enter Your Details</h2>
  <form action="UserInsertServlet" method="post">
        <table>

            <tr>
                <td>Email:</td>
                <td><input type="text" name="email" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="text" name="Password" required></td>
            </tr>
            <tr>
                <td>UserType:</td>
                <td><input type="text" name="userType" required></td>
            </tr>
            <tr>
                <td>Name :</td>
                <td><input type="text" name="name" required></td>
            </tr>
            <tr>
                <td>Address :</td>
                <td><input type="text" name="address" required></td>
            </tr>
            <tr>
                <td>Phone number :</td>
                <td><input type="text" name="phoneNumber" required></td>
            </tr>
            <tr>
                <td>Profile :</td>
                <td><input type="text" name="profile" required></td>
            </tr>
            <tr>
                <td>image url :</td>
                <td><input type="text" name="img_url" required></td>
            </tr>
            <tr>

                <td colspan="2"><input type="submit" value="Submit"></td>
            </tr>
        </table>
  </form>

</body>
</html>
