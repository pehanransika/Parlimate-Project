<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Wrong Page</title>
  <script type="text/javascript">
    setTimeout(function(){
      window.location.href = "announcements.jsp";
    }, 2000); // Redirect after 2 seconds
  </script>
</head>
<body>
<h1>Oops! Something went wrong.</h1>
<p>The page you were looking for could not be found. You will be redirected to the announcements page shortly.</p>
<p>If you want to go there immediately, <a href="announcements.jsp">click here</a>.</p>
</body>
</html>
