// 닉네임 중복 체크
var check_nick = false;
$('input[name="nick"]').keyup(function() {
    var nick = $('input[name="nick"]').val();
    $.ajax({
        type: 'post',
        url: 'member_checknick_ex.ajax',
        data: {
            "nick": nick
        },
        success: function(data) {
            if (nick == ""){
                $('input[name="nick"]').removeClass('pass').addClass('caution');
                $('.pass_nick').addClass('hide');
                $('.check_nick').addClass('hide');
                $('.npass_nick').addClass('hide');
                $('.fill_nick').removeClass('hide');
                check_nick = false;
            } else if (nick != "" && data.check_nick) {
                $('input[name="nick"]').removeClass('caution').addClass('pass');
                $('.pass_nick').removeClass('hide');
                $('.check_nick').addClass('hide');
                $('.npass_nick').addClass('hide');
                $('.fill_nick').addClass('hide');
                check_nick = true;
            } else if (nick != "" && !data.check_nick) {
                $('input[name="nick"]').removeClass('pass').addClass('caution');
                $('.pass_nick').addClass('hide');
                $('.check_nick').removeClass('hide');
                $('.npass_nick').addClass('hide');
                $('.fill_nick').addClass('hide');
                check_nick = false;
            }
        },
        error: function(e) {}
    });
});

// 프로필 입력시 미리보기 출력, 입력 개수 제한
function readFile(input){
    if (input.files.length > 1){
        modal.showAlert("프로필 이미지는 한 장만 입력할 수 있습니다.");
        $('input[name="profile"]').val('');
    } else if (input.files.length == 1) {
        $('input[name="initProfile"]').val('initiate');
        for (var file of input.files) {
            $('.img_preview div').empty();
            reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function(e) {
                $('.img_preview div').css('background-image', 'url("'+e.target.result+'")');
            }
        }
    }
}

// 프로필 초기화
function initProfile() {
    modal.showAlert("하단의 수정하기 버튼을 클릭하면 프로필 사진이 삭제됩니다.");
    $('input[name="initProfile"]').val('initiate');
    $('.img_preview div').css('background-image', 'none').html('<i class="bi bi-person-circle"></i>');
}

// 소개글 작성시 글자수 출력
function drawLength(elem) {
    $(elem).removeClass('caution').addClass('pass');
    $(elem).parent('p').next('.showLength').children('h3').children('span').html(elem.value.length);
    if (elem.value.length >= $(elem).attr('maxlength')){
        $(elem).removeClass('pass').addClass('caution');
        modal.showAlert("최대 1,000자까지 입력할 수 있습니다.");
    }
}

// 지역 출력
function onOptionChange(event){
    var region_idx = event.target.value;
    $.ajax({
        type: 'post',
        url: 'member_callregion.ajax',
        data: {
            "region_idx": region_idx
        },
        success: function(data) {
            drawRegion(data.list)
        },
        error: function(e) {}
    });
}

function drawRegion(list) {
    $('select[name="region2"]').empty();
    var tags = '';
    for (var item of list){
        tags += '<option value="'+item.regions_idx+'">'+item.regions_name+'</option>';
    }
    $('select[name="region2"]').append(tags);
}

// 제출
function update() {
    var pw = $('input[name="pw"]').val();
    var nick = $('input[name="nick"]').val();
    var name = $('input[name="name"]').val();
    var email = $('input[name="email"]').val();
    var birthday = $('input[name="birthday"]').val();
    var check_null = false;
    $('input').removeClass('pass').removeClass('caution');
    $('.msg').addClass('hide');
    if (pw != '' && nick != '' && name != '' && email != '' && birthday != ''){
        check_null = true;
    }
    if (!check_null){
        modal.showAlert('필수 항목을 모두 입력하세요.');
        showNull(user_id, pw, nick, name, email, birthday);
    } else if (!check_nick){
        modal.showAlert('닉네임 중복 여부를 확인하세요.');
        showNull(user_id, pw, nick, name, email, birthday);
    } else if (!check_pw){
        modal.showAlert('비밀번호와 비밀번호 확인값은 동일해야 합니다.');
        showNull(user_id, pw, nick, name, email, birthday);
    } else {
        $('form').submit();
    }
}

function showNull(user_id, pw, nick, name, email, birthday) {
    if (pw == ''){
        $('input[name="pwconfirm"]').addClass('caution');
        $('.fill_pw').removeClass('hide');
    } else if (!check_pw){
        $('input[name="pwconfirm"]').addClass('caution');
        $('.check_pw').removeClass('hide');
    }
    if (nick == ''){
        $('input[name="nick"]').addClass('caution');
        $('.fill_nick').removeClass('hide');
    } else if (!check_nick){
        $('input[name="nick"]').addClass('caution');
        $('.npass_nick').removeClass('hide');
    }
    if (name == ''){
        $('input[name="name"]').addClass('caution');
        $('.fill_name').removeClass('hide');
    }
    if (email == ''){
        $('input[name="email"]').addClass('caution');
        $('.fill_email').removeClass('hide');
    }
    if (birthday == ''){
        $('input[name="birthday"]').addClass('caution');
        $('.fill_birth').removeClass('hide');
    }
}