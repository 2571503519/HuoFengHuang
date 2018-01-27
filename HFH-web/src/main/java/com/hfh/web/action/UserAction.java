package com.hfh.web.action;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.User;
import com.hfh.service.UserService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class UserAction extends BaseAction<User> {
	// 属性驱动，登录时用户输入的验证码
	private String checkcode;

	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	
	@Autowired
	private UserService userService;
	
	public String login() {
		// 比较用户输入的验证码与validatecode.jsp页面生成后放入session中的验证码
		String validateCode = (String) ServletActionContext.getRequest().getSession().getAttribute(MyConstant.VALIDATE_CODE);
		if (StringUtils.isNotBlank(checkcode) && checkcode.equals(validateCode)) {
			User user = userService.login(model);
			if (user != null) {
				// 用户登录成功，将用户放入session中，并跳转到主页
				ServletActionContext.getRequest().getSession().setAttribute(MyConstant.LOGINED_USER, user);
				return HOME;
			} else {
				this.addActionError("用户名或者密码错误！");
				return LOGIN;
			}
		} else {
			this.addActionError("验证码错误！");
		}
		return LOGIN;
	}
	
	public String logout() {
		// 使session失效，并返回到登录页面
		ServletActionContext.getRequest().getSession().invalidate();
		return LOGIN;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
