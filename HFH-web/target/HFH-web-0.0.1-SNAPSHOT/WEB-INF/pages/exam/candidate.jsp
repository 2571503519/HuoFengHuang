<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新闻设置</title>
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
	
	function examDetail() {
		var rows = $("#grid").datagrid("getSelections");
		var cand_id = null;
		if (rows.length == 0) {
			$.messager.alert("提示", "请选择需要查看的考生!", "warning");
			return ;
		} else {
			cand_id = rows[0].cand_id;
		}
		$("#examDetailWindow").window("open");
		$('#grid_examDetail').datagrid( {
			iconCls : 'icon-forward',
			fitColumns: true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [1, 5, 10],
			url : "candidateAction_listCandAnswer.action?cand_id=" + cand_id,
			idField : 'answer_id',
			columns : columns_examDetail
		});
	}
	function candidateInfo() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("提示", "请选择需要修改的考生!", "warning");
			return ;
		} else {
			$('#candidateInfoWindow').window("open");
			rows[0].cand_date = dateTransfer(rows[0].cand_date.time);
			$("#editForm").form("load", rows[0]);
		}
	}
	function editCandidate() {
		$("#editForm").form("submit", {
		url: "candidateAction_edit.action",  	
	   	onSubmit: function(){
	   		var res = $("#editForm").form("validate");
	   		return res;
	  	},  	
	    success: function(data){  
	    	data = eval("(" + data + ")");
	    	if (data.status == 1)
	    		$.messager.alert("提示信息", "修改成功");
	    	else
	    		$.messager.alert("提示信息", data.error);
	    }  
		});
	}
	//工具栏
	var toolbar = [ {
		id : 'button-examDetail',
		text : '考试答卷',
		iconCls : 'icon-add',
		handler : examDetail
	}, {
		id : 'button-candidateInfo',
		text : '考生信息',
		iconCls : 'icon-edit',
		handler : candidateInfo
	}];
	// 定义列
	var columns = [ [ {
		field : 'cand_id',
		checkbox : true,
	}, {
		field : 'cand_name',
		title : '考生姓名',
		width : 120,
		align : 'center'
	},{
		field : 'cand_username',
		title : '考生号',
		width : 120,
		align : 'center'
	}, {
		field : 'cand_date',
		title : '考试日期',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';
		    return dateTransfer(data.time);
		}
	}, {
		field : 'cand_grade',
		title : '考试得分',
		width : 120,
		align : 'center'
	} ] ];
	
	var columns_examDetail = [ [ {
		field : 'answer_id',
		checkbox : true,
	}, {
		field : 'quest_content',
		title : '题目',
		width : 200,
		align : 'center'
	},{
		field : 'answer_result',
		title : '考生回答',
		width : 120,
		align : 'center'
	}, {
		field : 'quest_result',
		title : '答案',
		width : 120,
		align : 'center'
	}, {
		field : 'exam_weights',
		title : '分值',
		width : 80,
		align : 'center'
	}, {
		field : 'correct',
		title : '对错',
		width : 80,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == -1) {
				return "未改";
			} else if (data == 1) {
				return "正确";
			} else {
				return "错误";
			}
		}
	} ] ];
	
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
			toolbar : toolbar,
			url : "candidateAction_pageQuery.action",
			idField : 'cand_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		
		
		// 添加、修改区域窗口
		$('#examDetailWindow').window({
	        title: '考生答卷',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#candidateInfoWindow').window({
	        title: '修改考生信息',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		
	});

	function doDblClickRow(){
		alert("双击表格数据...");
	}
</script>
</head>
<body  class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	
	<div class="easyui-window" title="考生考试答卷" id="examDetailWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<table id="grid_examDetail"></table>
	</div>
	
	<div class="easyui-window" title="考生信息" id="candidateInfoWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="saveEdit" icon="icon-save" onclick="editCandidate()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editForm" method="post">
			<input type="hidden" name="cand_id">
			<table class="table-edit" width="80%" align="center">
				<tr class="title">
					<td colspan="2">考生信息</td>
				</tr>
				<tr>
					<td>考生姓名</td>
					<td><input type="text" name="cand_name" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>考生号</td>
					<td><input type="text" name="cand_username" class="easyui-validatebox" required="true"/></td>
				</tr>
				<tr>
					<td>考试日期</td>
					<td><input type="text" name="cand_date" class="easyui-datebox" required="required"></input> </td>
				</tr>
				<tr>
					<td>最终得分</td>
					<td><input type="text" name="cand_grade" class="easyui-validatebox" required="true"/></td>
				</tr>
				</table>
				</form>
		</div>
	</div>
</body>
</html>
















