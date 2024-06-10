

$(function(){
	var sun = document.querySelector(".sun");
	var navi = document.querySelector(".navi");
	
	// 모드 변경 이벤트 리스너 등록
	$("#mode").on("click", toggleMode)
});

// 모드 변경 시 호출되는 함수
function toggleMode() {
    let body = document.body;
    // console.log("test")
    // <body>에 'light' 클래스 토글하기
    body.classList.toggle("light");
    
    // 아이콘 토글하기
    let darkIcon = document.querySelector(".fa-regular.fa-lightbulb");
    let lightIcon = document.querySelector(".fa-solid.fa-lightbulb");

    if (body.classList.contains("light")) {
        darkIcon.style.display = "none"; // 어두운 모드 아이콘 숨기기
        lightIcon.style.display = "inline-block"; // 밝은 모드 아이콘 표시
    } else {
        darkIcon.style.display = "inline-block"; // 어두운 모드 아이콘 표시
        lightIcon.style.display = "none"; // 밝은 모드 아이콘 숨기기
    }

    // <body>에 'light' 클래스가 있을 때 색상을 화이트로 변경
    if (body.classList.contains("light")) {
        document.documentElement.style.setProperty('--color-black', 'black');
        sun.style.backgroundColor = "var(--bg-dark)";
    	navi.style.backgroundColor = "var(--bg-dark)";
    } else {
        document.documentElement.style.setProperty('--color-black', 'white');
        navi.style.backgroundColor = "var(--bg-nav)";
    	sun.style.backgroundColor = "var(--bg-nav)";
    }
}