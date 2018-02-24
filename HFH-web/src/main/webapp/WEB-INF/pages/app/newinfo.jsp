<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>火凤凰志愿者系统</title>
    <link rel="stylesheet" href="<%= basePath %>/css/appcss/css.css" />
    <script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.js"></script>
    <script type="text/javascript" src="<%= basePath %>/js/myjs/js.js"></script>
</head>

<body>
	<!-- header -->
   	<jsp:include page="/WEB-INF/pages/app/header.jsp"></jsp:include>
    <!--nav/-->
    <div class="insideCont">
        <div class="insideLeft">
            <h1 class="new1Title2"><span>详情页面</span></h1>
            <div class="detailsCont">
                <h3><s:property value="#theNew.new_title" /> </h3>
                <time><s:date name="#theNew.create_time" format="yyyy-MM-dd"/>　来源：<span class="red"><s:property value="#theNew.source"/></span></time>
                <%-- <div class="jiathis_style">
                    <span class="jiathis_txt">浏览数：<span>(10)</span> &nbsp;&nbsp;&nbsp;分享到：
                    </span>
                    <a class="jiathis_button_qzone">QQ空间</a>
                    <a class="jiathis_button_tsina">新浪微博</a>
                    <a class="jiathis_button_tqq">腾讯微博</a>
                    <a class="jiathis_button_weixin">微信</a>
                    <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank">更多</a>
                    <a class="jiathis_counter_style"></a>
                </div> --%>
                <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script><br />
                <div class="detaPar">
                    <div style="text-align:center;">
                        <s:property value="#theNew.new_content" escape="false"/>
                    </div>
                </div>
                <!--detaPar/-->
                <!--分页开始-->
                <%-- <div class="yahoo2"><span class="disabled">&lt; Prev</span><span class="current">1</span><a href="#?page=2">2</a><a href="#?page=3">3</a><a href="#?page=4">4</a><a href="#?page=5">5</a><a href="#?page=6">6</a><a href="#?page=7">7</a>...<a href="#?page=199">199</a>
                    <a href="#?page=200">200</a><a href="#?page=2">Next &gt;</a></div> --%>
                <!--分页结束-->
            </div>
            <!--detailsCont/-->
            <br />
        </div>
        <!--insideLeft/-->
        <div class="insideRight">
            <div class="inRiNew">
                <h1 class="new1Title2"><span>通知公告</span></h1>
                <ul>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2017”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2017”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2017”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2017”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2017”多国海上联合演习准备完毕</a></li>
                </ul>
            </div>
            <!--inRiNew/-->
        </div>
        <!--insideRight/-->
        <div class="clears"></div>
    </div>
    <!--cont/-->
    <jsp:include page="/WEB-INF/pages/app/footer.jsp"></jsp:include>
    <!--footer/-->
</body>

</html>