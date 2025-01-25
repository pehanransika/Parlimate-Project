<%--
  Created by IntelliJ IDEA.
  User: Manuja Ransara
  Date: 11/21/2024
  Time: 7:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Profile</title>
</head>
<body>
       <h1>User Profile</h1>
       <h2>ID: ${user.userId}</h2>
       <h2>Gmail: ${user.email}</h2>
       <h2>Password: ${user.password}</h2>
       <h2>UserType: ${user.userType}</h2>
<<<<<<< HEAD
       <h2>name: ${userProfile.name}</h2>
=======
       <h2>name: ${citizen.name}</h2>
>>>>>>> 72354581de48bfd381a545c7f574c30d58d84595
       <a href="updateprofile.jsp?id=${user.userId}&email=${user.email}&password=${user.password}&userType=${user.userType}&name=${citizen.name}">
           <button>Update</button>
       </a>
       <form action="DeleteUserServlet" method="post">
           <input type="hidden" name="id" value="${user.userId}" />
           <input type="hidden" name="userType" value="${user.userType}" />
           <button type="submit">Delete</button>
       </form>




</body>
</html>
