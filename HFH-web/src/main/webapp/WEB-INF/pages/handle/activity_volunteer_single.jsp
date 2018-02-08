<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function dateTransfer(timestamp) {
		var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	 	var Y = date.getFullYear() + '-';
		var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
		var D = date.getDate();
	
	    return Y+M+D;
	}
	
	// 定义列
	var columns = [ [ {
		field : 'act_id',
		checkbox : true,
	}, {
		field : 'act_title',
		title : '标题',
		width : 120,
		align : 'center'
	},{
		field : 'act_content',
		title : '内容',
		width : 120,
		align : 'center'
	},{
		field : 'act_addr',
		title : '活动地点',
		width : 120,
		align : 'center'
	},{
		field : 'live_url',
		title : '直播地址',
		width : 120,
		align : 'center'
	},{
		field : 'sponsor',
		title : '主办方',
		width : 120,
		align : 'center'
	}, {
		field : 'start_time',
		title : '活动开始时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';

		    return dateTransfer(data.time);
		}
	}, {
		field : 'end_time',
		title : '活动结束时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';
		    return dateTransfer(data.time);
		}
	}] ];
	columns = [ [ {
		field : 'act_id',
		checkbox : true,
	}, {
		field : 'act_title',
		title : '标题',
		width : 120,
		align : 'center'
	},{
		field : 'act_content',
		title : '内容',
		width : 120,
		align : 'center'
	},{
		field : 'act_addr',
		title : '活动地点',
		width : 120,
		align : 'center'
	},{
		field : 'live_url',
		title : '直播地址',
		width : 120,
		align : 'center'
	},{
		field : 'sponsor',
		title : '主办方',
		width : 120,
		align : 'center'
	}, {
		field : 'start_time',
		title : '活动开始时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';

		    return dateTransfer(data.time);
		}
	}, {
		field : 'end_time',
		title : '活动结束时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';
		    return dateTransfer(data.time);
		}
	}] ];
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [1, 5, 10],
			pagination : true,
			url : "activityAction_pageQuery.action",
			idField : 'act_id',
			columns : columns
		});
	});
</script>
</head>
<body  class="easyui-layout" style="visibility:hidden;">
	<table class="table-edit" width="100%" align="center">
		<tr class="title">
			<td colspan="2">活动信息</td>
		</tr>
		<tr>
			<td>标题</td>
			<td><input type="text" id="act_title" disabled="disabled"/></td>
		</tr>
		<tr>
			<td>活动地点</td>
			<td><input type="text" id="act_addr" disabled="disabled"/></td>
		</tr>
		<tr>
			<td>活动直播地址</td>
			<td><input type="text" id="act_live_url" disabled="disabled"/></td>
		</tr>
		<tr>
			<td>主办方</td>
			<td><input type="text" id="act_sponsor" disabled="disabled"/></td>
		</tr>
		<tr>
			<td>活动日期</td>
			<td><input type="text" id="act_date" disabled="disabled"/></td>
		</tr>
	</table>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>