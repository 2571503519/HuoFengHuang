<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.hfh.domain.User"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
User loginedUser = (User) session.getAttribute("loginedUser");
if (loginedUser != null) 
	System.out.println(loginedUser.getUsername());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页</title>
    <script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.js"></script>
    <script type="text/javascript" src="<%= basePath %>/js/myjs/js.js"></script>
    <script type="text/javascript" src="<%= basePath %>/js/myjs/jquery-1.4.1.js"></script>
    <!-- <script src="<%= basePath %>/js/myjs/bootstrap.js"></script> -->
    <link rel="stylesheet" href="<%= basePath %>/css/appcss/css.css" />
    <link rel="stylesheet" href="<%= basePath %>/css/appcss/bootstrap.css">
    <!-- 动态悬浮框的Js部分 -->
    <script type="text/javascript">
        $(document).ready(function() {
            $(".advbox").show();
            $(".advbox").animate({
                top: "50%"
            }, 1000);
            $(".closebtn").click(function() {
                $(".advbox").fadeOut(500);
            })
        })
    </script>

    <!-- js通用样式 -->
    <script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.minsp.js"></script>
    <!-- js通用样式 -->
    <!-- 滚动条主要样式 -->
    <script type="text/javascript" src="<%= basePath %>/js/myjs/jquery.nicescroll.js"></script>
    <!-- 滚动条主要样式 -->
    <style type="text/css">
        /*格式化样式*/
        
        ul,
        dl,
        dt,
        dd,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        form {
            padding: 0;
            margin: 0;
        }
        
        ul {
            list-style: none;
        }
        
        img {
            border: 0px;
        }
        
        a {
            text-decoration: none;
            outline: none;
            color: #444;
        }
        
        a:visited {
            text-decoration: none;
        }
        
        a:hover {
            cursor: pointer;
            text-decoration: none;
            color: #3C97D6;
        }
        
        a:focus {
            text-decoration: none;
        }
        
        img {
            border: 0;
        }
        
        .clear {
            clear: both;
        }
        /*格式化样式*/
        /*播放器样式*/
        
        .video_player {
            height: 393px;
        }
        
        .video_list_area {
            width: 700px;
        }
        
        ul.video_list {
            margin: 7px 0px 0px 0;
            height: 107px;
            list-style: none;
            border-bottom: 10px solid #dcdcdc;
        }
        
        ul.video_list li {
            float: left;
            font-size: 14px;
            font-weight: bold;
            line-height: 24px;
        }
        
        ul.video_list li a {
            display: inline-block;
            padding: 14px 15px;
            margin-right: 7px;
            width: 140px;
            height: 72px;
            color: #fff;
            background-color: #7e2d2d;
        }
        
        ul.video_list li.last a {
            margin-right: 0;
        }
        
        ul.video_list li a:hover,
        ul.video_list li a.on {
            color: #fff;
            background-color: #c12e2e;
        }
        
        #ascrail2000-hr div {
            margin-left: 0;
        }
        
        .center {
            width: 700px;
            margin: 20px auto;
        }
        
        .log {
            display: inline-block;
            width: 110px;
            height: 50px;
            position: relative;
            top: -50px;
            left: 92%;
            line-height: 50px;
        }
        
        .log .shuxian {
            float: left;
            position: relative;
            left: 40%;
            top: -40px;
            display: block;
            width: 5px;
            height: 30px;
            background: url(<%= path %>/images/navlist.jpg) no-repeat;
            /* background-color: #000; */
            z-index: 8888;
        }
        
        .login {
            color: #fff;
            height: 50px;
            display: block;
            width: 50px;
            text-align: center;
            margin-left: -7px;
        }
        
        .reg {
            color: #fff;
            position: relative;
            top: -50px;
            float: right;
            height: 50px;
            display: block;
            width: 50px;
            background: url(<%= path %>/images/navback.jpg) repeat-x;
        }
        /*播放器样式*/
    </style>
    <!--- iframe切换停止播放js -->
    <script type="text/javascript">
        $(function() {
            var iframe = $("div.video_player iframe"); //播放页面
            $('ul.video_list li a').click(function() {
                iframe.attr("src", $(this).attr("name")); //更改iframe src
                $('ul.video_list li a').removeClass('on');
                $(this).addClass('on'); //给点击的元素添加正在播放标识
            });
        });
    </script>
    <!-- iframe切换停止播放js -->
</head>

<body>
    <!-- 首页动态悬浮框 -->
    <!-- <div class="advbox">
        <div class="advpic" style="background-image: url(images/tk3.jpg); width:600px; height:414px;">
            <a href="javascript:void(0);" class="closebtn" style="color:#000">关闭</a>
            <div class="wz"> <strong>欢迎来到一泰消防科技有限公司</strong></div>
        </div>
    </div> -->
    <!-- header -->
    <jsp:include page="/WEB-INF/pages/app/header.jsp"></jsp:include>
    <!--nav/-->
    <div class="cont">
        <div class="time">
            <span>2017年10月01日14:06:40</span>
            <form action="#" method="get" id="search">
                <div class="search">
                    <input type="text" class="seaLeft" />
                    <input type="image" src="<%= basePath %>/images/inRight.jpg" class="seaRight" />
                </div>
                <!--search/-->
            </form>
            <!--select/-->
        </div>
        <!--time/-->
        <div class="new1Box">

            <div class="new1Left">
                <div class="new1imgBig">
                    <img src="<%= basePath %>/images/new1.jpg" width="350" height="259" />
                    <img src="<%= basePath %>/images/new1_1.jpg" width="350" height="259" />
                    <img src="<%= basePath %>/images/new1_2.jpg" width="350" height="259" />
                    <img src="<%= basePath %>/images/new1_3.jpg" width="350" height="259" />
                    <div class="clears"></div>
                </div>
                <!--new1imgBig/-->
                <ul class="new1imgSmaill">
                    <li><img src="<%= basePath %>/images/new1.jpg" width="85" height="64" /></li>
                    <li><img src="<%= basePath %>/images/new1_1.jpg" width="85" height="64" /></li>
                    <li><img src="<%= basePath %>/images/new1_2.jpg" width="85" height="64" /></li>
                    <li><img src="<%= basePath %>/images/new1_3.jpg" width="85" height="64" /></li>
                    <div class="clears"></div>
                </ul>
                <!--new1imgSmaill/-->
            </div>

            <!--new1Left/-->
            <div class="new1Mid">
                <ul class="new1Title">
                    <li>公司要闻</li>
                    <!--<li>基层快讯</li>
                    <li>总队要闻</li>-->
                    <p style="float: right;font-size: 15px;margin-top: 5px;"><a href="<%= basePath %>/hfh_index_newList?page=1">更多>>></a></p>
                    <div class="clears"></div>
                </ul>
                <!-- 新闻版块 -->
                <div class="new1New">
                    <table class="newBox">
                   		<s:iterator value="#latestNewList" var="n" >
                        <tr class="newTitle">
                            <td>
                                <div><a href="<%= basePath %>/hfh_index_newDetail?id=<s:property value="#n.new_id"/>">
                                	<s:property value="#n.new_title" />
                                 </a> <span><s:date name="#n.create_time" format="yyyy-MM-dd"/></span></div>
                            </td>
                        </tr>
                        <tr class="newList">
                            <td><s:property value="#n.new_desc"/> </td>
                        </tr>
                        </s:iterator>
                    </table>
                    <!--newBox/-->
                </div>
                <!--new1New/-->
                <div class="new1New">
                    <table class="newBox">
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">外资企业在上海自贸区经营增值电信业务的试点即将开始</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">上海基层民警配枪巡逻 盘点各国如何管理警察配枪</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">未来版四轮车纽约展出 可监控骑车者心情</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">亚马逊3D智能手机曝光配6个摄像头</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">未来版四轮车纽约展出 可监控骑车者心情(组图) </a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                    </table>
                    <!--newBox/-->
                </div>
                <!--new1New/-->
                <div class="new1New">
                    <table class="newBox">
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">俄罗斯驻华大使：中俄关系不受世界局势左右</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">湛江消防巡逻 盘点各国如何管理消防队伍</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">未来版四轮车纽约展出 可监控骑车者心情</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">未来版四轮车纽约展出 可监控骑车者心情(组图) </a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newList">
                            <td>
                                根据工信部、湛江市政府发布的文件，外资企业在湛江自贸区经营增值电信业务的试点即将开始，这意味着继虚拟运营商之后，外资企业也终于有机会正式进入中国通信市场，不过外资只能经营增值电信业务，且增值电信业务已是的业务
                            </td>
                        </tr>
                        <tr class="newTitle">
                            <td>
                                <div><a href="newinfo.html">亚马逊3D智能手机曝光配6个摄像头</a> <span>2017-10-02</span></div>
                            </td>
                        </tr>
                        <!--newList/-->
                    </table>
                    <!--newBox/-->
                </div>
                <!--new1New/-->
            </div>
            <!--new1Mid/-->
            <div class="new1Right">
                <h1 class="new1Title2"><span>活动通知</span></h1>
                <ul>
                	<s:iterator value="#onDoingActivityList" var="activity">
                    <li><a href="newinfo.html"><s:property value="#activity.act_title"/> </a></li>
                    </s:iterator>
                    <s:iterator value="#willDoActivityList" var="activity">
                    <li><a href="newinfo.html"><s:property value="#activity.act_title"/> </a></li>
                    </s:iterator>
                </ul>
            </div>
            <!--new1Right/-->
            <div class="clears"></div>
        </div>
        <!--new1Box/-->
        <div class="new2Box" style="position:relative;">
            <!--videoNew/-->
            <div class="clears" style="position: absolute; width: 411px; height: 500px; left: 773px; top: 262px;">
            </div>
        </div>
        <!--new2Box/-->
        <div class="new4Box">
            <div class="new4Left">
                <h1 class="new4LeftTitle">
                	<span>法律法规</span>
                	<p style="float: right;font-size: 15px;margin-top: 6px;"><a href="falv.html">更多>>></a></p>
                </h1>
                <div class="new4LeftBox">
                   <ul class="new4LeftNew">
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                   </ul>
                   <img src="<%= basePath %>/images/fenge.jpg" width="3" height="193" style="float:left;" />
                   <ul class="new4LeftNew">
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                   </ul>
                   <!--new4LeftNew/-->
               	<img src="<%= basePath %>/images/fenge.jpg" width="3" height="193" style="float:left;" />
                       <ul class="new4LeftNew">
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                   </ul>
                   <img src="<%= basePath %>/images/fenge.jpg" width="3" height="193" style="float:left;" />
                       <ul class="new4LeftNew" style="float: left;width: 260px;">
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       <li><a href="sp_book.html">中国航母辽宁舰返回大连首次</a></li>
                       <li><a href="sp_book.html">“海上合作—2014”多国海上联合</a></li>
                       </ul>
                </div>
                <!--new4RightBox/-->
            </div>
            <!--new4Left/-->
            <!--new4Right/-->
            <div class="clears"></div>
        </div>
        <div class="new5Box">
            <h1 class="new4LeftTitle"><span><a href="sp_photo.html" style="color:#FFF">志愿者风采</a></span></h1>
            <div class="fengcai" style="width:1180px; height:480px; position:relative;">
                <div class="tu1 bigpass" style="background-image: url(<%= basePath %>/images/tu1.jpg); width: 360px; height: 230px; overflow:hidden; position: absolute; left: 12px; top: 7px;"></div>
                <div class="tu2 bigpass" style="background-image: url(<%= basePath %>/images/tu2.jpg); width: 310px; height: 150px; overflow:hidden; position: absolute; left: 788px; top: 6px;"></div>
                <div class="tu3 bigpass" style="background-image: url(<%= basePath %>/images/tu3.jpg); width: 360px; height: 236px; overflow:hidden; position: absolute; left: 397px; top: 5px;"></div>
                <div class="tu4 bigpass" style="background-image: url(<%= basePath %>/images/tu4.jpg); width: 310px; height: 150px; overflow:hidden; position: absolute; left: 788px; top: 165px;"></div>
                <div class="tu5 bigpass" style="background-image: url(<%= basePath %>/images/tu5.jpg); width: 310px; height: 150px; overflow:hidden; position: absolute; left: 788px; top: 327px;"></div>
                <div class="tu6 bigpass" style="background-image: url(<%= basePath %>/images/tu6.jpg); width: 171px; height: 219px; overflow:hidden; position: absolute; left: 15px; top: 257px;"></div>
                <div class="tu7 bigpass" style="background-image: url(<%= basePath %>/images/tu7.jpg); width: 540px; height: 219px; overflow:hidden; position: absolute; left: 218px; top: 257px;"></div>
                <!--<img src="../images/wujingfengcai.jpg" width="1180" height="480" />  -->
            </div>
            <!--fengcai/-->
        </div>
        <!--new5Box/-->
    </div>
    <!--cont/-->
    <jsp:include page="/WEB-INF/pages/app/footer.jsp"></jsp:include>
    <!--footer/-->
</body>

</html>