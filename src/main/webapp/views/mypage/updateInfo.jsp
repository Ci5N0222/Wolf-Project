<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Wolf</title>
    <link rel="icon" href="/images/favicon.png" />

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
        <main class="mypage-select-container">
          <div class="mypage-select-title">내 정보</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-select-form">
              <form
                action="/update.mypage"
                method="post"
                enctype="multipart/form-data"
              >
                <div class="select-board">
                  <div class="select-board-list">
                    <div class="avatar-img-area">
                      <div></div>
                      <div id="avatarImgArea">
                        <c:choose>
                          <c:when test="${WolfAvatar eq null}">
                            <img
                              src="/images/default-avatar.jpg"
                              alt=""
                              id="avatarImg"
                            />
                          </c:when>
                          <c:otherwise>
                            <img src="${WolfAvatar}" alt="" id="avatarImg" />
                          </c:otherwise>
                        </c:choose>
                        <div style="display: none">
                          <input
                            type="file"
                            name="avatar"
                            accept="image/*"
                            id="inputAvatar"
                          />
                        </div>
                      </div>
                      <div></div>
                    </div>
                    <div class="avatar-defaultImg-btn" style="display: none">
                      <button type="button" id="defaultImgBtn">
                        기본 이미지로 변경
                      </button>
                    </div>
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
                      <button
                        type="button"
                        id="nicknameCheck"
                        style="display: none"
                      >
                        중복 확인
                      </button>
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
                      <div class="content" id="email" name="email">
                        ${member.email}
                      </div>
                      <button
                        type="button"
                        id="CertificationCodeSend"
                        style="display: none"
                      >
                        전송하기
                      </button>
                    </div>
                    <div
                      class="form-group"
                      id="certificationCodeGroup"
                      style="display: none"
                    >
                      <div class="txt">Certification</div>
                      <input
                        type="text"
                        id="CertificationCode"
                        name="CertificationCode"
                        placeholder="인증번호를 입력해주세요"
                      />
                      <button id="CertificationCodeBtn" type="button">
                        인증확인
                      </button>
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
                <input
                  type="hidden"
                  name="defaultCheck"
                  value="false"
                  id="defaultCheck"
                />
              </form>
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
      // 사용변수
      let id = $("#id");
      let name = $("#name");
      let nickname = $("#nickname");
      let phone = $("#phone");
      let email = $("#email");
      let avatarOK = false;

      let regexNickname = /^(?=.*[가-힣a-zA-Z])[가-힣a-zA-Z0-9]{0,7}$/;
      let regexPhone = /^01[\d]-?\d{4}-?\d{4}$/;
      let regexEmail = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.(com|net|co\.kr)+$/;

      $("#defaultImgBtn").prop("disabled", true); // 기본 이미지로 변경 버튼 비활성화

      $("#nicknameCheck").on("click", function () {
        let nickname = $("#nickname").text().trim();
        if (nickname == "") {
          alert("닉네임을 먼저 입력해주세요.");
          return;
        }
        let result = regexNickname.test(nickname);
        if (!result) {
          alert("사용할 수 없는 형식의 닉네임입니다");
          return false;
        }

        $.ajax({
          url: "/nicknamecheck.members",
          data: {
            nickname: nickname,
          },
        }).done(function (resp) {
          if (resp == "true") {
            alert("이미 사용중인 닉네임 입니다.");
          } else {
            alert("사용가능한 닉네임 입니다.");
            // 사용 가능한 경우 처리할 로직 추가
          }
        });
      });

      // 이메일 중복확인
      $("#CertificationCodeSend").on("click", function () {
        let email = $("#email").text().trim();
        if (!regexEmail.test(email)) {
          alert("이메일을 올바르게 입력해주세요.");
          return false;
        }
        $.ajax({
          url: "/emailSend.members",
          data: {
            email: email, // 이메일 주소를 URL 인코딩하여 공백과 특수문자를 처리
          },
        }).done(function (res) {
          console.log(email);
          if (res === "true") {
            alert("이메일로 인증번호가 전송되었습니다.");
            $("#certificationCodeGroup").show();
          } else {
            alert("이미 존재하는 이메일입니다.");
          }
        });
      });

      // 이메일 인증하기
      $("#CertificationCodeBtn").on("click", function () {
        if ($("#CertificationCode").val() == "") {
          alert("인증번호를 입력해주세요.");
        }

        $.ajax({
          url: "/CertificationCode.members",

          data: {
            CertificationCode: $("#CertificationCode").val(),
          },
        }).done(function (res) {
          if (res == "true") {
            alert("인증에 성공하였습니다.");
            emailCheckFlag = true;
            $("#CertificationCode").prop("disabled", true);
          } else {
            alert("인증에 실패하였습니다.");
          }
        });
      });

      // 수정버튼 눌렀을 시
      $("#edit").on("click", function () {
        $("#edit, #home").hide();
        $("#complete, #cancel").show();

        $("#nickname, #phone, #email").attr("contenteditable", true);
        $("#nickname, #phone, #email").css({
          border: "1px solid black",
          "border-radius": "5px",
        });

        $("#nicknameCheck").show();
        $("#CertificationCodeSend").show();

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

        // 수정버튼 눌렀을 시 아바타 선택 가능하게
        $("#avatarImg").on("click", function () {
          $("#inputAvatar").click();
        });

        $("#inputAvatar").on("change", function (event) {
          var input = event.target;

          if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
              $("#avatarImg").attr("src", e.target.result);
              avatarOK = true;
            };

            reader.readAsDataURL(input.files[0]);
          }
        });

        $("#avatarImgArea").addClass("pointer"); // CSS로 이미지 클릭 활성화
        $("#defaultImgBtn").prop("disabled", false); // 기본 이미지로 변경 버튼 활성화
        $(".avatar-defaultImg-btn").show();
      });

      // 기본 이미지로 변경
      $("#defaultImgBtn").click(function () {
        if ($(this).prop("disabled")) {
          return; // 버튼이 비활성화 상태라면 아무 작업도 하지 않음
        }

        if (confirm("프로필 사진을 기본 이미지로 변경하시겠습니까?")) {
          $("#avatarImg").attr("src", "/images/default-avatar.jpg");
          $("#inputAvatar").val(null);
          $("#defaultCheck").val("true");
        }
      });

      // 홈 버튼 눌렀을 시
      $("#home").on("click", function () {
        location.href = "/views/mypage/mypage.jsp";
      });

      // 완료 버튼 눌렀을 시
      $("#complete").on("click", function () {
        $("#hidden_nickname").val($("#nickname").text().trim());
        $("#hidden_phone").val($("#phone").text().trim());
        $("#hidden_email").val($("#email").text().trim());

        if (!regexPhone.test(phone.html())) {
          alert("전화번호를 올바르게 입력해주세요.");
          return false;
        }

        // 아바타 사진을 선택하지 않은 경우 기존 사진 유지
        if (!avatarOK) {
          $("#avatarImg").attr("src", "${WolfAvatar}");
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
  </body>
</html>
