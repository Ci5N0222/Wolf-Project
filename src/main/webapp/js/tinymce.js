$(() => {
	
	
	var  myButton;
    let index=0;
    
    tinymce.init({
		selector: 'div#contents',
		plugins:'wordcount anchor image',
		images_file_types:'jpg,svg,webp',
		file_picker_types: 'file image media',
		toolbar: ' fileupload | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags  | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat ',
		resize: true,
		height: 500,
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
				        url: "/upload.images?board_seq=999999",
				        type: "post",
				        dataType: "json",
				        processData: false,
				        contentType: false,
				        data: formData
				    }).done(function(resp){ //서버에서 저장해서 데이터 보내줌
				        let imageData = {
				            url: resp.url,
				            width: resp.width,
				            height: resp.height
				        };
				    	callback(resp.url, imageData);
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
				        
				    });
				
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
			        let button=$("<button style='margin-left: 30px; font-size:16px; border: none; background-color:white; cursor:pointer'> X </button>")
			        input.click();
			        let temp=$("<div>");
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
    
    
});