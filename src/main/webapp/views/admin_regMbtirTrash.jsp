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
            <h2>헬스 MBTI 정보 관리 > 삭제한 항목</h2>
        </div>
        <ul class="noDesc menu_tab">
            <li>
                <a href="admin_regMbtiq.go">질문</a>
            </li>
            <li>
                <a href="admin_regMbtiq_sub.go?mbtiq_idx=1">세부 질문</a>
            </li>
            <li class="active_tab">
                <a href="admin_regMbtir.go">결과</a>
            </li>
            <li>
                <a href="admin_regMbtir_detail.go?mbtir_idx=1">결과 상세</a>
            </li>
        </ul>
        <div class="contents narrow">
            <h3 class="capt">삭제한 항목</h3>
            <ul class="noDesc narrow">
                <c:if test="${list.size() == 0}">
                    <li>
                        <input type="text" value="삭제한 항목이 없습니다." class="full" readonly />
                    </li>
                </c:if>
                <c:forEach items="${list}" var="list">
                    <li>
                        <form action="admin_restoreMbtir.do?mbtir_idx=${list.mbtir_idx}" method="post">
                            <div class="btn_flex narrow">
                                <div class="width80p">
                                    <input type="text" name="mbtir_name" value="${list.mbtir_name}" maxlength="1000" class="full flex_left" readonly />
                                </div>
                                <div class="width20p">
                                    <input type="submit" value="복구" class="disabledbtn full flex_right" />
                                </div>
                            </div>
                        </form>
                    </li>
                </c:forEach>
            </ul>
            <button onclick="location.href='admin_regMbtir.go'" class="textbtn full">돌아가기</button>
        </div>
    </div>
</div>
<c:import url="layout/modal.jsp" />
</body>
<script src="resources/js/admin_common.js"></script>
<script src="resources/js/admin_regData.js"></script>
</html>