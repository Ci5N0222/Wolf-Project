<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>First-Project</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
 
<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
        
<!-- Project local -->
<link rel="stylesheet" href="css/style.css">

</head>
<body> 
	<!-- container -->
    <div class="container-fluid d-flex flex-column">
    	 <div class="container text-center flex-grow-1 d-flex flex-column">
    		<img src="images/bg1.png" alt="" class="img_bg">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
            <img src="images/bg3.png" alt="" class="img_bg bgs">
	        <!-- nav -->
	        <%@ include file="/views/include/header.jsp" %>
	        
	        <!-- 컨텐츠 -->
            <div id="contents" class="d-flex align-items-center justify-content-center my-3">
                <div>Developer <br/> who wants to cry</div>
                <div></div>
            </div>
          
			<!-- main -->
            <main class="main container flex-grow-1">
                <section class="d-flex flex-wrap list">
                    <div class="item flex-grow-1">
                        <div class="card d-flex">
                            <img src="images/card.gif" class="card-img-top" alt="..." style="flex: 7;">
                            <div class="card-body" style="flex: 3;">
                                <p class="card-text">test</p>
                            </div>
                        </div>
                    </div>
                    <div class="item flex-grow-1">
                        <div class="card d-flex">
                            <img src="images/card.gif" class="card-img-top" alt="..." style="flex: 7;">
                            <div class="card-body" style="flex: 3;">
                                <p class="card-text">test</p>
                            </div>
                        </div>
                    </div>
                    <div class="item flex-grow-1">
                        <div class="card d-flex">
                            <img src="images/card.gif" class="card-img-top" alt="..." style="flex: 7;">
                            <div class="card-body" style="flex: 3;">
                                <p class="card-text">test</p>
                            </div>
                        </div>
                    </div>
                    <div class="item flex-grow-1">
                        <div class="card d-flex">
                            <img src="images/card.gif" class="card-img-top" alt="..." style="flex: 7;">
                            <div class="card-body" style="flex: 3;">
                                <p class="card-text">test</p>
                            </div>
                        </div>
                    </div>
                    <div class="item flex-grow-1">
                        <div class="card d-flex">
                            <img src="images/card.gif" class="card-img-top" alt="..." style="flex: 7;">
                            <div class="card-body" style="flex: 3;">
                                <p class="card-text">test</p>
                            </div>
                        </div>
                    </div>
                </section>
            </main>
	       	</div>
	        
			<div class="sun"></div>
	        <!-- mode -->
	        <div id="mode">
	            <i class="fa-regular fa-lightbulb" style="display: none;"></i>
	            <i class="fa-solid fa-lightbulb"></i>
	        </div>
    </div>
    <script src="js/main.js"></script>
</body>
</html>