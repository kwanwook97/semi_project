<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitMATE</title>
    <link rel="stylesheet" type="text/css" href="resources/css/admin_common.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/admin_regData.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        var index = 5;
    </script>
</head>
<body>
<div class="container">
    <c:import url="layout/admin_leftnav.jsp" />
    <div class="right_wrapper">
        <c:import url="layout/admin_header.jsp" />
        <div class="title">
            <h2>헬스 MBTI 정보 관리</h2>
        </div>
        <ul class="noDesc menu_tab">
            <li class="active_tab">
                <a href="admin_regMbtiq.go">질문</a>
            </li>
            <li>
                <a href="admin_regMbtiq_sub.go?mbtiq_idx=1">세부 질문</a>
            </li>
            <li>
                <a href="admin_regMbtir.go">결과</a>
            </li>
            <li>
                <a href="admin_regMbtir_detail.go?mbtir_idx=1">결과 상세</a>
            </li>
        </ul>
        <div class="contents narrow">
            <h3 class="capt">기존 항목</h3>
            <ul class="noDesc narrow">
                <c:forEach items="${list}" var="list">
                    <li>
                        <div class="btn_flex narrow">
                            <div class="width80p">
                                <input type="text" name="mbtiq_con" value="${list.mbtiq_con}" maxlength="1000" class="full flex_left" readonly />
                            </div>
                            <div class="width20p">
                                <input type="submit" value="수정" class="disabledbtn full flex_right" onclick="location.href='admin_regMbtiq_sub.go?mbtiq_idx=${list.mbtiq_idx}'" />
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <form id="insert" action="admin_insertMbtiq.do" method="post">
                <ul class="noDesc narrow">
                    <li>
                        <h3 class="capt">항목 추가</h3>
                        <div class="btn_flex narrow">
                            <div class="width80p">
                                <input type="text" name="mbtiq_con" maxlength="1000" class="full flex_left" placeholder="추가할 항목을 입력하세요." />
                            </div>
                            <div class="width20p">
                                <input type="submit" value="추가" class="mainbtn full flex_right" />
                            </div>
                        </div>
                    </li>
                </ul>
            </form>
            <button onclick="location.href='admin_regMbtiqTrash.go'" class="textbtn full">삭제한 항목 보기</button>
        </div>
    </div>
</div>
<c:import url="layout/modal.jsp" />
</body>
<script src="resources/js/admin_common.js"></script>
<script src="resources/js/admin_regData.js"></script>
</html>