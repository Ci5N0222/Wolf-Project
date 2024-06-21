<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    // URL 파라미터로 전달된 값을 가져오기
    String boardCode = request.getParameter("board_code");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.tiny.cloud/1/9bewfouem96jjnfvuu236yinb3kp53xruh2gkkz3pkfnkw6c/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
 

<style>
     :root {
    --bg-light: #ffd449;
    --bg-dark: #14213D;
    --bg-transparent: transparent;

    --color-white: #eeeeee;
    --color-black: #14213D;
    --bg-nav: #f9a620;
    --color-nav-icon: #14213D;
    --color-nav-bg: #f9a620;
    font-size: 16px;
}
html,
    
    .container{
        display: flex;
        flex-direction: column;
        max-width: 1000px;
        margin: auto;
        
       
    }
    .btn{
    	height: 30px;
    	line-height: 30px;
    	font-size: 15px ;
    	color: white ;
   		background-color: #428bca;
    	border: none;
    	border-radius: 5px;
    	cursor: pointer;
    }
    .btn:hover{
        transform: scale(1.2);
        text-decoration: underline;
    }
    #files{
        color: white;
    }

</style>
<style>
      body {
        margin: 0;
         background-color: var(--bg-dark);
       
       
      } 
    /* img */
.img_bg {
position: absolute;
top: 0%;
left: 0;
width: 100%;
object-fit: cover;
}

.bgs {
animation: bg 1s ease-in Infinite Alternate;
transition: all ease-in 0.2s;
width: 50px;
}

.bgs:nth-child(1) {
top: 20%;
background-color: #eee;
left: 80%;
}

.bgs:nth-child(2) {
top: 20%;
left: 80%;
width: 40px;
}

.bgs:nth-child(3) {
top: 15%;
left: 20%;
}

.bgs:nth-child(4) {
top: 20%;
left: 40%;
width: 30px;
}

.bgs:nth-child(5) {
top: 12%;
left: 50%;
}

.bgs:nth-child(6) {
top: 12%;
left: 80%;
width: 20px;
}

@keyframes bg {
0% {
    opacity: 1;
}

100% {
    opacity: 0;
}
}
.index{
    z-index: 100;
        position: relative;
}
</style>

</head>
<body>
    <img  src="/images/bg1.png" alt="" class="img_bg"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs"> 
    <img  src="/images/bg3.png" alt="" class="img_bg bgs">
    <form action="/insert.board" id="fileform" method="post" enctype="multipart/form-data" >
        <div class="container">
            <div style="margin-top: 20px; display: flex; flex: 1; font-size: 40px; justify-content: center; background-color: white; font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;" class="index">
                자유 게시판 글 작성하기 
            </div>
            <div style="flex: 2; overflow: hidden; border: 0px; "class="index">
                <input type="text" placeholder="글 제목을 입력하세요" style="border: 0; width: 100%; height: 75px; font-size:30px;" name="title">
            </div>
            <div style="flex: 8;"  id="contents"></div>
            <div style="display: flex; flex: 1; justify-content: flex-end; "class="index">        
                    <button type="button"  class="btn" id="list">목록으로</button>&nbsp&nbsp
                    <button class="btn">작성완료</button>
            </div>
            <div id="files" class="index">
            </div>
        </div>
        <input type="hidden" value="<%= boardCode %>" name="board_code">
    </form>
<script>
    var  myButton;
    let index=0;
    tinymce.init({
      selector: 'div#contents',
      plugins:'wordcount anchor image',
      //toolbar:'image',
      images_file_types:'jpg,svg,webp',
      file_picker_types: 'file image media',
      //plugins: 'inlinecss  autolink charmap codesample emoticons image link lists media searchreplace table visualblocks  checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage advtemplate mentions tableofcontents footnotes mergetags typography',
      toolbar: ' fileupload | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags  | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat ',
      resize: true,
      height:600,
      language: 'ko_KR',
      statusbar: false,
      forced_root_block : false,
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
                            url:"/upload.images?board_seq=999999",
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
                                    url:"/upload.images?board_seq=999999&check=true",
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
      //force_br_newlines : true,
      //force_p_newlines : false,
      //content_css: false,
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
                        let button=$("<button style='width: 50px; height: 50px; background-color: #14213D; border: 0; font-size: 20px;'>❌</button>")
                       
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
</script>
<script>
		$("#list").on("click",function(){
            let boardCode = "<%= boardCode %>";
            $.ajax({
                url:"/delete.images?board_code="+boardCode
            }).done(function(resp){
               // alert(resp);
                location.href="/list.board?board_code="+boardCode;
            })
			
		})
</script>
</body>
</html>