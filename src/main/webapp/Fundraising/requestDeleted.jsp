<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Deletion Confirmation</title>
    <style>
        /* Your existing styles */
    </style>
</head>
<body>
<div class="container">
    <h1>Operation Completed</h1>
    <p>The requested operation has been processed successfully.</p>

    <!-- Debug output (remove after testing) -->
    <div style="color:red; display:none;">
        DEBUG: ${alertMessage}
    </div>

    <a href="javascript:history.back()" class="back-link">← Back</a>
    <a href="index.jsp" class="back-link">← Home</a>
</div>

<script>
    <c:if test="${not empty alertMessage}">
    try {
        // Use JSON.stringify to properly escape the message
        var message = JSON.parse(`"${alertMessage.replaceAll('"', '\\"')}"`)
            .replace(/\\n/g, '\n');
        alert(message);
    } catch(e) {
        console.error("Failed to show alert:", e);
        alert("Operation completed"); // Fallback
    }
    </c:if>
</script>
</body>
</html>
