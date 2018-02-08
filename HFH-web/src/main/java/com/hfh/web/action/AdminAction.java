package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.Admin;
import com.hfh.service.AdminService;
import com.hfh.utils.HFHUtils;
import com.hfh.utils.MyConstant;
import com.hfh.utils.PageBean;
import com.hfh.web.action.base.BaseAction;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class AdminAction extends BaseAction<Admin> {
	
	// 属性驱动，登录时管理员输入的验证码
	private String checkcode;
	// 接受页面提交的分页参数
	private int page;
	private int rows;
	// 批量删除时，接受id组成的字符串 "1,2,3,4"
	private String ids;
	
	public void setPage(int page) {
		this.page = page;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	
	public void setIds(String ids) {
		this.ids = ids;
	}

	@Autowired
	private AdminService adminService;
	
	public String login() {
		// 比较管理员输入的验证码与validatecode.jsp页面生成后放入session中的验证码
		String validateCode = (String) ServletActionContext.getRequest().getSession().getAttribute(MyConstant.VALIDATE_CODE);
		if (StringUtils.isNotBlank(checkcode) && checkcode.equals(validateCode)) {
			Admin admin = adminService.login(model);
			if (admin != null) {
				// 管理员登录成功，将管理员放入session中，并跳转到主页
				ServletActionContext.getRequest().getSession().setAttribute(MyConstant.LOGINED_ADMIN, admin);
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
	
	public String editPassword() throws IOException {
		// 修改用户密码是否成功的标志
		String flag = MyConstant.EDIT_ADMIN_SUCCESS;
		// 获取登录的用户
		Admin admin = HFHUtils.getLoginedAdmin();
		try {
			adminService.editPassword(admin.getAdmin_id(), model.getPassword());
		} catch (Exception e) {
			// 修改失败
			flag = MyConstant.EDIT_ADMIN_FAIL;
			e.printStackTrace();
		}
		// 修改成功，并返回修改成功的标志
		ServletActionContext.getResponse().setContentType("text/html;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(flag);
		return NONE;
	}
	
	public String pageQuery() throws IOException {
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(page);
		pageBean.setPageSize(rows);
		// 创建离线查询对象
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Admin.class);
		pageBean.setDetachedCriteria(detachedCriteria);
		adminService.pageQuery(pageBean);
		
		// 将查询出的pageBean转化成Json数据，通过输出流返回到页面中
		//JSONObject---将单一对象转为json
		//JSONArray----将数组或者集合对象转为json
		JsonConfig jsonConfig = new JsonConfig();
		//指定哪些属性不需要转json
		jsonConfig.setExcludes(new String[]{"currentPage","detachedCriteria","pageSize"});
		String json = JSONObject.fromObject(pageBean, jsonConfig).toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	/**
	 * 添加管理员
	 * @return
	 */
	public String add() {
		// 由于前端是通过checkbox传来的参数，所以当用户不启用时是没有status参数的，所以手动判断添加
		if (model.getStatus() != MyConstant.ADMIN_STATUS_ENABLE) {
			model.setStatus(MyConstant.ADMIN_STATUS_DISABLE);
		}
		// 设置管理员创建时间
		model.setCreate_time(new Date());
		// 保存
		adminService.save(model);
		// 返回管理员列表
		return LIST;
	}
	
	/**
	 * 批量删除
	 * @return
	 */
	public String deleteBatch() {
		// ids为多个id以字符串形式传来，例如："1,2,3,4"
		adminService.deleteBatch(ids);
		return LIST;
	}
	
	
	
	
	
	
	
	
	
}
