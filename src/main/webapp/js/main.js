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
   	var mode = localStorage.getItem("mode");
      if (mode === "light") {
          toggleMode(); // light 모드인 경우 토글 함수 호출하여 변경
      }
  
  	  // 모드 변경 이벤트 리스너 등록
	  let modeEvent = document.getElementById("mode"); //버튼
	  modeEvent.addEventListener("click", toggleMode);
  
    // 현재 페이지 주소
    var pathname = window.location.pathname;
    if (pathname === "/" || pathname === "/index.jsp") homeBinding();
  
  	     
	if(pathname === "/qna_list.service"){
		const searchParams = new URLSearchParams(window.location.search);
		const res = searchParams.get('res');
		if(res !== null) $("#qna-res-seelct").val(res);
	}
	
	// Admin memeber list select bar change
	$("#qna-res-seelct").on("change", () => {
		location.href="/qna_list.service?res=" + $("#qna-res-seelct").val();
	});
<<<<<<< HEAD

	resize();
	navbarToggle();
	
	// 팝업 클릭 시 토글 효과
	$(".signBtn").on("click", togglePopup);
	
	// 페이지 전환 감지 및 팝업 닫기
	$(window).on("beforeunload", closePopupOnPageChange);
	
	// 팝업 외부 클릭 감지 및 팝업 닫기
	$(document).on("click", closePopupOnClickOutside);

	
});

// 팝업 토글 함수
function togglePopup() {
    let popup = document.querySelector(".login-popup");
    if (popup.style.display === "none" || popup.style.display === "") {
        popup.style.display = "flex";
    } else {
        popup.style.display = "none";
    }
}

// 페이지 전환 시 팝업 닫기
function closePopupOnPageChange() {
    let popup = document.querySelector(".login-popup");
    popup.style.display = "none";
}

// 팝업 외부 클릭 시 팝업 닫기
function closePopupOnClickOutside(event) {
    let popup = document.querySelector(".login-popup");
    if (popup.style.display === "block" && !popup.contains(event.target) && !document.querySelector(".loginBtn").contains(event.target)) {
        popup.style.display = "none";
    }
}


/** Home 입장 시 게임 데이터 받아서 카드에 바인딩 **/
const homeBinding = () => {
	$.ajax({
		url: "/home.web",
		method: "post",
		dataType: "json"
	})
	.done((res) => {
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
/** index card binding **/
const homeCardSetting = (res) => {
	let discription = res.discription;
	if (discription.length > 20) discription = discription.slice(0, 19) + "...";

	let item = `
=======
  
});

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
  /** index card binding **/
  const homeCardSetting = (res) => {
      let discription = res.discription;
      if(discription.length > 20) discription = discription.slice(0, 19) + "...";
      
      let item = `
>>>>>>> 69e6537076b9291639a19a62f9020fff8adf6d91
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

  /** index mobile binding **/

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

  // 서비스 센터 접근
  const serviceFormMove = (url) => {
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

