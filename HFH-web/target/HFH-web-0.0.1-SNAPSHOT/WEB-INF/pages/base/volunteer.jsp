<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>志愿者设置</title>
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
<!-- 区域选择相关js文件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.citys.js"></script>
<script type="text/javascript">
	// 将时间戳转化为字符串形式的日期 2018-01-22
	function dateTransfer(timestamp) {
		var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
	 	var Y = date.getFullYear() + '-';
		var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
		var D = date.getDate();

	    return Y+M+D;
	}
	// 将区域信息添加到指定节点内
	function loadInfo(selection, info) {
		for (var i = 0; i < info.length; i++) {
			var opt = new Option(info[i].name, info[i].adcode);
			selection.append(opt)
		}
	}
	
	function doAdd(){
		$('#addActivityWindow').window("open");
	}
	
	
	function doEdit(){
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length <= 0) {
			$.messager.alert("提示信息", "请选择志愿者！");
			return ;
		}
		$('#editActivityWindow').window("open");
		$("#saveEdit").css("display", "inline-block");
		$("#province").append('<option value="'+1+'">'+rows[0].province+'</option>');
		$("#activityEditForm").form('load', rows[0]); 
	}
	
	/* 添加消防常识 */
	function addVolunteer() {
		var province = $("#province option:selected").text();
		var city = $("#city option:selected").text();
		var county = $("#area option:selected").text();
		var town = $("#town option:selected").text();
		$('#activityForm').form('submit', { 
			url:"volunteerAction_add.action", 
			onSubmit: function(param){
				param.provinceTmp = province;	
				param.cityTmp = city;	
				param.countyTmp = county;	
				param.townTmp = town;	
			},
			success: function(data) {
				var data = eval('(' + data + ')'); 
				if (data.status == 1) {
					$.messager.alert("提示信息", "志愿者添加成功！");
					$('#activityForm').form('clear');
				} else {
					$.messager.alert("提示信息", data.error);
				}
			}
		});
	}
	/* 修改消防常识 */
	function editVolunteer() {
		var province = $("#allProvince option:selected").text();
		var city = $("#allCity option:selected").text();
		var county = $("#allCounty option:selected").text();
		var town = $("#allTown option:selected").text();
		$('#activityEditForm').form('submit', { 
			url:"volunteerAction_edit.action", 
			onSubmit: function(param){
				param.provinceTmp = province;	
				param.cityTmp = city;	
				param.countyTmp = county;	
				param.townTmp = town;	
			},
			success: function(data) {
				var data = eval('(' + data + ')'); 
				if (data.status == 1) {
					$.messager.alert("提示信息", "志愿者修改成功！");
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
						arr.push(rows[i].vol_id);
					}
					var ids = arr.join(",");
					location.href="volunteerAction_deleteVolunteers.action?ids=" + ids;
				}
			});
		}
	}
	/* 发布 */
	function publishVolunteer() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要发布的记录!", "warning");
		} else {
			$.messager.confirm("发布确认", "你确定要发布吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].vol_id);
					}
					var ids = arr.join(",");
					location.href="volunteerAction_publishVolunteers.action?ids=" + ids;
				}
			});
		}
	}
	/* 撤销 */
	function revokeVolunteer() {
		var rows = $("#grid").datagrid("getSelections");
		if (rows.length == 0) {
			$.messager.alert("请选择需要撤销的记录!", "warning");
		} else {
			$.messager.confirm("撤销确认", "你确定要撤销吗！", function(res) {
				var arr = new Array();
				if (res) {
					// 确定
					for (var i = 0; i < rows.length; i++) {
						arr.push(rows[i].vol_id);
					}
					var ids = arr.join(",");
					location.href="volunteerAction_revokeVolunteers.action?ids=" + ids;
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
		text : '激活',
		iconCls : 'icon-redo',
		handler	: publishVolunteer
	}, {
		id : 'button-revoke',
		text : '撤销',
		iconCls : 'icon-undo',
		handler	: revokeVolunteer
	}];
	// 定义列
	var columns = [ [ {
		field : 'vol_id',
		checkbox : true,
	}, {
		field : 'vol_name',
		title : '姓名',
		width : 120,
		align : 'center'
	}, {
		field : 'vol_IDCard',
		title : '身份证',
		width : 150,
		align : 'center'
	},{
		field : 'live_url',
		title : '直播地址',
		width : 120,
		align : 'center'
	},{
		field : 'address',
		title : '所在地',
		width : 150,
		align : 'center'
	},{
		field : 'reg_time',
		title : '注册时间',
		width : 120,
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
			if (data == 0) return '未激活';
			else if (data == 1) return '已激活';
			else return '已删除';
		}
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		// 所有的区域信息储存在data对象中
		data = null;
		cur_province = null; // 当前所选中的省份名称
		cur_city = null; // 当前所选中的城市名称
		cur_county = null; // 当前所选中的区县名称
		cur_town = null; // 当前所选中的乡镇、街道名称
		cur_city_info = null; // 当前省份下的城市信息
		cur_county_info = null; // 当前城市下的区县信息
		cur_town_info = null; // 当前区县下的乡镇信息
		$allProvince = $("#allProvince"); // 省份select节点
		$allCity = $("#allCity"); // 城市select节点
		$allCounty = $("#allCounty"); // 区县select节点
		$allTown = $("#allTown"); // 乡镇select节点
		// 获取所有的区域信息
		$.ajax({
			url: 'http://restapi.amap.com/v3/config/district?key=f1f842bf132a7e13c0202eee6ef304d7&subdistrict=3&extensions=base',
			dataType: 'json',
			success: function(res) {
				data = res.districts[0];
				// 将省份信息载入省份select节点
				loadInfo($allProvince, data.districts);
			}
		});
		// 省份节点选中内容改变时，绑定事件
		$allProvince.change(function() {
			cur_province = $("#allProvince option:selected").text(); 
			// 清空其他节点内容
			$allCity.empty(); 
			$allCounty.empty();
			$allTown.empty();
			for (var i = 0; i < data.districts.length; i++) {
				if (data.districts[i].name == cur_province) {
					cur_city_info = data.districts[i].districts;
					break;
				}
			}
			loadInfo($allCity, cur_city_info);
		});
		$allCity.change(function() {
			cur_city = $("#allCity option:selected").text();
			$allCounty.empty();
			$allTown.empty();
			for (var i = 0; i < cur_city_info.length; i++) {
				if (cur_city_info[i].name == cur_city) {
					cur_county_info = cur_city_info[i].districts;
					break;
				}
			}
			loadInfo($allCounty, cur_county_info);
		});
		$allCounty.change(function() {
			cur_county = $("#allCounty option:selected").text();
			$.ajax({
				url: 'http://restapi.amap.com/v3/config/district?key=f1f842bf132a7e13c0202eee6ef304d7&keywords='+cur_county+'&subdistrict=1&extensions=base',
				dataType: 'json',
				success: function(res) {
					cur_town_info = res.districts[0].districts;
					$allTown.empty(); 
					loadInfo($allTown, cur_town_info);
				}
			});
		});
		
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [1, 5, 10],
			pagination : true,
			toolbar : toolbar,
			url : "volunteerAction_pageQuery.action",
			idField : 'vol_id',
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
		
	});

	function doDblClickRow(index, data){
		
	}
</script>
</head>
<body  class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div class="easyui-window" title="志愿者添加修改" id="addActivityWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" onclick="addVolunteer()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="activityForm" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">志愿者信息</td>
					</tr>
					<tr>
						<td>姓名</td>
						<td><input type="text" name="vol_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>身份证</td>
						<td><input type="text" name="vol_IDCard" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>直播地址</td>
						<td><input type="text" name="live_url" class="easyui-validatebox"/></td>
					</tr>
					<tr>
						<td>所在地</td>
						<td>
							<div id="demo3" class="citys">
				                <p>
				                    <select id="province" name="province"></select>
				                    <select id="city" name="city"></select>
				                    <select id="area" name="area"></select>
				                    <select id="town" name="town"></select>
				                </p>
				            </div>
			            </td>
		            </tr>
		             <script type="text/javascript">
			        		var $town = $('#demo3 select[name="town"]');
			        		var townFormat = function(info){
			        			$town.hide().empty();
			        			if(info['code']%1e4&&info['code']<7e5){	//是否为“区”且不是港澳台地区
			        				$.ajax({
			        					url:'http://passer-by.com/data_location/town/'+info['code']+'.json',
			        					dataType:'json',
			        					success:function(town){
			        						$town.show();
			        						for(i in town){
			        								$town.append('<option value="'+i+'">'+town[i]+'</option>');
			        						}
			        					}
			        				});
			        			}
			        		};
			                $('#demo3').citys({
			        			province:'福建',
			        			city:'厦门',
			        			area:'思明',
			        			onChange:function(info){
			        				townFormat(info);
			        			}
			        		},function(api){
			        			var info = api.getInfo();
			        			townFormat(info);
			        		});
			            </script>
					<tr>
						<td>详细地址</td>
						<td><input type="text" name="addr_detail" class="easyui-validatebox"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
	<div class="easyui-window" title="活动添加修改" id="editActivityWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="saveEdit" icon="icon-save" onclick="editVolunteer()" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="activityEditForm" method="post">
				<input type="hidden" name="vol_id">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">志愿者信息</td>
					</tr>
					<tr>
						<td>姓名</td>
						<td><input type="text" name="vol_name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>身份证</td>
						<td><input type="text" name="vol_IDCard" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>直播地址</td>
						<td><input type="text" name="live_url" class="easyui-validatebox"/></td>
					</tr>
					<tr>
						<td>所在地</td>
						<td>
							<div id="demo3" class="citys">
				                <p>
				                    <select id="allProvince" name="province">
				                    	<option>---全部省份---</option>
				                    </select>
				                    <select id="allCity" name="city">
				                    	<option>---全部城市---</option>
				                    </select>
				                    <select id="allCounty" name="county">
				                    	<option>---全部区县---</option>
				                    </select>
				                    <select id="allTown" name="town">
				                    	<option>---全部乡镇、街道---</option>
				                    </select>
				                </p>
				            </div>
			            </td>
		            </tr>
					<tr>
						<td>详细地址</td>
						<td><input type="text" name="addr_detail" class="easyui-validatebox"/></td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>
















