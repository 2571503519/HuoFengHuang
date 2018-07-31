package com.hfh.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.hfh.domain.Admin;

public class HFHUtils {
	//获取session对象
	public static HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	
	public static HttpServletRequest getRequest() {
		return  ServletActionContext.getRequest();
	}
	
	public static String getPath() {
		return getRequest().getContextPath();
		
	}
	
	public static String getAbsolutePath() {
		return getRequest().getScheme() + "://" + getRequest().getServerName() + 
				":"	+ getRequest().getServerPort() + getPath();
	}
		
	public static Admin getLoginedAdmin() {
		return (Admin) getSession().getAttribute(MyConstant.LOGINED_ADMIN);
	}

}
