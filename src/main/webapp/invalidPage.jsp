<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 4/18/2025
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Invalid Page</title>
</head>
<body>
<%@ page isErrorPage="true" %>
<h3>Error Details</h3>
<pre><% exception.printStackTrace(new java.io.PrintWriter(out)); %></pre>
</body>
</html>
