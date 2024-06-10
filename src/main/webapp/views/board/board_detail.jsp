<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        div {
            display: flex;
        }

        .container {
            width: 600px;
            height: 600px;
            margin: auto;
            flex-direction: column;
            border: 1px solid black;
        }

        .center {
            justify-content: center;
            align-items: center;
        }

        .reply {
            margin-top: 20px;
            width: 600px;
            height: auto;
            margin-bottom: auto;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid black;
        }

        #reply_contents {
            width: 600px;
            height: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: auto;
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
            height: auto;
            margin: 20px;
        }

        .swal2-container {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            text-align: center;
        }

        .custom-confirm-button {
            color: white !important;
            /* 확인 버튼 텍스트 색깔 */
        }

        .custom-cancel-button {
            color: red !important;
            /* 취소 버튼 텍스트 색깔 */
        }

        button {
            width: 70px;
            height: 70px;
        }

        .none {
            display: none;
        }

        .block {
            display: flex;
        }

        p {
            width: 100%;
        }
    </style>
</head>

<body>
    <div class="container">
        <div style="flex: 1;" class="center dto title" id="board_title">${board_dto.title}</div>
        <div style="flex: 1;" class="center">${board_nickname}</div>
        <div style="flex: 1; color: gray;">
            <div style="flex: 1;">
                <p>
                    <fmt:formatDate value="${board_dto.write_date}" pattern="yyyy.MM.dd HH:mm" />
                    조회 ${board_dto.count}
                </p>
            </div>
            <div style="flex: 1;">
                <c:forEach var="files_dto" items="${files_list}">
                    <div>
                        ${files_dto.seq }. <a
                            href="/download.files?sysname=${files_dto.sysname }&oriname=${files_dto.oriname}">${files_dto.oriname}</a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div style="border: 1px solid black; align-items: center; justify-content: center;"></div>
        <div style="flex: 5;" class="dto" id="board_contents">${board_dto.contents}</div>
        <div style="flex: 1; justify-content: flex-end;">
            <c:choose>
                <c:when test="${WolfID eq dto.member_id}">
                    <div style="border: 0; display: flex;" id="div1">
                        <button type="button" id="update">수정하기</button>
                        <button type="button" id="delete">삭제하기</button>
                        <button type="button" id="list">목록으로</button>
                    </div>
                    <div style="border: 0; display: none;" id="div2">
                        <form action="/update.board" method="post" id="joinform">
                            <input type="hidden" name="title" class="update_input"> 
                            <input type="hidden" name="contents" class="update_input"> 
                            <input type="hidden" name="count" value="${board_dto.count}"> 
                            <input type="hidden" name="seq" value="${board_dto.seq}" class="notuse">
                            <button type="submit" id="confirm">확인</button>
                            <button type="button" id="cancel">취소</button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <button id="list">목록으로</button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <form action="/insert.reply" method="get" id="replyform">
    <div class="reply">
        <div style="flex: 4; border: 1px solid black; margin: 15px; word-break: break-all;" contenteditable="true"
            class="dto" id="reply_insert_div"></div>
        <input type="hidden" name="contents" id="reply_insert_contents">
        <input type="hidden" name="member_id" value="${WolfID}"class="notuse">
        <input type="hidden" name="board_seq" value="${board_dto.seq}" class="notuse">
        <div style="flex: 1; justify-content: center; align-items: center;">
            <button id="reply_btn">등록</button>
        </div>
    </div>
    </form>
    <div id="reply_contents">
        <c:forEach var="reply_dto" items="${reply_list}">
            <div class="reply_contents">
                <div style="flex: 6; word-break: break-all; white-space: pre-wrap; flex-direction: column;">
                    <div>${reply_nickname}</div>
                    <div class="reply_div">${reply_dto.contents}</div>
                    <div><p style="color: gray;"><fmt:formatDate value="${reply_dto.write_date}" pattern="yyyy.MM.dd HH:mm" /></p></div>
                </div>
                <div style="flex: 1; font-size: x-small; justify-content: flex-end; align-items: flex-end;">
                    <div id="check">
                        <div stylse=" display: flex; width: 110px;" class="reply_div1">
                            <button style="width: 50px; height: 50px;" class="reply_update">수정</button>
                            <button style="width: 50px
                            ; height: 50px;" class="reply_delete">삭제</button>
                        </div>
                        <div style="display: none; width: 110px;" class="reply_div2">
                            <form action="/update.reply" method="post" class="reply_update_form">
                                <input type="hidden" name="contents" class="reply_input">
                                <input type="hidden" name="seq" value="${reply_dto.seq}" class="reply_seq">
                                 <input type="hidden" name="parent_seq" value="${dto.seq}" class="notuse">
                                <button style="width: 50px; height: 50px;" type="submit" class="reply_confirm">확인</button>
                                <button style="width: 50px; height: 50px;" type="button" class="reply_cancel">취소</button>
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
            </div>
        </c:forEach>
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


        reply_div.each(function (index, e) {
            reply_contents.push($(e).html().trim());
        })

        reply_delete.each(function (index, e) {
            $(e).on("click", function () {
                location.href = "/delete.reply?seq=" + reply_seq.eq(index).val() +
                    "&parent_seq=${dto.seq}";
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

        
        $(".reply_update_form").on("submit", function () {
            let form=$(this);
            let reply_input=form.find(".reply_input");
            let reply_div=form.find(".reply_div");
            reply_input.val(reply_div.html().trim());
        })


        $("#replyform").on("submit",function(){
            if("${WolfID}"!="")
            $("#reply_insert_contents").val($("#reply_insert_div").html().trim());
            else{
                alert("로그인 해주세요");
            }
        })

        $("#joinform").on("submit", function () {

            input.each(function (index, e) {
                $(e).val(dto.eq(index).html().trim());

            })
        })

        btn1.on("click", function () { //delete
            swal("/delete.board?seq=${board_dto.seq}");

        })
        btn2.on("click", function () { //list
            location.href = "/list.board";

        })
        btn3.on("click", function () { //update
            $("#div1").css({
                display: "none"
            })
            $("#div2").css({
                display: "flex"
            })
            board_title.attr("contenteditable", "true");
            board_contents.attr("contenteditable", "true");
        })

        btn5.on("click", function () {//cancel
            dto.eq(0).html(title);
            dto.eq(1).html(contents);

            $("#div1").css({
                display: "flex"
            })
            $("#div2").css({

                display: "none"
            })
            board_title.attr("contenteditable", "false");
            board_contents.attr("contenteditable", "false");
        })





        function swal(comfirm) {
            Swal.fire({
                title: '댓글을 삭제 하시겠습니까?',
                // text: "You won't be able to revert this!",
                showCancelButton: true,
                confirmButtonText: '삭제하기',
                cancelButtonText: '취소하기',
                reverseButtons: true, // 확인 버튼과 취소 버튼을 반대로 표시
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
</body>

</html>