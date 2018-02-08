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
	// 将时间戳转化为字符串形式的日期 2018-01-22
	function dateTransfer(timestamp) {
		var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	 	var Y = date.getFullYear() + '-';
		var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
		var D = date.getDate();

	    return Y+M+D;
	}
	
	function doAdd(){
		$('#addActivityWindow').window("open");
	}
	
	
	function doEdit(){
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length <= 0) {
			$.messager.alert("提示信息", "请选择活动！");
			return ;
		}
		$('#editActivityWindow').window("open");
		$("#saveEdit").css("display", "inline-block");
		UE.getEditor('editorEdit').setContent(rows[0].act_content);
		
		rows[0].start_time = dateTransfer(rows[0].start_time.time);
		rows[0].end_time = dateTransfer(rows[0].end_time.time);
		$("#activityEditForm").form('load', rows[0]);  
	}
	
	/* 添加消防常识 */
	function addActivity() {
		var act_content =  UE.getEditor('editor').getContent();
		$('#activityForm').form('submit', { 
			url:"activityAction_add.action", 
			onSubmit: function(param){ 
				param.act_content = act_content;			 
			},
			success: function(data) {
				var data = eval('(' + data + ')'); 
				if (data.status == 1) {
					$.messager.alert("提示信息", "活动添加成功！");
					UE.getEditor('editor').setContent('');
					$('#activityForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
			}
		}); 
   
	}
	/* 修改消防常识 */
	function editActivity() {
		var act_content =  UE.getEditor('editorEdit').getContent();
		$('#activityEditForm').form('submit', { 
			url:"activityAction_edit.action", 
			onSubmit: function(param){ 
				param.act_content = act_content;			 
			},
			success: function(data) {
				// {status: 0, error: "消防常识的标题或内容不能为空！"}
				// {status: 1}
				var data = eval('(' + data + ')'); 
				if (data.status == 1) {
					$.messager.alert("提示信息", "活动修改成功！");
					UE.getEditor('editorEdit').setContent('');
					$('#activityEditForm').form('clear');
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
						arr.push(rows[i].act_id);
					}
					var ids = arr.join(",");
					location.href="activityAction_deleteActivities.action?ids=" + ids;
				}
			});
		}
	}
	/* 发布 */
	function publishActivity() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要发布的记录!", "warning");
		} else {
			$.messager.confirm("发布确认", "你确定要发布吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].act_id);
					}
					var ids = arr.join(",");
					location.href="activityAction_publishActivities.action?ids=" + ids;
				}
			});
		}
	}
	/* 撤销 */
	function revokeActivity() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要撤销的记录!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要撤销吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].act_id);
					}
					var ids = arr.join(",");
					location.href="activityAction_revokeActivities.action?ids=" + ids;
				}
			});
		}
	}
	/* 批准申请 */
	function approval(id, vol_id) {
		$.post("activityAction_approval.action", 
				{"actVol_id": id},
				function(data) {
					console.log(data);
					/*if (data.status == 1) {
						$("#volunteer" + vol_id).html("已批准");
					} else {
						$.messager.alert("批准申请失败");
					}*/
				}, 
				"json");
		$("#volunteer" + vol_id).html("已批准");
	}
	
	function activityApplyDetail() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择记录!", "warning");
		} else {
			$("#applyDetailWindow").window("open");
			$("#applyDetail").empty();
			var act_id = rows[0].act_id;
			$("#act_id_apply").val(act_id);
			$.post("activityAction_listVolunteer.action", 
				{"act_id": act_id}, 
				function(data) {
					for (var i = 0; i < data.length; i++) {
						if (data[i].status == 0) {
							$("#applyDetail")
								.append("<tr><td>" + data[i].volunteer.vol_name +"</td><td>" + dateTransfer(data[i].create_time.time) +"</td><td><button id='volunteer" + data[i].volunteer.vol_id +"' onclick='approval(" + data[i].id + ", " +　data[i].volunteer.vol_id +");'>批准申请</button></td></tr>");
						} else if (data[i].status == 1) {
							$("#applyDetail")
								.append("<tr><td>" + data[i].volunteer.vol_name +"</td><td>" + dateTransfer(data[i].create_time.time) +"</td><td><button id='volunteer" + data[i].id +" disabled='disabled'>已批准</button></td></tr>");
						} else {
							$("#applyDetail")
							.append("<tr><td>" + data[i].volunteer.vol_name +"</td><td>" + dateTransfer(data[i].create_time.time) +"</td><td><button id='volunteer" + data[i].id +" disabled='disabled'>已拒绝</button></td></tr>");
						}
					}
				}, 
				"json");
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
		handler	: publishActivity
	}, {
		id : 'button-revoke',
		text : '撤销',
		iconCls : 'icon-undo',
		handler	: revokeActivity
	}, {
		id : 'button-revoke',
		text : '活动申请',
		iconCls : 'icon-help',
		handler	: activityApplyDetail
	}];
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
	}, {
		field : 'create_time',
		title : '创建时间',
		width : 80,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';

		    return dateTransfer(data.time);
		}
	}, {
		field : 'update_time',
		title : '修改时间',
		width : 80,
		align : 'center',
		formatter: function(data, row, index) {
			if (data == null) 
				return '';

		    return dateTransfer(data.time);
		}
	}, {
		field : 'status',
		title : '状态',
		width : 90,
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
			url : "activityAction_pageQuery.action",
			idField : 'act_id',
			columns : columns,
			onDblClickRow : doDblClickRow
		});
		
		// 添加、修改区域窗口
		$('#addActivityWindow').window({
	        title: '添加活动',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#editActivityWindow').window({
	        title: '修改活动',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
		$('#applyDetailWindow').window({
	        title: '活动申请',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false,
	        maximized:true
	    });
	});

	function doDblClickRow(index, data){
		$('#editActivityWindow').window("open");
		$("#saveEdit").css("display", "none");
		UE.getEditor('editorEdit').setContent(data.act_content);
		
		data.start_time = dateTransfer(data.start_time.time);
		data.end_time = dateTransfer(data.end_time.time);
		$("#activityEditForm").form('load', data);  
	}
</script>
</head>
<body  class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="活动添加修改" id="addActivityWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="addActivity()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="activityForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">活动信息</td>
					</tr>
					<tr>
						<td>标题</td>
						<td><input type="text" name="act_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>内容</td>
						<td><script id="editor" type="text/plain" style="width:1024px;height:200px;"></script></td>
					</tr>
					<tr>
						<td>活动地点</td>
						<td><input type="text" name="act_addr" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>活动直播地址</td>
						<td><input type="text" name="live_url" class="easyui-validatebox"/></td>
					</tr>
					<tr>
						<td>活动时间</td>
						<td>
							<input id="start_time" name="start_time" type="text" class="easyui-datebox" required="required"></input>
							&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;
							<input id="end_time" name="end_time" type="text" class="easyui-datebox" required="required"></input>
						</td>
					</tr>
					<tr>
						<td>主办方</td>
						<td><input type="text" name="sponsor" class="easyui-validatebox"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<div class="easyui-window" title="活动添加修改" id="editActivityWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="saveEdit" icon="icon-save" onclick="editActivity()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="activityEditForm" method="post">
				<input type="hidden" name="act_id">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">活动信息</td>
					</tr>
					<tr>
						<td>标题</td>
						<td><input type="text" name="act_title" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>内容</td>
						<td><script id="editorEdit" type="text/plain" style="width:1024px;height:200px;"></script></td>
					</tr>
					<tr>
						<td>活动地点</td>
						<td><input type="text" name="act_addr" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>活动直播地址</td>
						<td><input type="text" name="live_url" class="easyui-validatebox"/></td>
					</tr>
					<tr>
						<td>活动时间</td>
						<td>
							<input id="start_time" name="start_time" type="text" class="easyui-datebox" required="required"></input>
							&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;
							<input id="end_time" name="end_time" type="text" class="easyui-datebox" required="required"></input>
						</td>
					</tr>
					<tr>
						<td>主办方</td>
						<td><input type="text" name="sponsor" class="easyui-validatebox"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	
	<div class="easyui-window" title="活动申请" id="applyDetailWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<input id="act_id_apply" type="hidden"/>
		<table id="applyDetail" class="table-edit" width="80%" align="center">
			<tr>
				<td>申请人</td>
				<td><button>申请</button></td>
			</tr>
			<tr>
				<td>申请人</td>
				<td><button>申请</button></td>
			</tr>
			<tr>
				<td>申请人</td>
				<td><button>批准</button></td>
			</tr>
			<tr>
				<td>申请人</td>
				<td><button>申请</button></td>
			</tr>
		</table>	
	</div>
</body>
</html>
















