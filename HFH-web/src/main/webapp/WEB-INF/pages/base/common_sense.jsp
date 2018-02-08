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
	var ue = UE.getEditor('editor');
	var ueEdit = UE.getEditor('editorEdit');
	
	function doAdd(){
		$('#addCommonSenseWindow').window("open");
	}
	
	
	function doEdit(){
		$('#editCommonSenseWindow').window("open");
		var rows = $("#grid").datagrid("getSelections");
		$("#commonSenseEditForm").form('load', rows[0]);
		UE.getEditor('editorEdit').setContent(rows[0].sense_content);
		/* var jq = top.jQuery;    
        var title = "sdsf";
        var url = "page_base_add_common_sense.action";
        if (jq("#tabs").tabs('exists', title)){    
        	jq("#tabs").tabs('select', title);    
        } else {  
              var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';     
              jq("#tabs").tabs('add',{    
                              title:title,    
                              content:content,    
                              closable:true    
                         });    
         }   */    
	}
	
	/* 添加消防常识 */
	function addCommonSense() {
		var sense_content =  UE.getEditor('editor').getContent();
		$('#commonSenseForm').form('submit', { 
			url:"commonSenseAction_add.action", 
			onSubmit: function(param){ 
				param.sense_content = sense_content;			 
			},
			success: function(data) {
				// {status: 0, error: "消防常识的标题或内容不能为空！"}
				// {status: 1}
				var data = eval('(' + data + ')'); 
				console.log(data);
				if (data.status == 1) {
					$.messager.alert("提示信息", "消防常识添加成功！");
					UE.getEditor('editor').setContent('');
					$('#commonSenseForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
			}
		}); 
   
	}
	/* 修改消防常识 */
	function editCommonSense() {
		var sense_content =  UE.getEditor('editorEdit').getContent();
		$('#commonSenseEditForm').form('submit', { 
			url:"commonSenseAction_edit.action", 
			onSubmit: function(param){ 
				param.sense_content = sense_content;			 
			},
			success: function(data) {
				// {status: 0, error: "消防常识的标题或内容不能为空！"}
				// {status: 1}
				var data = eval('(' + data + ')'); 
				if (data.status == 1) {
					$.messager.alert("提示信息", "消防常识修改成功！");
					UE.getEditor('editorEdit').setContent('');
					$('#commonSenseEditForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
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
						arr.push(rows[i].sense_id);
					}
					var ids = arr.join(",");
					location.href="commonSenseAction_deleteNews.action?ids=" + ids;
				}
			});
		}
	}
	/* 发布 */
	function publishCommonSense() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要发布的记录!", "warning");
		} else {
			$.messager.confirm("发布确认", "你确定要发布吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].sense_id);
					}
					var ids = arr.join(",");
					location.href="commonSenseAction_publishNews.action?ids=" + ids;
				}
			});
		}
	}
	/* 撤销 */
	function revokeCommonSense() {
		var rows = $("#grid").datagrid("getSelections");
		console.log(rows);
		if (rows.length == 0) {
			$.messager.alert("请选择需要撤销的记录!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要撤销吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].sense_id);
					}
					var ids = arr.join(",");
					location.href="commonSenseAction_revokeNews.action?ids=" + ids;
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
	},{
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	}, {
		id : 'button-publish',
		text : '发布',
		iconCls : 'icon-redo',
		handler	: publishCommonSense
	}, {
		id : 'button-revoke',
		text : '撤销',
		iconCls : 'icon-undo',
		handler	: revokeCommonSense
	}];
	// 定义列
	var columns = [ [ {
		field : 'sense_id',
		checkbox : true,
	}, {
		field : 'sense_title',
		title : '标题',
		width : 120,
		align : 'center'
	},{
		field : 'sense_content',
		title : '内容',
		width : 120,
		align : 'center'
	}, {
		field : 'create_time',
		title : '创建时间',
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
		
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [1, 5, 10],
			pagination : true,
			toolbar : toolbar,
			url : "commonSenseAction_pageQuery.action",
			idField : 'sense_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改区域窗口
		$('#addCommonSenseWindow').window({
	        title: '添加消防常识',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#editCommonSenseWindow').window({
	        title: '修改消防常识',
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
	<div class="easyui-window" title="消防常识添加修改" id="addCommonSenseWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="addCommonSense()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="commonSenseForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">消防常识信息</td>
					</tr>
					<tr>
						<td>标题</td>
						<td><input type="text" name="sense_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>内容</td>
						<td><script id="editor" type="text/plain" style="width:1024px;height:200px;"></script></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<div class="easyui-window" title="消防常识添加修改" id="editCommonSenseWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="editCommonSense()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="commonSenseEditForm" method="post">
				<input type="hidden" name="sense_id">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">消防常识信息</td>
					</tr>
					<tr>
						<td>标题</td>
						<td><input type="text" name="sense_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>内容</td>
						<td><script id="editorEdit" type="text/plain" style="width:1024px;height:200px;"></script></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>
















