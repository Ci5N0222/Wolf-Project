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