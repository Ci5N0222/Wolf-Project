<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Wolf</title>
	<link rel="icon" href="/images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.tiny.cloud/1/9bewfouem96jjnfvuu236yinb3kp53xruh2gkkz3pkfnkw6c/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
    <script src="https://kit.fontawesome.com/1ee4acc8d4.js" crossorigin="anonymous"></script>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- Project local -->
<link rel="stylesheet" href="css/style.css">
<style> @import url('https://fonts.googleapis.com/css2?family=Gugi&display=swap');</style>

<style>
    body{
        overflow-y: auto;
        overflow-x: hidden;
        height: 100% !important;
        
    }
        * {
            box-sizing: border-box;
        }


        .main {
            height: 800px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            justify-content: unset !important;
            align-items: unset !important;
          
           
        }
        .main div{
            display: flex;
        }
        #main_main{
            margin-top: 20px;
            height: auto;
            width: auto;
            display: block;
            z-index: 1;
            position: relative;
            font-family: "Noto Sans KR", sans-serif;
        }
      
        .reply{
            margin-top: 20px;
            width: auto;
            height: 300px;
            margin-bottom: auto;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid black;
            background-color: white;
            flex-direction: column;
            display: flex;
        }
        .reply div{
            display: flex;
            margin-bottom: 10px;
        }

        #reply_contents {
            width: auto;
            height: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: auto;
            background-color: white;
            border-radius: 20px; 
        }
        #reply_contents div{
            display: flex;
        }

        .title {
            font-family: Arial, sans-serif;
            /* 폰트 설정 */
            font-size: 2em;
            /* 글씨 크기 설정 */
            color: #333;
            /* 글씨 색상 설정 */
            font-weight: bold;
            /* 글씨 굵기 설정 */
        }

        .reply_contents {
            display: flex;
            width: 100%;
            height: 100%;
            margin: 20px;
            flex-direction: column;
            z-index: 100;
            position: relative;
            border-radius: 20px;
            padding: 0 10px;
        }
        

        .swal2-container {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            text-align: center;
            border-radius: 20px !important;
        }
        body.swal2-height-auto {
            height: 100% !important;
        }       
        .custom-confirm-button {
            color: red !important;
            background-color: #001021 !important;
          
            /* 확인 버튼 텍스트 색깔 */
        }

        .custom-cancel-button {
          
            color: white !important;
            /* 취소 버튼 텍스트 색깔 */
        }


        .none {
            display: none !important;
        }

        .block {
            display: flex !important;
        }

    p {
            width: 100%;
    }
    .tox-toolbar-overlord{
        overflow: auto;
    }
    .tox-toolbar__primary{ 
          
     }
     .board{
        flex: 6;
        flex-direction: column;
        background-color: white;
        border: 1px solid black;
        overflow: hidden; 
        border-radius: 15px;
        
    }
    .board div{
        display: flex;
    }
    .menu{
        margin-bottom: 10px;
        flex: 0.5;
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
            justify-content: center;
            align-items: center;
    }
    .menu_title:hover{
        cursor: pointer;
        color: rgb(6, 14, 249);
    }
    .center{
        justify-content: center;
        align-items: center;
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
        text-decoration: underline;
    }
    .no-hover:hover{
        transform: scale(1) !important;
    }
    .div_input{
        word-break: break-all;
        overflow-wrap: break-word; 
        overflow: auto;
    }
    .m_navi{
        position: relative !important;
    }
    .navi{
        min-height: auto !important;
    }
    #wolfLogo{
        width: auto !important;
    }
    
</style>

</head>

<body>


<div class="container-fluid d-flex flex-column">
    <div class="container flex-grow-1 d-flex flex-column">
        <div id="img_box">
            <img  src="/images/bg1.png" alt="" class="img_bg"> 
            <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
            <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
             <img  src="/images/bg3.png" alt="" class="img_bg bgs">
        </div>
        
        <%@ include file="/views/include/header.jsp" %>  
    
    <div id="main_main">
        <div class="main">
            <div style="flex: 8; overflow: auto; flex-direction: column;">
                <div class="menu">
                    <div style="flex: 0.5;">
                        <div style=" height: 50px !important; flex: 1;" class="center menu_title" id="board_1">
                            자유 게시판
                        </div>
                        <div style=" height: 50px !important;  flex: 1;"  class="center menu_title" id="board_2">
                            공지 게시판
                        </div>
                        <div style=" height: 50px !important;  flex: 1; display: none;" class="center menu_title" id="board_3">
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
                </div>   
            <div class="board" >
                <div style="flex: 0.8;" class="center dto title" id="board_title">${board_dto.title}</div>
                <div style="flex: 0.35; background-color: #f5f5f5; color: #545861;font-weight: bold; border-bottom: 5px solid #e3e3e3;">
                        <div style="flex: 1;" class="center">${board_nickname}(${board_dto.member_id.substring(0, 4)}****)</div>
                        <div style="flex: 1;"  class="center"> <fmt:formatDate value="${board_dto.write_date}" pattern="yyyy.MM.dd HH:mm" /></div>
                        <div style="flex: 1;"  class="center"> 조회 ${board_dto.count}</div>
                </div>
                <div style="flex: 5; flex-direction: column; overflow: auto; height: 100% ; width: 100%; padding: 20px;" class="dto" id="board_contents" >${board_dto.contents}</div>
                <div style="flex: 0.8; overflow-y: auto;">
                    <form action="/update.board" method="post" id="joinform" enctype="multipart/form-data" style="flex: 1; display: flex;">
                    <div style="flex: 1.5;">
                        <div style="flex: 0.7; flex-direction: column; overflow: auto; color: gray;" id="files_div_main">
                            <c:forEach var="files_dto" items="${files_list}">
                                <div class="files_div  justify-content: flex-start; align-items: center;">
                                   <span class="files_seq">${files_dto.seq }</span>.&nbsp<a href="/download.files?sysname=${files_dto.sysname }&oriname=${files_dto.oriname}">${files_dto.oriname}</a>&nbsp&nbsp
                                    <button type="button" class="files_delete button_css" style="display: none; font-size: 20px; background-color: white !important;" >❌</button> <!--onclick="filesDelete(${files_dto.seq })"-->
                                </div>
                            </c:forEach>
                        </div> 
                        <div id="files" class="index" style="flex: 1; flex-direction: column; overflow: auto;">
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${WolfID eq board_dto.member_id}">
                            <div style="display: flex; justify-content:flex-end; align-items: center; flex: 1.5;" id="div1">
                                <button type="button" id="update" class="button_css">글수정</button>&nbsp&nbsp
                                <button type="button" id="delete" class="button_css">글삭제</button>&nbsp&nbsp
                                <button type="button" id="list" class="button_css">목록보기</button>&nbsp&nbsp
                            </div>
                            <div style="border: 0; display: none; flex: 1; justify-content:flex-end; align-items: center;" id="div2">
                                
                                    <input type="hidden" id="arrayField" name="array">
                                    <input type="hidden" name="title" class="update_input" id="board_title_input"> 
                                    <input type="hidden" name="contents" class="update_input" id="board_contents_input"> 
                                    <input type="hidden" name="count" value="${board_dto.count}">
                                    <input type="hidden" name="board_code" value="${board_code}">
                                    <input type="hidden" name="seq" value="${board_dto.seq}" class="notuse" id="board_dto_seq">
                                    <button type="submit" id="confirm" class="button_css">확인</button>&nbsp&nbsp
                                    <button type="button" id="cancel" class="button_css">취소</button>&nbsp&nbsp
                             
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="flex: 1; justify-content: flex-end; align-items: center;">
                                <button type="button" id="list" class="button_css">목록으로</button>&nbsp&nbsp
                            </div>
                        </c:otherwise>
                    </c:choose>
                </form>
                </div>
                </div>
            </div>
        </div> <!--contaier 끝-->
        <form action="/insert.reply" method="get" id="replyform">
        <div class="reply" style="  border-radius: 20px; margin-bottom: 15px;">
            <div style="flex: 1; margin-left: 15px;" class="center"> <p style="font-family: 'Courier New', Courier, monospace; font-size:18px; margin: 25px 10px 0 10px; font-weight: bolder;">${WolfNickname}(${WolfID.substring(0, 4)}****) </p></div>
            <div style="flex: 5; overflow: auto;">
                <div style="flex-direction: column; flex: 5; border: 1px solid black; margin: 0 20px 10px; border-radius: 8px; word-break: break-all; overflow: auto; max-height: 183px;" contenteditable="true" class="dto reply_child_input" id="reply_insert_div"  onkeydown="handleKeyPress(this,event)"><label class="reply_child_label" style="font-size: 20px; color: gray; margin: 5px 10px;">주제와 무관한 댓글이나 스포일러, 악플은 경고조치 없이 삭제되며 징계 대상이 될 수 있습니다.</label></div>
                <input type="hidden" name="contents" id="reply_insert_contents">
                <input type="hidden" name="member_id" value="${WolfID}"class="notuse">
                <input type="hidden" name="board_seq" value="${board_dto.seq}" class="notuse">
            </div>
            <div style="flex: 1;">
                <div style=" margin-left: 15px; flex:1; color: grey; justify-content: flex-start; align-items: center;"><span>현재 입력한 글자수 :&nbsp</span><span class="reply_child_count">0</span>/<span>전체 입력 가능한 글자수 :&nbsp</span><span class="reply_child_count_max">300</span></div>
                <div style=" flex: 1; justify-content: flex-end; align-items: center;">
                    <button id="reply_btn" style="width: 80px !important; height: 35px !important; background-color: #fabf61  !important; color: white !important;" class="no-hover button_css">등록</button>&nbsp&nbsp&nbsp&nbsp
                </div>
            </div>
        </div>
        <input type="hidden" value="${board_code}" name="board_code">
        </form>
        <script>
            if("${checkGrade}"=="false" &&${board_code==3}){
                $("#replyform").remove();
            }
        </script>
        <div id="reply_contents">
            <c:forEach var="reply_dto" items="${reply_list}" varStatus="status">
                <div class="reply_contents">
                        <div style="flex: 6; word-break: break-all; white-space: pre-wrap; flex-direction: column; margin-left:15px ;overflow: auto;">
                            <div style="margin-bottom:8px;">${reply_nickname_list[status.index]}(${reply_dto.member_id.substring(0, 4)}****) </div>
                            <div class="reply_div" style="flex-direction: column; margin-bottom: 8px; overflow: auto; max-height: 100px;">${reply_dto.contents}</div>
                            <div><p style="color: gray;"><fmt:formatDate value="${reply_dto.write_date}" pattern="yyyy.MM.dd HH:mm" /></p></div>
                        </div>
                        <div style="flex: 1; font-size: x-small; justify-content: flex-end; align-items: flex-end;">
                            <div style="flex: 1; margin-left:15px"> 
                                <button  class="reply_child_btn button_css">답글</button>
                            </div>
                            <div id="check" style="flex: 1; justify-content: flex-end; margin-right: 20px;">
                                <div stylse=" display: flex; width: 110px;" class="reply_div1">
                                    <button  class="reply_update button_css">수정</button>&nbsp&nbsp
                                    <button  class="reply_delete button_css">삭제</button>&nbsp&nbsp
                                </div>
                                <div style="display: none; width: 110px;" class="reply_div2">
                                    <form action="/update.reply" method="post" class="reply_update_form">
                                        <input type="hidden" name="contents" class="reply_input">
                                        <input type="hidden" name="seq" value="${reply_dto.seq}" class="reply_seq">
                                         <input type="hidden" name="board_seq" value="${board_dto.seq}" class="notuse">
                                        <button  type="button" class="reply_confirm button_css">확인</button>&nbsp&nbsp
                                        <button  type="button" class="reply_cancel button_css">취소</button>&nbsp&nbsp
                                    </form>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${WolfID eq reply_dto.member_id}">
                                    <script>
                                        $("#check").attr("class", "block");
                                        $("#check").removeAttr("id");
                                    </script>
                                </c:when>
                                <c:otherwise>
                                    <script>
                                        $("#check").attr("class", "none");
                                        $("#check").removeAttr("id");
                                    </script>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                    <div class="reply_child_div_main" style="flex-direction: column; display: none; border: 1px solid gray; margin: 15px; align-items: center; justify-content: center;">
                        <c:forEach var="reply_child_dto" items="${reply_child_list}" varStatus="status">
                            <c:if test="${reply_child_dto.reply_seq==reply_dto.seq}">
                                <div style="width:100% ;border-bottom: 1.5px solid gray; flex-direction: column; margin-left: 15px; margin-top: 10px;" class="reply_child_list">
                                    <div style="flex-direction: column;">
                                        <div style="flex: 1; font-family: 'Courier New', Courier, monospace; font-size:small; font-size: 13px;" class="reply_child_list_title">
                                            ${reply_child_nickname[status.index]}(${reply_child_dto.member_id.substring(0, 4)}****)     
                                        </div>
                                        <div style="flex: 4; flex-direction: column;" class="reply_child_list_contents">
                                           ${reply_child_dto.contents}
                                        </div>
                                        <div style="flex: 1; color: gray;" class="reply_child_list_write_date">
                                            <fmt:formatDate value="${reply_child_dto.write_date}" pattern="yyyy.MM.dd HH:mm" />
                                        </div>
                                    </div>
                                <c:if test="${WolfID==reply_child_dto.member_id}">
                                    <div style="justify-content: flex-end;" class="reply_child_div1">
                                        <button  onclick="reply_child_update(this)" class="button_css">수정</button>&nbsp&nbsp
                                        <button  onclick="reply_child_delete(this)" class="button_css">삭제</button>&nbsp&nbsp
                                        <input type="hidden" value="${reply_child_dto.seq}" class="reply_child_seq">
                                    </div>
                                    <div style="justify-content: flex-end; display: none;" class="reply_child_div2">
                                        <button  onclick="reply_child_confirm(this)" class="button_css">확인</button>&nbsp&nbsp
                                        <button  onclick="reply_child_cancel(this)" class="button_css">취소</button>&nbsp&nbsp     
                                    </div>
                                </c:if>
                                </div>
                            </c:if>
                        </c:forEach> 
                        <!---->
                        <div style="width:100% ; border-bottom: 1px solid gray; flex-direction: column; display: none; margin-left: 15px; margin-top: 10px;" class="reply_child_list">
                            <div style="flex-direction: column;">
                                <div style="flex: 1; font-family: 'Courier New', Courier, monospace; font-size:small; font-size: 13px;" class="reply_child_list_title">  
                                </div>
                                <div style="flex: 4; flex-direction: column;" class="reply_child_list_contents">
                                </div>
                                <div style="flex: 1; color: gray;" class="reply_child_list_write_date">
                                </div>
                            </div>
                            <div style="justify-content: flex-end;" class="reply_child_div1">
                                <button style="width: 50px; height: 30px;" onclick="reply_child_update(this)" class="button_css">수정</button>&nbsp&nbsp
                                <button style="width: 50px; height: 30px;" onclick="reply_child_delete(this)" class="button_css">삭제</button>&nbsp&nbsp
                                <input type="hidden" class="reply_child_seq">
                            </div>
                            <div style="justify-content: flex-end; display: none;" class="reply_child_div2">
                                <button style="width: 50px; height: 30px;" onclick="reply_child_confirm(this)" class="button_css">확인</button>&nbsp&nbsp
                                <button style="width: 50px; height: 30px;" onclick="reply_child_cancel(this)" class="button_css">취소</button>&nbsp&nbsp      
                            </div>
                        </div>
                        <!---->
                            <div class="reply_child_div"  style="width: 90%; height: 300px; flex-direction: column; margin-bottom: 10px;">
                                <div class="reply_child_contents" style="flex-direction: column; flex: 6.5;">
                                    <div style="flex: 1;" class="center">
                                        <p style="font-family: 'Courier New', Courier, monospace; font-size:small;">${WolfNickname}(${WolfID.substring(0, 4)}****) </p>
                                    </div>
                                    <div style="flex: 3; border: 1px solid gray; width: 100%; max-height: 155px; flex-direction: column;" class="reply_child_input div_input" onkeydown="handleKeyPress(this,event)"><label class="reply_child_label" style="font-size: 20px; color: gray;">주제와 무관한 댓글이나 스포일러, 악플은 경고조치 없이 삭제되며 징계 대상이 될 수 있습니다.</label></div>
                                    <div style="flex:0.5; color: grey;"><span>현재 입력한 글자수 :&nbsp</span><span class="reply_child_count">0</span>/<span>전체 입력 가능한 글자수 :&nbsp</span><span class="reply_child_count_max">300</span></div>
                                    <div style="flex: 1; justify-content: flex-end;">
                                            <button class="reply_child_insert no-hover button_css" style="color: #00c73c !important; background-color: whitesmoke !important; height: 100% !important; width: 18% !important;">등록</button>
                                    </div>         
                                </div>
                                <div style="flex: 1; justify-content: center; align-items: center;">
                                    <button style="text-align: center;" class="reply_child_close button_css">답글 접기△</button>
                                </div>
                            </div>
                    </div>
                </div>
            </c:forEach>
           
            <div class="footer" style="flex: 1;">
                    
            </div>
        </div>
        </div>
</div>
        <script> //reply_child_script
            let reply_child_btn=$(".reply_child_btn");
            let reply_child_close=$(".reply_child_close");
            let reply_child_insert=$(".reply_child_insert");
            let reply_child_input=$(".reply_child_input");
            let reply_child_labal=$(".reply_child_label").eq(1).clone(true);
            console.log(reply_child_labal);
            let reply_check=true;
            reply_child_btn.on("click",function(){
                let btn=$(this);
                let main=btn.parents(".reply_contents").find(".reply_child_div_main");
                let label=main.find(".reply_child_input");
                console.log(label.html());
                if(reply_check){
                    main.css({
                    display:"flex"
                    })
                    reply_check=false;
                    if(label.html().trim()==="")
                    label.append(reply_child_labal);
                    label.attr("contenteditable",false);
                }
              
                else{
                    reply_check=true;
                    main.css({
                    display:"none"
                    })
                }

            })
            reply_child_close.on("click",function(){
                let btn=$(this);
                let main=btn.parents(".reply_child_div_main");
                main.css({
                    display:"none"
                })
                reply_check=true;
            })
            reply_child_input.on("click",function(){
                $(this).attr("contenteditable",true);
                $(this).find("label").remove();
            })

            let div_input_temp;
            reply_child_input.keyup(function(event){
                const scrollHeight = $(this).prop('scrollHeight');
                
                    if(!(event.code === 'Space' || event.key === ' ' || event.key === 'Spacebar')){
                    let input=$(this).html().trim().replace(/(&nbsp;|<br>|<span>|<\/\s*span\s*>)/g, '');
                    let length=input.length;
                    console.log(input);
                    let count=$(this).parent().parent().find(".reply_child_count"); 
                    if(length>300){
                        $(this).html(div_input_temp);
                        count.text(300);
                        alert("300자까지 입력할 수 있습니다")
                    }else{
                        count.text(length);
                    }
                   
                    }
                    
                    if(scrollHeight<220){

                    }
                    else{
                        $(this).html(div_input_temp);
                        alert("댓글 범위를 넘었습니다.");
                    }
                    div_input_temp=$(this).html();
                 
            })

            

            reply_child_insert.on("click",function(){
                let btn=$(this);
                let div=btn.parents(".reply_child_div");
                let input=div.find(".reply_child_input");
                let reply_seq=div.parent().parent().find(".reply_seq");
                div.find(".reply_child_label").remove();
                $.ajax({
                    url:"/insert.reply_child",
                    type:"post",
                    dataType:"json",
                    data:{
                        contents:input.html(),
                        reply_seq:reply_seq.val()
                    }
                }).done(function(resp){
                    
                    let clone=$(".reply_child_list").eq(0).clone(true);
                    clone.css("display","flex");
                    clone.find(".reply_child_list_title").html("${WolfNickname} ${WolfID}");
                    clone.find(".reply_child_list_contents").html(input.html());
                  //  let date = new Date(resp[1]);
                    // 연도, 월, 일, 시간, 분을 추출합니다.
                    clone.find(".reply_child_list_write_date").html(resp[1]);
                    clone.find(".reply_child_seq").val(resp[0]);
                    let main=div.parent();
                    main.prepend(clone);
                    input.html("");

                })

            })

            function reply_child_update(e){
                let parent=$(e).parent().parent();
                let contents=parent.find(".reply_child_list_contents");
                let div1=parent.find(".reply_child_div1");
                let div2=parent.find(".reply_child_div2");

                contents.attr("contenteditable",true);
                div1.css("display","none");
                div2.css("display","flex");
                
            }

            function reply_child_confirm(e){
                let parent=$(e).parent().parent();
                let seq= parent.find(".reply_child_seq").val();
                let contents=parent.find(".reply_child_list_contents");
                let div1=parent.find(".reply_child_div1");
                let div2=parent.find(".reply_child_div2");
                $.ajax({
                    url:"/update.reply_child",
                    type:"post",
                    data:{
                        seq:seq,
                        contents:contents.html().trim()
                    }
                }).done(function(resp){
                    if(resp){
                        contents.attr("contenteditable",false);
                        div1.css("display","flex");
                        div2.css("display","none");
                    }
                })
            }

            function reply_child_cancel(e){
                let parent=$(e).parent().parent();
                let seq= parent.find(".reply_child_seq").val();
                let contents=parent.find(".reply_child_list_contents");
                let div1=parent.find(".reply_child_div1");
                let div2=parent.find(".reply_child_div2");

                contents.attr("contenteditable",false);
                div1.css("display","flex");
                div2.css("display","none");

                $.ajax({
                    url:"/cancel.reply_child",
                    type:"post",
                    data:{
                        seq:seq
                    }
                }).done(function(resp){
                    contents.html(resp);
                })
        
            }



            function reply_child_delete(e){
                let parent= $(e).parent().parent();
                let seq= parent.find(".reply_child_seq").val();
                console.log(seq);
                $.ajax({
                    url:"/delete.reply_child?seq="+seq
                }).done(function(){
                    parent.remove();
                })
            }

             function handleKeyPress(a,event) {
                // 엔터 키 코드는 13입니다.
                if (event.keyCode === 13) {
                    for(let i=0;i<1;i++){
                        event.preventDefault(); // 기본 동작 막기
                         // 현재 div 요소의 높이를 가져옵니다.
                        const currentHeight = $(a).height()+5;
                        console.log(currentHeight);
                        // scrollHeight는 div 요소의 스크롤이 포함된 전체 높이를 나타냅니다.
                        const scrollHeight = $(a).prop('scrollHeight');
                        console.log(scrollHeight);
                        if( scrollHeight < 210){
                        
                            let span=$("<span>\u200B</span>");
                            $(a).append(span);

                            // 커서를 새로 삽입된 br 바로 뒤로 이동
                            let range = document.createRange();
                           
                            range.setStartAfter(span[0]);
                            range.collapse(true);
                            let sel = window.getSelection();
                            sel.removeAllRanges();
                            sel.addRange(range);   

                        }
                        else{
                            alert("더 이상 엔터키를 칠 수 없습니다")
                        }
                      
                    }       
                }
            }
        </script>
    </div>

    <script>
        let btn1 = $("#delete");
        let btn2 = $("#list");
        let btn3 = $("#update");
        let btn4 = $("#confirm");
        let btn5 = $("#cancel");
        let dto = $(".dto");

        let board_title=$("#board_title");
        let board_contents=$("#board_contents");
        let board_title_input=$("#board_title_input");
        let board_contents_input=$("#board_contents_input");

        let input = $(".update_input");

        let title = board_title.html().trim();
        let contents = board_contents.html().trim();

        let reply_input = $(".reply_input");
        let reply_seq = $(".reply_seq");
        let reply_delete = $(".reply_delete");
        let reply_cancel = $(".reply_cancel");
        let reply_update = $(".reply_update");
        let reply_div = $(".reply_div");
        let reply_div1 = $(".reply_div1");
        let reply_div2 = $(".reply_div2");
        let reply_contents = [];
        let reply_confirm=$(".reply_confirm");
       

        let files_delete=$(".files_delete");

        reply_div.each(function (index, e) {
            reply_contents.push($(e).html().trim());
        })

        reply_delete.each(function (index, e) {
            $(e).on("click", function () {
                //location.href = 
                $.ajax({
                    url:"/delete.reply?seq=" + reply_seq.eq(index).val() +
                    "&board_seq=${board_dto.seq}"
                }).done(function(){
                    reply_div.eq(index).parent().parent().remove();
                })
            })
        })

        reply_update.each(function (index, e) { //0
            $(e).on("click", function () {
                reply_div1.eq(index).css({
                    display: "none"
                })
                reply_div2.eq(index).css({
                    display: "flex"
                })
                reply_div.eq(index).attr("contenteditable", "true");
            })
        })
        reply_cancel.each(function (index, e) {
            $(e).on("click", function () {

                reply_div1.eq(index).css({
                    display: "flex"
                })
                reply_div2.eq(index).css({
                    display: "none"

                })
                reply_div.eq(index).attr("contenteditable", "false");
                reply_div.eq(index).html(reply_contents[index]);

            })
        })

        let files_seq=$(".files_seq");
        let data=[];
        files_delete.each(function(index,e){
            $(e).on("click",function(){       
                data.push(files_seq.eq(index).text());
                $(".files_div").eq(index).css({
                    display:"none"
                });
            })    
        })


        /*
        $(".reply_update_form").on("submit", function () {
            let form=$(this);
            let reply_input=form.find(".reply_input");
            let reply_div=form.parents(".reply_contents").find(".reply_div");
            reply_input.val(reply_div.html().trim());
        })*/

        reply_confirm.on("click",function(){
            let btn=$(this);
            let reply_update_div=btn.parents(".reply_contents").find(".reply_div");
            let reply_update_div1=btn.parents(".reply_contents").find(".reply_div1");
            let reply_update_div2=btn.parents(".reply_contents").find(".reply_div2");
            let reply_update_seq=btn.parent().find(".reply_seq").val();
            let reply_update_contents=reply_update_div.html().trim();
            $.ajax({
                url:"/update.reply",
                type:"post",
                data:{
                    seq:reply_update_seq,
                    contents:reply_update_contents,
                    board_seq:"${board_dto.seq}"
                }

            }).done(function(){
                reply_update_div.attr("contenteditable", "false");
                reply_update_div1.css({
                    display: "flex"
                })
                reply_update_div2.css({
                    display: "none"

                })

            });
            
        })


    


        $("#replyform").on("submit",function(){
            if("${WolfID}"!="")
            $("#reply_insert_contents").val($("#reply_insert_div").html().trim());
            else{
                alert("로그인 해주세요");
            }
        })

        $("#joinform").on("submit", function () {

           /* input.each(function (index, e) {
                $(e).val(dto.eq(index).html().trim());

            })*/
            board_title_input.val(board_title.html().trim());
            board_contents_input.val(tinymce.get("board_contents").getContent());

            let jsonData = JSON.stringify(data);
            // 숨겨진 필드에 JSON 데이터 설정
            document.getElementById('arrayField').value = jsonData;

        })

        btn1.on("click", function () { //delete
            swal("/delete.board?seq=${board_dto.seq}");

        })
        btn2.on("click", function () { //list
            location.href = "/list.board?target=${target}&keyword=${keyword}&board_code=${board_code}";

        })
        btn3.on("click", function () { //update
            files_delete.css("display","block");

            $("#div1").css({
                display: "none"
            })
            $("#div2").css({
                display: "flex"
            })
            board_title.attr("contenteditable", "true");
           // board_contents.attr("contenteditable", "true");
           let index=0;
            tinymce.init({
                selector: 'div#board_contents',
                plugins:'wordcount anchor image code  media',
                images_file_types:'jpg,svg,webp,jfif',
                file_picker_types: 'file image media',
                statusbar: false,
                 //plugins: 'inlinecss  autolink charmap codesample emoticons image link lists media searchreplace table visualblocks  checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage advtemplate mentions tableofcontents footnotes mergetags typography',
                toolbar: ' fileupload | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags  | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat ',
                max_width: 600,
                 resize: true,
                 //height:auto,
                language: 'ko_KR',
                forced_root_block : false,
                 //force_br_newlines : true,
                 //force_p_newlines : false,
                //content_css: false,
                file_picker_callback: function (callback, value, meta) {
                    if (meta.filetype === 'image') {
                        let input = document.createElement('input');
                        input.setAttribute('type', 'file');
                        input.setAttribute('accept', 'image/*');
                        input.onchange = function () {
                        let file = this.files[0];
                        let formData = new FormData();
                        formData.append('image', file);
                        $.ajax({
                            url:"/upload.images?board_seq=${board_dto.seq}",
                            type:"post",
                            dataType:"json",
                            processData: false,
                            contentType: false,
                            data:formData
                        }).done(function(resp){ //서버에서 저장해서 데이터 보내줌
                            let imageData = {
                                url:resp.url,
                                width:  resp.width,
                                height: resp.height
                            };
                        callback(resp.url, imageData);
                        //console.log($("body").find(".tox-textfield"));
                            $("body").find(".tox-textfield").eq(2).val(resp.width);
                            $("body").find(".tox-textfield").eq(3).val(resp.height);
                            $("body").find(".tox-button").eq(4).on("click",function(){
                                $.ajax({
                                    url:"/upload.images?board_seq=${board_dto.seq}&check=true",
                                    type:"post",
                                     dataType:"json",
                                    processData: false,
                                    contentType: false,
                                    data:formData
                                 })
                            });
                            
                        })
                    
                        };
                    input.click();
                    }
                },
                setup: function (editor) {
                editor.ui.registry.addButton('fileupload', {
                    text: '파일 업로드: 선택된 파일없음',
                    onSetup: function(e) {
                      myButton=e;
                    },
                    onAction: function() {
                        let files=$("#files");
                        let div=$("<div style='display: none;''>");
                        let input=$("<input type='file'class='upload'>");
                        input.attr("name","files"+index++);
                        div.append(input);
                        let button=$("<button style='font-size: 20px; background-color: white !important'>❌</button>");
                        button.attr("class","button_css");
                        input.click();
                        let temp=$("<div>");
                        //myButton.setText("aa");
                        input.on('change', function() {
                                var fileName = $(this).val().split('\\').pop();
                                console.log(fileName);
                                temp.html('파일 업로드: ' + fileName);
                                temp.append(button);
                                files.append(temp);
                                
                          });   
                        button.on("click",function(){
                            input.remove();
                            temp.remove();
                        })
                        files.append(div);
                            
                    },         
                }); 
                editor.on('change', function () {
                    localStorage.setItem('editorContent', editor.getContent());
                });
            }
                

        });
    })

   
        $("#reply_btn").on("click",function(){
            $("body").find(".reply_child_label").eq(0).remove();
        })


        btn5.on("click", function () {//cancel
            $(this).parent().parent().find("#files").empty();
            data=[];
            files_delete.css("display","none");
            $("#div1").css({
                display: "flex"
            })
            $("#div2").css({

                display: "none"
            })
            board_title.attr("contenteditable", "false");
            //board_contents.attr("contenteditable", "false");
            tinymce.remove();
            board_title.html(title);
            board_contents.html(contents);
            $(".files_div").css({
                display:"flex"
            });

            $.ajax({
                url:"/detail_cancel.images",
                type:"post",
                data:{
                    board_seq:$("#board_dto_seq").val(),
                    board_code:"${board_code}"
                }
            })
        })





        function swal(comfirm) {
            Swal.fire({
                title: '게시물을 삭제 하시겠습니까?',
                // text: "You won't be able to revert this!",
                showCancelButton: true,
                confirmButtonText: '삭제하기',
                cancelButtonText: '취소하기',
                reverseButtons: false, // 확인 버튼과 취소 버튼을 반대로 표시
                customClass: {
                    confirmButton: 'custom-confirm-button',
                    cancelButton: 'custom-cancel-button'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    // 확인 버튼을 클릭한 경우
                    Swal.fire(
                        'Deleted!'
                    ).then((result) => {
                        if (result.isConfirmed) {
                            location.href = comfirm;
                        }
                    });
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    // 취소 버튼을 클릭한 경우
                    Swal.fire(
                        'Cancelled'
                    ).then((result) => {

                    });

                }
            });
        }
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
  

  <script>
    
    resize();
        $(window).resize(function() {
            resize();
        }); 
        function resize(){
            const currentHeight =  $("body").height()+5;
            const scrollHeight = $("body").prop('scrollHeight');
            if(scrollHeight>currentHeight){
            $(".img_bg").css({
                left:"0%",
                width:"98.5%"
            })
            
            }
        }
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

</body>

</html>