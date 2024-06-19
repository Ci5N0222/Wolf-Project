<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>First-Project</title>

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
            <div class="admin-dashboard">
            
            	<!-- 성별 대시보드 -->
            	<div class="dashboard-item">
            		남여 성별 비율 <br />
 					총 회원 수: ${ male + female } <br />
	            	<div>
						<canvas id="genderChart"></canvas>
					</div>

					<script>
					const genderLabels = ["남성", "여성"]
					const genderChart = document.getElementById('genderChart');
					new Chart(genderChart, {
						type: 'bar',
						data: {
							 labels: genderLabels,
							  datasets: [{
							    label: '남여 이용자 비율',
							    data: [${ male }, ${ female }],
							    backgroundColor: [
							      'rgba(255, 99, 132, 0.2)',
							      'rgba(255, 159, 64, 0.2)'
							    ],
							    borderColor: [
							      'rgb(255, 99, 132)',
							      'rgb(255, 159, 64)'
							    ],
							    borderWidth: 1
							  }]
						},
						options: {
						    scales: {
						      y: {
						        beginAtZero: true
						      }
						    }
						  },
					});
					</script>
            	</div>
            	
            	<!-- 연령 대시보드 -->
            	<div class="dashboard-item">
            		연령별 사용자수<br />
	            	총 회원 수: ${ male + female } <br />
	            	<div>
						<canvas id="birthChart"></canvas>
					</div>
					
					<script>
						const birthLabels = ["10대 이하", "20대", "30대", "40대", "50대", "60대 이상"]
						const birthChart = document.getElementById('birthChart');
						new Chart(birthChart, {
							type: 'bar',
							data: {
								 labels: birthLabels,
								  datasets: [{
								    label: '연령별 이용자 수',
								    data: [${ageList[0].membersCount}, ${ageList[1].membersCount}, ${ageList[2].membersCount}, ${ageList[3].membersCount}, ${ageList[4].membersCount}, ${ageList[5].membersCount}],
								    backgroundColor: [
								      'rgba(255, 99, 132, 0.2)',
								      'rgba(255, 159, 64, 0.2)',
								      'rgba(255, 205, 86, 0.2)',
								      'rgba(75, 192, 192, 0.2)',
								      'rgba(54, 162, 235, 0.2)',
								      'rgba(153, 102, 255, 0.2)',
								      'rgba(201, 203, 207, 0.2)'
								    ],
								    borderColor: [
								      'rgb(255, 99, 132)',
								      'rgb(255, 159, 64)',
								      'rgb(255, 205, 86)',
								      'rgb(75, 192, 192)',
								      'rgb(54, 162, 235)',
								      'rgb(153, 102, 255)',
								      'rgb(201, 203, 207)'
								    ],
								    borderWidth: 1
								  }]
							},
							options: {
							    scales: {
							      y: {
							        beginAtZero: true
							      }
							    }
							  },
						});
					</script>
            	</div>
            	
				
			</div>
        </section>

    </main>
</body>
</html>