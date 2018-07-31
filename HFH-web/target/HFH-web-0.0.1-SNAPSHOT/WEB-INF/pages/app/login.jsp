<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<!doctype html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录-火凤凰志愿系统</title>
    <link rel="stylesheet" type="text/css" href="<%= basePath %>/css/appcss/default.css">
    <link rel="stylesheet" type="text/css" href="<%= basePath %>/css/appcss/styles.css">
</head>
<body>
    <!-- <script src="/demos/googlegg.js"></script> -->
	<form action="<%= basePath %>/hfh_index_login" method="post">
    <div class="panel-lite">
        <div class="thumbur">
            <div class="icon-lock"></div>
        </div>
        <h4>用户登录</h4>
        <div class="form-group">
            <input name="username" required="required" class="form-control" />
            <label class="form-label">用户名    </label>
        </div>
        <div class="form-group">
            <input name="password" type="password" required="required" class="form-control" />
            <label class="form-label">密　码</label>
            <span style="color:#ff0000;"><s:property value="#errorInfo"/></span>
        </div><a href="#">忘记密码 ?  </a>
        <a href="<%= basePath %>/app_register" style="float:right;">立即注册</a>
        <button value="" class="floating-btn"><i class="icon-arrow"></i></button>
    </div>
    </form>
</body>

</html>