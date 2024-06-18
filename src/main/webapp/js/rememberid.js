let idKey = "id";
let idInput = document.getElementById('id');
let rememberid = document.getElementById('rememberid');

let loginInfo = localStorage.getItem(idKey);

if (loginInfo != null) {
    idInput.value = loginInfo;
    console.log('저장된 아이디값 불러옴');
    rememberid.checked = true;
}

function checkRemeberLoginInfo() {
    let userId = idInput.value;
    if (rememberid.checked == true) {
        localStorage.setItem(idKey, userId);
        console.log('아이디값 저장');
    } else {
        localStorage.removeItem(idKey);
        console.log('아이디값 저장 안함');
    }
}


rememberid.addEventListener('change', function() {
    checkRemeberLoginInfo();
});
