package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.Law;
import com.hfh.domain.Question;
import com.hfh.service.QuestionService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class QuestionAction extends BaseAction<Question> {
	
	@Autowired
	private QuestionService questionService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	
	public void setIds(String ids) {
		this.ids = ids;
	}

	public String pageQuery() {
		this.pageBean.getDetachedCriteria().add(Restrictions.ne("quest_status", -1));
		questionService.pageQuery(this.pageBean);
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize"});
		return NONE;
	}
	
	public String publishQuestions() {
		questionService.publishQuestions(ids);
		
		return LIST;
	}
	
	public String revokeQuestions() {
		questionService.revokeQuestions(ids);
		
		return LIST;
	}
	
	public String deleteQuestions() {
		questionService.deleteQuestions(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getQuest_content()) 
				|| !StringUtils.isNotBlank(model.getQuest_result()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "题目内容或答案不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		questionService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getQuest_content()) 
				|| !StringUtils.isNotBlank(model.getQuest_result()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		Question q = questionService.findById(model.getQuest_id());
		q.setQuest_content(model.getQuest_content());
		q.setQuest_result(model.getQuest_result());
		questionService.update(q);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
}
