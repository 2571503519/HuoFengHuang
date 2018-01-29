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
	function doAdd(){
		//alert("增加...");
		$('#addAdminWindow ').window("open");
	}
	
	function doView(){
		alert("查看...");
	}
	
	function doDelete(){
		//获取数据表格中所有选中的行，返回数组对象
		var rows = $("#grid").datagrid("getSelections");
		console.log(rows);
		if(rows.length == 0){
			//没有选中记录，弹出提示
			$.messager.alert("提示信息","请选择需要关闭的管理员！","warning");
		}else{
			//选中了管理员,弹出确认框
			$.messager.confirm("删除确认","你确定要关闭选中的管理员吗？",function(r){
				if(r){
					var array = new Array();
					//确定,发送请求
					//获取所有选中的管理员的id
					for(var i=0;i<rows.length;i++){
						var admin = rows[i];//json对象
						var id = admin.admin_id;
						array.push(id);
					}
					var ids = array.join(",");//1,2,3,4,5
					location.href = "adminAction_deleteBatch.action?ids="+ids;
				}
			});
		}
	}
	function doAbsoluteDelete() {
		alert("你确定要完全删除该管理员账号吗？");
	}
	//工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '禁用',
		iconCls : 'icon-remove',
		handler : doDelete
	}, {
		id : 'button-absolute-delete',
		text : '完全删除',
		iconCls : 'icon-cancel',
		handler : doAbsoluteDelete
	}];
	// 定义列
	var columns = [ [ {
		field : 'admin_id',
		checkbox : true,
	},{
		field : 'username',
		title : '用户名',
		width : 120,
		align : 'center'
	}, {
		field : 'create_time',
		title : '创建时间',
		width : 120,
		align : 'center',
		formatter : function(data, row, index){
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
		formatter : function(data, row, index){
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
		title : '账户状态',
		width : 120,
		align : 'center',
		formatter : function(data, row, index){
			if(data==1){
				return "启用"
			}else{
				return "未启用";
			}
		}
	}] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 取派员信息表格
		$('#grid').datagrid( {
			fit : true,
			border : true,
			rownumbers : true,
			striped : false,
			pageList: [1, 3, 5, 10],
			pagination : true,
			toolbar : toolbar,
			url : "adminAction_pageQuery.action",
			idField : 'admin_id',
			columns : columns,
		});
		
		// 添加取派员窗口
		$('#addAdminWindow').window({
	        title: '添加管理员',
	        width: 400,
	        modal: true,//遮罩效果
	        shadow: true,//阴影效果
	        closed: true,//关闭
	        height: 400,
	        resizable:false
	    });
		//为保存按钮绑定事件
		$("#save").click(function(){
			//表单校验，如果通过，提交表单
			var v = $("#addAdminForm").form("validate");
			if(v){
				//表单校验通过，手动校验两次输入是否一致
				var v1 = $("#password").val();
				var v2 = $("#repassword").val();
				if(v1 == v2){
					//两次输入一致，发送ajax请求
					$("#addAdminForm").submit();
				}else{
					//两次输入不一致，弹出错误提示
					$.messager.alert("提示信息","两次密码输入不一致！","warning");
				}
				
			}
		});
	});
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="对管理员进行添加或者修改" id="addAdminWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="addAdminForm" action="adminAction_add.action" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">管理员信息</td>
					</tr>
					<tr>
						<td>用户名</td>
						<td><input type="text" name="username" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>密码</td>
						<td>
						<input id="password" type="password" data-options="validType:'length[4, 10]'" 
							name="password" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>确认密码</td>
						<td>
						<input id="repassword" type="password" data-options="validType:'length[4, 10]'"
						class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="checkbox" name="status" value="1" />
						是否启用</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>