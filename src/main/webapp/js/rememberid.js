let idKey = "id"; // 저장할 아이디의 키
let idInput = document.getElementById('id'); // 아이디 입력 필드
let rememberid = document.getElementById('rememberid'); // 아이디 저장 체크박스

// 초기 로드 시 로컬 스토리지에서 아이디 값 가져오기
let savedId = localStorage.getItem(idKey);

if (savedId !== null) {
    idInput.value = savedId; // 입력 필드에 저장된 아이디 값 설정
    rememberid.checked = true; // 체크박스를 체크된 상태로 설정
}

// 입력 필드의 값이 변경될 때마다 로컬 스토리지에 저장
idInput.addEventListener('input', function() {
    if (rememberid.checked) { // 체크박스가 체크된 상태인 경우에만 저장
        let userId = idInput.value;
        localStorage.setItem(idKey, userId); // 아이디 값을 로컬 스토리지에 저장
    }
});

// 체크박스 상태가 변경될 때마다 호출
rememberid.addEventListener('change', function() {
    if (!rememberid.checked) { // 체크박스가 체크 해제된 경우
        localStorage.removeItem(idKey); // 로컬 스토리지에서 아이디 값 제거
    } else { // 체크박스가 체크된 경우
        let userId = idInput.value;
        localStorage.setItem(idKey, userId); // 아이디 값을 로컬 스토리지에 저장
    }
});
