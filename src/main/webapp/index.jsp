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

<!-- Project local -->
<link rel="stylesheet" href="css/style.css">
<script src="js/main.js"></script>

</head>
<body>
	<!-- container -->
    <div class="container">
    
        <!-- nav -->
        <%@ include file="/views/include/header.jsp" %>
        
        <!-- ㅡmain -->
        <main class="main">
            <section class="list">
                <div class="item">1</div>
                <div class="item">2</div>
                <div class="item">3</div>
                <div class="item">4</div>
                <div class="item">5</div>
            </section>
            <div class="btn">
                <span id="prev"></span>
                <span id="next"></span>
            </div>
        </main>
        
        <!-- mode -->
        <div id="mode">
            <i class="fa-regular fa-lightbulb" style="display: none;"></i>
            <i class="fa-solid fa-lightbulb"></i>
        </div>
    </div>

	
</body>
</html>