<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>火凤凰志愿者系统</title>
    <link type="text/css" href="<%= basePath %>/css/appcss/css1.css" rel="stylesheet" />
	<script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.js"></script>
	<script type="text/javascript" src="<%= basePath %>/js/myjs/js.js"></script>
</head>

<body>
    <!-- header -->
    <jsp:include page="/WEB-INF/pages/app/header.jsp"></jsp:include>
    <!--nav/-->
    <div class="insideCont">
        <div class="new1Box">
        <div class="insideLeft">
            <h1 class="new1Title2">
            	<span>志愿者动态</span>
            	<p style="float: right;font-size: 15px;"><a href="../application/new.html">更多>>></a></p>
            </h1>
            <div class="zhengCont">
                <dl class="zhengNew">
                    <dt><img src="/HFH-web/images/zheng2.jpg" width="400" height="298" /></dt>
                    <dd>
                        <h2>美将启动电磁炮海上试射计划 炮弹成本仅为导弹1%</h2>
                        <ul>
                            <li><a href="newinfo.html">日媒：美批安倍“拜鬼”起因为中国崛起</a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">北京卫戍区某师落实“双推双考” 严以用权选干部 </a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">日媒：美批安倍“拜鬼”起因为中国崛起</a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">北京卫戍区某师落实“双推双考” 严以用权选干部 </a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">日媒：美批安倍“拜鬼”起因为中国崛起</a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">北京卫戍区某师落实“双推双考” 严以用权选干部 </a><span>2017-010-22</span></li>
                            <li><a href="newinfo.html">日媒：美批安倍“拜鬼”起因为中国崛起</a><span>2017-010-2</span></li>
                            <li><a href="newinfo.html">北京卫戍区某师落实“双推双考” 严以用权选干部 </a><span>2017-010-2</span></li>
                        </ul>
                    </dd>
                    <div class="clears"></div>
                </dl>
                <!--zhengNew/-->
                <h1 class="new1Title2" style="margin-top: -20px;">
                	<span>正在进行中</span>
                	<p style="float: right;font-size: 15px;"><a href="../application/new.html">更多>>></a></p>
                </h1>
                <dl class="zhengNew2">
                    <dd style="margin:0;margin-right:8px;">
                        <ul>
                        	<s:iterator value="#onDoingActivityList" var="activity">
                            <li>
	                            <a href="<%= basePath %>/hfh_volunteer_activityDetail?id=<s:property value="#activity.act_id"/>"><s:property value="#activity.act_title" /> </a><span><s:date name="#activity.start_time" format="yyyy-MM-dd"/> </span>
	                            <button type="button" style="float: right;" onclick="window.open('<s:property value="#activity.live_url" />');">观看直播</button>
                            </li>
                            </s:iterator>
                        </ul>
                    </dd>
                    <div class="clears"></div>
                </dl>
                <!--zhengNew2/-->
                <h1 class="new1Title2" style="margin-top: -20px;">
                	<span>即将开展</span>
                	<p style="float: right;font-size: 15px;"><a href="../application/new.html">更多>>></a></p>
                </h1>
                <dl class="zhengNew2">
                    <dd style="margin:0;margin-right:8px;">
                        <ul>
                        	<s:iterator value="#willDoActivityList" var="activity">
                            <li>
	                            <a href="<%= basePath %>/hfh_volunteer_activityDetail?id=<s:property value="#activity.act_id"/>"><s:property value="#activity.act_title" /> </a><span><s:date name="#activity.start_time" format="yyyy-MM-dd"/> </span>
	                            <button class="activity_apply" value="<s:property value="#activity.act_id"/>" type="button" style="float: right;">申请加入</button>
                            </li>
                            </s:iterator>
                        </ul>
                    </dd>
					<script type="text/javascript">
                    	$(function(){
                    		$(".activity_apply").click(function(){
                    			// TODO:活动申请逻辑
                    			var act_id = this.value;
                    			$.post("<%= basePath %>/hfh_volunteer_apply",
                    					{"id": act_id},
                    					function(data) {
                    						if (data.status == 0) {
                    							alert(data.error);
                    							if (data.url) {
                    								window.location.href = data.url;
                    							}
                    						} else {
                    							alert("申请成功！");
                    						}
                    					}, "json");
                    		});
                    	});
                    </script>
                    <div class="clears"></div>
                </dl>
                <!--zhengNew/-->

                <h1 class="new1Title2" style="margin-top: -20px;"><span>查询志愿者</span></h1>
                <div style="width: auto;height: 300px;">
                    <div style="padding-Top:5px;background:#ddd;height:40px">
                        <label style="margin-left:45px">姓名：</label> <input class="in" id="userName" placeholder="请输入姓名" />
                        <label>编号：</label> <input class="in" id="honestName" placeholder="请输入编号" />
                        <label>城市名：</label> <input class="in" id="honestName" placeholder="请输入城市名" />
                        <label onclick="onQ()" class="getS"> 查 询 </label>
                    </div>
                    <table class="newtable2" !important>
                        <tr class="text1">
                            <th width="60px">编号</th>
                            <th width="100px">姓名</th>
                            <th width="100px">城市</th>
                            <th width="100px">等级</th>
                            <th width="140px">工作时长</th>
                            <th width="140px">是否空闲</th>
                            <th width="200px">直播链接</th>
                        </tr>
                        <tr class="text1">
                            <th width="60px">1</th>
                            <th width="100px">xxx</th>
                            <th width="100px">xxx</th>
                            <th width="100px">xxx</th>
                            <th width="140px">xxxx</th>
                            <th width="140px">xxxxx</th>
                            <th width="200px">xxxxx</th>
                        </tr>
                    </table>


                </div>
            </div>
            <!--newsCont/-->

            <br />
        </div>
        <!--insideLeft/-->

        <div class="insideRight">
            <div class="inRiNew">
                <h1 class="new1Title2"><span>通知公告</span></h1>
                <ul>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2014”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2014”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2014”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2014”多国海上联合演习准备完毕</a></li>
                    <li><a href="newinfo.html">中国航母辽宁舰返回大连首次维护或进行大换血</a></li>
                    <li><a href="newinfo.html">“海上合作—2014”多国海上联合演习准备完毕</a></li>
                </ul>
            </div>
            <!--inRiNew/-->
            <div class="inRivieoNew" style="width: auto;height: 300px;">
                <h1 class="new1Title2"><span>志愿者申请</span></h1>
                <form>
                    <table>
                        <tr>
                            <td>姓&nbsp;&nbsp;名：</td>
                            <td>
                                <!--<input type="text" name="userid" value="" placeholder="登录名"/>-->
                                <input id="volunteer_name" type="text" name="vol_name" value="" />
                            </td>
                        </tr>

                        <tr>
                            <td>身份证号：</td>
                            <td>
                                <input id="volunteer_IDCard" type="text" name="vol_IDCard" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td>电&nbsp;&nbsp;话：</td>
                            <td>
                                <input id="volunteer_telephone" type="text" name="user_tel" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td>邮&nbsp;&nbsp;箱：</td>
                            <td>
                                <input id="volunteer_email" type="text" name="user_email" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td>地&nbsp;&nbsp;区：</td>
                            <td>
                                <input id="volunteer_addr_detail" type="text" name="addr_detail" value="" />
                            </td>
                        </tr>
                    </table>
                    <button id="volunteer_form_submit" type="button" style="margin-left: 20px;margin-top: 25px;">确认提交</button>
                    <button type="reset" style="margin-left: 100px;margin-top: 25px;">重置</button>
                </form>
				<script type="text/javascript">
					$(function() {
						$("#volunteer_form_submit").click(function (){
							var vol_name = $("#volunteer_name").val();
							var vol_IDCard = $("#volunteer_IDCard").val();
							var user_tel = $("#volunteer_telephone").val();
							var user_email = $("#volunteer_email").val();
							var addr_detail = $("#volunteer_addr_detail").val();
							$.post("<%= basePath %>/hfh_volunteer_volunteerApply",
									{
										"vol_name": vol_name,
										"vol_IDCard": vol_IDCard,
										"user_tel": user_tel,
										"user_email": user_email,
										"addr_detail": addr_detail
									},
									function(data) {
										console.log(data);
									}, "json");
						});
					});
				</script>
            </div>
            <!--inRivieoNew/-->
            <div class="inRiImg">
                <div style="width: auto;height:200px;text-align: center;padding: 20px;background-color: #0099FF;">
                    <a href="#">
                        <img src="/HFH-web/images/monikaoshi.png" style="width: auto;height: 180px;" />
                        <p style="font-size: x-large;">模拟考试</p>
                    </a>
                </div>
                <!--模拟考试 -->
                <br />
                <div style="width: auto;height: 200px;text-align: center;padding: 20px;background-color: #0099FF;">
                    <a href="#">
                        <img src="/HFH-web/images/onlinekaoshi.png" style="width: auto;height: 180px;" />
                        <p style="font-size: x-large;">正式考试</p>
                    </a>
                </div>
                <!--在线考试 -->
            </div>
            <!--inRiImg/-->

        </div>
        <!--insideRight/-->
        </div>
        <div class="clears"></div>
    </div>
    <!--cont/-->
    <jsp:include page="/WEB-INF/pages/app/footer.jsp"></jsp:include>
 	<!--footer/-->
    <!--footer/-->
</body>

</html>