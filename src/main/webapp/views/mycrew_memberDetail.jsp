<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitMATE</title>
    <link rel="stylesheet" type="text/css" href="resources/css/common.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .contents.narrow {
            height: 1100px;
            padding: 24px 200px;
        }

        .profile.relative {
            position: relative;
        }

        .inlineBlock {
            display: inline-block;
        }

        .width_50 {
            display: inline-block;
            margin-left: 3%;
            margin-bottom: 2%;
        }

        .txt_green {
            color: #048187;
            font-weight: bold;
        }

        .txt_opacity {
            opacity: 0.5;
        }

        .profile_box {
            border: 1px solid #282b34;
            border-radius: 6px;
            background-color: #282b34;
            color: #e9ecef;
            font-size: 14px;
            padding: 10px;
        }

        .font {
            font-family: 'Noto Sans KR', sans-serif;
        }

        .red {
            background-color: #ff4040;
            border: 1px solid #ff4040;
        }

        #status {
            border: 1px solid #e9ecef;
        }

        .modal {
            display: none; /* 처음에 모달 숨김 */
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 어두운 배경 */
            z-index: 1000;
        }

        .modal_container {
            position: relative;
            margin: auto;
            background: white;
            width: 300px; /* 필요에 따라 조정 */
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .modal_header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal_body {
            margin: 10px 0;
        }

        .modal_footer {
            display: flex;
            justify-content: space-between;
        }

        .btn_flex {
            width: 100%;
            display: flex;
        }

        .mainbtn {
            flex: 1; /* 버튼 동일 너비 */
            margin-right: 5px; /* 간격 추가 */
        }

        .mainbtn:last-child {
            margin-right: 0; /* 마지막 버튼의 오른쪽 여백 제거 */
        }
        
        .modal_container{
       	    width: 380px;
        }
        
        .modal .modal_footer .btn_flex {
 		   width: 333px;
		}
		.modal_footer {
		   display: flex;
		   justify-content: space-evenly;
		}
    </style>
</head>
<body>
<div class="container">

    <c:import url="layout/leftnav_1.jsp"></c:import>

    <div class="contents narrow">
        <!-- 제목 -->
        <h2 class="title">
            ${profile.crew_name}<span>크루원 프로필 보기</span>
        </h2>
        <!-- //제목 -->

        <div class="profile_box">
            <div class="profile relative">
                <i class="inlineBlock bi bi-person-circle" style="font-size: 60px;"></i>
                <!-- ${profile.profile} i태그는 추후 프로필 사진으로 대체 예정.-->
                <div class="width_50">
                    <div class="profile_right">
                        <div>
                            <div class="text_area">
                                <h3 class="inlineBlock title">${profile.nick}</h3>
                            </div>
                            <div class="text_area">
                                <span class="txt_opacity">${profile.user_id}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <h3 class="capt">상태 메시지</h3>
            <p>
                <textarea id="status" class="font full" name="statusMessage" readonly>${profile.status}</textarea>
            </p>
        </div>

        <div class="list">
            <h3 class="capt">크루 입단날짜</h3>
            <p>
                <input type="text" class="full" name="statusMessage" value="${profile.join_date}" readonly/>
            </p>
        </div>

        <div class="list">
            <h3 class="capt">헬스 MBTI</h3>
            <p>
                <input type="text" class="full" name="statusMessage" value="${profile.mbtir_name}" readonly/>
            </p>
        </div>

        <div class="list">
            <h3 class="capt">생년월일</h3>
            <p>
                <input type="text" class="full" name="statusMessage" value="${profile.birthday}" readonly/>
            </p>
        </div>

        <div class="list">
            <h3 class="capt">주로 운동하는 지역</h3>
            <p>
                <input type="text" class="full" name="statusMessage" value="${profile.region_name} ${profile.regions_name}" readonly/>
            </p>
        </div>

        <div class="list">
            <h3 class="capt">이메일</h3>
            <p>
                <input type="text" class="full" name="statusMessage" value="${profile.email}" readonly/>
            </p>
        </div>

        <div class="list">
            <!-- 모달 (경고창, 확인창) -->
            <button id="memberFire" class="mainbtn full red">추방하기</button>
        </div>
        <!-- addr: 확인 버튼을 누르면 이동할 경로 -->
    </div>
</div>

<c:import url="layout/modal.jsp"></c:import>
<!-- 모달 창 -->
<div class="modal" id="confirmationModal">
    <div class="modal_container">
        <div class="modal_header">
            <h3 class="title">경고</h3>
            <div class="btn_close">
				<i class="bi bi-x-lg"></i>
			</div>
        </div>
        <div class="modal_body">
            <p>정말로 이 작업을 진행하시겠습니까?</p>
        </div>
        <div class="modal_footer">
            <div class="btn_flex">
                <button id="confirmYes" class="mainbtn">예</button>
                <button id="confirmNo" class="mainbtn width">아니요</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="resources/js/common.js"></script>

<script>
    // 모달을 보여주는 함수 생략하고 직접 이벤트에서 사용
    // 0: 크루장X, 1: 크루장O 
    var leader_chk = 1; // 일단은 크루장인것으로...
    var crew_id = '${profile.crew_id}';     // 가져온 크루장ID
    
    // member_id => 전달받은 member_id(크루원 ID) 값으로 수정필요. 
    var member_id = 'member07';
    
    // 크루 추방을 위한 크루원목록 idx
    var member_idx = '${profile.member_idx}';
    
    // 크루장이 아닌경우 추방하기 버튼 삭제
    // 크루장이 자기자신의 정보를 보고 있는 경우에도 추방버튼 삭제
    if(leader_chk !== 1 || member_id === crew_id) {
        $('#memberFire').remove();
    }    
    
    // 크루원추방하기 버튼을 클릭시 모달 보여주기
    $('#memberFire').on('click', function() {
        $('#confirmationModal').fadeIn(); // 모달 표시
    });
    
    // 예 버튼 클릭시
    // crew_member테이블의 status를 0(false)로 바꿔준다.
    $('#confirmYes').on('click', function() {
        $.ajax({
            url: 'crewMemberFire.ajax', // AJAX 요청을 보낼 URL
            type: 'POST',
            data: {
                member_idx: member_idx
            },
            success: function(data) {
                console.log("성공여부 : " + data.success);
                // 요청 성공 시 처리
                if(data.success === true) {
                    modal.showAlert('크루원이 추방되었습니다.');    
                    // 이전 페이지로 이동
                    window.history.back();
                } else {
                    modal.showAlert('크루원 추방에 실패했습니다.')
                }
                
                $('#confirmationModal').fadeOut(); // 모달 숨김
            },
            error: function(e) {    
                console.log(e);
                $('#confirmationModal').fadeOut(); // 모달 숨김
            }
        });
    });
    
    // 아니요 버튼 클릭 시
    $('#confirmNo').on('click', function() {
        $('#confirmationModal').fadeOut(); 
    });
    
    // 모달 닫기 버튼 클릭 시
    $('.btn_close').on('click', function() {
        $('#confirmationModal').fadeOut();
    });
</script>
</html>