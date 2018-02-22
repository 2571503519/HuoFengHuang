package com.hfh.web.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.CandAnswer;
import com.hfh.domain.Candidate;
import com.hfh.domain.PaperExam;
import com.hfh.service.CandidateService;
import com.hfh.service.PaperExamService;
import com.hfh.utils.CandAnswerBean;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class CandidateAction extends BaseAction<Candidate> {
	
	@Autowired
	private CandidateService candidateService;
	
	
	public String pageQuery() {
		candidateService.pageQuery(this.pageBean);
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize", "candAnswers"});
		return NONE;
	}
	
	// 列出考生回答
	public String listCandAnswer() {
		List<CandAnswerBean> candAnswerBeanList = null;
		
		List<CandAnswer> candAnswerList = candidateService.findCandAnswerByCandId(model.getCand_id());
		if (!candAnswerList.isEmpty()) {
			candAnswerBeanList = new ArrayList<CandAnswerBean>();
			CandAnswerBean bean = null;
			for (CandAnswer temp : candAnswerList) {
				bean = new CandAnswerBean();
				bean.setAnswer_id(temp.getAnswer_id());
				bean.setAnswer_result(temp.getAnswer_result());
				bean.setCorrect(temp.getCorrect());
				bean.setExam_weights(temp.getExamQuestion().getExam_weights());
				bean.setQuest_content(temp.getExamQuestion().getQuestion().getQuest_content());
				bean.setQuest_result(temp.getExamQuestion().getQuestion().getQuest_result());
				bean.setQuest_type(temp.getExamQuestion().getQuestion().getQuest_type());
				candAnswerBeanList.add(bean);
			}
		}
		this.java2Json(candAnswerBeanList, new String[] {});
		return NONE;
	}
	
	public String edit() throws IOException {
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getCand_name()) 
				|| !StringUtils.isNotBlank(model.getCand_username())) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "考生姓名或考生号不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		Candidate candidate = candidateService.findById(model.getCand_id());
		candidate.setCand_name(model.getCand_name());
		candidate.setCand_date(model.getCand_date());
		candidate.setCand_grade(model.getCand_grade());
		candidate.setCand_username(model.getCand_username());
		candidateService.update(candidate);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
}
