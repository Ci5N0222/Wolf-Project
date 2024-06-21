<%@ page contentType="text/html; charset=UTF-8" %>
<!-- nav -->
<div class="row g-4 my-0 navi">
    <div class="col-4 d-flex justify-content-start">
        <div class="d-flex flex-row">
        	<div class="me-3 naviBtn wolf" onclick="location.href='/'">Home</div>
            <div class="me-3 naviBtn" onclick="location.href='/list.game'">Game</div>
            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Community</div>
            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Ranking</div>
            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Service</div>
        </div>
    </div>
    <div class="col-4 d-flex justify-content-center align-items-center">
            <div id="wolfLogo" onclick="location.href='/index.jsp'">
                <img src="/images/wolfLogo.png" alt="">
            </div>
    </div>
    <div class="col-4 d-flex justify-content-end">
        <div class="d-flex flex-row">
            <c:if test="${WolfID != null}">
	            <div class="naviBtn" onclick="location.href ='/views/mypage/mypage.jsp'">
	            	<c:choose>
	            		<c:when test="${WolfAvatar != null}">
	            			<img src="${WolfAvatar}">
	            		</c:when>
	            		<c:otherwise>
	            			<img src="/images/default-avatar.jpg" width="50" alt="기본 아바타">
	            		</c:otherwise>
	            	</c:choose>
	            	
	            </div>
            </c:if>
            <c:if test="${WolfID == null}">
	            <div class="naviBtn" onclick="location.href ='/views/members/login.jsp'"><i class="fa-solid fa-user menus"></i></div>
            </c:if>
        </div>
    </div>
</div>


<!-- 모바일 헤더 -->
<div class="m_navi">
    <div class="collapse" id="navbarToggleExternalContent" data-bs-theme="dark">
        <div class="p-1" style="background-color: white; opacity: 0.9; color: var(--bg-dark);">
            <div style="display: flex; justify-content: space-evenly;">
	        	<div class="me-3 naviBtn wolf" onclick="location.href='/'">Home</div>
	            <div class="me-3 naviBtn" onclick="location.href='/list.game'">Game</div>
	            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Community</div>
	            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Ranking</div>
	            <div class="me-3 naviBtn" onclick="location.href='/list.board'">Service</div>
            </div>
        </div>
    </div>
	<nav class="navbar navbar-dark"
		style="background-color: var(--bg-nav);">
		<div>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse"
				data-bs-target="#navbarToggleExternalContent"
				aria-controls="navbarToggleExternalContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
		<c:if test="${WolfID != null}">
			<div class="naviBtn"
				onclick="location.href ='/views/mypage/mypage.jsp'">
				<c:choose>
					<c:when test="${WolfAvatar != null}">
						<img src="${WolfAvatar}">
					</c:when>
					<c:otherwise>
						<img src="/images/default-avatar.jpg" width="50" alt="기본 아바타">
					</c:otherwise>
				</c:choose>

			</div>
		</c:if>
		<c:if test="${WolfID == null}">
			<div class="naviBtn"
				onclick="location.href ='/views/members/login.jsp'">
				<i class="fa-solid fa-user menus"></i>
			</div>
		</c:if>
	</nav>
</div>