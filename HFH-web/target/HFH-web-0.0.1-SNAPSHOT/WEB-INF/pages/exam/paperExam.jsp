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
	function doAdd(){
		$('#addWindow').window("open");
	}
	function doEdit() {
		var rows = $("#grid").datagrid("getSelections");
		var paper_id = null;
		if (rows.length == 0) {
			$.messager.alert("提示", "请选择需要查看的考卷!", "warning");
			return ;
		} else {
			paper_id = rows[0].paper_id;
		}
		$("#editWindow").window("open");
		$('#grid_examDetail').datagrid( {
			iconCls : 'icon-forward',
			fitColumns: true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [1, 5, 10],
			url : "paperExamAction_listQuestionExam.action?paper_id=" + paper_id,
			idField : 'exam_id',
			toolbar: toolbar_examDetail,
			columns : columns_examDetail
		});
	}
	/* 添加 */
	function add() {
		$('#addForm').form('submit', { 
			url:"paperExamAction_add.action", 
			onSubmit: function(){
			    var res = $(this).form('validate');	
				return res;
			},
			success:function(data){
				data = eval("("+ data +")");
				if (data.status == 1) {
					$.messager.alert("提示信息", "考卷添加成功！");
					$('#addForm').form("clear");
				}
				else
					$.messager.alert("提示信息", data.error);
			} 
			}); 
	}
	/* 修改 */
	function edit() {
		$('#editForm').form('submit', { 
			url:"questionAction_edit.action", 
			onSubmit: function(){
				var res = $(this).form('validate');	
				return res;
			// 返回false来防止提交;
			}, 
			success:function(data){ 
				data = eval("("+ data +")");
				if (data.status == 1) {
					$.messager.alert("提示信息", "题目修改成功！");
					$('#editForm').form("clear");
				}
				else
					$.messager.alert("提示信息", data.error);
			} 
			}); 
	}
	function publish() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要发布的记录!", "warning");
		} else {
			$.messager.confirm("发布确认", "你确定要发布吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].paper_id);
					}
					var ids = arr.join(",");
					location.href="paperExamAction_publishPaperExam.action?ids=" + ids;
				}
			});
		}
	}
	function revoke() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要撤销的记录!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要撤销吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].paper_id);
					}
					var ids = arr.join(",");
					location.href="paperExamAction_revokePaperExam.action?ids=" + ids;
				}
			});
		}
	}
	function replace() {
		var rows = $("#grid_examDetail").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要替换的记录!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要替换吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].exam_id);
					}
					var ids = arr.join(",");
					$.post("paperExamAction_replaceQuestionExam.action",
							{"ids": ids},
							function(data) {
								console.log(data);
								$('#grid_examDetail').datagrid("loadData", data);
							},
							"json");
				}
			});
		}
	}
	//工具栏
	var toolbar = [ {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	}, {
		id : 'button-publish',
		text : '发布',
		iconCls : 'icon-redo',
		handler	: publish
	}, {
		id : 'button-revoke',
		text : '撤销',
		iconCls : 'icon-undo',
		handler	: revoke
	}];
	var toolbar_examDetail = [{
		id : 'button-add',
		text : '替换',
		iconCls : 'icon-add',
		handler : replace
	}];
	// 定义列
	var columns = [ [ {
		field : 'paper_id',
		checkbox : true,
	}, {
		field : 'paper_name',
		title : '题目',
		width : 120,
		align : 'center'
	}, {
		field : 'selected',
		title : '是否作为考试用卷',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == 0) return '否';
			else return '是';
		}
	} ] ];
	var columns_examDetail = [ [ {
		field : 'exam_id',
		checkbox : true,
	}, {
		field : 'quest_content',
		title : '题目',
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
		width : 120,
		align : 'center'
	}, {
		field : 'quest_type',
		title : '题型',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == 1)
				return "选择题";
			else if (data == 2)
				return "填空题";
			else 
				return "其他";
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
			url : "paperExamAction_pageQuery.action",
			idField : 'paper_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		// 添加、修改区域窗口
		$('#addWindow').window({
	        title: '组卷',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#editWindow').window({
	        title: '考卷信息',
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
	<div class="easyui-window" title="考卷修改" id="editWindow" collapsible="false" minimizable="false" maximizable="true">
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<table id="grid_examDetail"></table>
		</div>
	</div>
	<div class="easyui-window" title="考题添加修改" id="addWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="add()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="addForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="3">考卷信息</td>
					</tr>
					<tr>
						<td>考卷名</td>
						<td><input name="paper_name" type="text" class="easyui-validatebox" required="true"></td>
					</tr>
					<tr>
						<td>选择题</td>
						<td>
							<span>数量：</span>
							<select name="xuanze_number">
								<option value="2">2</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>分值：</span>
							<select name="xuanze_weights">
								<option value="2">2</option>
								<option value="5">5</option>
								<option value="10">10</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>填空题</td>
						<td>
							<span>数量：</span>
							<select name="tiankong_number">
								<option value="2">2</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>每空分值：</span>
							<select name="tiankong_weights">
								<option value="2">2</option>
								<option value="5">5</option>
								<option value="10">10</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>是否作为考卷</td>
						<td><input name="selected" type="checkbox" value="1"><span>是</span></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
















