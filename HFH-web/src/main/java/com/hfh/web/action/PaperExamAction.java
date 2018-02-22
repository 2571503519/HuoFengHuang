package com.hfh.web.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.CandAnswer;
import com.hfh.domain.PaperExam;
import com.hfh.service.PaperExamService;
import com.hfh.utils.CandAnswerBean;
import com.hfh.utils.MyConstant;
import com.hfh.utils.QuestionExamBean;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class PaperExamAction extends BaseAction<PaperExam> {
	
	@Autowired
	private PaperExamService paperExamService;
	
	private String ids;
	private int xuanze_number;
	private int tiankong_number;
	private int xuanze_weights;
	private int tiankong_weights;
	
	public void setIds(String ids) {
		this.ids = ids;
	}
	public void setXuanze_number(int xuanze_number) {
		this.xuanze_number = xuanze_number;
	}
	public void setTiankong_number(int tiankong_number) {
		this.tiankong_number = tiankong_number;
	}
	public void setXuanze_weights(int xuanze_weights) {
		this.xuanze_weights = xuanze_weights;
	}
	public void setTiankong_weights(int tiankong_weights) {
		this.tiankong_weights = tiankong_weights;
	}

	public String pageQuery() {
		paperExamService.pageQuery(this.pageBean);
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize", "exam_questions"});
		return NONE;
	}
	
	public String publishPaperExam() {
		paperExamService.publishPaperExam(ids);
		
		return LIST;
	}
	
	public String revokePaperExam() {
		paperExamService.revokePaperExam(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		System.out.println(model.getSelected());
		System.out.println(xuanze_number);
		System.out.println(xuanze_weights);
		System.out.println(tiankong_number);
		System.out.println(tiankong_weights);
		
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getPaper_name()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "考卷名不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		paperExamService.makeUpPaperExam(model, xuanze_number, xuanze_weights
				, tiankong_number, tiankong_weights);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	// 列出考生回答
	public String listQuestionExam() {
		List<QuestionExamBean> questionExamBeanList = 
				paperExamService.findAllQuestionExamByPaperId(model);
		this.java2Json(questionExamBeanList, new String[] {});
		return NONE;
	}
	
	// 替换考卷中的考题, 实际上是修改quest_id值
	public String replaceQuestionExam() {
		
		List<QuestionExamBean> questionExamBeanList = 
				paperExamService.replaceQuestionExam(ids);
		this.java2Json(questionExamBeanList, new String[] {});
		
		return NONE;
	}
}
