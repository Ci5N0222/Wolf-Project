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

<!-- tinymce -->
<script src="https://cdn.tiny.cloud/1/r2rzvjel9syljhm3rt83aafhrjazwe85b2hv02ods9k46db0/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/admin.css">
<script src="/js/admin.js"></script>
<script src="/js/tinymce.js"></script>

</head>
<body>
	<main class="admin-container">
        <%@ include file="/views/include/admin_side.jsp" %>
        <section class="admin-main-form">
        
	        <c:choose>
        		<c:when test="${ board_code eq 2 }">
        			<h1 class="admin-main-title">공지사항 작성</h1>
        		</c:when>
        		<c:when test="${ board_code eq 3 }">
        			<h1 class="admin-main-title">Q&A 작성</h1>
        		</c:when>
        		<c:otherwise>
        		<h1 class="admin-main-title">FAQ 작성</h1>
        		</c:otherwise>
        	</c:choose>
			<div class="admin-members-list">
				<form action="/notice_insert.admin" id="fileform" method="post" enctype="multipart/form-data" >
		            <div class="admin-notice-insert-title">
		                <input type="text" name="title" placeholder="글 제목을 입력하세요">
		            </div>
		            <div id="contents"></div>
		            <div id="files"></div>
		            <div class="notice-insert-btn">
		            	<button class="btn">작성완료</button>        
	                    <button type="button" onclick="location.href='/notice_list.admin'">취소</button>
		            </div>
		            <input type="hidden" name="board_code" value="${board_code}">
			    </form>
			</div>
        </section>
    </main>
</body>
</html>