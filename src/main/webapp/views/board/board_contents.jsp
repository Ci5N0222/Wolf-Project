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
    }

</style>

</head>
<body>
    <form action="/insert.board" id="fileform" method="post" enctype="multipart/form-data" >
        <div class="container">
            <div style="display: flex; flex: 1; font-size: xx-large; justify-content: center">
                자유 게시판 글 작성하기
            </div>
            <div style="flex: 1;">
                <input type="text" placeholder="글 제목을 입력하세요" style="width: 100%;" name="title">
            </div>
            <div style="flex: 8;"  id="contents"></div>
            <div style="display: flex; flex: 1; justify-content: flex-end;">
                    <div style="display: none;"><input type="file" name="file" id="upload"></div>
                    <button type="button" id="list">목록으로</button>
                    <button>작성완료</button>
            </div>
        </div>
<script>
    var  myButton;
    tinymce.init({
      selector: 'div#contents',
      plugins:'wordcount anchor image inlinecss ',
      //toolbar:'image',
      images_file_types:'jpg,svg,webp',
      file_picker_types: 'file image media',
      //plugins: 'inlinecss  autolink charmap codesample emoticons image link lists media searchreplace table visualblocks  checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage advtemplate mentions tableofcontents footnotes mergetags typography',
      toolbar: ' fileupload | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags  | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat ',
      max_width: 600,
      resize: false,
      //height:auto,
      language: 'ko_KR',
      forced_root_block : false,
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
                        $("#upload").click();
                        //myButton.setText("aa");
                            
                    },         
                });   
                $('#upload').on('change', function() {
                     var fileName = $(this).val().split('\\').pop();
                     console.log(fileName);
                     if(fileName===""){
                        myButton.setText('파일 업로드: 선택된 파일없음');
                        
                     }
                     else{
                        myButton.setText('파일 업로드: ' + fileName);
                     }
                     
                });   
                editor.on('change', function () {
                    localStorage.setItem('editorContent', editor.getContent());
                });
        }
    });
</script>
<script>
		$("#list").on("click",function(){
			location.href="/list.board";
		})
</script>
</body>
</html>