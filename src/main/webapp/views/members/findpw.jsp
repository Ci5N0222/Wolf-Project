<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 </title>
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
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        #passwordMismatch {
            margin-top: 10px;
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
        #Result {
            margin-top: 10px;
            text-align: center;
        }
        #passwordChangeForm {
            display: none;
        }
    </style>
</head>
<body>
    <div id="container">
        <h2>Email Verification</h2>
        <div id="Result"></div>
        <form id="sendEmailForm" action="/sendEmail.members" method="post">
            <label for="id">ID:</label>
            <input type="text" id="id" name="id" placeholder="ID를 입력해주세요.">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="Emali을 입력해주세요.">
            <button type="submit">인증번호 발송</button>
        </form>
        
        <form id="passwordChangeForm" action="/changePassword.members" method="post">
            <label for="CertificationCode">인증번호 :</label>
            <input type="text" id="CertificationCode" name="CertificationCode"  placeholder="인증번호를 입력해주세요">
            <label for="newPassword">새 비밀번호:</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력해주세요">
            <label for="confirmNewPassword">새 비밀번호 확인:</label>
            <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="새 비밀번호를 확인해주세요.">
            <div id="passwordMismatch" style="display: none; color: red;">
                비밀번호가 일치하지 않습니다!
            </div>
            <button id="CertificationCodeBtn" type="button">인증번호 확인</button>
            <button id="changePasswordBtn" type="button" name="changePasswordBtn" style="display: none;">비밀번호 변경</button>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
        $(document).ready(function() {
            $('#sendEmailForm').submit(function(e) {
                e.preventDefault();
                
                var formData = {
                        id: $('#id').val(),
                        email: $('#email').val()
                    };
                
                $.ajax({
                    url: '/sendEmail.members',
                    type: 'POST',
                    data: formData,
                    success: function(data) {
                        if (data === 'true') {
                            $('#Result').text('이메일 전송 성공!!');
                            $('#passwordChangeForm').show();
                            $('#email').prop('disabled', true); // 이메일 입력 필드 비활성화
                        } else {
                            $('#Result').text('아이디와 이메일이 일치하지 않습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                    }
                });
            });

            $('#CertificationCodeBtn').click(function() {
                var formData = $('#passwordChangeForm').serialize();
                
                $.ajax({
                    url: '/CertificationCode.members',
                    type: 'POST',
                    data: formData,
                    success: function(data) {
                        if (data === 'true') {
                            $('#Result').text('인증 성공!');
                            $('#changePasswordBtn').show();
                        } else {
                            $('#Result').text('인증 실패!');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                    }
                });
            });

            $('#changePasswordBtn').click(function() {
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmNewPassword').val();
                var id = $('#id').val();
                var CertificationCode = $('#CertificationCode').val(); // 인증 코드 가져오기
                
                if (newPassword !== confirmPassword) {
                    $('#passwordMismatch').show();
                    return;
                } else {
                    $('#passwordMismatch').hide();
                }

                var formData = {
                    id: id,
                    newPassword: newPassword,
                    CertificationCode: CertificationCode
                };

                $.ajax({
                    url: '/changePassword.members',
                    type: 'POST',
                    data: formData,
                    success: function(data) {
                    	alert("비밀번호가 성공적으로 변경 되었습니다.")
                    	location.href = '/views/members/login.jsp';
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                    }
                });
            });
        });
    </script>
</body>
</html>
