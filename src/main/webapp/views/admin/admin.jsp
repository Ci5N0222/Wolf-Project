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

<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Project local -->
<link rel="stylesheet" href="/css/admin.css">
<script src="/js/admin.js"></script>

</head>
<body>
    <main class="admin-container">
        <%@ include file="/views/include/admin_side.jsp" %>
        <section class="admin-main-form">
            <h1 class="admin-main-title">Dash Board</h1>
            <p>총 회원 수 : ${ male + female }명</p><br />
            <div class="admin-dashboard">
            	<!-- 성별 대시보드 -->
            	<div class="dashboard-item">
            		남여 성별 비율 <br />
	            	<div>
						<canvas id="genderChart"></canvas>
					</div>
					<div class="dashboard-info">
						<p>남성 회원 : ${ male }명 ( <fmt:formatNumber value="${ male/(male + female) }" type="percent" /> )</p>
						<p>여성 회원 : ${ female }명 ( <fmt:formatNumber value="${ female/(male + female) }" type="percent" /> )</p>
					</div>
            	</div>
            	
            	<!-- 연령 대시보드 -->
            	<div class="dashboard-item">
            		연령별 사용자수<br />
	            	<div>
						<canvas id="birthChart"></canvas>
					</div>
					<div class="dashboard-info">
						<p>10대 이하 회원 : ${ ageList[0].membersCount }명 ( <fmt:formatNumber value="${ ageList[0].membersCount/(male + female) }" type="percent" /> )</p>
						<p>20대 회원 : ${ ageList[1].membersCount }명 ( <fmt:formatNumber value="${ ageList[1].membersCount/(male + female) }" type="percent" /> )</p>
						<p>30대 회원 : ${ ageList[2].membersCount }명 ( <fmt:formatNumber value="${ ageList[2].membersCount/(male + female) }" type="percent" /> )</p>
						<p>40대 회원 : ${ ageList[3].membersCount }명 ( <fmt:formatNumber value="${ ageList[3].membersCount/(male + female) }" type="percent" /> )</p>
						<p>50대 회원 : ${ ageList[4].membersCount }명 ( <fmt:formatNumber value="${ ageList[4].membersCount/(male + female) }" type="percent" /> )</p>
						<p>60대 이상 회원 : ${ ageList[5].membersCount }명 ( <fmt:formatNumber value="${ ageList[5].membersCount/(male + female) }" type="percent" /> )</p>
					</div>
            	</div>
			</div>
        </section>
        <script>
        	let genderData = [${ male }, ${ female }];
        	let ageData = [${ageList[0].membersCount}, ${ageList[1].membersCount}, ${ageList[2].membersCount}, ${ageList[3].membersCount}, ${ageList[4].membersCount}, ${ageList[5].membersCount}];
        	getGenderChart(genderData);
        	getAgeChart(ageData);
        </script>

    </main>
</body>
</html>