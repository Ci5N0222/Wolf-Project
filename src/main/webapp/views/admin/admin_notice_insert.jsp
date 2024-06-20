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

<!-- tinymce -->
<script src="https://cdn.tiny.cloud/1/9bewfouem96jjnfvuu236yinb3kp53xruh2gkkz3pkfnkw6c/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
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
	        <h1 class="admin-main-title">공지사항 작성</h1>
			<div class="admin-members-list">
				<form action="/insert.board" id="fileform" method="post" enctype="multipart/form-data" >
		            <div class="admin-notice-insert-title">
		                <input type="text" name="title" placeholder="글 제목을 입력하세요">
		            </div>
		            <div id="contents"></div>
		            <div id="files"></div>
		            <div class="notice-insert-btn">
		            	<button class="btn">작성완료</button>        
	                    <button type="button" onclick="location.href='/notice_list.admin'">취소</button>
		            </div>
			    </form>
			</div>
        </section>
    </main>
</body>
</html>