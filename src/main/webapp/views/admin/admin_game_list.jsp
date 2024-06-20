<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- JSTL Fmt -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wolf</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 
<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/admin.css">
<script src="/js/admin.js"></script>

</head>
<body>
	<main class="admin-container">
        <%@ include file="/views/include/admin_side.jsp" %>
        
        <section class="admin-main-form">
        <h1 class="admin-main-title">게임 관리</h1>
        <div class="admin-members-list">
        	<div class="admin-game-insert-btn">
	        	<select id="game-service-select">
        			<option value="9">전체 서비스</option>
        			<option value="1">서비스 활성</option>
        			<option value="0">서비스 정지</option>
        		</select>
        		<button onclick="location.href='/page_game_insert.admin'">게임 추가</button>
        	</div>
             <div class="admin-members-list">
             	<c:if test="${gameList.size() > 0}">
             		<table>
             			<tr>
             				<th>ID</th>
             				<th>대표이미지</th>
             				<th>제목</th>
             				<th>서비스</th>
             			</tr>
	             		<c:forEach var="games" items="${gameList}">
	             			<tr>
	             				<td>${games.seq}</td>
	             				<c:choose>
				        			<c:when test="${games.thumbnail != null}">
				        				<td><img src="/${games.thumbnail}" alt="게임 섬네일 이미지"></td>
				        			</c:when>
				        			<c:otherwise>
				        				<td><img src="/images/default-game.png" alt="게임 섬네일 이미지"></td>
				        			</c:otherwise>
				        		</c:choose>
	             				<td><span class="admin-game-list-title"><a href="game_detail.admin?seq=${games.seq}">${games.title}</a></span></td>
	             				<c:choose>
	             					<c:when test="${games.service_code eq 1}">
	             						<td class="admin-game-list-service-ing" style="color:green; font-weight:800">활성</td>
	             					</c:when>
	             					<c:otherwise>
	             						<td class="admin-game-list-service-stop" style="color:red; font-weight:800">정지</td>
	             					</c:otherwise>
	             				</c:choose>
	             				
	             			</tr>
	             		</c:forEach>
             		</table>
             	</c:if>
             </div>
             <div class="page-navigation"></div>
     		 <script>
     		 	 pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/game_list.admin", "${wpageName}", ${wpage});
     		 </script>
        </div>
        </section>

    </main>
</body>
</html>