<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 4/18/2025
  Time: 7:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Profile</title>
    <link rel="stylesheet" href="../../index/sidebar1.css" />
    <link rel="stylesheet" href="../../index/header/header.css" />
    <link rel="stylesheet" href="../../index.css" />
    <link rel="stylesheet" href="../profile.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.6.0/css/all.css" />
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
<%@ include file="../../index/sidebar.jsp" %>
<%@ include file="../../index/header/header.jsp" %>
<div class="container">
    <h1>Update Profile</h1>

    <form action="updateProfile" method="post">
        <!-- Left Side: Account Info -->
        <div class="left-side">
            <div class="form-group">
                <label>Email:</label>
                <input type="text" name="email" placeholder="Enter your email" readonly>
            </div>
            <div class="form-group">
                <label>User Type:</label>
                <input type="text" name="userType" value="Politician" readonly>
            </div>
        </div>

        <!-- Right Side: Personal Info -->
        <div class="right-side">
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" placeholder="Full name" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <input type="text" name="address" placeholder="Your address" required>
            </div>
            <div class="form-group">
                <label>Phone Number:</label>
                <input type="text" name="phoneNumber" placeholder="Your phone number" required>
            </div>
            <div class="form-group">
                <label>Profile Summary:</label>
                <textarea name="profile" placeholder="Short description about yourself" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label>Image URL:</label>
                <input type="text" name="img_url" placeholder="Link to profile image" required>
            </div>
        </div>

        <hr>

        <!-- Policy Section -->
        <h2>Your Policy Descriptions</h2>
        <p>Briefly describe your stance or plans under each topic:</p>

        <div class="form-group">
            <label>Education Policy:</label>
            <textarea name="policy_education" placeholder="Describe your education policies..." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Healthcare Policy:</label>
            <textarea name="policy_healthcare" placeholder="Describe your healthcare plans..." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Economy & Employment Policy:</label>
            <textarea name="policy_economy" placeholder="Plans for job creation, economy, businesses..." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Youth & Sports Development:</label>
            <textarea name="policy_youth" placeholder="Describe your ideas for empowering youth and sports..." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Infrastructure & Development:</label>
            <textarea name="policy_infrastructure" placeholder="Your views on transport, roads, etc." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Law & Order / Justice:</label>
            <textarea name="policy_law" placeholder="Your stance on justice system, police, law reforms..." rows="3"></textarea>
        </div>

        <div class="form-group">
            <label>Other Areas (Optional):</label>
            <textarea name="policy_other" placeholder="Anything else you'd like to share..." rows="3"></textarea>
        </div>

        <button type="submit" class="btn">Update</button>
    </form>
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
