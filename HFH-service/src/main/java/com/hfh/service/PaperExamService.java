package com.hfh.service;

import java.util.List;

import com.hfh.domain.PaperExam;
import com.hfh.utils.PageBean;
import com.hfh.utils.QuestionExamBean;

public interface PaperExamService {

	void pageQuery(PageBean pageBean);

	void publishPaperExam(String ids);

	void revokePaperExam(String ids);

	void deletePaperExam(String ids);
	
	void save(PaperExam model);

	void makeUpPaperExam(PaperExam model, int xuanze_number, int xuanze_weights, int tiankong_number, int tiankong_weights);
	
	List<QuestionExamBean> findAllQuestionExamByPaperId(PaperExam model);

	List<QuestionExamBean> replaceQuestionExam(String ids);
}
