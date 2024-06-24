<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>비밀번호 변경</title>

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
        --darkMode: linear-gradient(to top, #001021, #00264f, #fcf6f5);
        --darkNav: #00264f;
        --lightMode: linear-gradient(to top, #ffd449, #f9a620, #fcf6f5);
        --lightNav: #f9a620;

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
        background-color: #00264f;
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
        background-color: var(--lightMode);
      }

      /* 하단 원 */
      .sun {
        position: absolute;
        width: 120%;
        height: 100%;
        background-image: var(--darkMode);
        box-shadow: 0px -10px 20px #fcf6f5;
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
        top: 20%;
        background-color: #eee;
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
        top: 20%;
        left: 40%;
        width: 30px;
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
      .navi {
        display: block;
      }
      .m_navi {
        display: none;
      }
      .wolf {
        display: none;
      }

      .navi {
        min-height: 50px;
        z-index: 5;
        height: 10%;
        display: flex;
        align-items: center;
        background-color: var(--darkNav);
        box-shadow: 0px 5px 20px #444;
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
        width: 30%;
      }

      .navi > div:nth-child(2) {
        width: 40%;
      }

      .navi > div:nth-child(1) > div {
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: left;
      }

      .navi > div:nth-child(2) #wolfLogo {
        width: 100%;
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
      }

      .mypage-updatePW-container {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        z-index: 100;
      }

      .mypage-updatePW-title {
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

      .mypage-updatePW-form {
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
      }

      .updatePW-warning-text {
        font-size: large;
        padding-bottom: 30px;
        color: #ffd449;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        margin-left: 150px;
      }

      .updatePW-board {
        width: 100%;
        max-width: 950px;
        padding: 0 140px;
      }

      .current_password,
      .new_password,
      .confirm_password {
        padding: 10px;
      }

      .current_password {
        padding-bottom: 60px;
      }

      .updatePW-board label {
        display: flex;
        margin-bottom: 10px;
        font-weight: bold;
        font-size: large;
        color: #ffffff;
      }

      .updatePW-board input[type="password"],
      .updatePW-board input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      .buttons {
        margin-top: 20px;
      }

      .buttons button {
        margin: 5px;
        border-radius: 8px;
        width: 60px;
        height: 40px;
      }

      /* ================== [반응형] ================== */
      @media (max-width: 1100px) {
        .mypage-side-menu {
          display: none;
        }
      }
      @media (max-width: 768px) {
        .updatePW-warning-text {
          margin-left: 80px;
        }
        .updatePW-board {
          padding: 0 40px;
        }
      }

      /* 테블릿 가로, 테블릿 세로 (해상도 768px ~ 1023px)*/
      @media all and (min-width: 768px) and (max-width: 1023px) {
        .wolf {
          display: block;
        }

        .wolfLogo {
          display: none;
        }

        .navi > div:nth-child(1),
        .navi > div:nth-child(3) {
          flex: 4;
        }

        .navi > div:nth-child(2) {
          flex: 2;
        }

        .navi > div:nth-child(2) #wolfLogo img {
          width: 100%;
          height: 100%;
          object-fit: contain;
        }
      }

      /* 모바일 */
      @media all and (max-width: 767px) {
        #mode {
          z-index: 100;
        }
        #wolfLogo {
          display: none;
        }
        .container-fluid {
          padding: 0;
        }

        /* 하단 원 */
        .sun {
          display: none;
        }

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
        .container-fluid,
        .container {
          padding: 0;
        }

        /* 내용물 */
        /* 햄버거 */
        .navbar {
          background-color: var(--lightNav);
        }

        /* 햄버거 클릭시 나오는 메뉴 화면 */
        .offcanvas-body {
          display: flex;
          justify-content: center;
          align-items: center;
        }

        .offcanvas-body .navbar-nav {
          flex: 1;
          display: flex;
          flex-direction: column;
          height: 100%;
        }

        .offcanvas-body .navbar-nav .nav-item {
          position: relative;
          margin-bottom: 0;
          flex: 1;
          display: flex;
          flex-direction: row;
          justify-content: center;
          align-items: center;
          margin-bottom: 10%;
        }

        .offcanvas-body .navbar-nav .nav-item:last-child {
          margin-bottom: 0;
        }

        .offcanvas-body .navbar-nav .nav-item > div:first-child {
          flex: 1;
        }

        .offcanvas-body .navbar-nav .nav-item > div:first-child i {
          font-size: 1.3rem;
        }

        .offcanvas-body .navbar-nav .nav-item > div:last-child {
          flex: 9;
          cursor: pointer;
          letter-spacing: 2px;
        }

        /* 가상요소 추가 밑줄 */
        .offcanvas-body .navbar-nav .nav-item::after {
          content: "";
          position: absolute;
          left: 0;
          bottom: 0;
          height: 3px;
          width: calc(100%);
          background: #cccccc63;
        }

        /* 가상 요소 호버 */
        @media (hover) {
          .offcanvas-body .navbar-nav .nav-item:hover::after {
            transform: scaleX(1);
            margin-left: 0;
          }

          .offcanvas-body .navbar-nav .nav-item::after {
            transform: scaleX(0);
            margin-left: 50%;
            transform-origin: left;
            transition: transform 500ms ease, margin-left 0.5s ease;
          }
        }

        ul,
        li {
          list-style: none;
        }

        .offcanvas-header {
          border-bottom: 1px solid #cccccc63;
        }

        .offcanvas-title {
          letter-spacing: 2px;
        }
      }

      /* 라이트 다크 mode */
      #mode {
        cursor: pointer;
        position: absolute;
        bottom: 5%;
        right: 5%;
        background-color: var(--darkNav);
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
        color: white;
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
        <main class="mypage-updatePW-container">
          <div class="mypage-updatePW-title">비밀번호 변경</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-updatePW-form">
              <div class="updatePW-warning-text">
                <p class="warning">
                  * 다른 아이디/사이트에서 사용한 적 없는 비밀번호
                </p>
                <p class="warning">
                  * 이전에 사용한 적 없는 비밀번호가 안전합니다.
                </p>
                <p class="warning">
                  * 알파벳 대,소문자 숫자 1개씩 포함 8자 이상 입력
                </p>
              </div>

              <div class="updatePW-board">
                <div class="current_password">
                  <label for="current_password">현재 비밀번호</label>
                  <input
                    type="password"
                    placeholder="현재 비밀번호"
                    id="current_password"
                    name="current_password"
                    required
                  />
                </div>

                <div class="update" style="display: none">
                  <div class="new_password">
                    <label for="new_password">새 비밀번호</label>
                    <input
                      type="password"
                      placeholder="새 비밀번호"
                      id="new_password"
                      name="new_password"
                      required
                    />
                  </div>

                  <div class="confirm_password">
                    <label for="confirm_password">새 비밀번호 확인</label>
                    <input
                      type="password"
                      placeholder="새 비밀번호 확인"
                      id="confirm_password"
                      name="confirm_password"
                      required
                    />
                  </div>
                </div>
                <div class="buttons">
                  <button type="button" id="confirm">확인</button>
                  <button
                    type="button"
                    id="update_confirm"
                    style="display: none"
                  >
                    확인
                  </button>
                  <button type="button" id="cancel">취소</button>
                </div>
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

    <script>
      let regexPW = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$/;

      $("#confirm").on("click", function () {
        $.ajax({
          url: "/pwCheck.mypage",
          method: "post",
          data: {
            current_password: $("#current_password").val(),
          },
        }).done(function (resp) {
          if (resp === "ok") {
            // 새 비밀번호 폼 오픈
            $(".update").show();
            $(".current_password").hide();
            $("#update_confirm").show();
            $("#confirm").hide();
          } else {
            alert("비밀번호가 틀렸습니다.");
          }
        });

        $("#update_confirm").on("click", function () {
          let newPassword = $("#new_password").val();
          let confirmPassword = $("#confirm_password").val();

          if (!regexPW.test(newPassword)) {
            alert("올바르지 않은 형식의 PW입니다");
            $("#new_password").val("");
            $("#confirm_password").val("");
            return;
          }

          if (newPassword == confirmPassword) {
            $.ajax({
              url: "/pwUpdate.mypage",
              method: "post",
              data: {
                new_password: newPassword,
              },
            }).done(function (resp) {
              console.log(resp);
              if (resp == "ok") {
                alert("비밀번호 변경이 완료되었습니다.");
                location.href = "/views/mypage/mypage.jsp";
              } else {
                alert("오류가 발생하였습니다.");
              }
            });
          } else {
            alert("확인 비밀번호가 일치하지 않습니다.");
            $("#confirm_password").val("");
          }
        });
      });

      $("#cancel").on("click", function () {
        location.href = "/views/mypage/mypage.jsp";
      });
    </script>
    <script src="/js/main.js"></script>

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
