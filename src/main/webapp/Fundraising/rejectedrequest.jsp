<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rejected Requests</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Embedded Styling -->
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h1 {
            font-size: 28px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .badge {
            background-color: #dc3545;
            color: #fff;
            font-size: 14px;
            padding: 5px 12px;
            border-radius: 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table thead {
            background-color: #343a40;
            color: white;
        }

        .table th,
        .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .text-muted {
            color: #888;
            font-style: italic;
        }

        .action-btn {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            margin-right: 5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .no-records {
            text-align: center;
            padding: 40px 0;
            color: #666;
        }

        .no-records i {
            color: #bbb;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .table thead {
                display: none;
            }

            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }

            .table tr {
                margin-bottom: 15px;
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 10px;
            }

            .table td {
                text-align: right;
                position: relative;
                padding-left: 50%;
            }

            .table td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                width: 45%;
                font-weight: bold;
                text-align: left;
            }
        }
    </style>
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
                        <td data-label="Rejection ID">${rejection.rejectionId}</td>
                        <td data-label="Request ID">${rejection.requestId}</td>
                        <td data-label="Title">
                            <c:choose>
                                <c:when test="${not empty rejection.title}">
                                    ${rejection.title}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">(Original request deleted)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="Reason">${rejection.reasonForReject}</td>
                        <td data-label="Rejected On">
                            <fmt:formatDate value="${rejection.rejectionDate}" pattern="MMM dd, yyyy hh:mm a" />
                        </td>
                        <td data-label="Actions">
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
</body>
</html>
