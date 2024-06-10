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
<link rel="stylesheet" href="css/style.css">
<script src="js/main.js"></script>

<style>
	* {
	    box-sizing: border-box;
	    margin: 0;
	    padding: 0;
	}
	
	.admin-container {
	    display: flex;
	    height: 100vh;
	    width: 100%;
	}
	
	.admin-side-menu {
	    flex: 1;
	    height: 100%;
	    background-color: antiquewhite;
	}
	
	.admin-side-menu > p:hover {
		cursor: pointer;
	}
	
	.admin-side-menu > p {
	    padding: 20px;
	    font-size: 20px;
	    font-weight: 800;
	    text-align: center;
	}
	
	.admin-logo {
		display: flex;
		justify-content: center;
		padding: 10px;
	}
	
	.admin-logo > img {
		width: 230px;
	}
	
	.admin-main-form {
	    flex: 4;
	    background-color: aqua;
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	}
	
	.admin-dashboard {
	    width: 90%;
	    background-color: white;
	    display: flex;
    	justify-content: space-around;
	    
	}
	
	.admin-dashboard > .dashboard-item {
		width: 300px;
		height: 300px;
	}
	
	.admin-logout {
		padding: 10px;
		display: flex;
		justify-content: space-around;
	}
	.admin-logout > p {
		margin: 20px 0;	
	}
	.admin-logout > p:hover {
		cursor: pointer;
	}
	
	.admin-main-title {
		margin: 30px 0;
		font-size: 50px;
	}
	
	
</style>

</head>
<body>
    <main class="admin-container">
        <aside class="admin-side-menu">
            <div class="admin-logo">
                <img src="/images/img09.png" alt="logo">
            </div>
            <p onclick="/location.href='/main.admin'"> 대시보드 </p>
            <p onclick="/location.href='/main.admin'"> 멤버목록 </p>
            <p onclick="/location.href='/main.admin'"> 공지사항 </p>
            <p onclick="/location.href='/main.admin'"> FAQ </p>
            <p onclick="/location.href='/main.admin'"> QNA </p>
            <div class="admin-logout">
	            <p onclick="location.href='/'">홈페이지</p>
	            <p onclick="location.href='/logout.admin'">로그아웃</p>
            </div>
        </aside>
        
        <section class="admin-main-form">
            <h1 class="admin-main-title">관리자 페이지</h1>
            <h2 class="admin-sub-title">대시보드</h2>
            <div class="admin-dashboard">
            
            	<!-- 성별 대시보드 -->
            	<div class="dashboard-item">
            		남여 성비 <br />
	            	총 회원 수: ${ male + female } <br />
	            	남성 : ${ male } <br />
	            	여성 : ${ female } <br />
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
            		연령별 사용자수  <br />
	            	총 회원 수: ${ male + female } <br />
	            	남성 : ${ male } <br />
	            	여성 : ${ female } <br />
	            	<div>
						<canvas id="birthChart"></canvas>
					</div>
					
					<script>
						const birthLabels = ["10대", "20대", "30대", "40대", "50대", "60대"]
						const birthChart = document.getElementById('birthChart');
						new Chart(birthChart, {
							type: 'bar',
							data: {
								 labels: birthLabels,
								  datasets: [{
								    label: '연령별 이용자 수',
								    data: [65, 59, 80, 81, 56, 55, 40],
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