package com.hfh.web.interceptor;

import com.hfh.domain.Admin;
import com.hfh.utils.HFHUtils;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class HFHLoginInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// 获取代理类
		ActionProxy proxy = invocation.getProxy();
		// 获取访问的Action
		String actionName = proxy.getActionName();
		// 获取命名空间
		String namespace = proxy.getNamespace();
		// 两者组成了url
		String url = namespace + actionName;
		// 拦截器中指定了对hfh_和开头的请求不拦截
		if (actionName.startsWith("app_"))
			return invocation.invoke();
		if (actionName.startsWith("hfh_"))
			return invocation.invoke();
		System.out.println(url);
		// 获取Session中的登录的管理员
		Admin admin = HFHUtils.getLoginedAdmin();
		if (admin == null) {
			// 没有登录，跳转到登录页面
			return "login";
		}
		// 放行
		return invocation.invoke();
	}

}
