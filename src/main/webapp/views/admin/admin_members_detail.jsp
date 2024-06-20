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
        	<h1 class="admin-main-title">Member Info</h1>
             <div class="admin-members-info">
             
             	<label for="id">아이디</label>
            	<input type="text" id="id" value="${member.id}" readonly>
            	
            	<label for="name">이름</label>
            	<input type="text" id="name" value="${member.name}" readonly>
            	
            	<label for="nickname">닉네임</label>
            	<input type="text" id="nickname" value="${member.nickname}" readonly>
            	
            	<label for="phone">전화번호</label>
            	<input type="text" id="phone" value="${member.phone}" readonly>
            	
            	<label for="email">이메일</label>
            	<input type="text" id="email" value="${member.email}" readonly>
            	
            	<label for="gender">성별</label>
            	<c:choose>
            		<c:when test="${ member.gender eq 'M' }">
            			<input type="text" id="gender" value="남성 유저" readonly>
            		</c:when>
            		<c:otherwise>
            			<input type="text" id="gender" value="여성 유저" readonly>
            		</c:otherwise>
            	</c:choose>
            	
            	<label for="birth">생년월일</label>
            	<input type="text" id="birth" value="${member.birth}" readonly>
            	
            	<label for="grade">회원상태</label>
            	<c:choose>
            		<c:when test="${ member.grade eq 1 }">
            			<input type="text" id="grade" value="일반 회원" readonly>
            		</c:when>
            		<c:when test="${ member.grade eq 2 }">
            			<input type="text" id="grade" value="휴면 회원" readonly>
            		</c:when>
            		<c:when test="${ member.grade eq 3 }">
            			<input type="text" id="grade" value="블랙 회원" readonly>
            		</c:when>
            		<c:when test="${ member.grade eq 98 }">
            			<input type="text" id="grade" value="서브 관리자" readonly>
            		</c:when>
            		<c:when test="${member.grade eq 99 }">
            			<input type="text" id="grade" value="메인 관리자" readonly>
            		</c:when>
            	</c:choose>
            	
           	    <select id="grade_select">
			        <option value="1">일반회원</option>
			        <option value="2">휴면계정</option>
			        <option value="3">블랙리스트</option>
			        <option value="98">서브관리자</option>
			        <option value="99">메인관리자</option>
			    </select>
            	
            	<label for="join_date">가입일</label>            	
            	<span class="member-info-date"><fmt:formatDate value="${ member.join_date }" pattern="yyyy-MM-dd" /></span>

				<div class="btn-box1">
					<button onclick="adminMemberEdit(${member.grade})">등급 수정</button>
	            	<button onclick="location.href='/members_list.admin'">목록보기</button>
				</div>
				<div class="btn-box2">
					<button onclick="adminMemberUpdate('${member.id}')">확인</button>
	            	<button onclick="location.reload()">취소</button>
				</div>
             	
             </div>
        </section>

    </main>
</body>
</html>