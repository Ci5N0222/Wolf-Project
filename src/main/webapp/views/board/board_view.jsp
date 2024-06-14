<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
    *{
        box-sizing: border-box;
    }
    div{
      
        display: flex;
    }
    .container{
        width: 850px;
        height: 850px;
        margin: auto;
        
    } 
    .title{
        flex: 1;
        
    }
    .contents{
        flex:5;
        flex-direction: column;
       
    }

    .footer{
        flex: 1;
        justify-content: flex-end;
        align-items: center;
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
    }
    .menu{
        margin: 15px;
        flex: 1.3;
        flex-direction: column;
        background-color: #f9a62098;
    }
    .menu_title{
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
        transform: scale(1.2);
        cursor: pointer;
        color: rgb(6, 14, 249);
    }
    button{
    	height: 30px;
    	line-height: 30px;
    	font-size: 15px !important;
    	color: white !important;
   		background-color: #428bca !important;
    	border: none;
    	border-radius: 5px;
    	cursor: pointer;
    }
    button:hover{
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
    <div class="container">
        <div class="menu">
            <div style="flex: 1; flex-direction: column;">
                <div style="flex: 1;" class="center menu_title" id="board_1">
                    자유 게시판
                </div>
                <div style="flex: 1;"  class="center menu_title" id="board_2">
                    공지 게시판
                </div>
                <div style="flex: 1;"  class="center menu_title" id="board_3">
                    QNA 게시판
                </div>
                <div style="flex: 1;"  class="center menu_title" id="board_4">
                    문의하기
                </div>
                <script>
                    $("#board_1").on("click",function(){
                        location.href="/list.board";
                    })
                </script>
            </div>
            <div style="flex: 1;">

            </div>
        </div>
        <div class="board">
            <div class="center" style="flex: 1; font-family: 'Luckiest Guy', cursive; font-size: 30px;">
                자유게시판
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
                    <button >검색</button>
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
            <div class="footer">
                <button id="new">글쓰기</button>&nbsp&nbsp
                <button id="index">뒤로가기</button>&nbsp&nbsp&nbsp
            </div>
        </div>
    </div>


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
                location.href="/detail.board?seq="+seq.eq(index).text();
            })

         })

         $("#index").on("click",function(){
            location.href="/index.jsp";
        })
        $("#new").on("click",function(){ //작성하기
            if("${WolfID}"!="")
            location.href="/views/board/board_contents.jsp";
            else{
                alert("로그인을 해주세요");
            }
        })

    </script>
</body>
</html>