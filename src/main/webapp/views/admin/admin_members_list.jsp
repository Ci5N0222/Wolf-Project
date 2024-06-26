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
<title>Wolf-Admin</title>
<link rel="icon" href="/images/favicon.png">

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
	        <h1 class="admin-main-title">회원 관리</h1>
			<div class="admin-members-list">
				<div class="admin-game-insert-btn">
					<select id="members-id-select">
						<option value="0">전체회원</option>
				        <option value="1">일반회원</option>
				        <option value="2">휴면계정</option>
				        <option value="3">블랙리스트</option>
				        <option value="98">서브관리자</option>
				        <option value="99">메인관리자</option>
					</select>
					<div class="member-search-box">
						<input type="text" id="member_search_text" placeholder="검색할 ID를 입력하세요">
						<button onclick="adminMemberSearch()">search</button>
					</div>
				</div>
				
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
							   			<td class="member-select-noraml">일반 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 2 }">
							   			<td class="member-select-dormant">휴면 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 3 }">
							   			<td class="member-select-black">블랙 회원</td>
							   		</c:when>
							   		<c:when test="${ members.grade eq 98 }">
							   			<td class="member-select-sub-manager">서브 관리자</td>
							   		</c:when>
							   		<c:when test="${members.grade eq 99 }">
							   			<td class="member-select-main-manager">메인 관리자</td>
							   		</c:when>
							   	</c:choose>
				 			</tr>
			 			</c:forEach>
					</table>
				</c:if>
				</div>
				<div class="page-navigation"></div>
				<script>
					/** 페이징 네이게이터 **/
					pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/members_list.admin", "${wpageName}", ${wpage});
				</script>
			</div>
        </section>

    </main>
</body>
</html>