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
             	<c:if test="${gameList.size() > 0}">
             		<table>
             			<tr>
             				<th>ID</th>
             				<th>title</th>
             				<th>thumbnail</th>
             			</tr>
	             		<c:forEach var="games" items="${gameList}">
	             			<tr>
	             				<td>${games.seq}</td>
	             				<td>${games.title}</td>
	             				<td>${games.thumbnail}</td>
	             			</tr>
	             		</c:forEach>
             		</table>
             		<!-- 페이징 -->
             		<script>
             			pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/game_list.admin");
             		</script>
             	</c:if>
             </div>
             <!-- 멤버 검색 -->
        </section>

    </main>
</body>
</html>