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
    *{
        box-sizing: border-box;
    }
    div{
        border: 1px solid black;
        display: flex;
    }
    .container{
        width: 600px;
        height: 600px;
        flex-direction: column;
        margin: auto;
    }
    .title{
        flex: 1;
     
    }
    .contents{
        flex:5;
        flex-direction: column;
    }

    .footer{
        flex: 1;
    }
    .center{
        display: flex;
        justify-content: center;
        align-items: center;
    }


</style>
</head>
<body>
    <div class="container">
        <div class="title center">
            자유게시판
        </div>
        <div style="flex: 1;">
				<div style="flex: 5;" class="center">제목</div>
				<div style="flex: 1;" class="center">작성자</div>
				<div style="flex: 1;" class="center">날짜</div>
				<div style="flex: 1;" class="center" id="a">조회</div>
        </div>    
        <div class="contents">
            <c:forEach var="dto" items="${list}">
                <div style="display: flex; height: 50px;" >
                    <div style="flex: 1;" class="center"><span class="seq">${dto.seq}</span></div>
				    <div style="flex: 5;" class="center"><span class="title">${dto.title}</span> </div>
				    <div style="flex: 1;" class="center">${dto.writer}</div>
				    <div style="flex: 1;" class="center"><fmt:formatDate value="${dto.write_date}" pattern="yyyy.MM.dd"/></div>
				    <div style="flex: 1;" class="center">${dto.view_cout}</div>
                </div>
            </c:forEach>
        </div>
        <div style="flex: 1;" class="center">1 2 3 4 5 6 7 8 9 10</div>
        <div class="footer">
        </div>
    </div>

</body>
</html>