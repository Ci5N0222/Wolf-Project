<!-- nav -->
<div class="row g-4 my-0 navi">
    <div class="col-4 d-flex justify-content-start">
        <div class="d-flex flex-row">
            <div class="me-3 naviBtn" onclick="location.href='/list.game'">Game</div>
            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Board</div>
            <div class="naviBtn">About</div>
        </div>
    </div>
    <div class="col-4 d-flex justify-content-center align-items-center">
            <div id="wolfLogo" onclick="location.href='/index.jsp'">
                <img src="/images/wolf_1.png" alt="">
            </div>
    </div>
    <div class="col-4 d-flex justify-content-end">
        <div class="d-flex flex-row">
            <c:if test="${WolfID != null}">
	            <div class="naviBtn" onclick="location.href ='/views/mypage/mypage.jsp'"><i class="fa-solid fa-user menus"></i></div>
            </c:if>
            <c:if test="${WolfID == null}">
	            <div class="naviBtn" onclick="location.href ='/views/members/login.jsp'"><i class="fa-solid fa-user menus"></i></div>
            </c:if>
        </div>
    </div>
</div>