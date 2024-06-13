/** 페이지 로드 이후 동작해야 할 스크립트 **/
$(() => {
	
});



// Member 정보를 수정할 수 있게 폼을 바꾸는 함수
const adminMemberEdit = () => {
	// 입력 폼
	
	// 버튼
	$(".btn-box1").css({"display":"none"});
	$(".btn-box2").css({"display":"block"});
}


// Game정보를 삭제하는 함수
const adminGameDelete = (seq) => {
	
	$.ajax({
		url: "/game_delete.admin",
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


/** 페이지 네비게이션 함수 **/
const pagenation = (cpage, recordTotalCount, recordCountPerPage, naviCountPerPage, url) => {
	
	// 총 페이지 수
	let pageTotalCount = 0;
	if(recordTotalCount % recordCountPerPage > 0) pageTotalCount = recordTotalCount / recordCountPerPage + 1;
	else pageTotalCount = recordTotalCount / recordCountPerPage;
	
	// 네비게이터의 시작 번호
	let startNavi = Math.floor((cpage - 1) / naviCountPerPage) * naviCountPerPage + 1
	
	// 네비게이터의 마지막 번호
	let endNavi = startNavi + naviCountPerPage - 1;
	
	if(endNavi > pageTotalCount) endNavi = pageTotalCount;
	
	let needNext = true;
	let needPrev = true;
	
	if(startNavi == 1) needPrev = false;
	if(endNavi == pageTotalCount) needNext = false;
	
	if(needPrev){
		let prev = `<a href='${url}?cpage=" + (startNavi - 1) + "'>" + "< </a>`;
		$('#navi').append(prev);
	}
	
	for(let i = startNavi; i <= endNavi; i++){
		if(cpage === i){
			let items = `<a href='${url}?cpage=" + i + "'>" + i + "</a> `;
    		$('#navi').append(items);
		} else {
			let items = `<a href='${url}?cpage=" + i + "'>" + i + "</a> `;
    		$('#navi').append(items);	
		}
	}
	
	if(needNext) {
		let next = `<a href='${url}?cpage=" + (endNavi + 1) + "'>></a>`;
		$('#navi').append(next);
	}
	
}