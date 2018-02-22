package com.hfh.service;

import com.hfh.domain.Law;
import com.hfh.domain.Question;
import com.hfh.utils.PageBean;

public interface QuestionService {

	void pageQuery(PageBean pageBean);

	void publishQuestions(String ids);

	void revokeQuestions(String ids);

	void deleteQuestions(String ids);

	void save(Question model);

	Question findById(Long quest_id);

	void update(Question model);

}
