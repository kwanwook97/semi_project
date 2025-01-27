<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<html>
<head>
<meta charset="UTF-8">
<title>내 크루</title>
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />

<style>
.contents{
	height: 1100px;
}

h2.capt {
	margin: 1% 0;
	position: relative;
}
.crewCreate{
	display: inline-block;
	position: absolute;
	top: 0%;
	right: 3%;
}

div.recruitArea, div.approvalArea {
	overflow-y: scroll;
	overflow-x: hidden;
	width: 98%;
	height: 45%;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
}

div.recruit, div.recruit_odd {
	width: 48%;
	height: 46%;
	margin: 1% 1%;
	padding: 3% 2%;
	background-color: #282b34;
	position: relative;
}

.recruit_left {
	display: inline-block;
	width: 15%;
	aspect-ratio: 1;
	border: 0 solid black;
	border-radius: 50%;
}

.recruit_right {
	width: 80%;
	display: inline-block;
	position: absolute;
	top: 0%;
	left: 20%;
}

div.recruit_content {
	margin: 5% 2%;
	height: 20%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

div.recruit_info {
	margin: 5% 2%;
	height: 20%;
	display: flex;
	flex-wrap: wrap;
	position: relative;
}

span.cnt, span.rgn {
	width: 20%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

span.rgn {
	width: 35%;
}

.text_area {
	display: inline-block;
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	margin: 1%;
}

.button_area {
	position: absolute;
	top: 77%;
	right: 3%;
}

.member_button {
	position: absolute;
	top: 7%;
	right: 3%;
	aspect-ratio: 1;
	background-color: #282b34;
	color: white;
	border: none;
	margin: 0;
	padding: 0;
}

a.recruit_detail {
	display: block;
	width: 80%;
	position: relative;
	margin-bottom: 5%;
	height: 40%;
}

div.right_top, div.right_bottom {
	width: 100%;
}


a.crew_create {
	display: block;
	width: 100%;
	height: 100%;
}

#no_approvalArea {
	text-align: center;
	margin: auto;
}

.modal {
	display: none;
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
}

.modal_container {
	position: absolute;
	top: 20%;
	left: 40%;
	margin: auto;
	background: white;
	width: 300px;
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
	justify-content: space-evenly;
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

.modal_container {
	width: 380px;
}

.modal .modal_footer .btn_flex {
	width: 333px;
}

.modal_cancel_request, .modal_leave_crew, .modal_container.min {
	width: 190px;
	height: auto;
	margin: 0;
}

.noBtn{
	cursor: default; /* 커서를 기본 화살표로 설정 */
    opacity: 0.8; 
    right: 5%;
}

.bi.bi-arrow-repeat {
    display: inline-block; /* 또는 block */
    animation: spin 1s infinite; /* 애니메이션 적용 */
}

@keyframes spin {
   0% { transform: rotate(0deg); }
   100% { transform: rotate(360deg); }
}
 
.recruit:hover, .recruit_odd:hover {
   	transform: translateY(-5px) scale(1.05) !important;
   	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important; /* 추가된 그림자 효과 */
	transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out !important; /* 전환 효과 추가 */
}

/* 웹킷 기반 브라우저에서 스크롤바 숨기기 */
div.recruitArea::-webkit-scrollbar, div.approvalArea::-webkit-scrollbar {
    width: 0;  /* 수직 스크롤바의 너비를 0으로 설정 */
    height: 0; /* 수평 스크롤바의 높이를 0으로 설정 */
}

/* Firefox에서 스크롤바 숨기기 */
div.recruitArea, div.approvalArea {
    scrollbar-width: none;  /* 스크롤바를 숨김 */
    scrollbar-color: transparent transparent;  /* 스크롤바 색상도 투명하게 설정 */
}

</style>
</head>

<body>
	<div class="container">
		<c:import url="layout/leftnav_3.jsp"></c:import>
		<div class="contents">
			<div class="area">
				<h2 class="capt">신청중인 크루</h2>
				<div class="approvalArea scrollY"></div>

				<h2 class="capt">내 크루<a href="crew_create.go" class="crewCreate"><i class="bi bi-plus-lg" style="font-size:20px">크루 생성하기</i></a></h2>
				<div class="recruitArea scrollY"></div>
			</div>
		</div>
	</div>
</body>

<!-- 모달 div모음 -->
<c:import url="layout/modal.jsp"></c:import>

<!-- 신청취소 모달 -->
<div class="modal modal_cancel_request">
	<div class="modal_container min">
		<button class="btn_cancel_request subbtn full">
			<i class="bi bi-x-lg">신청 취소</i>
		</button>
		<button class="btn_cancel mainbtn full">창 닫기</button>
	</div>
</div>

<!-- 탈퇴하기 모달 -->
<div class="modal modal_leave_crew">
	<div class="modal_container min">
		<button class="btn_leave_crew subbtn full">
			<i class="bi bi-exclamation-circle-fill" style="color: red">탈퇴하기</i>
		</button>
		<button class="btn_cancel mainbtn full">창 닫기</button>
	</div>
</div>


<!-- 예/아니오 선택 모달 -->
<div class="modal" id="confirmationModal">
    <div class="modal_container">
        <div class="modal_header">
            <h3 class="title">경고</h3>
            <div class="btn_close">
                <i class="bi bi-x-lg"></i>
            </div>
        </div>
        <div class="modal_body">
        	<!-- 모달 창 내용. -->
        </div>
        <div class="modal_footer">
            <div class="btn_flex">
                <button id="confirmYes" class="mainbtn">예</button>
                <button id="confirmNo" class="mainbtn width">아니요</button>
            </div>
        </div>
    </div>
</div>


<script src="resources/js/common.js"></script>
<script>
	window.addEventListener("pageshow", (event) => {
	    if (event.persisted) {
	        // 페이지가 캐시에서 로드된 경우 새로고침
	        window.location.reload();
	    }
	});
	
	
	// 현재 유저가 MBTI검사를 받았는지 여부. 0: 미검사
	var mbtir_idx = ${mbtir_idx};
	
	// MBTI검사를 받아야 크루를 생성할 수 있도록 함.
	$(document).ready(function() { // HTML문서가 완전히 로드된 후 실행되도록하여 오류 방지.
	    $(".crewCreate").on("click", function(event) {
	        event.preventDefault();  // 페이지 이동 방지
	        if(mbtir_idx === 0){
	        	modal.showConfirm('헬스MBTI 검사완료 후 크루를 생성할 수 있습니다.<br/> 내 프로필 수정 페이지로 이동하시겠습니까?', 'member_profile.go');
				
	        }else{
		        window.location.href = "crew_create.go";
	        }
	        
	    });
	});
	
   var currentUserId = '${sessionScope.loginId}';
   var leader_chk = 0; // 크루장여부 체크 (0: 크루원, 1: 크루장)
   var cntApproval = 1; // 신청중인 크루 Count
   var cntRecruit = 1; // 내 크루 Count

   // 데이터가 아예없는경우 무한스크롤 이벤트를 작동하지 않도록 하기위함. 0: 꺼짐. 
   var observe_set = 1;
   
   // 무한 스크롤 이벤트 작동 시 데이터를 가져올 offset을 초기화
   // 신청중인 크루영역과 내크루 영역의 offset을 각각 관리.
   var offsetApproval = 0;
   var offsetRecruit = 0;
   
   // 한 번에 가져올 데이터 개수 (신청중영역, 내크루영역 공통)
   const limit = 4; 
   // 데이터 로딩 중 여부를 관리할 변수
   var isLoadingApproval = false;
   var isLoadingRecruit = false;
   
   // 버튼 변수
   var leader_button = '';
   var member_button = '';
   
   // 크루회원 탈퇴를 위한 idx번호
   var memberExit_idx = '';
   
   // 모달 변수 modal_cancel_request: 신청취소모달, modal_leave_crew: 탈퇴모달
   var modal_chk = '';
   
   // 신청중인 크루 목록 가져오기
   $('div.approvalArea').empty();
   crewList(0, offsetApproval);
   
   
   // 내 크루 목록 가져오기
   $('div.recruitArea').empty();
   crewList(1, offsetRecruit);

   // 크루 목록 데이터 불러오기 함수 (info_chk 0: 신청중인 크루목록, 1: 내 크루목록)
   function crewList(info_chk, offset) {

    $.ajax({
        url: 'mycrew.ajax',
        type: 'GET',
        data: { 
            'info_chk': info_chk,
            'offset': offset,
            'limit': limit
        }, 
        dataType: 'JSON',
        success: function(list) {
        	
            // 새로 읽어온 값이 비어 있는 경우
            if (list == null || list == '') {
            	if (cntApproval === 1 && info_chk === 0) {
            		   $('div.approvalArea').empty();
            	       $('div.approvalArea').append('<div id="no_approvalArea"><i class="bi bi-ban" style="font-size:30px">신청중인 크루가 없습니다.</i></div>');
           	    }else if(cntRecruit === 1 && info_chk === 1){
           	    	   $('div.recruitArea').empty();
           	    	   $('div.recruitArea').append('<div id="no_approvalArea"><i class="bi bi-ban" style="font-size:30px; border:1px dot">현재 속해있는 크루가 없습니다.</i></div>');
           	    }
            	
            	// 더이상 읽어올 데이터가 없는경우 트리거 메시지 변경.
            	$('#load-more-trigger-'+info_chk).html('더 이상 불러올 데이터가 없습니다.');
            	// 더 이상 데이터가 없으면 관찰 중지
            	if (info_chk === 0) {
            		observerApproval.unobserve($('#load-more-trigger-'+info_chk)[0]);
            	}else{
            		observerRecruit.unobserve($('#load-more-trigger-'+info_chk)[0]);
            	}
            	
            } else {
                if (list && list.length > 0) {
                    $.each(list, function(index, item) { // 데이터 = item
                        recruitAdd(item, info_chk); // Controller에서 받아온 크루원 모집게시글 추가
                        if (info_chk === 0) {
                        	cntApproval++; // 신청중인 크루 Count 증가
                        	console.log('cntApproval : ' + cntApproval);
                        }else {
                        	cntRecruit++; // 내 크루 Count 증가
                        }
                    });

                    if (info_chk === 0) {
                        isLoadingApproval = false; // 데이터 로딩 완료 시 다시 로딩 가능하도록 설정
                        addLoadMoreTrigger(0); 
                    } else {
                        isLoadingRecruit = false; // 데이터 로딩 완료 시 다시 로딩 가능하도록 설정
                        addLoadMoreTrigger(1); 
                    }
                } else {
                	// 더 이상 데이터가 없으면 관찰 중지
                	if (info_chk === 0) {
                		observerApproval.unobserve($('#load-more-trigger-'+info_chk)[0]);
                	}else{
                		observerRecruit.unobserve($('#load-more-trigger-'+info_chk)[0]);
                	}
                	// 트리거 요소 제거
                    $('#load-more-trigger'+info_chk).remove(); 
                }
            }
        },
        error: function(e) {
            modal.showAlert('크루 목록 가져오기 실패');
        }
        
    });
    	
     
    
	}
   
   function recruitAdd(item, info_chk) {
	   
	   // 크루장인지 크루원인지 체크
	   if(currentUserId === item.leader_id){
		   leader_chk = 1;	   
	   }else{
		   leader_chk = 0;
	   }
	   
	  
	  // 프로필
      var profile = item.leader_profile ? '<img class="recruit_left" src="/photo/' + item.leader_profile + '" alt="프로필 이미지" style="width: 54.18px; height: 54.18px; object-fit: cover; border-radius: 50%;"/>' 
                                         : '<i class="bi bi-person-circle" style="font-size: 54.18px;"></i>'; 
   	  
                                         
      
  	  // Header: 모집게시글링크-board_idx, 프로필사진, 크루명, 크루장 닉네임, MBTI                                   
      var header = '';                                   
                                         
       // 신청중인 크루인경우 => 모집글 페이지로 이동.    
       // 내 크루인경우 => 크루페이지로 이동.
       if (info_chk === 0) {
       	header += '<a href="crew_recruit_detail.go?board_idx=' + item.board_idx + '&crew_idx=' +item.crew_idx+ '" class="recruit_detail">';
       }else{
       	header += '<a href="crew_main_page.go?crew_idx=' +item.crew_idx+ '" class="recruit_detail">';
       }
    		   
      header += profile
                   + '<div class="recruit_right">'
                      + '<div class="right_top">'
                         + '<h4 class="text_area">' + item.crew_name + '</h4>'
                         + '<br/>'
                         + '<span class="text_area"></span>'
                      + '</div>'
                      + '<div class="right_bottom">'
                         + '<span>' + item.leader_nick + '</span>'
                         + '<span> (' + item.leader_mbti + ')</span>'
                      + '</div>'
                   + '</div>'
                + '</a>';
      
      // Content: 크루 소개글         
      var content = '<div class="recruit_content">' + item.subject + '</div>';
      
      // Info: 크루원 수, 활동지역
      var info = '<div class="recruit_info">'
                   + '<span class="cnt"><i class="bi bi-people-fill"></i>&nbsp;&nbsp;' + item.member_count + ' </span>'
                   + '<span class="rgn"><i class="bi bi-geo-alt-fill"></i>&nbsp;&nbsp;' + item.region_name + ' ' + item.regions_name + '</span>'
               + '</div>';

		
      
   	  // 신청중인 크루 영역이라면
      if (info_chk === 0) {     
    	  // 신청취소 버튼 => crew_join테이블의 join_idx값 전달
    	  modal_chk = '.modal_cancel_request';
    	  member_button = '<button type="button" class="member_button" onclick="my_modal(this, \'' + modal_chk + '\', ' + item.join_idx + ')"><i class="bi bi-three-dots-vertical" style="font-size:23px"></i></button>';
     	  
    	  // 신청중 버튼. 클릭은 하지못하고 표시만 해줄 예정. 그냥 leader_button을 가져다 쓰려고 함...
    	  leader_button = '<div class="button_area noBtn"><button type="button" class="mainbtn minbtn noBtn" disabled>신청중</button></div>';
          
         if (cntApproval % 2 == 1) {
            $('div.approvalArea').append('<div class="recruit">' + header + member_button + content + info + leader_button + '</div>');
         } else {
            $('div.approvalArea').append('<div class="recruit_odd">' + header + member_button + content + info + leader_button + '</div>');
         }
         
         
      } else {
    	// 크루장이면 리더버튼 세팅 OR 크루원,신청자이면 멤버버튼 세팅
         if(leader_chk === 1){
        	 leader_button = '<div class="button_area">'
        	 		// 크루 신청관리 => crew_recruit_detail.go페이지 이동. 
        	       + '<button type="button" class="mainbtn minbtn" onclick="location.href=\'crew_recruit_detail.go?board_idx=' + item.board_idx +'&crew_idx=' +item.crew_idx+ '\'">크루 신청 관리</button>&nbsp;&nbsp'
        	       // 크루정보 수정페이지 => crew_create_rewrite.go페이지 이동.
        	       + '<button type="button" class="subbtn minbtn" onclick="location.href=\'crew_create_rewrite.go?idx=' + item.crew_idx + '&board_idx=' + item.board_idx + '\'">크루 정보수정</button>'
        	       + '</div>';	 
         }else{
        	// 탈퇴하기 버튼 => 추후 크루원 목록. 크루멤버테이블의 member_idx값 전달.
        	 modal_chk = '.modal_leave_crew';
        	 member_button = '<button type="button" class="member_button" onclick="my_modal(this, \'' + modal_chk + '\', ' + item.member_idx + ')"><i class="bi bi-three-dots-vertical" style="font-size:23px"></i></button>';
 
         } 
    	 
    	 
         if (cntRecruit % 2 == 1) {
            $('div.recruitArea').append('<div class="recruit">' + header + member_button + content + info + leader_button + '</div>');
         } else {
            $('div.recruitArea').append('<div class="recruit_odd">' + header + member_button + content + info + leader_button + '</div>');
         }
     	
         
      }
   	  
      // Append후 변수 초기화
      member_button = '';
      leader_button = '';
   }

   // 멤버 버튼 클릭 시 모달 표시 함수
   function my_modal(obj, modal_chk, idx) {
	// 이미 열려 있는 모달이 있는지 체크
    if ($('.modal:visible').length) {
        return; // 이미 열려있다면 아무 것도 하지 않음
    }
	
 	// 스크롤 비활성화
    $('html, body, .scrollY').css('overflow', 'hidden');
	
	
 	// add버튼 위치좌표		
	var coordinate = $(obj).offset();
    
	// 스크롤 위치를 고려하여 top 값 조정
    var scrollTop = $(window).scrollTop(); // 현재 스크롤 위치
    $(modal_chk).css({
        top: coordinate.top - scrollTop, // 스크롤 위치 추가
        left: coordinate.left
    });
	
 	// 모달 내 버튼에 데이터 설정
 	// modal_chk가 신청취소(.modal_cancel_request)인경우 OR 탈퇴하기(.modal_leave_crew)인경우 각각 데이터 전달.
 	if(modal_chk === '.modal_cancel_request'){
 	    $(modal_chk).find('.btn_cancel_request').data('join_idx', idx);	
 	}else{
 		$(modal_chk).find('.btn_leave_crew').data('member_idx', idx); 		
 	}
    
	$(modal_chk).fadeIn(); // 모달표시
     
   }
   
   // 모달 닫기 버튼 클릭 시 모달 숨기기
   $('.btn_cancel').on('click', function() {
      $(this).closest('.modal').hide();
   	  // 스크롤 활성화
      $('html, body, .scrollY').css('overflow', 'auto');
   });

   // 신청 취소하기 버튼 클릭 시 .modal_cancel_request
   $('.btn_cancel_request').on('click', function() {
	   var join_idx = $(this).data('join_idx');  
	     
	   cancel_request(join_idx);
       $('.modal_cancel_request').hide(); // 모달 숨기기
      
   		// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   });

   // 탈퇴하기 버튼 클릭 시
   $('.btn_leave_crew').on('click', function() {
	   var member_idx = $(this).data('member_idx');   
	   	   
	   memberExit(member_idx);
      $('.modal_leave_crew').hide(); // 모달 숨기기
   		// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   });
   
   
   function cancel_request(join_idx){
	   console.log('join_idx : ' + join_idx);   
	   console.log('currentUserId : ' + currentUserId); 
	   
	   $.ajax({
		   url: 'leave_crew.ajax',
		   type: 'POST',
		   data: {
			 'join_idx' : join_idx  
		   },
		   success: function(data){
			// 주소창 그대로 새로고침.
     	    location.reload();
		   },
		   error: function(e){
		    modal.showAlert('입단철회를 수행하던도중 오류가 발생했습니다.');  
		   }
		   
	   });
   }
   
   function memberExit(member_idx){
		console.log('member_idx : ' + member_idx);   
		console.log('currentUserId2 : ' + currentUserId);
		
		memberExit_idx = member_idx;
		
		$('.modal_body').html('<p>크루에서 탈퇴하시겠습니까?</p>');
	    $('#confirmationModal').fadeIn(); // 모달 표시
	 	// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   }
   
   
   // 예 버튼 클릭시
   $('#confirmYes').on('click', function() {
       $.ajax({
           url: 'memberExit.ajax', // AJAX 요청을 보낼 URL
           type: 'POST',
           data: {
               'member_idx': memberExit_idx
           },
           success: function(data) {
               
               $('#confirmationModal').fadeOut(); // 모달 숨김
        	   // 주소창 그대로 새로고침.
        	   location.reload();
           },
           error: function(e) {    
               console.log(e);
               $('#confirmationModal').fadeOut(); // 모달 숨김
           }
       });
    	// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   });
   
   // 아니요 버튼 클릭 시
   $('#confirmNo').on('click', function() {
       $('#confirmationModal').fadeOut();
    	// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   });
   
   // 모달 닫기 버튼 클릭 시
   $('.btn_close').on('click', function() {
       $('#confirmationModal').fadeOut();
    	// 스크롤 활성화
		$('html, body, .scrollY').css('overflow', 'auto');
   });
   
   
   
   /* 무한스크롤 IntersectionObserver 구현 */
   // 신청중인 크루 영역에 대한 Intersection Observer
	var observerApproval = new IntersectionObserver(function(entries) {
	    loadMoreEntries(entries, isLoadingApproval, 0); // 0은 info_chk: 신청중인 크루
	}, {
	    root: null,
	    rootMargin: '0px',
	    threshold: 0.5
	});
	
	// 내 크루 영역에 대한 Intersection Observer
	var observerRecruit = new IntersectionObserver(function(entries) {
	    loadMoreEntries(entries, isLoadingRecruit, 1); // 1은 info_chk: 내 크루
	}, {
	    root: null,
	    rootMargin: '0px',
	    threshold: 0.5
	});
	
	// Intersection Observer 콜백 함수
	function loadMoreEntries(entries, isLoading, info_chk) {
	    entries.forEach(function(entry) {
	        if (entry.isIntersecting && !isLoading) {
	        	console.log('limit 상수 확인 : ' + limit);
	            isLoading = true; 
	            
	         	// 다음 요청을 위한 offset 값 증가
	            if(info_chk === 0){
	            	offsetApproval += limit; 
	            	crewList(info_chk, offsetApproval); // 데이터를 가져오는 함수 호출
	            }else{
	            	offsetRecruit += limit;
	            	crewList(info_chk, offsetRecruit); // 데이터를 가져오는 함수 호출
	            }
	            
	        }
	    });
	}
   

    // 관찰대상 세팅
    addLoadMoreTrigger(0);
    addLoadMoreTrigger(1);
   
 	// '더보기' 트리거 요소 추가 함수
	function addLoadMoreTrigger(info_chk) {
	    let cnt = (info_chk === 0) ? cntApproval : cntRecruit; // 크루의 개수에 따라 다름
	    // 요소가 4개 이상일 경우에만 발동
	    if (cnt > 4) {
	        // 기존 로드 모어 트리거 요소를 제거
	        $('#load-more-trigger-'+info_chk).remove(); 
	        
	        // 새 트리거 요소 생성
	        var targetElement = $('<div>', {
	            id: 'load-more-trigger-' + info_chk, // 고유한 ID 부여
	            html: '<i class="bi bi-arrow-repeat" style="font-size: 24px;"></i> 더 많은 데이터를 불러오는 중...',
	            css: {
	                textAlign: 'center',
	                width: '100%',
	                padding: '20px',
	                fontSize: '16px'
	            }
	        });
	
	        // 해당 영역에 트리거 요소 추가
	        // 새로운 트리거 요소를 observer로 관찰
	        if (info_chk === 0) {
	            $('.approvalArea').append(targetElement);
	            observerApproval.observe(targetElement[0]);
	        } else {
	            $('.recruitArea').append(targetElement);
	            observerRecruit.observe(targetElement[0]);
	        }
	        
	    }
	}

 	
 	
</script>
</html>
