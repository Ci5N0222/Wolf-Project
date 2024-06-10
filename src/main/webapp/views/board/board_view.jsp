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
        border: 1px solid black;
        display: flex;
    }
    .container{
        width: 600px;
        height: 600px;
        flex-direction: column;
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


</style>
</head>
<body>
    <div class="container">
        <div class="center" style="flex: 1;">
            자유게시판
        </div>
        <div style="flex: 1;">
				<div style="flex: 5;" class="center">제목</div>
				<div style="flex: 1;" class="center">작성자</div>
				<div style="flex: 1;" class="center">날짜</div>
				<div style="flex: 1;" class="center" id="a">조회</div>
        </div>    
        <div class="contents">
            <c:forEach var="dto" items="${list}" varStatus="status">
                <div style="display: flex; height: 50px;" >
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
            <button id="new">작성하기</button>
			<button id="index">뒤로가기</button>
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
			navi.append("<a href='/list.board?cpage="+i+"'>"+ i +"</a>&nbsp");
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