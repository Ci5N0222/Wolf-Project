<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>정보수정</title>

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
        overflow: auto;
        /* 폰트 */
        font-family: "Noto Sans KR", sans-serif;
        font-family: "Luckiest Guy", cursive;
      }
      body.light {
        background-color: var(--bg-light);
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
        position: relative;
        z-index: 100;
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

      .mypage-select-container {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
      }

      .mypage-select-title {
        margin: 50px 0;
        font-size: 50px;
        color: white;
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

      .mypage-select-form {
        flex: 13;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .select-board {
        width: 100%;
        min-width: 800px;
        /* height: 1100px; */
        padding: 30px;
        padding-top: 0;
      }

      .select-board .select-board-list {
        width: 100%;
        /* height: 90%; */
        min-height: 800px;
        display: flex;
        flex-direction: column;
        padding: 20px;
        border-radius: 10px;
        background-color: white;
        box-shadow: 0 0 10px #ccc;
      }

      .select-board .select-board-list .row {
        flex: 1;
        display: flex;
      }
      .select-board .select-board-list .row .txt {
        flex: 2;
        display: flex;
        align-items: center;
        font-weight: bold;
        font-size: x-large;
        justify-content: center;
      }
      .select-board .select-board-list .row .content {
        flex: 5;
        display: flex;
        align-items: center;
        padding-left: 5px;
        margin-left: 10px;
        font-size: x-large;
      }

      .correct {
        display: flex;
      }
      .correct_left {
        flex: 2;
      }
      .correct_right {
        flex: 5;
        display: flex;
        margin-left: 20px;
      }

      .container .footer {
        flex: 0.8;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .container .footer button {
        margin: 30px;
        border-radius: 8px;
        cursor: pointer;
        height: 40px;
        font-size: larger;
      }

      @media (max-width: 1100px) {
        .mypage-side-menu {
          display: none;
        }
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
        <img src="images/bg1.png" alt="" class="img_bg" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />
        <img src="images/bg3.png" alt="" class="img_bg bgs" />

        <!-- nav -->
        <%@ include file="/views/include/header.jsp" %>

        <!-- main -->
        <main class="mypage-select-container">
          <div class="mypage-select-title">내 정보</div>
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
              <p onclick="location.href='/myList.mypage'">문의내역</p>
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

            <section class="mypage-select-form">
              <form
                action="/update.mypage"
                method="post"
                enctype="multipart/form-data"
              >
                <div class="select-board">
                  <div class="select-board-list">
                    <div class="row">
                      <div class="txt">ID</div>
                      <div class="content" id="id" name="id">${member.id}</div>
                    </div>
                    <div class="row">
                      <div class="txt">Name</div>
                      <div class="content" id="name">${member.name}</div>
                    </div>
                    <div class="correct">
                      <div class="correct_left"></div>
                      <div class="correct_right correct_name"></div>
                    </div>

                    <div class="row">
                      <div class="txt">NickName</div>
                      <div class="content" id="nickname">
                        ${member.nickname}
                      </div>
                    </div>
                    <div class="correct">
                      <div class="correct_left"></div>
                      <div class="correct_right correct_nickname"></div>
                    </div>

                    <div class="row">
                      <div class="txt">Phone</div>
                      <div class="content" id="phone">${member.phone}</div>
                    </div>
                    <div class="correct">
                      <div class="correct_left"></div>
                      <div class="correct_right correct_phone"></div>
                    </div>

                    <div class="row">
                      <div class="txt">Email</div>
                      <div class="content" id="email">${member.email}</div>
                    </div>
                    <div class="correct">
                      <div class="correct_left"></div>
                      <div class="correct_right correct_email"></div>
                    </div>

                    <div class="row">
                      <div class="txt">Gender</div>
                      <div class="content" id="gender">${member.gender}</div>
                    </div>
                    <div class="row">
                      <div class="txt">Birth</div>
                      <div class="content" id="birth">${member.birth}</div>
                    </div>
                    <div class="row">
                      <div class="txt">Grade</div>
                      <div class="content" id="grade">
                        <span>${member.grade}</span>
                      </div>
                    </div>

                    <div class="row">
                      <div class="txt">Avatar</div>
                      <div class="content" id="avatar">
                        <input type="file" name="avatar" accept="image/*" />
                      </div>
                    </div>

                    <div class="row">
                      <div class="txt">Join Date</div>
                      <div class="content" id="join_date">
                        <fmt:formatDate
                          value="${member.join_date}"
                          pattern="yyyy.MM.dd"
                        />
                      </div>
                    </div>
                  </div>

                  <div class="footer">
                    <button type="button" id="edit">수정하기</button>
                    <button type="button" id="home">홈으로</button>
                    <button type="submit" id="complete" style="display: none">
                      완료
                    </button>
                    <button type="button" id="cancel" style="display: none">
                      취소
                    </button>
                  </div>
                </div>

                <input
                  type="hidden"
                  name="name"
                  id="hidden_name"
                  value="${member.name}"
                />
                <input
                  type="hidden"
                  name="nickname"
                  id="hidden_nickname"
                  value="${member.nickname}"
                />
                <input
                  type="hidden"
                  name="phone"
                  id="hidden_phone"
                  value="${member.phone}"
                />
                <input
                  type="hidden"
                  name="email"
                  id="hidden_email"
                  value="${member.email}"
                />
                <!-- <input
                type="hidden"
                name="avatar"
                id="hidden_avatar"
                value="${member.avatar}"
              /> -->
              </form>
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
      // 사용변수
      let id = $("#id");
      let name = $("#name");
      let nickname = $("#nickname");
      let phone = $("#phone");
      let email = $("#email");
      let avatar = $("#avatar");

      let regexName = /^[가-힣]{2,5}$/;
      let regexPhone = /^01[\d]-?\d{4}-?\d{4}$/;
      let regexEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.(com|net|co\.kr)+$/;

      // 수정버튼 눌렀을 시
      $("#edit").on("click", function () {
        $("#edit, #home").hide();
        $("#complete, #cancel").show();

        name.attr("contenteditable", true);
        nickname.attr("contenteditable", true);
        phone.attr("contenteditable", true);
        email.attr("contenteditable", true);
        avatar.attr("contenteditable", true);

        name.on("keyup", function () {
          let result = regexName.test(name.html());

          if (name.html() === "") {
            $(".correct_name").html("");
            return false;
          }

          if (result) {
            $(".correct_name").html("확인");
            $(".correct_name").css("color", "green");
          } else {
            $(".correct_name").html("불가");
            $(".correct_name").css("color", "red");
          }
        });

        phone.on("keyup", function () {
          let result = regexPhone.test(phone.html());

          if (name.html() === "") {
            $(".correct_phone").html("");
            return false;
          }

          if (result) {
            $(".correct_phone").html("확인");
            $(".correct_phone").css("color", "green");
          } else {
            $(".correct_phone").html("불가");
            $(".correct_phone").css("color", "red");
          }
        });

        email.on("keyup", function () {
          let result = regexEmail.test(email.html());

          if (name.html() === "") {
            $(".correct_email").html("");
            return false;
          }

          if (result) {
            $(".correct_email").html("확인");
            $(".correct_email").css("color", "green");
          } else {
            $(".correct_email").html("불가");
            $(".correct_email").css("color", "red");
          }
        });
      });

      // 홈 버튼 눌렀을 시
      $("#home").on("click", function () {
        location.href = "/views/mypage/mypage.jsp";
      });

      // 완료 버튼 눌렀을 시
      $("#complete").on("click", function () {
        $("#hidden_name").val($("#name").text().trim());
        $("#hidden_nickname").val($("#nickname").text().trim());
        $("#hidden_phone").val($("#phone").text().trim());
        $("#hidden_email").val($("#email").text().trim());
        $("#hidden_avatar").val($("#avatar").text().trim());

        if (!regexName.test(name.html())) {
          alert("이름을 올바르게 입력해주세요.");
          return false;
        } else if (!regexPhone.test(phone.html())) {
          alert("전화번호를 올바르게 입력해주세요.");
          return false;
        } else if (!regexEmail.test(email.html())) {
          alert("이메일을 올바르게 입력해주세요.");
          return false;
        }
      });

      // 취소 버튼 눌렀을 시
      $("#cancel").on("click", function () {
        location.href = "/selectMember.mypage";
      });

      // enter 입력하지 못하게. 여기에 유효성검사해도됨
      $("td").on("keydown", function (e) {
        if (e.key == "Enter") {
          return false;
        }
      });
    </script>
    <script src="js/main.js"></script>
  </body>
</html>
