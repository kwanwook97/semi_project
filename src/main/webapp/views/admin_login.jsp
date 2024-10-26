<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitMATE</title>
    <link rel="stylesheet" type="text/css" href="resources/css/admin_common.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="container">
    <c:import url="layout/admin_leftnav.jsp"></c:import>
    <div class="right_wrapper">
        <div class="header_title">
            <h2 class="title">로그인</h2>
        </div>
        <div class="contents narrow">
            <form action="member_login.do" method="post">
                <div class="list">
                    <h3 class="capt">아이디</h3>
                    <p><input type="text" class="full" name="user_id" value="${user_id}" /></p>
                    <h3 class="msg caution checkid hide">아이디를 확인하세요.</h3>
                </div>
                <div class="list">
                    <h3 class="capt">비밀번호</h3>
                    <p><input type="password" class="full" name="pw" value="${pw}" /></p>
                    <h3 class="msg caution checkpw hide">비밀번호를 확인하세요.</h3>
                </div>
                <div class="list">
                    <input type="submit" class="full mainbtn" value="로그인" />
                </div>
            </form>
            <div class="list">
                <button onclick="location.href='member_join.go'" class="full subbtn">회원가입</button>
            </div>
            <div class="list">
                <button type="button" onclick="location.href='admin_login.go'" class="full textbtn">관리자 로그인</button>
            </div>
        </div>
    </div>
</div>
<c:import url="layout/modal.jsp"></c:import>
</body>
<script src="resources/js/common.js"></script>
<script>
    var state = '${state}';
    var msg = '${msg}';
</script>
<script src="resources/js/member_login.js"></script>
</html>