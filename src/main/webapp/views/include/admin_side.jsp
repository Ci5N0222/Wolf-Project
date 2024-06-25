<%@ page contentType="text/html; charset=UTF-8" %>

<aside class="admin-side-menu">
	<div class="admin_navigator">
	    <div class="admin-logo">
        	<img src="/images/wolf-font-logo.png" alt="logo">
	    </div>
	    <p onclick="location.href='/main.admin'"> 대시보드 </p>
	    <p onclick="location.href='/members_list.admin'"> 회원관리 </p>
	    <p onclick="location.href='/game_list.admin'"> 게임관리 </p>
	    <p onclick="location.href='/notice_list.admin'"> 공지 및 FAQ </p>
	    <p onclick="location.href='/qna_list.admin'"> 고객센터 </p>
	    <div class="admin-logout">
			<p onclick="location.href='/'">Home</p>
			<p onclick="location.href='/logout.admin'">Log-out</p>
	    </div>
	</div>
</aside>