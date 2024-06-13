<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        #container {
            max-width: 400px;
            width: 100%;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        #message {
            margin-top: 10px;
            text-align: center;
            color: red;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
    <div id="container">
        <h2>ID 찾기</h2>
        <form id="findIdForm" method="post">
            <label for="name">이름:</label>
            <input type="text" id="name" name="name" required>
            <label for="email">이메일:</label>
            <input type="text" id="email" name="email" required>
            <button type="button" id="Certification">확인</button>
            <p id="message"></p>
        </form>
    </div>

    <script>
        $("#Certification").on("click", function() {
            if ($("#name").val() === "") {
                alert("Please enter your name.");
                return false;
            }
            if ($("#email").val() === "") {
                alert("Please enter your email.");
                return false;
            }

            var formData = {
                name: $("#name").val(),
                email: $("#email").val()
            };

            $.ajax({
                url: '/selectId.members',
                type: 'POST',
                data: formData,
                success: function(response) {
                    alert("회원님의 아이디는 : : " + response);
                    location.href = '/views/members/login.jsp';
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert("An error occurred. Please try again.");
                }
            });
        });
    </script>
</body>
</html>
