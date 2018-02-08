package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.CommonSense;
import com.hfh.domain.Law;
import com.hfh.service.LawService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class LawAction extends BaseAction<Law> {
	@Autowired
	private LawService lawService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public String pageQuery() {
		lawService.pageQuery(this.pageBean);
		// 将pageBean转换成json数据，设置到responce中返回给浏览器
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize"});
		// 将json数据返回后，前端easyui框架会自己解析json数据，所以不需要跳转、刷新页面
		return NONE;
	}
	
	public String publishLaws() {
		lawService.publishLaws(ids);
		
		return LIST;
	}
	
	public String revokeLaws() {
		lawService.revokeLaws(ids);
		
		return LIST;
	}
	
	public String deleteLaws() {
		lawService.deleteLaws(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getLaw_title()) 
				|| !StringUtils.isNotBlank(model.getLaw_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		model.setCreate_time(new Date());
		lawService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getLaw_title()) 
				|| !StringUtils.isNotBlank(model.getLaw_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		Law c = lawService.findById(model.getLaw_id());
		c.setLaw_title(model.getLaw_title());
		c.setLaw_content(model.getLaw_content());
		c.setUpdate_time(new Date());
		lawService.update(c);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
}
