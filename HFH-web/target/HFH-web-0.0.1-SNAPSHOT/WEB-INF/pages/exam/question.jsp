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
	
	/* 添加 */
	function add() {
		$('#addForm').form('submit', { 
			url:"questionAction_add.action", 
			onSubmit: function(){
				var res = $(this).form('validate');	
				return res;
			// 返回false来防止提交;
			}, 
			success:function(data){
				data = eval("("+ data +")");
				if (data.status == 1) {
					$.messager.alert("提示信息", "题目添加成功！");
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
	/* 删除 */
	function doDelete(){
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要删除记录!", "warning");
		} else {
			$.messager.confirm("删除确认", "你确定要删除吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].quest_id);
					}
					var ids = arr.join(",");
					location.href="questionAction_deleteQuestions.action?ids=" + ids;
				}
			});
		}
	}
	/* 作为考题 */
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
						arr.push(rows[i].quest_id);
					}
					var ids = arr.join(",");
					location.href="questionAction_publishQuestions.action?ids=" + ids;
				}
			});
		}
	}
	/* 撤销 */
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
						arr.push(rows[i].quest_id);
					}
					var ids = arr.join(",");
					location.href="questionAction_revokeQuestions.action?ids=" + ids;
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
	},{
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
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
	// 定义列
	var columns = [ [ {
		field : 'quest_id',
		checkbox : true,
	}, {
		field : 'quest_content',
		title : '题目',
		width : 120,
		align : 'center'
	},{
		field : 'quest_result',
		title : '答案',
		width : 120,
		align : 'center'
	}, {
		field : 'quest_type',
		title : '题型',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == 1) return "选择题";
			else return "填空题";
		}
	}, {
		field : 'quest_status',
		title : '是否作为考题',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == 0) return '否';
			else return '是';
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
			url : "questionAction_pageQuery.action",
			idField : 'quest_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改区域窗口
		$('#addWindow').window({
	        title: '添加题目',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#editWindow').window({
	        title: '修改题目',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		
	});

	function doDblClickRow(rowIndex, rowData){
		$("#editWindow").window("open");
		$("#editForm").form("load", rowData);
	}
</script>
</head>
<body  class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
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
						<td colspan="2">题目信息</td>
					</tr>
					<tr>
						<td>题型</td>
						<td>
							<select name="quest_type">
								<option value="1">选择题</option>
								<option value="2">填空题</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>题目</td>
						<td><textarea name="quest_content" rows="10" cols="60"  class="easyui-validatebox" required="true"></textarea></td>
					</tr>
					<tr>
						<td>答案</td>
						<td><input type="text" name="quest_result" class="easyui-validatebox" required="true"/><span> 多选题和填空题用 "," 分隔</span></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div class="easyui-window" title="考题添加修改" id="editWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="edit()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="editForm" method="post">
				<input type="hidden" name="quest_id">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">题目信息</td>
					</tr>
					<tr>
						<td>题型</td>
						<td>
							<select name="quest_type">
								<option value="1">选择题</option>
								<option value="2">填空题</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>题目</td>
						<td><textarea name="quest_content" rows="10" cols="60"  class="easyui-validatebox" required="true"></textarea></td>
					</tr>
					<tr>
						<td>答案</td>
						<td><input type="text" name="quest_result" class="easyui-validatebox" required="true"/><span> 多选题和填空题用 "," 分隔</span></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
















