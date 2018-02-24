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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/ueditor/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
    div{
        width:100%;
    }
</style>
<script type="text/javascript">
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');
	var ueEdit = UE.getEditor('editorEdit');
	
	function doAdd(){
		$('#addNewWindow').window("open");
	}
	
	function doView(){
		$('#editNewWindow').window("open");
		var rows = $("#grid").datagrid("getSelections");
		$("#newEditForm").form('load', rows[0]);
		UE.getEditor('editorEdit').setContent(rows[0].new_content);
	}
	
	function deleteNews(){
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要删除的新闻!", "warning");
		} else {
			$.messager.confirm("删除确认", "你确定要删除吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].new_id);
					}
					var ids = arr.join(",");
					location.href="newAction_deleteNews.action?ids=" + ids;
				}
			});
		}
	}
	
	function publishNews() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要发布的新闻!", "warning");
		} else {
			$.messager.confirm("发布确认", "你确定要发布吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].new_id);
					}
					var ids = arr.join(",");
					location.href="newAction_publishNews.action?ids=" + ids;
				}
			});
		}
	}
	/* 撤销新闻 */
	function revokeNews() {
		var rows = $("#grid").datagrid("getSelections");
		console.log(rows);
		if (rows.length == 0) {
			$.messager.alert("请选择需要撤销的新闻!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要撤销吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].new_id);
					}
					var ids = arr.join(",");
					location.href="newAction_revokeNews.action?ids=" + ids;
				}
			});
		}
	}
	
	
	/* 添加新闻 */
	function addNew() {
		var new_content =  UE.getEditor('editor').getContent();
		$('#newForm').form('submit', { 
			url:"newAction_add.action", 
			onSubmit: function(param){ 
				param.new_content = new_content;
				return $(this).form("validate");
			},
			success: function(data) {
				// {status: 0, error: "新闻的标题或内容不能为空！"}
				// {status: 1}
				var data = eval('(' + data + ')'); 
				console.log(data);
				if (data.status == 1) {
					$.messager.alert("提示信息", "新闻添加成功！");
					UE.getEditor('editor').setContent('');
					$('#newForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
			}
		}); 
   
	}
	/* 修改新闻 */
	function editNew() {
		var new_content =  UE.getEditor('editorEdit').getContent();
		$('#newEditForm').form('submit', { 
			url:"newAction_edit.action", 
			onSubmit: function(param){ 
				param.new_content = new_content;
				return $(this).form("validate");
			},
			success: function(data) {
				// {status: 0, error: "新闻的标题或内容不能为空！"}
				// {status: 1}
				var data = eval('(' + data + ')'); 
				console.log(data);
				if (data.status == 1) {
					$.messager.alert("提示信息", "新闻修改成功！");
					UE.getEditor('editorEdit').setContent('');
					$('#newEditForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
			}
		}); 
	}
	//工具栏
	var toolbar = [ {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : deleteNews
	}, {
		id : 'button-publish',
		text : '发布',
		iconCls : 'icon-redo',
		handler	: publishNews
	}, {
		id : 'button-revoke',
		text : '撤销',
		iconCls : 'icon-undo',
		handler	: revokeNews
	}];
	// 定义列
	var columns = [ [ {
		field : 'new_id',
		checkbox : true,
	},{
		field : 'new_title',
		title : '新闻标题',
		width : 120,
		align : 'center'
	}, {
		field : 'new_desc',
		title : '新闻描述',
		width : 280,
		align : 'left',
		formatter: function(data, row, index) {
			if (data.length > 20) {
				return data.substring(0, 20) + "...";
			} else {
				return data;
			}
		}
	}, {
		field : 'author',
		title : '作者',
		width : 120,
		align : 'center'
	}, {
		field : 'source',
		title : '来源',
		width : 120,
		align : 'center'
	}, {
		field : 'create_time',
		title : '创建时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			// data 单元格里的数据对象
			// row 一行数据对象
			// index 行数 从0开始
			if (data == null) 
				return '';
			var date = new Date(data.time);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
		 	var Y = date.getFullYear() + '-';
			var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
			var D = date.getDate();

		    return Y+M+D;
		}
	}, {
		field : 'update_time',
		title : '修改时间',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';
			var date = new Date(data.time);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
		 	var Y = date.getFullYear() + '-';
			var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
			var D = date.getDate();

		    return Y+M+D;
		}
	}, {
		field : 'status',
		title : '状态',
		width : 120,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == 0) return '未发布';
			else if (data == 1) return '已发布';
			else return '已删除';
		}
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : false,
			rownumbers : true,
			striped : true,
			pageList: [1,5,10],
			pagination : true,
			toolbar : toolbar,
			url : "newAction_pageQuery.action",
			idField : 'new_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改区域窗口
		$('#addNewWindow').window({
	        title: '添加新闻',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#editNewWindow').window({
	        title: '修改新闻',
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
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="新闻添加修改" id="addNewWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="addNew()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="newForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">新闻信息</td>
					</tr>
					<tr>
						<td>新闻标题</td>
						<td><input type="text" name="new_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>新闻描述</td>
						<td><textarea rows="5" cols="30" name="new_desc" class="easyui-validatebox" required="true"></textarea></td>
					</tr>
					<tr>
						<td>新闻内容</td>
						<td><script id="editor" type="text/plain" style="width:1024px;height:500px;"></script></td>
					</tr>
					<tr>
						<td>作者</td>
						<td><input type="text" name="author" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>来源</td>
						<td><input type="text" name="source" class="easyui-validatebox" required="true"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<div class="easyui-window" title="新闻添加修改" id="editNewWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="editNew()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="newEditForm" method="post">
				<input type="hidden" name="new_id">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">新闻信息</td>
					</tr>
					<tr>
						<td>新闻标题</td>
						<td><input type="text" name="new_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>新闻描述</td>
						<td><textarea rows="5" cols="30" name="new_desc" class="easyui-validatebox" required="true"></textarea></td>
					</tr>
					<tr>
						<td>新闻内容</td>
						<td><script id="editorEdit" type="text/plain" style="width:1024px;height:500px;"></script></td>
					</tr>
					<tr>
						<td>作者</td>
						<td><input type="text" name="author" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>来源</td>
						<td><input type="text" name="source" class="easyui-validatebox" required="true"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>