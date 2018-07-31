<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + 
		":"	+ request.getServerPort() + path;
%>
<!doctype html>
<html>
<head>
    <meta charset='utf-8' />
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="<%= basePath %>/css/appcss/reg.css">
    <script type="text/javascript" src='<%= basePath %>/js/myjs/Myjs.js'></script>
    <script type="text/javascript" src='<%= basePath %>/js/myjs/reg.js'></script>
</head>
<script type="text/javascript">
$(function() {
	<s:if test="#status == 1">
		alert("注册成功");
	</s:if>
	<s:elseif test="#status == 0">
		alert("注册失败");
	</s:elseif>
	<s:else>
	
	</s:else>
});
</script>
<body>
    <form method='post' action='<%= basePath %>/hfh_index_register'>
        <dl>
            <dd class='user_dd'>
                <div class="outline">
                    用&nbsp;户&nbsp;&nbsp;名 : <input type='text' name='username' value='' placeholder="请输入用户名" />
                </div>
                <span class='info user_put'>请输入6个字符的用户名，可由汉字数字字母下划线组成（空格自动忽略）。<p></p></span>
                <span class='info_error user_error'>请输入正确用户名!<p></p></span>
                <span class='ok user_ok'></span>
            </dd>
            <dd>
                <div class="outline">
                    密　　码 : <input type='password' name='password' vlaue='' placeholder="请输入密码" />
                </div>
                <span class='info pass_put'>请输入6-18位密码，由数字字母下划线组成（不能出现空格）。<p></p></span>
                <span class='safe'>安全等级：<strong class='s s1'></strong> <strong class='s s2'></strong>
				<strong class='s s3'></strong> <strong class='word'></strong><p></p>
			</span>
                <span class='info_error pass_error'>请输入正确密码!<p></p></span>
                <span class='ok pass_ok'></span>
            </dd>
            <dd>
                <div class="outline">
                    确认密码 : <input type='password' name='confirm_pass' placeholder="请确认密码" />
                </div>
                <span class='info confirm_put'>请再次输入密码。<p></p></span>
                <span class='info_error confirm_error'>两次密码不一致！<p></p></span>
                <span class='ok confirm_ok'></span>
            </dd>
            <dd>
                <div class="outline">
                    电子邮箱 : <input type='text' name='email' placeholder="请输入邮箱" />
                </div>
                <span class='info email_put'>请输入您的电子邮箱。<p></p></span>
                <span class='info_error email_error'>请输入正确电子邮箱！<p></p></span>
                <span class='ok email_ok'></span>
                <ul class='auto_complete'>
                    <li><span></span>@qq.com</li>
                    <li><span></span>@163.com</li>
                    <li><span></span>@126.com</li>
                    <li class='last_li'><span></span>@yahoo.com</li>
                </ul>
            </dd>
            <dd>
                <input type="submit" value='注册' />
            </dd>
        </dl>
    </form>
</body>

</html>