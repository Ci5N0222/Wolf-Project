<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Wolf</title>
	<link rel="icon" href="/images/favicon.png">

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
    <link rel="stylesheet" href="/css/style.css" />
    <link rel="stylesheet" href="/css/mypage.css" />
    <script src="/js/main.js"></script>
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
                <div class="confirm-buttons">
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
  </body>
</html>
