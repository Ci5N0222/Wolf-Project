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
<title>First-Project</title>

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
        <h1 class="admin-main-title">Game List</h1>
        <div class="admin-members-list">
        	<div class="admin-game-insert-btn">
	        	<select id="game-service-select">
        			<option value="9">전체 목록</option>
        			<option value="1">서비 중 </option>
        			<option value="0">서비스 정지</option>
        		</select>
        		<button onclick="location.href='/page_game_insert.admin'">게임 추가</button>
        	</div>
             <div class="admin-members-list">
             	<c:if test="${gameList.size() > 0}">
             		<table>
             			<tr>
             				<th>Thumbnail</th>
             				<th>Title</th>
             				<th>Service</th>
             			</tr>
	             		<c:forEach var="games" items="${gameList}">
	             			<tr>
	             				<c:choose>
				        			<c:when test="${games.thumbnail != 'none'}">
				        				<td><img src="/${games.thumbnail}" alt="게임 섬네일 이미지"></td>
				        			</c:when>
				        			<c:otherwise>
				        				<td><img src="/images/default-game.png" alt="게임 섬네일 이미지"></td>
				        			</c:otherwise>
				        		</c:choose>
	             				<td><span class="admin-game-list-title"><a href="game_detail.admin?seq=${games.seq}">${games.title}</a></span></td>
	             				<c:choose>
	             					<c:when test="${games.service_code eq 1}">
	             						<td class="admin-game-list-service-ing" style="color:green; font-weight:800">서비스 중</td>
	             					</c:when>
	             					<c:otherwise>
	             						<td class="admin-game-list-service-stop" style="color:red; font-weight:800">서비스 정지</td>
	             					</c:otherwise>
	             				</c:choose>
	             				
	             			</tr>
	             		</c:forEach>
             		</table>
             		<div class="page-navigation"></div>
             		<script>
             			pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/game_list.admin", "${wpageName}", ${wpage});
             		</script>
             	</c:if>
             </div>
        </div>
        	
             <!-- 멤버 검색 -->
        </section>

    </main>
</body>
</html>