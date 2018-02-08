package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.CommonSense;
import com.hfh.domain.New;
import com.hfh.service.CommonSenseService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class CommonSenseAction extends BaseAction<CommonSense> {
	
	@Autowired
	private CommonSenseService commonSenseService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public String pageQuery() {
		commonSenseService.pageQuery(this.pageBean);
		// 将pageBean转换成json数据，设置到responce中返回给浏览器
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize"});
		// 将json数据返回后，前端easyui框架会自己解析json数据，所以不需要跳转、刷新页面
		return NONE;
	}
	
	public String publishNews() {
		commonSenseService.publishCommonSense(ids);
		
		return LIST;
	}
	
	public String revokeNews() {
		commonSenseService.revokeCommonSense(ids);
		
		return LIST;
	}
	
	public String deleteNews() {
		commonSenseService.deleteCommonSense(ids);
		
		return LIST;
	}
	

	public String add() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getSense_title()) 
				|| !StringUtils.isNotBlank(model.getSense_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		model.setCreate_time(new Date());
		commonSenseService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getSense_title()) 
				|| !StringUtils.isNotBlank(model.getSense_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		CommonSense c = commonSenseService.findById(model.getSense_id());
		c.setSense_title(model.getSense_title());
		c.setSense_content(model.getSense_content());
		c.setUpdate_time(new Date());
		commonSenseService.update(c);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
}
