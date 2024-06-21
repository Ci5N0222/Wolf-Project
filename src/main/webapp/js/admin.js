/** 페이지 로드 이후 동작해야 할 스크립트 **/
$(() => {
	// 현재 페이지 주소
	var pathname = window.location.pathname;

	// ================================ [ Board ] ================================
	if(pathname === "/notice_list.admin"){
		const searchParams = new URLSearchParams(window.location.search);
    	const boardCode = searchParams.get('board_code');
    	if(boardCode !== null) $("#board-code-select").val(boardCode);
	}
	
	// Admin memeber list select bar change
	$("#board-code-select").on("change", () => {
		location.href="/notice_list.admin?board_code=" + $("#board-code-select").val();
	});

	// ================================ [ Members ] ================================
	
	// Admin members list select bar default
	if(pathname === "/members_list.admin"){
		const searchParams = new URLSearchParams(window.location.search);
    	const grade = searchParams.get('grade');
    	if(grade !== null) $("#members-id-select").val(grade);
	}
	
	// Admin memeber list select bar change
	$("#members-id-select").on("change", () => {
		location.href="/members_list.admin?grade=" + $("#members-id-select").val();
	});
	
	// ================================ [ Game ] ================================
	
	// Admin game list select bar default
	if(pathname === "/game_list.admin"){
		const searchParams = new URLSearchParams(window.location.search);
    	const service = searchParams.get('service');
    	if(service !== null) $("#game-service-select").val(service);
	}
	
	//  Admin Game list select bar change
	$("#game-service-select").on("change", () => {
		
		location.href="/game_list.admin?service=" + $("#game-service-select").val();
	});
	
	// Admin game insert, detail image preview
	if(pathname === "/page_game_insert.admin" || pathname === "/game_detail.admin"){
        $("#admin_game_thumbnail").on("change", (e) => {
            const file = e.target.files[0];
            if(file){
                const reader = new FileReader();
                reader.onload = function(e) {
                    $("#imagePreview").attr("src", e.target.result);
                    $("#imagePreview").show();
                 	$("#imagePreviewBtn").show();
                }
                reader.readAsDataURL(file);
            } else {
				if(pathname === "/game_detail.admin"){
					$("#imagePreview").attr("src", $("#before_thumbnail").val());
				} else{
					$("#imagePreview").attr("src", "");	
				}
                $("#imagePreview").hide();
                $("#imagePreviewBtn").hide();
			}
        });
    }
    
    // Game Insert Validation
    $("#admin_game_insert").on("submit", () => {
		$("#game_discription").val($("#div_game_discription").html().trim());
		$("#game_contents").val($("#div_game_contents").html().trim());
		
		if($("#admin_game_thumbnail").val() === ""){
			alert("thumbnail 이미지 없음!");
			return false;
		}
		
		if($("#game_title").val() === ""){
			alert("제목을 입력하세요");
			return false;
		}
		
		if($("#game_discription").val() === ""){
			alert("요약 내용을 입력하세요");
			return false;
		}
		
		if($("#game_contents").val() === ""){
			alert("상세 내용을 입력하세요.");
			return false;
		}
	});
	
	// Game Update Validation
	$("#admin_game_update").on("submit", () => {
		$("#game_discription").val($("#div_game_discription").html().trim());
		$("#game_contents").val($("#div_game_contents").html().trim());
		
		if($("#game_title").val() === ""){
			alert("제목을 입력하세요");
			return false;
		}
		
		if($("#game_discription").val() === ""){
			alert("요약 내용을 입력하세요");
			return false;
		}
		
		if($("#game_contents").val() === ""){
			alert("상세 내용을 입력하세요.");
			return false;
		}
	});
	
});

// Admin main dashboard gender chart
const getGenderChart = (data) => {
	const genderLabels = ["남성", "여성"]
	const genderChart = document.getElementById('genderChart');
	new Chart(genderChart, {
		type: 'bar',
		data: {
			 labels: genderLabels,
			  datasets: [{
			    label: '남여 이용자 비율',
			    data: data,
			    backgroundColor: [
			      'rgba(255, 99, 132, 0.2)',
			      'rgba(255, 159, 64, 0.2)'
			    ],
			    borderColor: [
			      'rgb(255, 99, 132)',
			      'rgb(255, 159, 64)'
			    ],
			    borderWidth: 1
			  }]
		},
		options: {
		    scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  },
	});
}

// Admin main dashboard age chart
const getAgeChart = (data) => {
	const birthLabels = ["10대 이하", "20대", "30대", "40대", "50대", "60대 이상"]
	const birthChart = document.getElementById('birthChart');
	new Chart(birthChart, {
		type: 'bar',
		data: {
			 labels: birthLabels,
			  datasets: [{
			    label: '연령별 이용자 수',
			    data: data,
			    backgroundColor: [
			      'rgba(255, 99, 132, 0.2)',
			      'rgba(255, 159, 64, 0.2)',
			      'rgba(255, 205, 86, 0.2)',
			      'rgba(75, 192, 192, 0.2)',
			      'rgba(54, 162, 235, 0.2)',
			      'rgba(153, 102, 255, 0.2)',
			      'rgba(201, 203, 207, 0.2)'
			    ],
			    borderColor: [
			      'rgb(255, 99, 132)',
			      'rgb(255, 159, 64)',
			      'rgb(255, 205, 86)',
			      'rgb(75, 192, 192)',
			      'rgb(54, 162, 235)',
			      'rgb(153, 102, 255)',
			      'rgb(201, 203, 207)'
			    ],
			    borderWidth: 1
			  }]
		},
		options: {
		    scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  },
	});
}

// ====================================== [ 멤버 ] ===========================================

// Member info update form change
const adminMemberEdit = (defaultValue) => {
	$('#grade_select').val(defaultValue); 
	$('#grade_select').css({"display": "inline-block"});
	$('#grade').css({"display": "none"});
	
	// 버튼
	$(".btn-box1").css({"display":"none"});
	$(".btn-box2").css({"display": "flex", "justify-content": "space-evenly", "align-items": "center"});
}

// Members grade update
const adminMemberUpdate = (id) => {
	if($("#grade_select").val() === "99" || $("#grade_select").val() === "98"){
		if(confirm("정말 관리자로 변경하시겠습니까?")){
		} else return false;
	}
	
	$.ajax({
		url: "/members_update.admin",
		method: "post",
		data:{
			grade: $("#grade_select").val(),
			id: id
		}
	})
	.done((res)=> {
		console.log("res === ", res);
		if(res === "ok"){
			location.href = `members_detail.admin?id=${id}`;
		}
	});
}

// Search member list
const adminMemberSearch = () => {
	location.href="/members_search.admin?id="+$("#member_search_text").val();
}

// ====================================== [ 게 임 ] ===========================================

// Game insert preview image delete
const previewImageDelete = (image, url) => {
	if(image){
		$("#admin_game_thumbnail").val("");
		$("#imagePreview").attr("src", url);
		$("#imagePreviewBtn").hide();	
	} else {
		$("#admin_game_thumbnail").val("");
		$("#imagePreview").attr("src", "");
		$("#imagePreview").hide();
		$("#imagePreviewBtn").hide();	
	}	
}

// Game info update form change
const adminGameEdit = (defaultValue) => {
	$(".admin-game-btn").css({"display": "none"});
	$(".admin-game-update-btn").css({
		"display": "flex", 
		"justify-content": "space-evenly", 
		"align-items": "center"
	});
	
	$('#sevice_select').val(defaultValue); 
	$('#sevice_select').css({"display": "inline-block"});
	
	$(".admin_game_update_thumbnail").show();
	$("#game_title").removeAttr("readonly");
	$("#div_game_discription").attr("contenteditable", "true");
	$("#div_game_contents").attr("contenteditable", "true");
	$("#game_title").focus();
}

// Game info delete
const adminGameDelete = (seq) => {
	if(confirm("정말로 삭제하시겠습니까?")){
		$.ajax({
			url: "/game_delete.admin",
			method: "post",
			data:{
				seq
			}
		})
		.done((res)=> {
			if(res === "ok"){
				location.href = "/game_list.admin";
			}
		});
	}
}

// ====================================== [ 공 통 ] ===========================================

/** page navigation **/
const pagenation = (cpage, recordTotalCount, recordCountPerPage, naviCountPerPage, url, wpageName, wpage) => {
	
	if(wpageName === undefined) wpageName = "";
	if(wpage === undefined)	wpage = "";

	// total page count
	let pageTotalCount = 0;
	if(recordTotalCount % recordCountPerPage > 0) pageTotalCount = recordTotalCount / recordCountPerPage + 1;
	else pageTotalCount = recordTotalCount / recordCountPerPage;
	
	// navigator start number
	let startNavi = Math.floor((cpage - 1) / naviCountPerPage) * naviCountPerPage + 1
	
	// navigator end number
	let endNavi = startNavi + naviCountPerPage - 1;
	
	if(endNavi > pageTotalCount) endNavi = pageTotalCount;
	
	let needNext = true;
	let needPrev = true;
	
	if(startNavi == 1) needPrev = false;
	if(endNavi == pageTotalCount) needNext = false;
	
	if(needPrev){
		let prev = `<a href='${url}?${wpageName}=${wpage}&cpage=${(startNavi - 1)}'> < </a>`;
		$('.page-navigation').append(prev);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		if(cpage === i){
			let items = `<a href='${url}?${wpageName}=${wpage}&cpage=${i}'> ${i} </a>`;
    		$('.page-navigation').append(items);
		} else {
			let items = `<a href='${url}?${wpageName}=${wpage}&cpage=${i}'> ${i} </a>`;
    		$('.page-navigation').append(items);	
		}
	}
	
	if(needNext) {
		let next = `<a href='${url}?${wpageName}=${wpage}&cpage=${(endNavi + 1)}'> > </a>`;
		$('.page-navigation').append(next);
	}
	
}