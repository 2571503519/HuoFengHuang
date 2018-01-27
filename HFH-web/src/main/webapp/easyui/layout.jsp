<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Layout</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"></script>

</head>
<body class="easyui-layout">
	<!-- 使用div元素描述每个区域 -->
	<div title="XXX管理系统" style="height: 100px" data-options="region:'north'">北部区域</div>
	<div title="系统菜单" style="width: 200px" data-options="region:'west'">
		<div class="easyui-accordion" data-options="fit:true">
			<div title="面板一" data-options="iconCls:'icon-cut'">
				<!-- 展示zTree效果：使用简单的json数据构造zTree -->
				<ul id="ztree01" class="ztree"></ul>
				<script type="text/javascript">
					$(function() {
						var setting = {
							data: {
								simpleData: {
									enable: true // 启用使用简单json数据构造ztree
								}
							},
							callback: {
								onClick: function(event, treeId, treeNode) {
									if (treeNode.page != undefined) {
										var e = $("#mytabs").tabs("exists", treeNode.name);
										if (e) {
											// 存在
											$("#mytabs").tabs("select", treeNode.name);
										} else {
											$("#mytabs").tabs("add", {
												title: treeNode.name,
												closable: true,
												content: '<iframe frameborder="0" height="100%" width="100%" src="' + treeNode.page + '">'
											});
										}
									}
								}
							}
						};
						/* var zNode = [
							{"name": "Node01", "id": "1", "pId": "0"},
							{"name": "Node02", "id": "2", "pId": "1"},
							{"name": "Node03", "id": "3", "pId": "2"}
						]; */
						// 发送AJAX请求获取JSon数据
						var url = "${pageContext.request.contextPath}/json/menu.json";
						$.post(url, {}, function(data){
							// 调用API初始化ztree
							$.fn.zTree.init($("#ztree01"), setting, data);
						}, 'json');
						
					});
				</script>
			</div>
			<div title="面板二" data-options="selected:true">
				<a id="btn01" class="easyui-linkbutton">系统菜单</a>
				<script type="text/javascript">
					$(function() {
						$("#btn01").click(function() {
							var e = $("#mytabs").tabs("exists", "系统管理");
							if (e) {
								// 存在
								$("#mytabs").tabs("select", "系统管理");
							} else {
								$("#mytabs").tabs("add", {
									title: '系统管理',
									iconCls: "icon-edit",
									closable: true,
									content: '<iframe frameborder="0" height="100%" width="100%" src="https://www.baidu.com">'
								});
							}
						});
					});
				</script>
			</div>
			<div title="面板三">面板三</div>
		</div>
	</div>
	<div data-options="region:'center'">
		<div id="mytabs" class="easyui-tabs" data-options="fit:true">
			<div title="面板一" data-options="iconCls:'icon-cut'">面板一</div>
			<div title="面板二" data-options="closable:true">面板二</div>
			<div title="面板三">面板三</div>
		</div>
	</div>
	<div style="width: 100px" data-options="region:'east'">东部区域</div>
	<div style="height: 50px" data-options="region:'south'">南部区域</div>
</body>
</html>