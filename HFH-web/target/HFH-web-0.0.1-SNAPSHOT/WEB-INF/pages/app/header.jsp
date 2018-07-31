<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<div class="header">
    <h1 class="logo">
        <a href="app_index"></a>
    </h1>
</div>
<!--header/-->
<div class="nav">
    <ul>
        <li class="aHover"><a href="<%= basePath %>/hfh_index_index">网站首页</a></li>
        <li><a href="<%= basePath %>/hfh_volunteer_volunteer">志愿者</a></li>
        <li><a href="app_fireShop">凤凰通宝</a></li>
        <li><a href="app_peiXun">培训考试</a></li>
        <li><a href="app_gongsi">公司简介</a></li>
        <div class="clears"></div>
        <div class="log">
        <s:if test="#session.loginedUser != null">
        	[ <s:property value="#session.loginedUser.username"/> ]
        	&nbsp;<a href="<%= basePath %>/hfh_index_logout">退出</a>
        </s:if>
        <s:else>
            <a href="<%= basePath %>/app_login" class="login" type="button">登 录 </a>
            <div class="shuxian"></div>
            <a href="<%= basePath %>/app_register" class="reg" type="button"> 注 册</a>
        </s:else>
        </div>
        <div class="clears"></div>
    </ul>
</div>