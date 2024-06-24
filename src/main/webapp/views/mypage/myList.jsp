<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>내 글 목록</title>

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
      div {
        border: 1px solid #67ffd1;
      }

      .mypage-myList-container {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        z-index: 100;
      }

      .mypage-myList-title {
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

      .mypage-myList-form {
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 30px;
        padding-top: 0;
      }
      .mypage-myList {
        background-color: #f7f7f7;
        display: flex;
        width: 100%;
        max-width: 950px;
        height: auto;
        min-height: 800px;
        border-radius: 30px;
        display: flex;
        flex-direction: column;
        padding: 20px;
      }
      .mypage-myList > div {
        /* 임시 */
        background-color: lightgray;
      }
      .mypage-myList .mypage-myList-dropdown {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        padding-left: 10px;
      }
      .mypage-myList .mypage-myList-header {
        flex: 1.5;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .mypage-myList .mypage-myList-header > p {
        margin: 0;
        font-size: x-large;
        font-weight: 700;
      }
      .mypage-myList .mypage-myList-navi {
        flex: 1;
        display: flex;
      }
      .mypage-myList .mypage-myList-navi > div {
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .mypage-myList .mypage-myList-navi > div > p {
        margin: 0;
        font-weight: 600;
      }

      .mypage-myList .mypage-myList-contents {
        flex: 15;
      }
      .mypage-myList .mypage-myList-paging {
        flex: 1.3;
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
      @media (max-width: 1400px) {
        .mypage-side-menu {
          display: none;
        }
      }
      @media (max-width: 992px) {
        .mypage-myList-form {
          padding: 0;
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
        <img src="/images/bg1.png" alt="" class="img_bg" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <!-- nav -->
        <%@ include file="/views/include/header.jsp"%>

        <!-- main -->
        <main class="mypage-myList-container">
          <div class="mypage-myList-title">내 글 목록</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-myList-form">
              <div class="mypage-myList">
                <div class="mypage-myList-dropdown">
                  <!-- <button
                    class="btn btn-secondary dropdown-toggle"
                    type="button"
                    id="dropdownMenuButton1"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                  >
                    내 게시글
                  </button>
                  <ul
                    class="dropdown-menu"
                    aria-labelledby="dropdownMenuButton1"
                  >
                    <li>
                      <a class="dropdown-item" href="#">내 게시글</a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="#">문의내역</a>
                    </li>
                  </ul> -->
                </div>
                <div class="mypage-myList-header"><p>내가 쓴 게시글</p></div>
                <div class="mypage-myList-navi">
                  <div style="flex: 1"><p>번호</p></div>
                  <div style="flex: 5"><p>제목</p></div>
                  <div style="flex: 1"><p>작성자</p></div>
                  <div style="flex: 1"><p>날짜</p></div>
                  <div style="flex: 1"><p>조회수</p></div>
                </div>
                <div class="mypage-myList-contents">
                  <c:forEach var="dto" items="${list}">
                    <div
                      style="
                        display: flex;
                        height: 50px;
                        border-bottom: 2px solid #e3e3e3;
                      "
                    >
                      <div style="flex: 1" class="center">
                        <span class="seq">${dto.seq}</span>
                      </div>
                      <div style="flex: 5" class="center">
                        <span class="title">${dto.title}</span>
                      </div>
                      <div style="flex: 1" class="center">
                        ${board_nickname_list[status.index]}
                      </div>
                      <div style="flex: 1" class="center">
                        <fmt:formatDate
                          value="${dto.write_date}"
                          pattern="yyyy.MM.dd"
                        />
                      </div>
                      <div style="flex: 1" class="center">${dto.count}</div>
                    </div>
                  </c:forEach>
                </div>
                <div class="mypage-myList-paging"></div>
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
