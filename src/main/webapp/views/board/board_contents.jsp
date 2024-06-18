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
<script src="https://cdn.tiny.cloud/1/9bewfouem96jjnfvuu236yinb3kp53xruh2gkkz3pkfnkw6c/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<style>
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

</style>


</head>
<body>
    <form action="/insert.board" id="fileform" method="post" enctype="multipart/form-data" >
        <div class="container">
            <div style="display: flex; flex: 1; font-size: xx-large; justify-content: center">
                자유 게시판 글 작성하기
            </div>
            <div style="flex: 2;">
                <input type="text" placeholder="글 제목을 입력하세요" style="width: 100%; height: 75px; font-size:30px;" name="title">
            </div>
            <div style="flex: 8;"  id="contents"></div>
            <div style="display: flex; flex: 1; justify-content: flex-end;">        
                    <button type="button"  class="btn" id="list">목록으로</button>&nbsp&nbsp
                    <button class="btn">작성완료</button>
            </div>
            <div id="files">
            </div>
        </div>
       
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
                        let button=$("<button style='width: 50px; height: 50px;'>삭제</button>")
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
            $.ajax({
                url:"/delete.images"
            }).done(function(resp){
               // alert(resp);
                location.href="/list.board";
            })
			
		})
</script>
</body>
</html>