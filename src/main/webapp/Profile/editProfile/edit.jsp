<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 700px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            grid-column: span 2;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background: #007bff;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s ease-in-out;
        }

        .btn:hover {
            background: #0056b3;
        }

        /* Styling the left and right side forms */
        .left-side {
            display: flex;
            flex-direction: column;
        }

        .right-side {
            display: flex;
            flex-direction: column;
        }

        /* Ensuring that the layout looks good on small screens */
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
                width: 90%;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Update Profile</h1>

    <div class="left-side">
        <div class="form-group">
            <label>Email:</label>
            <input type="text" name="email" value="${param.email}" readonly>
        </div>
        <div class="form-group">
            <label>User Type:</label>
            <input type="text" name="userType" value="${param.userType}" readonly>
        </div>
    </div>

    <div class="right-side">
        <div class="form-group">
            <label>Password:</label>
            <input type="password" name="password" value="${param.password}" required>
        </div>
        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" value="${param.name}" required>
        </div>
        <div class="form-group">
            <label>Address:</label>
            <input type="text" name="address" value="${param.address}" required>
        </div>
        <div class="form-group">
            <label>Phone Number:</label>
            <input type="text" name="phoneNumber" value="${param.phoneNumber}" required>
        </div>
        <div class="form-group">
            <label>Profile:</label>
            <input type="text" name="profile" value="${param.profile}" required>
        </div>
        <div class="form-group">
            <label>Image URL:</label>
            <input type="text" name="img_url" value="${param.img_url}" required>
        </div>
        <button type="submit" class="btn">Update</button>
    </div>
</div>

<script>
    // Ensure readonly fields cannot be edited even through JavaScript console
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelector('input[name="email"]').addEventListener("keydown", function (e) {
            e.preventDefault();
        });
        document.querySelector('input[name="userType"]').addEventListener("keydown", function (e) {
            e.preventDefault();
        });
    });
</script>
</body>
</html>
