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
        	<h1 class="admin-main-title">Member Info</h1>
             <div class="admin-members-list">
             	
           		<!-- ID -->
	            <p>아이디 : <span id="id">${ member.id }</span></p>
	            <p>이름 : <span id="name">${ member.name }</span></p>
	            <p>닉네임 : <span id="nickname">${ member.nickname }</span></p>
	            <p>전화번호 : <span id="phone">${ member.phone }</span></p>
	            <p>이메일 : <span id="email">${ member.email }</span></p>
	            <p>성별 :
	            	<c:choose>
	            		<c:when test="${ member.gender eq 'M' }">
	            			<span id="gender">남</span>
	            		</c:when>
	            		<c:otherwise>
	            			<span id="gender">여</span>
	            		</c:otherwise>
	            	</c:choose>
	            </p>
	            <p>생년월일 : 
	            	<span id="birth">${ member.birth }</span>
	            </p>
	            <p>회원상태 : 
	            	<c:choose>
	            		<c:when test="${ member.grade eq 1 }">
	            			<span id="grade">일반 회원</span>
	            		</c:when>
	            		<c:when test="${ member.grade eq 2 }">
	            			<span id="grade">휴면 회원</span>
	            		</c:when>
	            		<c:when test="${ member.grade eq 98 }">
	            			<span id="grade">서브 관리자</span>
	            		</c:when>
	            		<c:when test="${member.grade eq 99 }">
	            			<span id="grade">메인 관리자</span>
	            		</c:when>
	            	</c:choose>
	            </p>
	            
	            <p>가입일 : <span><fmt:formatDate value="${ member.join_date }" pattern="yyyy-MM-dd" /></span></p>
		            
        		<form action="/members_update.admin" method="post" id="admin_update">  
		            <input type="hidden" id="input_id" name="id">
		            <input type="hidden" id="input_name" name="name">
		            <input type="hidden" id="input_nickname" name="nickname">
		            <input type="hidden" id="input_phone" name="phone">
		            <input type="hidden" id="input_email" name="email">
		            <input type="hidden" id="input_grade" name="grade">

					<div class="btn-box1">
						<button type="button" onclick="adminMemberEdit()">정보 수정하기</button>
		            	<button type="button" onclick="location.href='/members_list.admin'">목록보기</button>
					</div>
					<div class="btn-box2">
						<button type="submit">확인</button>
		            	<button type="button" onclick="location.reload()">취소</button>
					</div>
             	</form>
             	
             </div>
        </section>

    </main>
</body>
</html>