<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원탈퇴</title>
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
        /* background-color: azure; */
        color: var(--bg-black);
        color: var(--color-black);
        overflow: hidden;
        /* 폰트 */
        font-family: "Noto Sans KR", sans-serif;
        font-family: "Luckiest Guy", cursive;
      }
      body.light {
        /* background-color: var(--bg-light); */
        background-color: white;
        color: var(--bg-black);
      }
      /* 모드 변경시 부드럽게 넘어가는 효과 */
      .sun,
      .navi {
        transition: background-color 0.5s ease, box-shadow 0.5s ease;
      }
      /* img */
      .img_bg {
        position: absolute;
        top: -60%;
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
      }
      /* 메뉴 */
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
      }
      .navi i {
        font-size: 22px;
      }
      .navi > div {
        margin-top: 0;
      }
      .navi > div:nth-child(2) #wolfLogo {
        width: 100px;
        height: 100px;
      }
      /* 로고 */
      .navi #wolfLogo > img {
        object-fit: cover;
        width: 100%;
        height: 100%;
      }
      /* 메뉴 버튼 */
      .naviBtn {
        cursor: pointer;
        transition: all 0.3s ease-in-out;
      }
      .naviBtn:hover {
        opacity: 0.5;
      }

      /* main */
      * {
        box-sizing: border-box;
      }

      /* div {
        border: 1px solid aqua;
      } */

      .mypage-delete-container {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
      }

      .mypage-delete-title {
        margin: 50px 0;
        font-size: 50px;
        color: #fab74b;
        height: 10%;
        width: 100%;
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

      .mypage-delete-form {
        /* background-color: #0a5479; */
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .delete-warning-text {
        font-size: large;
        padding-bottom: 30px;
        color: #ffd449;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        /* margin-left: 150px; */
      }

      .mypage-delete-innerBoard {
        width: 100%;
        max-width: 950px;
        height: 250px;
        /* padding: 0 80px; */
        position: relative;
        z-index: 5;
        display: flex;
        flex-direction: column;
        margin-left: 70px;
      }

      .id-txt,
      .pw-txt {
        /* margin-top: 0;
        margin-bottom: 1rem; */
        color: white;
        display: flex;
        margin-bottom: 10px;
      }

      input[type="text"],
      input[type="password"] {
        width: 400px;
        height: 40px;
        padding-left: 10px;
        margin-bottom: 30px;
      }

      .btn-box {
        display: flex;
        justify-content: flex-start;
        margin-bottom: 50px;
        margin-left: 170px;
      }

      .btn-box button {
        cursor: pointer;
        border-radius: 8px;
        margin: 10px;
        width: 80px;
        height: 35px;
        border: none;
      }

      .btn-box .deleteBtn {
        background-color: #fab74b;
        color: white;
      }

      .mypage-delete-notice {
        text-align: left;
        width: 70%;
      }

      .mypage-delete-notice p,
      li {
        color: white;
        margin-top: 3px;
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
    </style>
  </head>
  <body>
    <!-- container -->
    <div class="container-fluid d-flex flex-column">
      <!-- nav -->
      <div class="container text-center flex-grow-1 d-flex flex-column">
        <img src="/images/bg1.png" alt="" class="img_bg" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />
        <img src="/images/bg3.png" alt="" class="img_bg bgs" />

        <!-- nav -->
        <%@ include file="/views/include/header.jsp" %>

        <!-- main -->
        <main class="mypage-delete-container">
          <div class="mypage-delete-title">회원탈퇴</div>
          <div class="aside-section-form" style="display: flex">
            <aside class="mypage-side-menu">
              <p onclick="location.href='/views/mypage/mypage.jsp'">
                내정보 홈
              </p>
              <p onclick="location.href='/selectMember.mypage'">개인정보관리</p>
              <p onclick="location.href='/views/mypage/updatePW.jsp'">
                비밀번호 변경
              </p>
              <p onclick="location.href='/mypageGameList.mypage'">
                게임플레이 정보
              </p>
              <p onclick="location.href='/'">문의내역</p>
              <p onclick="location.href='/views/mypage/deleteMember.jsp'">
                회원탈퇴
              </p>
              <p
                class="logout"
                onclick="if(confirm('로그아웃을 하시겠습니까?')) { location.href='/logout.members'; }"
              >
                로그아웃
              </p>
            </aside>

            <section class="mypage-delete-form">
              <div style="display: flex; flex-direction: column; width: 70%">
                <div class="delete-warning-text">
                  <p class="warning">회원탈퇴를 진행하시겠습니까?</p>
                  <p class="warning">
                    탈퇴 시, 모든 데이터가 삭제되며 복구가 불가능합니다. 신중히
                    결정해 주세요.
                  </p>
                </div>

                <form action="/delete.mypage">
                  <div class="mypage-delete-innerBoard">
                    <p class="id-txt">아이디 입력</p>
                    <input
                      type="text"
                      placeholder="ID를 입력해주세요"
                      class="inputID"
                    />
                    <p class="pw-txt">비밀번호 입력</p>
                    <input
                      type="password"
                      placeholder="PW를 입력해주세요"
                      class="inputPW"
                    />
                  </div>
                  <div class="btn-box">
                    <button type="submit" class="deleteBtn">탈퇴하기</button>
                    <button type="button" class="cancelBtn">취소</button>
                  </div>
                </form>
              </div>
              <div class="mypage-delete-notice">
                <p>탈퇴 시 주의사항</p>
                <ul>
                  <li>탈퇴 후에는 동일한 아이디로 재가입이 불가능합니다.</li>
                  <li>
                    진행 중인 주문 및 예약 내역이 있는 경우, 처리 후 탈퇴가
                    가능합니다.
                  </li>
                  <li>탈퇴와 관련된 문의는 고객센터로 연락해 주세요.</li>
                </ul>
              </div>
            </section>
          </div>
        </main>
      </div>

      <!-- mode -->
      <div id="mode">
        <i class="fa-regular fa-lightbulb" style="display: none"></i>
        <i class="fa-solid fa-lightbulb"></i>
      </div>
    </div>

    <script>
      $(".cancelBtn").on("click", function () {
        $(".inputID").val("");
        $(".inputPW").val("");
      });
    </script>

    <script src="/js/main.js"></script>
  </body>
</html>
