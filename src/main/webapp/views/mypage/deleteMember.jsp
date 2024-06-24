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
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/mypage.css">

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
        <main class="mypage-delete-container">
          <div class="mypage-delete-title">회원탈퇴</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-delete-form">
              <div style="display: flex; flex-direction: column; width: 70%">
                <div class="delete-warning-text">
                  <p class="warning">회원탈퇴를 진행하시겠습니까?</p>
                  <p class="warning">
                    탈퇴 시, 모든 데이터가 삭제되며 복구가 불가능합니다. 신중히
                    결정해 주세요.
                  </p>
                </div>

                <div class="mypage-delete-innerBoard">
                  <p class="id-txt">아이디 입력</p>
                  <input
                    type="text"
                    name="id"
                    placeholder="ID를 입력해주세요"
                    class="inputID"
                    required
                  />
                  <p class="pw-txt">비밀번호 입력</p>
                  <input
                    type="password"
                    name="password"
                    placeholder="PW를 입력해주세요"
                    class="inputPW"
                    required
                  />
                </div>
                <div class="btn-box">
                  <button type="button" class="deleteBtn">탈퇴하기</button>
                  <button type="button" class="cancelBtn">취소</button>
                </div>
              </div>
              <div class="mypage-delete-notice">
                <p>탈퇴 시 주의사항</p>
                <ul>
                  <li>
                    게시글, 댓글 등 커뮤니티 활동 내역은 탈퇴 후에도 남아 있을
                    수 있습니다. <br />
                    삭제를 원하실 경우, 탈퇴 전에 직접 삭제해 주시기 바랍니다.
                  </li>
                  <li>탈퇴와 관련된 문의는 고객센터로 연락해 주세요.</li>
                </ul>
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
      $(".cancelBtn").on("click", function () {
        $(".inputID").val("");
        $(".inputPW").val("");
      });

      $(".deleteBtn").on("click", function (event) {
        if (confirm("탈퇴를 진행하시겠습니까?")) {
          $.ajax({
            url: "/delete.mypage",
            type: "post",
            data: { password: $(".inputPW").val() },
          })
            .done(function (resp) {
              if (resp === "ok") {
                alert("계정이 삭제되었습니다.");
                window.location.href = "/logout.members";
              } else {
                alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
              }
            })
            .fail(function (xhr, status, error) {
              console.error("Error:", error);
            });
        }
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
