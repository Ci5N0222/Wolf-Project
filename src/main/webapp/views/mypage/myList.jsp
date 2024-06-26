<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <main class="mypage-myList-container">
          <div class="mypage-myList-title">내 글 목록</div>
          <div class="aside-section-form" style="display: flex">
            <%@ include file="/views/include/mypage_side.jsp"%>

            <section class="mypage-myList-form">
              <div class="mypage-myList">
                <div class="mypage-myList-header"><p>내가 쓴 게시글</p></div>
                <div class="mypage-myList-navi">
                  <div style="flex: 1"><p>번호</p></div>
                  <div style="flex: 5"><p>제목</p></div>
                  <div style="flex: 1"><p>작성자</p></div>
                  <div style="flex: 1"><p>날짜</p></div>
                  <div style="flex: 1"><p>조회수</p></div>
                </div>
                <div class="mypage-myList-contents">
                  <c:forEach var="dto" items="${list}">
                    <div
                      style="
                        display: flex;
                        height: 50px;
                        border-bottom: 2px solid #e3e3e3;
                      "
                    >
                      <div style="flex: 1" class="center">
                        <span class="seq">${dto.seq}</span>
                      </div>
                      <div style="flex: 5" class="center">
                        <span class="title"
                          ><a
                            href="/detail.board?seq=${dto.seq}&target=&keyword=&board_code=1"
                            >${dto.title}</a
                          ></span
                        >
                      </div>
                      <div style="flex: 1" class="center">${dto.nickname}</div>
                      <div style="flex: 1" class="center">
                        <fmt:formatDate
                          value="${dto.write_date}"
                          pattern="yyyy.MM.dd"
                        />
                      </div>
                      <div style="flex: 1" class="center">${dto.count}</div>
                    </div>
                  </c:forEach>
                </div>
                <div class="page-navigation"></div>
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
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script src="/js/main.js"></script>

    <!-- 페이지 네비게이터 -->
    <script>
      pagenation(${cpage}, ${recode_total_count}, ${recode_count_per_page}, ${navi_count_per_page}, "/myList.mypage");
    </script>
  </body>
</html>
