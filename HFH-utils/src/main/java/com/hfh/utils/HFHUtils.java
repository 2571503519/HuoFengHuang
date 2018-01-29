package com.hfh.utils;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.hfh.domain.Admin;

public class HFHUtils {
	//获取session对象
	public static HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
		
	public static Admin getLoginedAdmin() {
		return (Admin) getSession().getAttribute(MyConstant.LOGINED_ADMIN);
	}

}
