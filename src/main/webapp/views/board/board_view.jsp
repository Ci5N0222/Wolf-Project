<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- icon -->
<script src="https://kit.fontawesome.com/1ee4acc8d4.js"
	crossorigin="anonymous"></script>

<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="css/style.css">
 <style> @import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');</style>

<script>
    if("${board_code}"==5  || "${board_code}"==4){
        location.href="/index.jsp";
        alert("잘못된 접근입니다");
    }
</script>


<style>
    .main{
        font-family: "Noto Sans KR", sans-serif;
        margin: auto;
        flex-direction: column;
        position:relative;
        z-index: 100;
    }
    .main div{
        display: flex;
    }
     
    .title{
        flex: 1;
        
    }
    .contents{
        flex:5;
        flex-direction: column;
       
    }
    .center{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .title:hover{
    cursor: pointer;
    color: red;
	}
    .board{
        flex: 6;
        flex-direction: column;
        border: 1px solid black;
        margin: 15px;
        background-color: white ;
    }
    .menu{
        margin: 15px;
        flex: 1.3;
        flex-direction: column;
       
    }
    .menu_title{
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-size: 15px;
            font-weight: bold;
            color: #333;
            margin: 10px;
            padding: 10px 15px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .menu_title:hover{
        cursor: pointer;
        color: rgb(6, 14, 249);
    }
    .button_css{
    	height: 30px;
    	line-height: 30px;
    	font-size: 15px !important;
    	color: white !important;
   		background-color: #428bca !important;
    	border: none;
    	border-radius: 5px;
    	cursor: pointer;
    }
    .button_css:hover{
        transform: scale(1.2);
        text-decoration: underline;
    }
    .page-number {
            width: 40px;
            height: 40px;
            line-height: 40px;
            margin: 0 5px;
            text-align: center;
            border: 1px solid #000;
            cursor: pointer;
            user-select: none;
            font-size: x-large;
    }   
    .page-number:hover {
            background-color: #f0f0f0;
    }
</style>
</head>
<body>


<div class="container-fluid d-flex flex-column">
    <div class="container text-center flex-grow-1 d-flex flex-column">
            <img src="/images/bg1.png" alt="" class="img_bg"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img src="/images/bg3.png" alt="" class="img_bg bgs">
            <%@ include file="/views/include/header.jsp" %>   
        <div class="main">
            <div style="flex: 0.1;"></div>
            <div style="display: flex; flex: 8;">
                <div class="menu" style="flex: 1.5;">
                    <div style="flex: 1; flex-direction: column;">
                        <div style=" height: 50px !important;" class="center menu_title" id="board_1">
                            자유 게시판
                        </div>
                        <div style=" height: 50px !important;"  class="center menu_title" id="board_2">
                            공지 게시판
                        </div>
                        <div  class="center menu_title" id="board_3">
                            QNA 게시판
                        </div>
                        <div style="flex: 1; display: none;"  class="center menu_title" id="board_4">
                            FAQ 게시판
                        </div>
                        <script>
                            $("#board_1").on("click",function(){
                                location.href="/list.board?board_code=1";
                            })
                            $("#board_2").on("click",function(){
                                location.href="/list.board?board_code=2";
                            })
                            $("#board_3").on("click",function(){
                                location.href="/list.board?board_code=3";
                            })
                            $("#board_4").on("click",function(){
                                location.href="/list.board?board_code=4";
                            })
                        </script>
                    </div>
                    <div style="flex: 1;">
        
                    </div>
                </div>    
                <div class="board">
                    <div class="center" style="flex: 1; font-family: 'Gugi', sans-serif; font-size: 30px;">
                        <c:choose>
                            <c:when test="${board_code==1}">
                                자유 게시판
                            </c:when>
                            <c:when test="${board_code==2}">
                                공지 게시판
                            </c:when>
                            <c:when test="${board_code==3}">
                                QNA 게시판
                            </c:when>
                            <c:when test="${board_code==4}">
                                FAQ 게시판
                            </c:when>
                        </c:choose>
                       
                    </div>
                    <div style="flex: 0.7; justify-content: flex-end;">
                        <form action="/list.board" method="get" >
                            <select name="target" title="검색선택" style="height: 30px;" id="targetSelect">
                                <option value="">선택</option>
                                <option value="title">제목</option>
                                <option value="contents">내용</option>
                                <option value="nickname">작성자</option>
                            </select>
                            <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요" style="height: 30px;">
                            <button class="button_css" >검색</button>
                            <input type="hidden" value="${board_code}" name="board_code">
                            <script>
                                document.getElementById('targetSelect').value = '${target}';
                            </script>
                        </form>
                    </div>
                    <div style="flex: 1; background-color: #f5f5f5; color: #545861;font-weight: bold; border-bottom: 5px solid #e3e3e3;">
                            <div style="flex: 1;" class="center">번호</div>
                            <div style="flex: 5;" class="center">제목</div>
                            <div style="flex: 1;" class="center">작성자</div>
                            <div style="flex: 1;" class="center">날짜</div>
                            <div style="flex: 1;" class="center" id="a">조회</div>
                    </div>    
                    <div class="contents">
                        <c:forEach var="dto" items="${list}" varStatus="status">
                            <div style="display: flex; height: 50px;  border-bottom: 2px solid #e3e3e3;" >
                                <div style="flex: 1;" class="center"><span class="seq">${dto.seq}</span></div>
                                <div style="flex: 5;" class="center"><span class="title">${dto.title}</span> </div>
                                <div style="flex: 1;" class="center">${board_nickname_list[status.index]}</div>
                                <div style="flex: 1;" class="center"><fmt:formatDate value="${dto.write_date}" pattern="yyyy.MM.dd"/></div>
                                <div style="flex: 1;" class="center">${dto.count}</div>
                            </div>
                        </c:forEach>
                    </div>
                    <div style="flex: 1;" class="center" id="navi"></div>
                    <c:choose>
                        <c:when test="${board_code==1 || board_code==3}">
                            <div style="flex: 1; justify-content: flex-end; align-items: center;">
                                <button id="new" class="button_css">글쓰기</button>&nbsp&nbsp
                                <button id="index" class="button_css">뒤로가기</button>&nbsp&nbsp&nbsp
                            </div>
                        </c:when>
                    </c:choose>
                  
                </div>
            </div>
        </div>
        <div class="footer" style="flex: 1;">
                    
        </div>

    </div>
</div>

    <script>
        let m_navi=$(".m_navi");
        let check=true;
        let toggle=m_navi.find(".navbar-toggler").on("click",function(){
            if(check){
                m_navi.find("#navbarToggleExternalContent").css({
                    display:"block"
                })
                check=false;
            }
            else{
                m_navi.find("#navbarToggleExternalContent").css({
                    display:"none"
                })
                check=true;
            }
        })
        
    </script>
  

    <script>
        //
        let seq=$(".seq");
        let title=$(".title");
		let cpage=${cpage};
		let navi=$("#navi");
		let record_total_count=${record_total_count};
		let record_count_per_page=${record_count_per_page};
		let navi_count_per_page=${navi_count_per_page};
		let page_total_count;
		if(record_total_count%record_count_per_page==0){
			page_total_count=(Math.floor(record_total_count/record_count_per_page));
		}
		else{
			page_total_count=Math.floor(record_total_count/record_count_per_page)+1;
		}
		let startNavi=Math.floor((cpage-1)/navi_count_per_page)*navi_count_per_page+1;
		let endNavi;
		if((startNavi+ navi_count_per_page-1)<page_total_count){
			endNavi=(startNavi+ navi_count_per_page-1)
		}
		else{
			endNavi=page_total_count
		}
		
		let needNext=true;
		let needPrev=true;
		if(startNavi==1)needPrev=false;
		if(endNavi==page_total_count)needNext =false;

		if(needPrev) {
			navi.append("<a href='/list.board?cpage="+(startNavi-1)+"'><</a>");
			}
		
		
		for (let i = startNavi; i <= endNavi; i++) {
            let div=$("<div class='page-number center'>");
                div.append("<a href='/list.board?cpage="+i+"&target=${target}&keyword=${keyword}'>"+ i +"</a>");
                if(i==cpage){
                    div.css({
                        backgroundColor:"red"
                    })
                }
			navi.append(div);
		}
		if(needNext) {
			navi.append("<a href='/list.board?cpage="+(endNavi+1)+"'>></a>");
		}

        //

         title.each(function(index,e){
            //console.log($(e).text());
            //console.log(seq.eq(index).text());
            $(e).on("click",function(){
                location.href="/detail.board?seq="+seq.eq(index).text()+"&target=${target}&keyword=${keyword}&board_code=${board_code}";
            })

         })
         

         $("#index").on("click",function(){
            location.href="/index.jsp";
        })
        $("#new").on("click",function(){ //작성하기
            if("${WolfID}"!="")
            location.href="/views/board/board_contents.jsp?board_code=${board_code}";
            else{
                alert("로그인을 해주세요");
            }
        })

    </script>
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

</body>
</html>