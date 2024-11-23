<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Fundraising Request</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input, select, textarea {
            margin-top: 5px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        input[type="submit"] {
            margin-top: 20px;
            background: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Add Fundraising Request</h2>
    <form action="CreateNewRequestServlet" method="post">
        <!-- Title -->
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>

        <!-- Description -->
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea>

        <!-- Category -->
        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="">--Select a Category--</option>
            <option value="Education">Education</option>
            <option value="Health">Health</option>
            <option value="Environment">Environment</option>
            <option value="Community">Community</option>
        </select>

        <!-- Target Amount -->
        <label for="targetamount">Target Amount:</label>
        <input type="number" id="targetAmount" name="targetamount" step="0.01" required>

        <!-- Currency -->
        <label for="currency">Currency:</label>
        <select id="currency" name="currency" required>
            <option value="">--Select Currency--</option>
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="INR">INR</option>
            <option value="GBP">GBP</option>
        </select>

        <!-- Date and Time -->
        <label for="datetime">Date and Time:</label>
        <input type="datetime-local" id="datetime" name="datetime" required>

        <!-- Submit Button -->
        <input type="submit" value="Submit Request">
    </form>
</div>
</body>
</html>