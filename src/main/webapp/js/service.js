const serviceFormMove = (url, id) => {
	
	console.log("url === ", url);
	console.log("id === ", id);
	
	$.ajax({
		url: "/check.service",
		method: "post",
		data: {
			id
		}
	})
	.done((res) => {
		console.log(JSON.stringify(res));
		if(res === "ok") location.href = url;
		else alert("로그인이 필요한 서비스 입니다.");
	});
}