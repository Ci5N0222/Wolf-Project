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
	        <h1 class="admin-main-title">공지사항</h1>
			<div class="admin-members-list">
				<div class="admin-game-insert-btn">
					<button onclick="location.href='/page_notice_insert.admin'">공지 작성</button>
					<div class="member-search-box">
						<input type="text" id="member_search_text" placeholder="검색할 ID를 입력하세요">
						<button onclick="adminMemberSearch()">search</button>
					</div>
				</div>
				
             	<div class="admin-members-list">
				<c:if test="${boardList.size() > 0}">
					<table>
						<tr>
							<th>N0.</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
			 			<c:forEach var="boardList" items="${boardList}">
				 			<tr>
				 				<td>${boardList.seq}</td>
				 				<td><a href="/detail.board?seq=${boardList.seq}&target=&keyword=&board_code=2">${boardList.title}</a></td>
				 				<td>${boardList.nickname}</td>
				 				<td>${boardList.write_date}</td>
				 				<td>${boardList.count}</td>
				 			</tr>
			 			</c:forEach>
					</table>
				</c:if>
				</div>
				<div class="page-navigation"></div>
				<script>
					/** 페이징 네이게이터 **/
					pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/notice_list.admin");
				</script>
			</div>
        </section>

    </main>
</body>
</html>