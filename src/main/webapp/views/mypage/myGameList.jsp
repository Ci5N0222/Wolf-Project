<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게임 플레이 정보</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <style>
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
        overflow: hidden;

        font-family: "Noto Sans KR", sans-serif;
      }

      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }
      div {
        border: 1px solid #67ffd1;
      }

      .mypage-container {
        display: flex;
        height: 100vh;
        width: 100%;
      }

      .mypage-side-menu {
        min-width: 200px;
        height: 100%;
        /* background-color: rgb(150, 217, 6); */
        background-color: #f8faff;
      }

      .mypage-side-menu > p:hover {
        cursor: pointer;
      }

      .mypage-side-menu > p {
        padding: 20px;
        font-size: 20px;
        font-weight: 800;
        text-align: center;
      }

      .mypage-logo {
        display: flex;
        justify-content: center;
        padding: 10px;
      }

      .mypage-logo > img {
        width: 230px;
      }

      .mypage-myGame-form {
        background-color: #bab58b;
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .mypage-myGame-title {
        margin: 50px 0;
        font-size: 50px;
        color: #f8faff;
      }

      .mypage-myGameList {
        background-color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
        max-width: 950px;
        height: auto;
        min-height: 800px;
        border-radius: 30px;
      }

      .mypage-myGameList > div {
        width: 80%;
        height: 80%;
        display: flex;
        flex-direction: column;
      }
      .mypage-myGameList > div > div {
        width: 100%;
        height: 15%;
        display: flex;
      }
      .mypage-myGameList .title {
        flex: 3;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: larger;
      }
      .mypage-myGameList .score {
        flex: 8;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: larger;
      }
      .mypage-myGameList .score .score_txt {
        font-weight: bolder;
        font-size: xx-large;
      }

      @media (max-width: 1100px) {
        .mypage-side-menu {
          display: none;
        }
      }
    </style>
  </head>
  <body>
    <main class="mypage-container">
      <aside class="mypage-side-menu">
        <div class="mypage-logo">
          <img
            src="/images/img09.png"
            alt="logo"
            onclick="location.href='/index.jsp'"
            style="cursor: pointer"
          />
        </div>
        <p onclick="location.href='/views/mypage/mypage.jsp'">내정보 홈</p>
        <p onclick="location.href='/select.members'">개인정보관리</p>
        <p onclick="location.href='/views/mypage/updatePW.jsp'">
          비밀번호 변경
        </p>
        <p onclick="location.href='/myGameList.members'">게임플레이 정보</p>
        <p onclick="location.href='/'">문의내역</p>
        <p onclick="location.href='/'">회원탈퇴</p>
        <p onclick="location.href='/logout.members'">로그아웃</p>
      </aside>

      <section class="mypage-myGame-form">
        <h1 class="mypage-myGame-title">게임 플레이 정보</h1>

        <div class="mypage-myGameList">
          <c:if test="${result == null}"> 플레이 한 게임이 없습니다. </c:if>
          <c:if test="${result != null}">
            <div>
              <c:forEach var="i" items="${result}">
                <div>
                  <div class="title"><p>${i.title}</p></div>
                  <div class="score">
                    <p>최고점수 : <p class="score_txt">${i.score}</p>점</p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:if>
        </div>
      </section>
    </main>
  </body>
</html>
