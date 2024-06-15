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
	        <h1 class="admin-main-title">Members List</h1>
			<div class="admin-members-list">
				<c:if test="${membersList.size() > 0}">
					<table>
						<tr>
							<th>ID</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>회원 등급</th>
						</tr>
			 			<c:forEach var="members" items="${membersList}">
				 			<tr>
				 				<td><a href="/members_detail.admin?id=${members.id}">${members.id}</a></td>
				 				<td>${members.name}</td>
				 				<td>${members.nickname}</td>
				 				<c:choose>
							   		<c:when test="${ members.grade eq 1 }">
							   			<td>일반 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 2 }">
							   			<td>휴면 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 3 }">
							   			<td>블랙 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 98 }">
							   			<td>서브 관리자</td>
							   		</c:when>
							   		<c:when test="${members.grade eq 99 }">
							   			<td>메인 관리자</td>
							   		</c:when>
							   	</c:choose>
				 			</tr>
			 			</c:forEach>
					</table>
					<div class="page-navigation"></div>
					<script>
						/** 페이징 네이게이터 **/
						pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/members_list.admin");
					</script>
				</c:if>
			</div>
	          <!-- 멤버 검색 -->
        </section>

    </main>
</body>
</html>