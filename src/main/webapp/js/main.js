// 모드 변경 시 호출되는 함수
function toggleMode() {
    let body = document.body;
    body.classList.toggle("light");
  
    // 현재 모드 상태를 로컬 스토리지에 저장
    localStorage.setItem("mode", body.classList.contains("light") ? "light" : "dark");

    // 아이콘 토글
    document.querySelector(".fa-regular.fa-lightbulb").style.display = body.classList.contains("light") ? "none" : "inline-block";
    document.querySelector(".fa-solid.fa-lightbulb").style.display = body.classList.contains("light") ? "inline-block" : "none";

    // 색상 변경
    let navColor = body.classList.contains("light") ? "var(--lightNav)" : "var(--darkNav)";
    let sunColor = body.classList.contains("light") ? "var(--lightMode)" : "var(--darkMode)";
    let boxShadow = body.classList.contains("light") ? "0px 5px 20px #999" : "0px 5px 20px #444";

    document.querySelector(".navi").style.backgroundColor = navColor;
    document.querySelector(".m_navi").style.backgroundColor = navColor;
    let sun = document.querySelector(".sun");
    sun.style.background = sunColor;
    sun.style.boxShadow = boxShadow;
}

// 페이지 로드 시 모드 상태 복원
document.addEventListener("DOMContentLoaded", function () {
    // 저장된 모드 상태 확인 및 설정
    if (localStorage.getItem("mode") === "light") {
        toggleMode();
    }
  
    // 현재 페이지 주소
    var pathname = window.location.pathname;
    if (pathname === "/" || pathname === "/index.jsp") homeBinding();
});

// 모드 변경 이벤트 리스너 등록
document.getElementById("mode").addEventListener("click", toggleMode);

  
  /** Home 입장 시 게임 데이터 받아서 카드에 바인딩 **/
  const homeBinding = () => {
      $.ajax({
          url: "/home.web",
          method: "post",
          dataType: "json"
      })
      .done((res) => {
          console.log("res === ", res);
          console.log(res.result);
          if (res.result === "ok") {
			  res.data.forEach((item, i) => {
				  homeCardSetting(item);
				  homeMobileSetting(item, i);
			  });
          } else {
              console.log("No 'data' property found in response.");
          }
      });
  }
  
  const homeCardSetting = (res) => {
      let discription = res.discription;
      if(discription.length > 20) discription = discription.slice(0, 19) + "...";
      
      let item = `
          <div class="item flex-grow-1" onclick="location.href='/detail.game?seq=${res.seq}'">
              <div class="card d-flex">
                  <img src="${res.thumbnail}" class="card-img-top" alt="..."
                      style="flex: 7;">
                  <div class="card-body" style="flex: 3;">
                      <p class="card-text">${res.title}</p>
                      <p class="card-text">${discription}</p>
                  </div>
              </div>
          </div>`
  
      $("#card-form").append(item);
  }
  
  const homeMobileSetting = (res, i) => {
	let item = "";
	if(i === 0){
		item = `
			<div class="carousel-item active" onclick="location.href='/detail.game?seq=${res.seq}'">
				<img src="${res.thumbnail}" alt="...">
			</div>`
	} else {
		item = `
			<div class="carousel-item" onclick="location.href='/detail.game?seq=${res.seq}'">
				<img src="${res.thumbnail}" alt="...">
			</div>`
	}
	
	$('#mobile-contents').append(item);
  }
  
  