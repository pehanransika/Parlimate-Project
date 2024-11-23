<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Update Profile</title>
</head>
<body>
<h1>Update Profile</h1>

<form action="UpdateUserServlet" method="post">
  <table>
    <tr>
      <td>Email:</td>
      <td><input type="text" name="email" value="${param.email}" required></td>
    </tr>
    <tr>
      <td>Password:</td>
      <td><input type="password" name="password" value="${param.password}" required></td>
    </tr>
    <tr>
      <td>User Type:</td>
      <td><input type="text" name="userType" value="${param.userType}" readonly></td>
    </tr>
    <tr>
      <td>Name:</td>
      <td><input type="text" name="name" value="${param.name}" required></td>
    </tr>
    <tr>
      <td>Address:</td>
      <td><input type="text" name="address" value="${param.address}" required></td>
    </tr>
    <tr>
      <td>Phone Number:</td>
      <td><input type="text" name="phoneNumber" value="${param.phoneNumber}" required></td>
    </tr>
    <tr>
      <td>Profile:</td>
      <td><input type="text" name="profile" value="${param.profile}" required></td>
    </tr>
    <tr>
      <td>Image URL:</td>
      <td><input type="text" name="img_url" value="${param.img_url}" required></td>
    </tr>
  </table>
  <button type="submit">Update</button>
</form>
</body>
</html>
