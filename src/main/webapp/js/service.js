$(() => {
	// 현재 페이지 주소
	var pathname = window.location.pathname;
	
	// ================================ [ Q&A List ] ================================
	if(pathname === "/qna_list.service"){
		const searchParams = new URLSearchParams(window.location.search);
    	const res = searchParams.get('res');
    	if(res !== null) $("#qna-res-seelct").val(res);
	}
	
	// Admin memeber list select bar change
	$("#qna-res-seelct").on("change", () => {
		location.href="/qna_list.service?res=" + $("#qna-res-seelct").val();
	});
	
});

const serviceFormMove = (url) => {
	
	console.log("url === ", url);
	
	$.ajax({
		url: "/check.service"
	})
	.done((res) => {
		console.log(JSON.stringify(res));
		if(res === "ok") location.href = url;
		else alert("로그인이 필요한 서비스 입니다.");
	});
}


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