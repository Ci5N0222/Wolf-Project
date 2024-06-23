<%@ page contentType="text/html; charset=UTF-8" %>

<aside class="mypage-side-menu">
  <p onclick="location.href='/views/mypage/mypage.jsp'">내정보 홈</p>
  <p onclick="location.href='/selectMember.mypage'">개인정보관리</p>
  <p onclick="location.href='/views/mypage/updatePW.jsp'">비밀번호 변경</p>
  <p onclick="location.href='/mypageGameList.mypage'">게임플레이 정보</p>
  <p onclick="location.href='/myList.mypage'">문의내역</p>
  <p onclick="location.href='/views/mypage/deleteMember.jsp'">회원탈퇴</p>
  <p
    class="logout"
    onclick="if(confirm('로그아웃을 하시겠습니까?')) { location.href='/logout.members'; }"
  >
    로그아웃
  </p>
</aside>
