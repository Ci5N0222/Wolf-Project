<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게임플레이 정보</title>
    <!-- 부트스트랩 -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <!-- icon -->
    <script
      src="https://kit.fontawesome.com/1ee4acc8d4.js"
      crossorigin="anonymous"
    ></script>

    <!-- bootstrap -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>

    <style>
      @charset "UTF-8";
      @import url("https://fonts.googleapis.com/css2?family=Luckiest+Guy&family=Noto+Sans+KR:wght@100..900&display=swap");
      :root {
        --bg-light: #ffd449;
        --bg-dark: #14213d;
        --bg-transparent: transparent;

        --color-white: #eeeeee;
        --color-black: #14213d;
        --bg-nav: #f9a620;
        --color-nav-icon: #14213d;
        --color-nav-bg: #f9a620;
        font-size: 16px;
      }
      html,
      body {
        height: 100%;
        margin: 0;
        background-color: var(--bg-dark);
        color: var(--bg-black);
        color: var(--color-black);
      }
      html {
        overflow: hidden;
      }
      body {
        overflow-y: auto;
        overflow-x: hidden;
      }

      body.light {
        background-color: var(--bg-light);
        color: var(--bg-black);
      }

      /* 하단 원 */
      .sun {
        position: absolute;
        width: 120%;
        height: 100%;
        background-color: var(--color-nav-bg);
        box-shadow: 5px -5px 10px var(--bg-light);
        border-radius: 50%;
        top: 40%;
        left: 50%;
        transform: translateX(-50%);
      }

      /* 모드 변경시 부드럽게 넘어가는 효과 */
      .sun,
      .navi {
        transition: background-color 0.5s ease, box-shadow 0.5s ease;
      }

      /* img */
      .img_bg {
        position: absolute;
        top: 0%;
        left: 0;
        width: 100%;
        object-fit: cover;
      }
      .bgs {
        animation: bg 1s ease-in Infinite Alternate;
        transition: all ease-in 0.2s;
        width: 50px;
      }
      .bgs:nth-child(1) {
        top: 15%;
        left: 80%;
      }
      .bgs:nth-child(2) {
        top: 20%;
        left: 80%;
        width: 40px;
      }
      .bgs:nth-child(3) {
        top: 15%;
        left: 20%;
      }
      .bgs:nth-child(4) {
        top: 27%;
        left: 70%;
        width: 20px;
      }
      .bgs:nth-child(5) {
        top: 12%;
        left: 50%;
      }
      .bgs:nth-child(6) {
        top: 12%;
        left: 80%;
        width: 20px;
      }
      @keyframes bg {
        0% {
          opacity: 1;
        }
        100% {
          opacity: 0;
        }
      }

      .container-fluid,
      .container,
      .main {
        height: 100%;
        /* 폰트 */
        font-family: "Noto Sans KR", sans-serif;
      }

      /* PC */
      /* 메뉴 */
      .wolf {
        display: none;
      }
      .navi {
        display: block;
      }
      .m_navi {
        display: none;
      }

      .navi {
        z-index: 5;
        height: 10%;
        display: flex;
        align-items: center;
        background-color: var(--bg-nav);
        padding: 0 3%;
        font-size: 20px;
        color: var(--color-white);
        text-shadow: 1px 1px 1px gray;
        letter-spacing: 1px;
        border-radius: 40px 80px / 80px 40px;
        /* 폰트 */
        font-family: "Luckiest Guy", cursive;
      }

      .navi i {
        font-size: 22px;
      }

      .navi > div {
        margin-top: 0;
        height: 100%;
      }

      /* 메뉴 */
      .navi > div:nth-child(1),
      .navi > div:nth-child(3) {
        width: 40%;
      }

      .navi > div:nth-child(2) {
        width: 20%;
      }

      .navi > div:nth-child(1) > div {
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: left;
        z-index: 10;
        cursor: pointer;
      }

      .navi > div:nth-child(2) #wolfLogo {
        width: initial;
        height: 100%;
      }

      .navi > div:nth-child(2) #wolfLogo img {
        width: initial;
        height: 130%;
        object-fit: contain;
      }
      .navi > div:nth-child(3) > div {
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: right;
      }

      /* 메뉴 버튼 */
      .naviBtn {
        cursor: pointer;
        transition: all 0.3s ease-in-out;
      }

      .naviBtn:hover {
        opacity: 0.5;
      }

      .naviBtn > img {
        width: 50px;
        height: 50px;
        border-radius: 100%;
      }

      /* ================== [main] ================== */
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }
      /* div {
        border: 1px solid #67ffd1;
      } */

      .mypage-myGame-container {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        z-index: 100;
      }

      .mypage-myGame-title {
        margin: 50px 0;
        font-size: 50px;
        font-weight: 700;
        color: white;
        height: 10%;
        width: 100%;
        text-shadow: 5px 5px 5px #14213d;
      }

      .aside-section-form {
        display: flex;
        overflow: hidden;
        max-height: 700px;

      }

      .mypage-side-menu {
        flex: 2;
        min-width: 200px;
        height: 600px;
        background-color: #f0f0f0;
        margin-left: 30px;
        margin-top: 0;
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        padding: 15px;
        width: 30%;
      }

      .mypage-side-menu > p:hover {
        cursor: pointer;
        background-color: #e0e0e0;
      }

      .mypage-side-menu > p {
        margin-top: 10px;
        margin-bottom: 0;
        padding: 10px;
        font-size: 20px;
        font-weight: 800;
        display: flex;
        flex: 1;
        justify-content: center;
        align-items: center;
      }

      .mypage-myGame-form {
        /* background-color: #bab58b; */
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 0 30px;
        overflow: auto;
      }

      .mypage-myGameList {
        background-color: rgb(247, 247, 247);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        width: 100%;
        max-width: 950px;
        border-radius: 30px;
        padding: 50px 100px;
      }

      .mypage-myGameList .mypage-myGameList-info {
        width: 100%;
        height: 200px;
        display: flex;
        border-radius: 30px;
        box-shadow: 0 0 10px #ccc;
        margin-bottom: 30px;
        padding: 10px;
      }
      .mypage-myGameList .mypage-myGameList-img {
        flex: 2;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #ffe8c1;
        border-radius: 30px;
      }

      .mypage-myGameList .mypage-myGameList-info > div:last-child {
        flex: 3;
        display: flex;
        flex-direction: column;
        margin-left: 40px;
      }
      .mypage-myGameList .mypage-myGameList-info .mypage-myGameList-title {
        flex: 1;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: x-large;
      }
      .mypage-myGameList .mypage-myGameList-info .mypage-myGameList-score {
        flex: 1;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        font-size: x-large;
      }

            /* -- main과 동일 -- */
      /* 라이트 다크 mode */
      #mode {
        cursor: pointer;
        position: absolute;
        bottom: 5%;
        right: 5%;
        background-color: var(--bg-dark);
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: all ease-in 0.2s;
        animation: ball 1s ease-in Infinite Alternate;
        border: double 1px rgba(255, 255, 255, 0.46);
        z-index: 150;
      }
      @keyframes ball {
        0% {
          bottom: 5%;
        }
        95% {
          width: 50px;
        }
        to {
          bottom: 8%;
          width: 50px;
          height: 60px;
        }
      }
      /* 모드 전환 버튼 호버 시 투명도 조정 */
      #mode:hover {
        opacity: 0.8;
      }

      /* 모드 전환 버튼 아이콘 스타일 */
      #mode i {
        font-size: 30px;
        color: var(--color-nav-bg);
      }


      /* ================== [반응형] ================== */
      @media (max-width: 1200px) {
        .mypage-side-menu {
          display: none;
        }
      }
      @media (max-width: 1000px) {
        .mypage-myGameList {
          padding: 50px 30px;
        }
      }

      /* 태블릿 크기  */
      @media all and (min-width: 768px) and (max-width: 1023px) {
        .wolf {
          display: block;
        }

        #wolfLogo {
          display: none;
        }
      }

      /* 모바일 메뉴 */
      @media all and (max-width: 767px) {
        /* 메뉴 */
        .wolf {
          display: block;
        }

        .navi {
          display: none;
        }

        .m_navi {
          display: block;
        }

        .container-fluid {
          padding: 0;
        }

        .container {
          padding: 0;
        }

        /* 내용물 */
        /* 햄버거 */
        .navbar {
          box-shadow: 0px 1px 5px white;
        }

        .navbar div {
          width: 50px;
          width: 50px;
          height: 50px;
          line-height: 50px;
          margin: 0 2%;
        }
      }
    </style>
  </head>
  <body>
	<!-- container -->
	<div class="container-fluid d-flex flex-column">
		<div class="container text-center flex-grow-1 d-flex flex-column">
			<img src="/images/bg1.png" alt="" class="img_bg"> 
			<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
			<img
				src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs"> 
				<img src="/images/bg3.png" alt="" class="img_bg bgs">
			<!-- nav -->
			<%@ include file="/views/include/header.jsp"%>

        <!-- main -->
        <main class="mypage-myGame-container">
          <div class="mypage-myGame-title">게임플레이 정보</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-myGame-form">
              <div class="mypage-myGameList">
                <!-- <c:if test="${result == null}">
                  <div style="border: 1px solid aqua">
                    플레이 한 게임이 없습니다.
                  </div>
                </c:if> -->
                <c:if test="${result != null}">
                  <c:forEach var="i" items="${result}">
                    <div class="mypage-myGameList-info">
                      <div class="mypage-myGameList-img">
                        <img src="${i.thumbnail}" style="width: 100%; height: 100%; border-radius: 30px;">
                      </div>
                      <div>
                        <div class="mypage-myGameList-title">
                          <p class="title_txt">${i.title}</p>
                        </div>
                        <div class="mypage-myGameList-score">
                          <c:choose>
                            <c:when test="${i.score != null}">
                                <p>최고점수 :
                                  <p class="score_txt">${i.score}</p>
                                  점
                                </p>
                              </c:when>
                              <c:otherwise>
                                플레이한 기록이 없습니다.
                              </c:otherwise>
                            </c:choose>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </c:if>
              </div>
            </section>
          </div>
        </main>
      </div>

      <div class="sun"></div>
      <!-- mode -->
      <div id="mode">
        <i class="fa-regular fa-lightbulb" style="display: none"></i>
        <i class="fa-solid fa-lightbulb"></i>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script src="js/main.js"></script>

    <!-- 스크롤 관련 -->
    <script>
      resize();
      $(window).resize(function () {
        resize();
      });
      function resize() {
        const currentHeight = $("body").height() + 5;
        const scrollHeight = $("body").prop("scrollHeight");
        if (scrollHeight > currentHeight) {
          $(".img_bg").css({
            left: "0%",
            width: "98.5%",
          });
        }
      }
      let m_navi = $(".m_navi");
      let check = true;
      let toggle = m_navi.find(".navbar-toggler").on("click", function () {
        if (check) {
          m_navi.find("#navbarToggleExternalContent").css({
            display: "block",
          });
          check = false;
        } else {
          m_navi.find("#navbarToggleExternalContent").css({
            display: "none",
          });
          check = true;
        }
      });
    </script>
  </body>
</html>
