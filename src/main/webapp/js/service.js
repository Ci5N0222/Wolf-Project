const serviceFormMove = (url) => {
	
	console.log("url === ", url);
	
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