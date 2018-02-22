package com.hfh.dao;

import java.util.List;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.QuestionExam;
import com.hfh.utils.QuestionExamBean;

public interface QuestionExamDao extends BaseDao<QuestionExam> {
	
	
	void saveQuestionExamBatch(List<QuestionExam> questionExamList);

	List<QuestionExam> findByPaperId(Long paper_id);
	
	List<QuestionExam> findAllById(Long[] ids);

	void saveOrUpDateBatch(List<QuestionExam> questionExamList);
	
}
