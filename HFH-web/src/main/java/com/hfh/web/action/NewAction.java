package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.New;
import com.hfh.service.NewService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class NewAction extends BaseAction<New> {
	
	@Autowired
	private NewService newService;
	
	public void setNewService(NewService newService) {
		this.newService = newService;
	}
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	
	public void setIds(String ids) {
		this.ids = ids;
	}

	public String pageQuery() {
		newService.pageQuery(this.pageBean);
		// 将pageBean转换成json数据，设置到responce中返回给浏览器
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize"});
		// 将json数据返回后，前端easyui框架会自己解析json数据，所以不需要跳转、刷新页面
		return NONE;
	}
	
	/**
	 * 批量发布新闻（也可以对单条记录操作），将新闻状态位置1
	 * @return
	 */
	public String publishNews() {
		newService.publishNews(ids);
		
		return LIST;
	}
	/**
	 * 批量撤销新闻（也可以对单条记录操作），将新闻状态位置0
	 * @return
	 */
	public String revokeNews() {
		newService.revokeNews(ids);
		
		return LIST;
	}
	/**
	 * 批量删除新闻（也可以对单条记录操作），将新闻状态位置-1
	 * @return
	 */
	public String deleteNews() {
		newService.deleteNews(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getNew_title()) 
				|| !StringUtils.isNotBlank(model.getNew_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "新闻的标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		model.setCreate_time(new Date());
		newService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getNew_title()) 
				|| !StringUtils.isNotBlank(model.getNew_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "新闻的标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		New n = newService.findById(model.getNew_id());
		n.setNew_title(model.getNew_title());
		n.setNew_content(model.getNew_content());
		n.setAuthor(model.getAuthor());
		n.setSource(model.getSource());
		n.setUpdate_time(new Date());
		newService.update(n);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
