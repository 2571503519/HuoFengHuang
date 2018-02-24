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
<title>新闻</title>
<link type="text/css" href="<%= basePath %>/css/appcss/css1.css" rel="stylesheet" />
<script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.js"></script>
<script type="text/javascript" src="<%= basePath %>/js/myjs/js.js"></script>
</head>

<body>
  <!-- header -->
  <jsp:include page="/WEB-INF/pages/app/header.jsp"></jsp:include>
  <div class="insideCont">
  <div class="insideLeft">
   <h1 class="new1Title2"><span>新闻中心</span></h1>
   <div class="newsCont">
   <s:iterator value="#newList" var="n">
    <dl>
     <!-- <dt><a href="newinfo.html"><img src="../images/news1.jpg" width="158" height="118" /></a></dt> -->
     <dd>
      <h2><s:property value="#n.new_title" /></h2>
      <time><s:date name="#n.create_time" format="yyyy-MM-dd" /> 来源：<s:property value="#n.source" /> </time>
      <div class="newPar"> 
      <s:property value="#n.new_desc" />...<a href="<%= basePath %>/hfh_index_newDetail?id=<s:property value="#n.new_id"/>">继续阅读&gt;&gt;</a>
      </div><!--newPar/-->
     </dd>
     <div class="clears"></div>
    </dl>
    </s:iterator>
   </div><!--newsCont/-->
   <!--分页开始-->
    <div class="yahoo2">
   		<a href="<%= basePath %>/hfh_index_newList?page=1">首页</a> 
	    <s:if test="#currentPage > 1">  
	        <a href="<%= basePath %>/hfh_index_newList?page=<s:property value="#currentPage - 1" />">&lt; 上一页</a>  
	    </s:if>
	     <s:iterator  
            begin="#currentPage>4?#currentPage+5>#totalPage?#totalPage>10?#totalPage-9:1:#currentPage-4:1"  
            end="#currentPage>4?#currentPage+5>#totalPage?#totalPage:#currentPage+5:#totalPage>10?10:#totalPage"  
            var="i">  
            <s:if test="#currentPage==#i">  
                <span class="current"><s:property value="#i" /></span> <!-- 当前页 --> 
            </s:if>  
            <s:else>  
                <a href="<%= basePath %>/hfh_index_newList?page=<s:property value="#i" />"><s:property value="#i" /></a>
            </s:else>  
        </s:iterator>
        <s:if test="#currentPage < #totalPage">  
	        <a href="<%= basePath %>/hfh_index_newList?page=<s:property value="#currentPage + 1" />">下一页 &gt;</a> <!-- 下一页 -->  
	    </s:if>
    	<a href="<%= basePath %>/hfh_index_newList?page=<s:property value="#totalPage" />">尾页</a>
   <!--分页结束-->
   </div>
   <br />
  </div><!--insideLeft/-->
  <div class="insideRight">
   <div class="inRiNew">
    <h1 class="new1Title2"><span>活动通知</span></h1>
    <ul>
    	<s:iterator value="#onDoingActivityList" var="activity">
        <li><a href="newinfo.html"><s:property value="#activity.act_title"/> </a></li>
        </s:iterator>
        <s:iterator value="#willDoActivityList" var="activity">
        <li><a href="newinfo.html"><s:property value="#activity.act_title"/> </a></li>
        </s:iterator>
    </ul>
   </div><!--inRiNew/-->
  </div><!--insideRight/-->
  <div class="clears"></div>
 </div><!--cont/-->
 <jsp:include page="/WEB-INF/pages/app/footer.jsp"></jsp:include>
 <!--footer/-->
</body>
</html>
