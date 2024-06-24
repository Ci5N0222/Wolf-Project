<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!-- JSTL Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>First-Project</title>
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
        <main class="mypage-container">
          <div class="mypage-main-title">마이페이지</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-main-form">
              <div class="mypage-dashboard">
                <div>
                  <div>
                    <div class="dashboard-inner_box">
                      <div>
                        <div style="overflow: hidden">
                          <c:choose>
                            <c:when test="${WolfAvatar eq null}">
                              <img src="/images/default-avatar.jpg" alt="" />
                            </c:when>
                            <c:otherwise>
                              <img
                                src="${WolfAvatar}"
                                alt=""
                                style="width: 100%; height: 100%"
                              />
                            </c:otherwise>
                          </c:choose>
                        </div>
                        <div>
                          <p>${WolfNickname} 님 환영합니다.</p>
                        </div>
                      </div>
                      <div>
                        <div style="flex: 1">
                          <button
                            class="mypage_btn"
                            onclick="location.href='/selectMember.mypage'"
                          >
                            내 정보
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div>
                    <div>
                      <div class="dashboard-inner_box">
                        <div><p>게임플레이 정보</p></div>
                        <div>
                          <button
                            onclick="location.href='/mypageGameList.mypage'"
                          >
                            바로가기
                          </button>
                        </div>
                      </div>
                    </div>
                    <div>
                      <div class="dashboard-inner_box">
                        <div><p>내 글 목록</p></div>
                        <div>
                          <button
                            onclick="location.href='/myList.mypage'"
                          >
                            바로가기
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div>
                  <div>
                    <div class="dashboard-inner_box">
                      <div><p>비밀번호 변경</p></div>
                      <div>
                        <button
                          onclick="location.href='/views/mypage/updatePW.jsp'"
                        >
                          바로가기
                        </button>
                      </div>
                    </div>
                  </div>
                  <div>
                    <div class="dashboard-inner_box">
                      <div><p>회원탈퇴</p></div>
                      <div>
                        <button
                          onclick="location.href='/views/mypage/deleteMember.jsp'"
                        >
                          바로가기
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </main>
      </div>
    </div>
    <div class="sun"></div>
    <!-- mode -->
    <div id="mode">
      <i class="fa-regular fa-lightbulb" style="display: none"></i>
      <i class="fa-solid fa-lightbulb"></i>
    </div>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
