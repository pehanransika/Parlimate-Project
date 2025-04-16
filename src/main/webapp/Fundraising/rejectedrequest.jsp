<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rejected Requests</title>
    <!-- Keep your existing styles -->
</head>
<body>
<div class="container">
    <h1>
        <i class="fas fa-ban"></i> Rejected Requests
        <c:if test="${not empty rejectedRequests}">
            <span class="badge badge-danger">${fn:length(rejectedRequests)}</span>
        </c:if>
    </h1>

    <c:choose>
        <c:when test="${not empty rejectedRequests}">
            <table class="table">
                <thead>
                <tr>
                    <th>Rejection ID</th>
                    <th>Request ID</th>
                    <th>Title</th>
                    <th>Reason</th>
                    <th>Rejected On</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${rejectedRequests}" var="rejection">
                    <tr>
                        <td>${rejection.rejectionId}</td>
                        <td>${rejection.requestId}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty rejection.title}">
                                    ${rejection.title}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">(Original request deleted)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${rejection.reasonForReject}</td> <!-- Note the property name -->
                        <td>
                            <fmt:formatDate value="${rejection.rejectionDate}"
                                            pattern="MMM dd, yyyy hh:mm a" />
                        </td>
                        <td>
                            <a href="ViewRequestServlet?requestId=${rejection.requestId}"
                               class="action-btn btn-primary btn-sm">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="DeleteRejectionServlet?rejectionId=${rejection.rejectionId}"
                               class="action-btn btn-danger btn-sm"
                               onclick="return confirm('Permanently delete this rejection record?')">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-records">
                <i class="fas fa-info-circle fa-2x"></i>
                <p>No rejected requests found</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</body>
</html>