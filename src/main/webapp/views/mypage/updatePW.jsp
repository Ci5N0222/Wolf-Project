<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>비밀번호 변경</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
      * {
        box-sizing: border-box;
      }

      body {
        background-color: #f2f2f2;
      }

      .container {
        width: 400px;
        height: 500px;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: auto;
      }

      .container h1 {
        font-size: 1.5em;
        margin-bottom: 20px;
        text-align: center;
      }

      .container p.warning {
        margin-bottom: 10px;
        color: red;
        font-size: 0.9em;
      }

      .container .current_password {
        margin-top: 20px;
      }
      .container .update {
        margin-top: 20px;
      }

      .container label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
      }

      .container input[type="password"],
      .container input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
      }

      .container button {
        width: calc(50% - 10px);
        margin-top: 30px;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
      }

      .container #confirm {
        background-color: #2c1d6b;
        color: white;
      }

      .container #cancel {
        background-color: #90b5ce;
        color: white;
      }

      .container .buttons {
        display: flex;
        justify-content: space-between;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>비밀번호 변경</h1>
      <p class="warning">* 다른 아이디/사이트에서 사용한 적 없는 비밀번호</p>
      <p class="warning">* 이전에 사용한 적 없는 비밀번호가 안전합니다.</p>

      <div class="current_password">
        <label for="current_password">현재 비밀번호</label>
        <input
          type="password"
          id="current_password"
          name="current_password"
          required
        />
      </div>

      <div class="update">
        <div class="new_password">
          <label for="new_password">새 비밀번호</label>
          <input
            type="password"
            id="new_password"
            name="new_password"
            required
          />
        </div>

        <div class="confirm_password">
          <label for="confirm_password">새 비밀번호 확인</label>
          <input
            type="password"
            id="confirm_password"
            name="confirm_password"
            required
          />
        </div>
      </div>

      <div class="buttons">
        <button type="button" id="confirm">확인</button>
        <button type="button" id="cancel">취소</button>
      </div>
    </div>

    <script>
      $("#confirm").on("click", function () {
        if (confirm("변경하시겠습니까?")) {
          $.ajax({
            url: "/pwUpdate.members",
            method: "post",
            data: {
              current_password: $("#current_password").val(),
              new_password: $("#new_password").val(),
              confirm_password: $("#confirm_password").val(),
            },
          }).done(function (resp) {
            if (resp == "true") {
              alert("변경되었습니다");
              location.href = "/test/index.jsp";
            } else if (resp == "false1") {
              alert("확인 비밀번호 불일치");
              $("#current_password").val("");
              $("#new_password").val("");
              $("#confirm_password").val("");
            } else if (resp == "false2") {
              alert("현재 비밀번호가 틀렸습니다");
              $("#current_password").val("");
              $("#new_password").val("");
              $("#confirm_password").val("");
            }
          });
        } else {
          // 취소 버튼을 눌렀을 때 실행할 코드
          alert("취소되었습니다.");
        }
      });

      $("#cancel").on("click", function () {
        location.href = "/views/mypage/mypage.jsp";
      });
    </script>
  </body>
</html>
