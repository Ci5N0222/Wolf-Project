<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 <style>
        div {
            border: 1px solid #000;
        }

        .container {
            width: 500px;
            height: 300px;
            margin: auto;
            display: flex;
        }

        .container>div {
            flex: 1;
        }

        .container>div:first-child {
            background-color: bisque;
            display: flex;
            flex-direction: column;
        }

        .container>div:first-child div {
            flex: 8;
        }

        .container>div:first-child button {
            flex: 2;
        }

        .container>div:last-child {
            background-color: thistle;
        }
    </style>
</head>
<body>
 ${seq}
    <div class="container">
        <div class="box1">
            <div>이미지</div>
            <button>버튼</button>
        </div>
        <div class="box2">
        </div>
    </div>
</body>
</html>