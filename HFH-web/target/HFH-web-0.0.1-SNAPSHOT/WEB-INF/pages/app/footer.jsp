<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<div class="footer">
    <div class="footNav">
        <a href="index.html">网站首页</a> -
        <a href="new.html">新闻中心</a> -
        <a href="zhenggong.html">政工指示</a> -
        <a href="edu.html">教育专栏</a> -
        <a href="xinli.html">心理工作</a> -
        <a href="jingying.html">警营文化</a> -
        <a href="gongxiang.html">共享磁盘</a> -
        <a href="sp_index.html">支队主页</a>
    </div>
    <div class="footBottom">
        <ul class="footLogo">
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo1.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo2.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo3.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo4.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo3.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo4.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo1.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo2.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo1.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo3.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo4.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo2.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo3.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo4.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo1.jpg" width="124" height="44" /></a>
            </li>
            <li>
                <a href="#"><img src="<%= basePath %>/images/footerlogo2.jpg" width="124" height="44" /></a>
            </li>
            <div class="clears"></div>
        </ul>
        <!--footLogo/-->
        <p>Copyright 2017 湛江市公安消防支队,All right Reserved 版权所有</p>
        <p>未经本网书面授权，请勿转载、摘编或建立镜像，负责视为侵权。 </p>
        <p>粤ICP备0000000号 技术支持：<a href="#" target="_blank">湛江TC网络科技集团</a></p>
    </div>
    <s:debug></s:debug>
    <!--footBottom/-->
</div>