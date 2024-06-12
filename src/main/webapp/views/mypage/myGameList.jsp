<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 플레이 정보</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <style>
      * {
        box-sizing: border-box;
      }
      div {
        border: 1px solid black;
      }
      body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .container {
        width: 75%;
        height: 550px;
        margin: auto;
        display: flex;
        flex-direction: column;
      }

      .container > div {
        flex: 1;
        display: flex;
      }

      .container > div > :first-child {
        flex: 3;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .container > div > :last-child {
        flex: 9;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .container > div > :last-child > div {
        width: 90%;
        height: 80%;
        display: flex;
        justify-content: center;
        align-items: center;
      }
    </style>
  </head>
  <body>
    <div class="container">
    <c:if test="${result == null}">
        플레이 한 게임이 없습니다.
        
    </c:if>
    <c:if test="${result != null}">
        <c:forEach var="i" items="${result}">
            <div class="game1">
                <div><p>${i.title}</p></div>
                <div>
                    <div>${i.score}</div>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>
  </body>
</html>
