<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

/*전체 페이지에 스크롤 없애는 법*/
html, body {
	overflow: hidden; /* 스크롤 숨기기 */
	height: 100%; /* 페이지 전체 높이를 설정 */
	margin: 0; /* 기본 마진 제거 */
	background-color: rgba(40, 43, 52, 1);
}

#calendar_related {
	width: 500px;
	height: 800px;
	margin-left: 4px;
	float : left;
}



.calendar {
	width: 412px;
	height: 500px;
	margin-top: 50px;
	background-color: red;
}

.journal_write_button {
	width: 412px;
	height: 30px;
	margin-top: 30px;
	background-color: rgba(4, 129, 135, 1);
	padding-top: 20px;
	padding-bottom: 41px;
	text-align: center;
	border-radius: 5px;
}

#schedule {
	width: 475px;
	height: 797px;
	overflow-y: scroll;
	overflow-x: hidden;
	margin: -755px  -11px 3px 0px;
	float : right;
}

.crew_schedule_title { /*만약 크루 일정 없으면 display = none*/
	width: 500px;
	height: 30px;
	padding-bottom: 38px;
	padding-top: 17px;
	padding-left: 17px;
	border-radius: 5px 5px 0px 0px;
	background-color: rgba(40, 43, 52, 1);
	font-weight: bold;
	/*글자 굵기*/
}

.crew_schedule_content { /*만약 크루 일정 없으면 append x*/
	width: 500px;
	height: 100px;
	margin-top: 5px;
	margin-bottom: 10px;
	border-radius: 5px;
	/*top - bottom, right-left*/
	background-color: rgba(40, 43, 52, 1);
}

.journal {
	margin: 20px 0px 10px 0px;
}

.journal_content {
	border-radius: 5px 5px 0px 0px;
	width: 500px;
	height: 150px;
	background-color: rgba(40, 43, 52, 1);
	margin: 10px 0px;
}

.journal_datetime {
	display: flex;
	flex-direction: row;
	padding: 10px 10px;
	font-weight: bold; /*굵은 글씨*/
}

.journal_start_end {
	display: flex;
	flex-direction: row;
	margin-left: 110px;
}

.journal_start, .journal_end {
	background-color: rgba(54, 57, 64, 1);
	border-radius: 5px;
	padding: 5px 5px;
}

.crew_tag {
	background-color: rgb(255, 140, 0);
	border-radius: 5px;
	padding: 5px 5px;
}

.individual_tag {
	background-color: rgba(4, 129, 135, 1);
	border-radius: 5px;
	padding: 5px 5px;
}

.journal {
	margin-bottom: 360px;
}

.journal_text {
	margin: 10px 10px;
	width: 430px;
	/*긴 단어가 영역 넘어가면 줄 바꿈되도록 하기*/
	word-wrap: break-word;
}

.journal_image {
	width: 500px;
	height: 370px;
	background-color: lightgray;
}

.crew_schedule_content {
	padding: 10px;
}

.crew_schedule_time {
	padding: 5px;
}

.crew_schedule_content_detail {
	display: flex;
	flex-direction: row;
	margin: 20px;
}

.circle {
	color: rgb(255, 140, 0);
}

.crew_name {
	font-weight: bold;
}

.crew_schedule_text {
	color: lightgray;
}
</style>

</head>

<body>
	<div class="container">
		<c:import url="layout/leftnav_1.jsp"></c:import>
		<!-- 운동일지는 nav1로, mbti만 nav5로 -->
		<div class="contents">
			<p>Hello, FitMATE!</p>
			<div id="calendar_related">

			<div class="calendar"></div>

			<div class="journal_write_button">일지 작성하기</div>

		</div>



		<div id="schedule">
			<div class="crew_schedule">
				<div class="crew_schedule_title">크루 일정</div>

				<div class="crew_schedule_content">
					<div class="crew_schedule_time">09:20-06:00</div>
					<div class="crew_schedule_content_detail">
						<div class="circle">●</div>
						&nbsp;&nbsp;&nbsp;
						<div class="crew_name">${crew_name}</div>
						&nbsp;&nbsp;&nbsp;
						<div class="crew_schedule_text">모임장소에서 하체 운동</div>
					</div>
				</div>
			</div>

			<div class="journal">
				<div class="journal_content">
					<div class="journal_datetime">
						<div class="journal_date">2024-10-14</div>
						&nbsp;&nbsp;&nbsp;
						<!--<div class="journal_time">09:20</div>-->
						<div class="journal_start_end">
							<div class="crew_tag">크루</div>
							&nbsp;&nbsp;&nbsp;
							<div class="journal_start">시작 시간</div>
							&nbsp;&nbsp;&nbsp;
							<div class="journal_end">끝난 시간</div>
						</div>
					</div>
					<div class="journal_text">내 그대를 생각함은 항상 그대가 앉아 있는 배경에서 해가 지고
						바람이 부는 일처럼 사소한 일일 것이나</div>

					<div class="journal_image"></div>
				</div>

			</div>
			<div class="journal">
				<div class="journal_content">
					<div class="journal_datetime">
						<div class="journal_date">2024-10-14</div>
						&nbsp;&nbsp;&nbsp;
						<!--<div class="journal_time">09:20</div>-->
						<div class="journal_start_end">
							<div class="individual_tag">개인</div>
							&nbsp;&nbsp;&nbsp;
							<div class="journal_start">시작 시간</div>
							&nbsp;&nbsp;&nbsp;
							<div class="journal_end">끝난 시간</div>
						</div>
					</div>
					<div class="journal_text">내 그대를 생각함은 항상 그대가 앉아 있는 배경에서 해가 지고
						바람이 부는 일처럼 사소한 일일 것이나</div>

					<div class="journal_image"></div>
				</div>
			</div>

		</div>
		</div>

		

		
	</div>

<c:import url="layout/modal.jsp"></c:import>
</body>
<script src="resources/js/common.js"></script>
</html>